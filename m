From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Unable to clone an ssh repository (with ugly installation-specific
 workaround)
Date: Tue, 12 Feb 2008 09:37:48 +0100
Message-ID: <47B15ADC.8080309@viscovery.net>
References: <51419b2c0802111822k4600e06bp4167a09b30bf947a@mail.gmail.com> <m31w7iegk6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 09:38:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOqep-0006yh-5E
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 09:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbYBLIhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 03:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbYBLIhx
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 03:37:53 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:57144 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbYBLIhx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 03:37:53 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JOqdp-0000g9-B3; Tue, 12 Feb 2008 09:37:26 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DE66E6B7; Tue, 12 Feb 2008 09:37:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <m31w7iegk6.fsf@localhost.localdomain>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73642>

Jakub Narebski schrieb:
> "Elijah Newren" <newren@gmail.com> writes:
> 
>> I'm pretty sure this worked before, but with git-1.5.4, when trying to
>> clone a repository via ssh from a machine that does not have git
>> installed in a standard system path, I get the following:
>>
>> $ git clone -u /home/enewren/software/install/linux/git/bin/git-upload-pack
>> ssh://enewren@remote/var/scratch/enewren/votd
>> Initialized empty Git repository in /home/newren/devel/votd/.git/
>> remote: fatal: exec pack-objects failed.
> 
> git-pull(1)
> [...]
>        --upload-pack <upload-pack>
>               When  given,  and  the  repository  to  fetch from is handled by
>               git-fetch-pack, --exec=<upload-pack> is passed to the command to
>               specify non-default path for the command run on the other end.
> 

The OP *did* use this option (rather, its short form, -u), see above.

The problem is that git-upload-pack (which is not a built-in) does not
call setup_path() and so does not extend PATH to contain the special
installation location. Now, when git-upload-pack tries to exec
git-pack-objects, it fails since this is not in PATH.

A quick work-around for Elijah is to add

   GIT_EXEC_PATH=/home/enewren/software/install/linux/git/bin

to .profile on the remote host.

-- Hannes
