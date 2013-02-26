From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Better handling of erroneous git stash save "somemessage" --keep-index
Date: Tue, 26 Feb 2013 17:21:17 +0100
Message-ID: <vpq1uc3cagy.fsf@grenoble-inp.fr>
References: <CAPs+M8JvcnTcZiySmpMBuOxek4THRnTx0jkZv7NHaSDNLhcOAQ@mail.gmail.com>
	<7vwqtvm4yr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Gunnlaugur Thor Briem <gunnlaugur@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 17:23:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UANJA-0000Vh-5a
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 17:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759154Ab3BZQWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 11:22:47 -0500
Received: from mx2.imag.fr ([129.88.30.17]:48909 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758214Ab3BZQWq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 11:22:46 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r1QGLFOH011190
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 26 Feb 2013 17:21:15 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UANHJ-000453-Gb; Tue, 26 Feb 2013 17:21:17 +0100
In-Reply-To: <7vwqtvm4yr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 26 Feb 2013 08:10:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 26 Feb 2013 17:21:16 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1QGLFOH011190
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1362500476.69422@dI2wqriGVgZ5HWfS2VkLlg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217143>

Junio C Hamano <gitster@pobox.com> writes:

> Gunnlaugur Thor Briem <gunnlaugur@gmail.com> writes:
>
>> the command:
>>
>> git stash save "some message" --keep-index
>>
>> stashes everything, including the index, and adds the "--keep-index"
>> to the message. The manual labor of separating index hunks from hunks
>> to stash is lost. This is in version 1.8.1.3.

Not lost, it's saved as part of the stash. "git stash pop --index" will
restore it.

>> This is a user error, of course (per the man page, parameters are not
>> accepted after the message). But it would be better handled by
>> erroring out, with a message like "git stash save does not permit
>> parameters after the stash message".
>
> Then the user cannot say
>
> 	git stash save some message that consists of multiple words
>
> no?

I didn't even know that multi-words messages would be allowed this way.
That seems to me to be really weird indeed.

I can't say

  git commit -m multi word message

so why would people want to omit quotes for "git stash" is a total
mystery. That said, we can't deny it right now, to preserve backward
compatibility.

My feeling is that "git stash save" should learn a "-m, --message"
option analogous to the one of "git commit", and then the "message on
the command-line" syntax could be deprecated.

(One nice side effect would be that in the very long term, we may want
to allow "git stash save -- <pathspecs>" to do a limited stash)

But maybe it's not worth the effort, I don't know.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
