From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH v2] git-pull.sh: better warning message for "git pull" on detached head.
Date: Tue, 07 Apr 2009 13:36:41 +0200
Message-ID: <vpqvdpgn19y.fsf@bauges.imag.fr>
References: <e2b179460904070224o3057c6efk6930bd1249adb0fe@mail.gmail.com>
	<1239098181-10360-1-git-send-email-Matthieu.Moy@imag.fr>
	<20090407104145.GA22658@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Apr 07 13:42:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr9gz-0004eZ-7U
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 13:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbZDGLjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 07:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbZDGLjp
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 07:39:45 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:41834 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751266AbZDGLjp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 07:39:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n37BafGq009394;
	Tue, 7 Apr 2009 13:36:42 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Lr9bd-0006rm-JR; Tue, 07 Apr 2009 13:36:41 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Lr9bd-0003Kv-HB; Tue, 07 Apr 2009 13:36:41 +0200
In-Reply-To: <20090407104145.GA22658@pvv.org> (Finn Arne Gangstad's message of "Tue\, 7 Apr 2009 12\:41\:46 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Tue, 07 Apr 2009 13:36:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115948>

Finn Arne Gangstad <finnag@pvv.org> writes:

> On Tue, Apr 07, 2009 at 11:56:21AM +0200, Matthieu Moy wrote:
>> Otherwise, git complains about not finding a branch to pull from in
>> 'branch..merge', which is hardly understandable. While we're there,
>> reword the sentences slightly.
>> [...]
>> +	if [ -z "$curr_branch" ]; then
>> +		echo "You asked me to pull without telling me which branch you want"
>> +		echo "to merge with, and you are on a detached HEAD, so I cannot"
>> [...]
>
> In this case why can't we just do
>
> echo "You are currently not on any branch."

Well, I would understand this as "you can't pull when you're not on a
branch", which would be incorrect.

> echo "git pull cannot be run without arguments unless you are on a branch."

This is better (less missleading).

> And possibly also something like this:
>
> echo "Usage: git pull <repository> <refspec>."
> echo " See git-pull(1) for details."

This usage string would be incorrect, repository and refspec are not
always mandatory. To be correct, it should be
Usage: git pull [<repository> <refspec>]
and then you're back to the problem of having to explain why they are
optionnal.

> If you need all the verbosity this error otherwise gives, "detached
> HEAD" is probably going to be confusing?

Grepping the source, "not on a branch" seems more widely used than
"detached head" in the UI (including in another place of git-pull.sh),
so, yes, something like this would be better:

	if [ -z "$curr_branch" ]; then
		echo "You are not currently on a branch, so I cannot use any"
		echo "'branch.<branchname>.merge' in your configuration file."
		echo "Please specify which branch you want to merge on the command"
		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
		echo "See git-pull(1) for details."
	else

-- 
Matthieu
