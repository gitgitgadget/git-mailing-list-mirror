From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: git diff: support "-U" and "--unified" options properly
Date: Sun, 14 May 2006 14:57:17 +0200
Message-ID: <200605141457.17314.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org> <Pine.LNX.4.64.0605131404391.3866@g5.osdl.org> <7vpsihsjq6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 14:57:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfGAL-00047U-JX
	for gcvg-git@gmane.org; Sun, 14 May 2006 14:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWENM5j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 08:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWENM5j
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 08:57:39 -0400
Received: from mail.gmx.de ([213.165.64.20]:23239 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750801AbWENM5i (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 08:57:38 -0400
Received: (qmail invoked by alias); 14 May 2006 12:57:36 -0000
Received: from p54968B53.dip0.t-ipconnect.de (EHLO noname) [84.150.139.83]
  by mail.gmx.net (mp039) with SMTP; 14 May 2006 14:57:36 +0200
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
In-Reply-To: <7vpsihsjq6.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19961>

On Saturday 13 May 2006 23:22, you wrote:
>  * remotes/ information from .git/config (js/fetchconfig)
> ...
>    [branch "master"]
> 	remote = "ko-private"

Why is this line needed? In this example, what is the relationship
of local "master" with the remote? I think it is enough to specify
the local upstream branch:

 [branch "master"]
    origin = "ko-master"

For the default pull action when on "master", we would have to look
up for remotes with a fetch line fetching into "ko-master", which
could be cumbersome. Besides, the fetch lines specify default actions
when fetching from a given remote, and there is no garantuee that we
want fetching into "ko-master" as any default action.

So we need

 [branch "ko-master"]
    tracksremote = "master of ko-private"

This also would specify that we are not allowed to commit on "ko-master".

If we do not want to have a local tracking branch at all, we would have

 [branch "master"]
    origin = "master of ko-private"

or

 [branch "master"]
    origin = "master of kernel.org:/pub/scm/git/git.git"


For a default push action when on master, I would add

 [branch "master"]
    push = "master of ko-private"

or alternatively

 [branch "master"]
    push = "master of kernel.org:/pub/scm/git/git.git"

> ...
>    [remote "ko"]
>    	url = "kernel.org:/pub/scm/git/git.git"
>       push = master:master
> ...
> 	fetch = master:ko-master

These specifications more or less are independent from the above,
as it specifies the defaults when fetching/pushing to the specified remote.

Josef

PS: Patch pending...
