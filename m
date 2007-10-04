From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-init: don't base core.filemode on the ability to
 chmod.
Date: Thu, 04 Oct 2007 10:36:15 +0200
Message-ID: <4704A5FF.6070105@viscovery.net>
References: <20071003105501.GD7085@admingilde.org>	<470388DC.4040504@viscovery.net>	<20071003231941.GA20800@admingilde.org>	<Pine.LNX.4.64.0710040053380.28395@racer.site>	<470482A2.3080907@op5.se> <7vr6kbbdph.fsf@gitster.siamese.dyndns.org>	<20071004071751.GD20800@admingilde.org> <7vir5nb89d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Waitz <tali@admingilde.org>, Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 10:36:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdMC5-0005hA-0v
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 10:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbXJDIgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 04:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753939AbXJDIgV
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 04:36:21 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:9984 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753654AbXJDIgU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 04:36:20 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IdMBo-000541-Ps; Thu, 04 Oct 2007 10:36:13 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3FE7D6B7; Thu,  4 Oct 2007 10:36:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vir5nb89d.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59931>

Junio C Hamano schrieb:
> Martin Waitz <tali@admingilde.org> writes:
>> On Wed, Oct 03, 2007 at 11:23:22PM -0700, Junio C Hamano wrote:
>>> filemode = !( (st1.st_mode & S_IXUSR)
>>>         	/* we did not ask for x-bit -- bogus FS */
>>> 	    || chmod(path, st1.st_mode & S_IXUSR)
>>>         	/* it does not let us flip x-bit -- bogus FS */
>>> 	    || lstat(path, &st2)
>>>         	/* it does not let us read back -- bogus FS */
>>> 	    || (st1.st_mode == st2.st_mode)
>>> 	        /* it forgets we flipped -- bogus FS */
>>> 	    );
>> that looks good.
> 
> I do not think git on Cygwin nor WinGit creates $GIT_DIR/config
> with executable bit set.  Is this pretty much a workaround only
> for vfat-on-Linux ?

I think so. Here on Windows, 'ls -l' after 'git init' tells that .git/config 
is not executable (both FAT and NTFS). But, anyway, as far as the MinGW port 
is concerned, at least the last condition in the sequence above triggers and 
causes filemode=false, which is good.

-- Hannes
