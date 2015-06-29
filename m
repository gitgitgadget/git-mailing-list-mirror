From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Mon, 29 Jun 2015 11:32:06 +0200
Message-ID: <vpqsi9alv1l.fsf@anie.imag.fr>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
	<CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
	<558F8B55.1070708@alum.mit.edu>
	<CAPc5daWmhkqDL0pNYne4-kRoxWK7ObcOKxtE5DsfHA2cnMM1pQ@mail.gmail.com>
	<558F9854.5080605@alum.mit.edu>
	<CAP8UFD0NjExQJHQWix1+zc4_k15e3+aC5vAv=dHipg-X+2y1sQ@mail.gmail.com>
	<vpq1tgvnf2g.fsf@anie.imag.fr>
	<CAP8UFD1gWXOZHfiELZYgvGP1dA-aeaxbyaokKCut9pfWghy9uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 11:32:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9VQL-0006jL-Tf
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 11:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbbF2JcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 05:32:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35757 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547AbbF2JcP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 05:32:15 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5T9W5Gk024377
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jun 2015 11:32:05 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5T9W6Ma023399;
	Mon, 29 Jun 2015 11:32:06 +0200
In-Reply-To: <CAP8UFD1gWXOZHfiELZYgvGP1dA-aeaxbyaokKCut9pfWghy9uQ@mail.gmail.com>
	(Christian Couder's message of "Mon, 29 Jun 2015 10:08:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 29 Jun 2015 11:32:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5T9W5Gk024377
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436175128.32093@/JYUKK9FRiFnoITCqMs28w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272946>

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Jun 29, 2015 at 9:34 AM, Matthieu Moy
>
>> As a user, when I
>> discovered "git bisect", I was actually surprised that it expected one
>> particular order between good and bad. I would have expected to be able
>> to say "this is good, this is bad, tell me where it changed" without
>> having an idea of who's good and who's bad.
>
> Maybe, but it's not how it has been developed.

... but it's how it would behave if we had this guessing feature. The
user does not have to care whether we internally need "good is an
ancestor of bad" if we can provide a user-interface which does not need
that.

I find it particularly frustrating that we issue the message:

  "The merge base %s is bad.\n"
  "This means the bug has been fixed "
  "between %s and [%s].\n"

bisect is all about finding the commit where a property has changed, and
here it stops, saying "I know it's between A and B, but I won't go
further".

>> In particular when bisecting from two branches, the user knows that
>> branch A is good, and branch B is bad, but does not necessarily know
>> whether it's a regression in B or a
>> fix in A. The fact that bisect can find out should be just "normal" from
>> the user point of view. There's no mistake involved, nothing to fix, and
>> nothing that went wrong.
>
> Well in this case, it's possible that the merge base is bad and what
> the user is interested in is the first bad commit that was commited
> before the merge base. We just don't know, in the case the merge base
> is bad, what is more interesting for the user.

The question asked by the user is "X is good, Y is bad, tell me where
exactly it changed". We can't know for sure what is "interesting" for
the user, but we can answer his question anyway.

Similarly, there can be several commits that introduce the same
regression (this may happen if you cherry picked the guilty commit from
branch A to branch B, and then merged A and B, or if you broke, fixed,
and then broke again). bisect finds one transition from good to bad, but
not all. It may or may not be the one the user wanted, but we can't
know.

>> I think I prefer "term" to "name".
>
> Ok with that. I agree that it would be more consistent to have a "git
> bisect terms" and "--term-{old,new,bad,good}".

OK, I've applied it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
