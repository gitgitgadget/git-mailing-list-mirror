From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [BUG?] Re: fail to svn clone debian's kernel repository
Date: Wed, 3 Mar 2010 15:33:12 +0100
Message-ID: <201003031533.13056.trast@student.ethz.ch>
References: <20090610160524.GA24435@pengutronix.de> <20100302195454.GB12942@vidovic> <4B8DB940.9020609@hartwork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	"Uwe =?iso-8859-1?q?Kleine-K=F6nig?=" 
	<u.kleine-koenig@pengutronix.de>, <git@vger.kernel.org>
To: Sebastian Pipping <webmaster@hartwork.org>
X-From: git-owner@vger.kernel.org Wed Mar 03 15:33:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmpdc-0000DH-KW
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 15:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab0CCOdS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 09:33:18 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:54930 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754643Ab0CCOdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 09:33:16 -0500
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 3 Mar
 2010 15:33:15 +0100
Received: from thomas.localnet (129.132.153.219) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 3 Mar
 2010 15:33:13 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <4B8DB940.9020609@hartwork.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141454>

On Wednesday 03 March 2010 02:20:00 Sebastian Pipping wrote:
> git svn init file://"${ABS_SVN_SOURCE}" \
>   --trunk=trunk --tags=NOTAGS --branches=NOBRANCHES
> git svn fetch -r1:1890
> git config --remove-section 'svn-remote.svn'
> git svn init file://"${ABS_SVN_SOURCE}" \
>   --trunk=main/trunk --tags=main/tags --branches=main/branches
> git svn fetch -r1891:HEAD
[...]
> Invalid filesystem path syntax: Cannot replace a directory from within
> at /usr/libexec/git-core/git-svn line 5089

While arguably[*] a bug, you can work around it by simply not removing
the previous trunk from git-svn's 'fetch' lines.  I.e., the following
config works for me after r1890:

[svn-remote "svn"]
	url = file:///.../portage-anon-svn-repo-dump
	fetch = main/trunk:refs/remotes/trunk2
	branches = main/branches/*:refs/remotes/branches/*
	tags = main/tags/*:refs/remotes/tags/*
	fetch = trunk:refs/remotes/trunk

You can later use update-ref (or even just mv) to rename trunk2 to
trunk.

You may also want to place the cutoff in the above commands at
1889/1890 instead, since r1890 is the one that does the move.
Combining this fix with the above config results in correct
"continuous" history of trunk, whereas merely using the config above
results in a disconnect at the move.


[*] SVN also fails if you check out trunk@1889 and attempt to 'svn update' it

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
