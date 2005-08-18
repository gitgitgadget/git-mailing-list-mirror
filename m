From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Multi-head pulling series
Date: Thu, 18 Aug 2005 12:45:58 +0200
Message-ID: <200508181245.58250.Josef.Weidendorfer@gmx.de>
References: <7vek8rlnbn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 18 12:48:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5hvT-000532-SD
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 12:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVHRKrI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 06:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVHRKrI
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 06:47:08 -0400
Received: from pop.gmx.net ([213.165.64.20]:13545 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932174AbVHRKrH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2005 06:47:07 -0400
Received: (qmail invoked by alias); 18 Aug 2005 10:47:06 -0000
Received: from p54969642.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.150.150.66]
  by mail.gmx.net (mp034) with SMTP; 18 Aug 2005 12:47:06 +0200
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7vek8rlnbn.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thursday 18 August 2005 09:24, Junio C Hamano wrote:
> 	$ cat $GIT_DIR/remotes/www
> 	URL: http://www.kernel.org/pub/scm/git/git.git/
> 	Pull: master:ko-master pu:ko-pu
>       Push: master:master pu:pu foo:bar

Isn't this mixing two kinds of information:
1) Some default/persistent mapping of local to remote heads
2) The default heads which are pulled/pushed when only giving the remote, like 
in:

> 	$ git push mko ;# push our master and pu to the same
> 			# name, foo to .git/refs/heads/bar.

I think it makes sense to be able to store mappings without adding the head to
the default group of heads pulled.

Can we put the default pull/push actions in separate lines, like

 	$ cat $GIT_DIR/remotes/mko
 	URL: master.kernel.org:/pub/scm/git/git.git/
 	Pull: master:ko-master pu:ko-pu mylocal:myremote
	Push: master:master pu:pu foo:bar
	Default-Pull: master pu
	Default-Push: master pu foo
	
> 	$ git push mko pu:refs/heads/testing
> 			# instead of pushing to the usual ref,
>                         # push our pu to refs/heads/testing,
>                         # this time only.

With a command (push/fetch/pull) giving an explicit local/remote mapping, it 
would be cool to automatically add the given mapping to the remotes/ file if 
there is no push-mapping for pu yet, so that you can have the same later with 
only

	git push mko pu

And finally, it would be nice to specify a default mapping for arbitrary heads

	$ cat $GIT_DIR/remotes/www
 	URL: http://www.kernel.org/pub/scm/git/git.git/
 	Pull: www#*:*

Such that

	git fetch www#pu

will fetch head pu into local head .refs/heads/www#pu


Josef

PS: I know I should provide patches for my proposals. But let discuss them 
first.
