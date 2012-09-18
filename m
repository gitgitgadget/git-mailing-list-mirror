From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase -i: fix misleading error message after 'exec no-such' instruction
Date: Tue, 18 Sep 2012 13:38:42 +0200
Message-ID: <vpqtxuvk1bx.fsf@grenoble-inp.fr>
References: <505857CE.3050909@viscovery.net> <vpq7grrlgqy.fsf@grenoble-inp.fr>
	<50585B1E.6030900@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 13:38:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDw8n-0002eq-5D
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 13:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758078Ab2IRLit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 07:38:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43133 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758017Ab2IRLis (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 07:38:48 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8IBXvaD008391
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Sep 2012 13:33:57 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TDw8Y-0003e2-EP; Tue, 18 Sep 2012 13:38:42 +0200
In-Reply-To: <50585B1E.6030900@viscovery.net> (Johannes Sixt's message of
	"Tue, 18 Sep 2012 13:29:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 18 Sep 2012 13:33:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8IBXvaD008391
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1348572841.34495@/0HS1n2fFW2W+w8oG2iM6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205823>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 9/18/2012 13:20, schrieb Matthieu Moy:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> 
>>> From: Johannes Sixt <j6t@kdbg.org>
>>>
>>> When the todo sheet of interactive rebase instructs to run a non-existing
>>> command, the operation stops with the following error:
>>>
>>>   Execution failed: no-such
>>>   You can fix the problem, and then run
>>>
>>>           git rebase --continue
>>>
>>>   fatal: 'rebase' appears to be a git command, but we were not
>>>   able to execute it. Maybe git-rebase is broken?
>> 
>> While you're there, maybe you want to turn the first line into
>> 
>> Execution failed: no-such (command not found)
>
> No, I don't want to: Neither do we have errno here, nor can we be specific
> enough because the whole shell script the user gave after 'exec' is
> repeated here.
>
> I would rather remove the line so that it does not distract from the more
> specific error message that the shell gave. On top of that, the command is
> already dumped before it is executed; we don't need to repeat it.

Not sure what you mean: remove the line in case $status = 127, or remove
it anyway.

If you mean only when $status = 127, then that is indeed a good idea, as
the full error message looks like

  Executing: nosuchcommand
  zsh:1: command not found: nosuchcommand
  Execution failed: nosuchcommand
  You can fix the problem, and then run [...]

So, yes, the shell's error message is enough and more precise than we
could do in git rebase.

If you mean remove it in any case, I disagree: repeating the command is
usually not very useful, but may help when the command itself produced a
lot of output (e.g. "exec make test" oftens fills-in your terminal's
buffer). And the information that the command fails can be important if
the command failed silently, e.g. with "exec false":

  Executing: false
  Execution failed: false
  You can fix the problem, and then run [...]

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
