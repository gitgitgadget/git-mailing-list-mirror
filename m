From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2] Make git_dir a path relative to work_tree in
 setup_work_tree()
Date: Thu, 19 Jun 2008 14:44:11 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806191427000.19665@iabervon.org>
References: <alpine.LNX.1.00.0806182327090.19665@iabervon.org> <7vod5xuvtj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 20:45:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9P8E-0000lj-7Y
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 20:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756007AbYFSSoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 14:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755942AbYFSSoO
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 14:44:14 -0400
Received: from iabervon.org ([66.92.72.58]:37929 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755213AbYFSSoN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 14:44:13 -0400
Received: (qmail 4453 invoked by uid 1000); 19 Jun 2008 18:44:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Jun 2008 18:44:11 -0000
In-Reply-To: <7vod5xuvtj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85510>

On Thu, 19 Jun 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > diff --git a/path.c b/path.c
> > index b7c24a2..790d8d4 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -294,6 +294,23 @@ int adjust_shared_perm(const char *path)
> >  /* We allow "recursive" symbolic links. Only within reason, though. */
> >  #define MAXDEPTH 5
> >  
> > +const char *make_relative_path(const char *abs, const char *base)
> > +{
> > +	static char buf[PATH_MAX + 1];
> > +	int baselen;
> > +	if (!base)
> > +		return abs;
> 
> This special case may help the specific caller you have below, but doesn't
> it make the function do more than it advertises with its name?

I don't think so; the best path relative to nothing is the absolute path. 
The idea is to return the easiest equivalent path if your pwd is known to 
be "base" and you give it an absolute path. If you don't know what your 
pwd is, the easiest equivalent path is the absolute path with no symlinks. 
Similarly, you get an absolute path if the path you give it isn't inside 
base. Maybe "make_brief_path" would be a better name?

> Other than that, I think the change is Ok, but as a "performance tweak",
> it should be backed by some numbers, please?

I was hoping Linus would provide some, since he'd noticed the slowness in 
the first place. I'm not sure I have the RAM to have the kernel spend 
non-trivial time looking up path elements in an all-cached tree. I'll try 
to replicate Linus's test case when I get a chance if he hasn't said 
anything.

	-Daniel
*This .sig left intentionally blank*
