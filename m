From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v1 23/45] check-ignore: convert to use parse_pathspec
Date: Sun, 14 Apr 2013 16:25:42 -0700
Message-ID: <20130414232542.GB21564@indian.linksys.moosehall>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-24-git-send-email-pclouds@gmail.com>
 <20130412150304.GH26949@pacific.linksys.moosehall>
 <CACsJy8Au4KL7msPr62bvSgGdseWFF=cUJSuB2JzGUXehDD6hng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 01:25:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URWIx-0005iT-G6
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 01:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609Ab3DNXZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 19:25:48 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:37987 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab3DNXZr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 19:25:47 -0400
Received: from localhost (unknown [209.63.50.82])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 646252EAD3;
	Mon, 15 Apr 2013 00:25:45 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CACsJy8Au4KL7msPr62bvSgGdseWFF=cUJSuB2JzGUXehDD6hng@mail.gmail.com>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221165>

On Sat, Apr 13, 2013 at 09:09:33AM +1000, Duy Nguyen wrote:
> On Sat, Apr 13, 2013 at 1:03 AM, Adam Spiers <git@adamspiers.org> wrote:
> >> -static int check_ignore(const char *prefix, const char **pathspec)
> >> +static int check_ignore(int argc, const char **argv, const char *prefix)
> >>  {
> >>       struct dir_struct dir;
> >> -     const char *path, *full_path;
> >>       char *seen;
> >>       int num_ignored = 0, dtype = DT_UNKNOWN, i;
> >>       struct path_exclude_check check;
> >>       struct exclude *exclude;
> >> +     struct pathspec pathspec;
> >>
> >>       /* read_cache() is only necessary so we can watch out for submodules. */
> >>       if (read_cache() < 0)
> >> @@ -70,31 +70,39 @@ static int check_ignore(const char *prefix, const char **pathspec)
> >>       dir.flags |= DIR_COLLECT_IGNORED;
> >>       setup_standard_excludes(&dir);
> >>
> >> -     if (!pathspec || !*pathspec) {
> >> +     if (!argc) {
> >
> > Is there a compelling reason for introducing argc as a new parameter
> > to check_ignore(), other than simplifying the above line?  And why
> > rename the pathspec parameter to argv?  Both these changes are
> > misleading AFAICS, since paths provided to check_ignore() can come
> > from sources other than CLI arguments (i.e. via --stdin).
> 
> Because I introduced "struct pathspec pathspec;" I need to rename the
> argument "pathspec" to something else.

Ah, I see - that makes sense :-)

> Maybe we could rename the argument to "paths"?

Sounds fine to me.

> > The introduction of argc also makes it possible to invoke
> > check_ignore() with arguments which are not self-consistent.
> 
> This is the same problem with main()

How could main() be invoked with argc inconsistent with argv?

> and other places that follow this convention.  But I don't mind
> dropping argc either.

What is the reason for that convention?  I'm willing to be persuaded
either way.
