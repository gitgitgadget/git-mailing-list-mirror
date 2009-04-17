From: William DiNoia <william.dinoia@mac.com>
Subject: Re: git for local web development
Date: Fri, 17 Apr 2009 15:44:43 +0000 (UTC)
Message-ID: <loom.20090417T153819-898@post.gmane.org>
References: <135754252540163221910297561025355826788-Webmail@me.com> <20090417115925.GB29121@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 17:46:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuqGu-0002LL-6f
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 17:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936AbZDQPo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 11:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753257AbZDQPo5
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 11:44:57 -0400
Received: from main.gmane.org ([80.91.229.2]:55808 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441AbZDQPo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 11:44:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LuqFK-0002kW-FH
	for git@vger.kernel.org; Fri, 17 Apr 2009 15:44:54 +0000
Received: from c-76-117-28-254.hsd1.pa.comcast.net ([76.117.28.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 15:44:54 +0000
Received: from william.dinoia by c-76-117-28-254.hsd1.pa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 15:44:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 76.117.28.254 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.7) Gecko/2009032803 Iceweasel/3.0.6 (Debian-3.0.6-1))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116751>

Jeff King <peff <at> peff.net> writes:

> 
> On Thu, Apr 16, 2009 at 07:04:10PM -0400, William DiNoia wrote:
> 
> > I would like to be able to git-push and have the work tree updated.
> >
> > [...]
> >
> > $vim .git/hooks/post-receive
> >  #!/bin/sh
> >  git-checkout -f
> > $chmod +x .git/hooks/post-receive
> >
> > [...]
> >
> > Counting objects: 5, done.
> > Compressing objects: 100% (2/2), done.
> > Writing objects: 100% (3/3), 277 bytes, done.
> > Total 3 (delta 1), reused 0 (delta 0)
> > Unpacking objects: 100% (3/3), done.
> > To /var/www/sites/test.com/.git
> >    9b490a2..5e5cc63  master -> master
> > error: unable to unlink old 'index.html' (Permission denied)
> > error: hooks/post-receive exited with error code 1
> 
> Well, your post-receive hook is running, and checkout is barfing with a
> permission denied error. Probably the repo directory is owned by
> www-data, and you are pushing as user "william"? What are the directory
> permissions like?
> 
> -Peff

I have since switched to using the post-update hook which now looks like:

git-checkout -f
exec git-update-server-info

However upon git-push from /home/william/Desktop I receive the following:

Counting objects: 5, done.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 281 bytes, done.
Total 3 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
To /var/www/sites/test.com/.git
   e337c9b..581228f  master -> master
error: unable to unlink old 'index.html' (Permission denied)

The repo is owned by "www-data" and I am pushing as user "william". "william"
is in the "www-data" group. I also ran

git-config core.sharedrepository group

as "www-data", but no change...
