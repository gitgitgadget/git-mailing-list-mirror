From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 22:37:27 +0200
Message-ID: <vpqvcz3x9q0.fsf@bauges.imag.fr>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
	<AANLkTin1QCda9BV+gND1kcXRTZBF7hj3Chce5OkLX2a9@mail.gmail.com>
	<4D909DD1.2050904@viscovery.net>
	<AANLkTinC9Lr9uCTUZSVxVR56+FQm2NGRpPu90fm9OHF5@mail.gmail.com>
	<vpq62r3i1z4.fsf@bauges.imag.fr>
	<AANLkTimT+WN2F-BmQzQrAs3uizHig9cCXDUdc7nQ-vC5@mail.gmail.com>
	<vpqr59r6sg5.fsf@bauges.imag.fr>
	<AANLkTinuH4Ut+jtdqRfFrNeXA6JmBK2i0ddCcz4vV6JC@mail.gmail.com>
	<vpqvcz35cjk.fsf@bauges.imag.fr>
	<AANLkTikADLZvN0N==_H47O1vcrap1_Mcf7vW69d5sh0d@mail.gmail.com>
	<AANLkTimR5XfOV-0RZjdyu72E9JdBfr1B+wc=q55V4qH5@mail.gmail.com>
	<vpqbp0v2fve.fsf@bauges.imag.fr>
	<AANLkTim+iQ89b49nC8NRtoUobV4tMVL+bCoW-vg3+rLD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: demerphq <demerphq@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andrew Garber <andrew@andrewgarber.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 22:40:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4JEl-0001Lm-Tm
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 22:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755044Ab1C1Uk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 16:40:26 -0400
Received: from imag.imag.fr ([129.88.30.1]:41806 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753911Ab1C1UkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 16:40:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p2SKbSQB010687
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Mar 2011 22:37:28 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Q4JBo-0004L4-3I; Mon, 28 Mar 2011 22:37:28 +0200
In-Reply-To: <AANLkTim+iQ89b49nC8NRtoUobV4tMVL+bCoW-vg3+rLD@mail.gmail.com>
	(Andrew Garber's message of "Mon, 28 Mar 2011 16:12:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 28 Mar 2011 22:37:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170187>

Andrew Garber <andrew@andrewgarber.com> writes:

> But what about demerphq's example? (see below)
>
>>      Bx--B--B--B*
>>     /
>>  --Gz--By--B--Gx--G*
>>
>> How does knowing that G* is good help you to find that Bx broke the
>> code in the B* branch again?

If all you want is to know which commit introduced the bug, it doesn't.
But usually, what you're really looking for is an explanation and a fix
for the bug. Let's see what git bisect tells us then:

$ git bisect start
$ git bisect good <good-branch>
$ git bisect bad <bad-branch>
Bisecting: a merge base must be tested
[f1fac16fb39dbe421b5cc4bcb945433495c794e1] ...
$ git bisect bad
The merge base f1fac16fb39dbe421b5cc4bcb945433495c794e1 is bad.
This means the bug has been fixed between f1fac16fb39dbe421b5cc4bcb945433495c794e1
 and [089840ef9f8b97ddc9e28fa152c65115fb0b649a].

This doesn't tell you where the bug was introduced, but gives you
something which is usually even more valuable: where to find the fix.
Then, you have the choice between merging the good branch into the bad
one (like merging a maintainance branch into a dev branch), or to bisect
again to find the actual fix in good-branch.

If you really wanted to find the first bad commit, you've spent one
iteration sub-optimally and can start a new bisect with the merge base
as the base commit.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
