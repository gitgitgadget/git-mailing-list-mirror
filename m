From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Please pull the patch series "use the $( ... ) construct for command substitution"
Date: Thu, 15 May 2014 09:45:22 +0200
Message-ID: <vpq38gbfpt9.fsf@anie.imag.fr>
References: <CA+EOSBk4YvQHTG=gRd1TF9gX0OgjLpjRidh7NAa9wmjr6bSkBQ@mail.gmail.com>
	<vpqoaz0i8od.fsf@anie.imag.fr>
	<CAPig+cT-Nn_hnqE0CK=c0-9+_QG9hpsp9j4cERsvvjwkrLmSMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elia Pinto <gitter.spiros@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 15 09:45:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkqMF-0007zj-Bk
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 09:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207AbaEOHpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 03:45:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35475 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753784AbaEOHpe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 03:45:34 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s4F7jMbm019782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 May 2014 09:45:22 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s4F7jM6r018148;
	Thu, 15 May 2014 09:45:22 +0200
In-Reply-To: <CAPig+cT-Nn_hnqE0CK=c0-9+_QG9hpsp9j4cERsvvjwkrLmSMw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 14 May 2014 17:21:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 15 May 2014 09:45:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s4F7jMbm019782
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1400744723.17302@BgvYhxg6Bj+IWcboxi2zJw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249066>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, May 14, 2014 at 1:14 PM, Matthieu Moy
>
>> I do not understand the use of the \ in front of the ` in the original
>> code.
>
> The second argument of test_expect_success is double-quoted, so a bare
> `...` would be evaluated before test_expect_success is even invoked.
> Quoting it as \'...\' correctly suppresses the automatic evaluation,
> giving test_expect_success the opportunity to evaluate it on-demand.

Ah, of course, you're right.

>> The correct code should be
>>
>>         test x\"$(sed -n -e 4p < file)\" = x4 &&
>>
>> I guess.
>
> Same issue. The $(...) is being evaluated even before
> test_expect_success is invoked. Better would be to suspend evaluation
> via \$(...) to allow test_expect_success to evaluate it on-demand.

OK, then the correct code should be

        test x\"\$(sed -n -e 4p < file)\" = x4 &&

And the other attempt was close:

> >  test_expect_success 'verify pre-merge ancestry' "
> > -       test x\`git rev-parse --verify refs/heads/svn^2\` = \
> > -            x\`git rev-parse --verify refs/heads/merge\` &&
> > +       test x\$(git rev-parse --verify refs/heads/svn^2\) = \
> > +            x\$(git rev-parse --verify refs/heads/merge\) &&

\-escaping the $ was right, but the \) should be a single ).

In any case, the fact that we need to discuss this supports my claim
"this should be reviewed as a separate series".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
