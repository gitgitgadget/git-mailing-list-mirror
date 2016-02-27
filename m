From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 02/16] bisect: add test for the bisect algorithm
Date: Sat, 27 Feb 2016 13:42:51 +0100
Message-ID: <vpqd1riqq7o.fsf@anie.imag.fr>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
	<1456452282-10325-3-git-send-email-s-beyer@gmx.net>
	<CAP8UFD2szf46skWmgZi3kSkh3D0aeMPw4TagUQa7KZ-z6pHdAA@mail.gmail.com>
	<56D0C5E0.2020703@gmx.net>
	<CAP8UFD27f3zmrLrvyCuMfs6ijt7MtLB8rX0Ykvfar3kidpm6LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stephan Beyer <s-beyer@gmx.net>, git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 13:43:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZeDE-0002kQ-IH
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 13:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756456AbcB0MnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 07:43:04 -0500
Received: from mx1.imag.fr ([129.88.30.5]:37150 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756183AbcB0MnC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 07:43:02 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1RCgoxQ023359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 27 Feb 2016 13:42:51 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1RCgp9C021957;
	Sat, 27 Feb 2016 13:42:51 +0100
In-Reply-To: <CAP8UFD27f3zmrLrvyCuMfs6ijt7MtLB8rX0Ykvfar3kidpm6LQ@mail.gmail.com>
	(Christian Couder's message of "Sat, 27 Feb 2016 12:40:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 27 Feb 2016 13:42:51 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1RCgoxQ023359
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457181774.5875@usHqjPjAbLmYwkYwBP/d+Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287695>

Christian Couder <christian.couder@gmail.com> writes:

> Hi Stephan,
>
> On Fri, Feb 26, 2016 at 10:38 PM, Stephan Beyer <s-beyer@gmx.net> wrote:
>> Hi Christian,
>>
>> On 02/26/2016 07:53 AM, Christian Couder wrote:
>>>> +test_expect_success 'bisect algorithm works in linear history with an odd number of commits' '
>>>> +       git bisect start A7 &&
>>>> +       git bisect next &&
>>>> +       test "$(git rev-parse HEAD)" = "$(git rev-parse A3)" \
>>>> +         -o "$(git rev-parse HEAD)" = "$(git rev-parse A4)"
>>>
>>> I thought that we should not use "-o" and "-a" but instead "|| test"
>>> and "&& test".
>>
>> Why is this?
>
> I think it is because it might not be very portable, but I am not sure
> I remember well the previous discussions about this.

See Documentation/CodingGuidelines:

 - We do not write our "test" command with "-a" and "-o" and use "&&"
   or "||" to concatenate multiple "test" commands instead, because
   the use of "-a/-o" is often error-prone.  E.g.

     test -n "$x" -a "$a" = "$b"

   is buggy and breaks when $x is "=", but

     test -n "$x" && test "$a" = "$b"

   does not have such a problem.

Regarding portability, test -a/-o is not strictly POSIX (it's in the XSI
extension), but AFAIK implemented by all reasonable shells.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
