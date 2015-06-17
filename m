From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 05/11] ref-filter: add parse_opt_merge_filter()
Date: Wed, 17 Jun 2015 10:27:41 +0200
Message-ID: <vpqzj3yzqma.fsf@anie.imag.fr>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
	<1434464457-10749-1-git-send-email-karthik.188@gmail.com>
	<1434464457-10749-5-git-send-email-karthik.188@gmail.com>
	<vpqmvzz7hjq.fsf@anie.imag.fr>
	<CAOLa=ZS_gY-MuGJ86TFpHhMXNYJ1gHWQWyfv71gDCVm1sMXZNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 10:27:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z58hP-0006hb-B5
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 10:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbbFQI1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 04:27:51 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45078 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752466AbbFQI1r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 04:27:47 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5H8ReAX009170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Jun 2015 10:27:40 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5H8RfWh030577;
	Wed, 17 Jun 2015 10:27:41 +0200
In-Reply-To: <CAOLa=ZS_gY-MuGJ86TFpHhMXNYJ1gHWQWyfv71gDCVm1sMXZNw@mail.gmail.com>
	(karthik nayak's message of "Tue, 16 Jun 2015 22:00:20 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 17 Jun 2015 10:27:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5H8ReAX009170
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435134464.02967@u4o209IPZPMnAD8XQYVXSg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271818>

karthik nayak <karthik.188@gmail.com> writes:

> On Tue, Jun 16, 2015 at 9:48 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> This is copied from 'builtin/branch.c' which will eventually be removed
>>> when we port 'branch.c' to use ref-filter APIs.
>>
>> Earlier in the series you took code from tag.c.
>>
>> I think you should focus on either merge or tag, get a ref-filter-based
>> replacement that passes the tests for it, and then consider the other.
>> The fact that the test pass for a rewritten command is important to
>> check the correctness of the these patches.
>>
>> I'm not asking you to remove commits from this series though. Just
>> impatient to see one command fully replaced (actually, I see that you
>> have more commits than you sent in your branch, so I guess it will come
>> soon on the list) :-).
>>
>
> The idea is to currently get ref-filter to support all options and port it over
> to for-each-ref which would be the first command to completely use ref-filter.

Err, for-each-ref already uses it before this series, no?

So, you don't need any extra option to get for-each-ref, because it is
already there. Having these extra options is a good side effect, though.

To make sure I'm clear enough, what you're doing is

- add all options to for-each-ref
- port tag.c
- port branch.c

What I'm suggesting is to prioritize this way

- add all options required for tag.c
- port tag.c
- add all options required for branch.c
- port branch.c

> And like you said, the challenge is to then ensure tag.c and branch.c to use
> ref-filter and make them pass all tests.

Not only the challenge, but also the way to validate your work. Think of
it as a rather comprehensive set of tests that you get for free once you
ported a command.

BTW, talking about tests, did you do some coverage analysis on git
branch and git tag? If not, I'd suggest that you do this to make sure
that the pieces of code you're rewritting using ref-filter are well
tested before being rewritten (a bit like Paul's work on shell -> C).
You don't have to actually do this before porting, but it should come
befor the port in the patch series to make sure that tests pass both the
old and new implementation.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
