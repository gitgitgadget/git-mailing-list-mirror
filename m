From: Sebastian Pipping <webmaster@hartwork.org>
Subject: Re: [BUG?] Re: fail to svn clone debian's kernel repository
Date: Wed, 03 Mar 2010 02:20:00 +0100
Message-ID: <4B8DB940.9020609@hartwork.org>
References: <20090610160524.GA24435@pengutronix.de> <4B8B21A8.6000603@hartwork.org> <20100302195454.GB12942@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Wed Mar 03 02:21:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmdH8-0002lS-9I
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 02:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305Ab0CCBVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 20:21:16 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.32]:52074 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab0CCBVP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 20:21:15 -0500
Received: from [92.225.25.240] (helo=[192.168.0.3])
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <webmaster@hartwork.org>)
	id 1NmdFo-0005ME-R4; Wed, 03 Mar 2010 02:20:00 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7) Gecko/20100228 Thunderbird/3.0.1
In-Reply-To: <20100302195454.GB12942@vidovic>
X-Df-Sender: 874396
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141429>

On 03/02/10 20:54, Nicolas Sebrecht wrote:
> I've stopped cloning at r10252 with current next version. I didn't
> notice any problem.

I've been working with another repository.

My case is reproducable as following:
=======================================================
ABS_SVN_SOURCE="$PWD/portage-anon-svn-repo-dump/"
rsync -r rsync://anonvcs.gentoo.org/vcs-public-svnroot/portage/ \
  "${ABS_SVN_SOURCE}"
mkdir portage-git
cd portage-git
git svn init file://"${ABS_SVN_SOURCE}" \
  --trunk=trunk --tags=NOTAGS --branches=NOBRANCHES
git svn fetch -r1:1890
git config --remove-section 'svn-remote.svn'
git svn init file://"${ABS_SVN_SOURCE}" \
  --trunk=main/trunk --tags=main/tags --branches=main/branches
git svn fetch -r1891:HEAD
=======================================================

The last command the fails with:
=======================================================
Found possible branch point:
file:///home/sping/__playground/portage-git-playground/portage-anon-svn-repo-dump/main/trunk
=>
file:///home/sping/__playground/portage-git-playground/portage-anon-svn-repo-dump/main/branches/savior,
1890
Found branch parent: (refs/remotes/savior)
3d100e8bd4e84f2779af6217cf60ebd168647733
Following parent with do_switch
Invalid filesystem path syntax: Cannot replace a directory from within
at /usr/libexec/git-core/git-svn line 5089
=======================================================

# git --version
git version 1.7.0.1.61.gdc05d.dirty


> Does the tests pass for you ?
> 
>   $ cd t
>   $ make

master
  fixed   1
  success 5657
  failed  0
  broken  16
  total   5674

next
  fixed   1
  success 5732
  failed  0
  broken  16
  total   5758

# git branch -v
  branch-master dc05d73 Merge branch 'maint'
* master        dc05d73 Merge branch 'maint'
  next          6604fd0 Merge branch 'jn/makedepend' into next



Sebastian
