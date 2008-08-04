From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Add completion for 'git grep'
Date: Sun, 3 Aug 2008 21:06:34 -0700
Message-ID: <20080804040634.GC2963@spearce.org>
References: <1217638593-57321-1-git-send-email-lee.marlow@gmail.com> <20080802210525.GD24723@spearce.org> <7968d7490808030031v39726af6r9f88feb28df02de7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lee Marlow <lee.marlow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 06:07:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPrM8-0001yH-2h
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 06:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbYHDEGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 00:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbYHDEGf
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 00:06:35 -0400
Received: from george.spearce.org ([209.20.77.23]:49714 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbYHDEGe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 00:06:34 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 11F9338419; Mon,  4 Aug 2008 04:06:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7968d7490808030031v39726af6r9f88feb28df02de7@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91313>

Lee Marlow <lee.marlow@gmail.com> wrote:
> On Sat, Aug 2, 2008 at 3:05 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> >
> > Hmm.  The has_doubledash test seems redundant since we don't do
> > anything with args that aren't --foo.  Even though git-grep will
> > accept a tree-ish and thus completion of __git_refs here may
> 
> I haven't found myself using grep to search anything but the current
> working directory.  I wonder whether __git_complete_file would be
> better than __git_refs.  My issue with __git_complete_file in this
> case and also doing completion for 'git mv' is that it falls back to
> just __git_refs.  Would it be better if it fell back to __git_refs and
> ls-tree for HEAD?  That way when using completion to get to
> Documentation/git-grep.txt,  it doesn't also show completions for
> Documentation/git-grep.{1,html,xml}.

Hmm.  __git_complete_file is about completing something in a tree-ish,
which is really most likely not what we want for grep.  Its useful for
git-show and git-cat-file, and that's about it.  Most git tools prefer
a calling format of "tree-ish -- paths ..." and not "tree-ish:path".

Though I think you have an excellent point about completing paths
by ls-tree for HEAD rather than the working directory itself,
as then you can avoid produced files.  But in practice how often
do you pass a single file or a couple of files to the grep utility
and are having problems bypassing the build products?  Compared to
just running grep on the entire source tree to find hits?  I never
use grep to search in a single file, but I call it several times
a day to look for where a function is defined or called.

After having thought about it your original patch makes the most
sense, but without the has_doubledash test.

-- 
Shawn.
