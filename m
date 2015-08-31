From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Mon, 31 Aug 2015 19:28:35 +0200
Message-ID: <vpqpp235pvg.fsf@anie.imag.fr>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	<1440857537-13968-5-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
	<CAOLa=ZTHtps2gJb9asSzG_4NOwx_xiA7OuCzjW=BTTFfkaYoQg@mail.gmail.com>
	<CAPig+cQF=1FPFP_7Bn2m2J+ay5ZupG25USWc9LT9SqO1=VDZvg@mail.gmail.com>
	<CAOLa=ZS53BNNvnYv2TU6xQbEihi1GiKBaEEZ=KT6p_gDBR9Y9Q@mail.gmail.com>
	<CAPig+cRAYeF0ZDn5FsHioZr1g4pH3Ay69_3KDb8ZF1USZxzcEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 19:28:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWSt3-0007ik-5K
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 19:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991AbbHaR2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 13:28:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59789 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753415AbbHaR2t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 13:28:49 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7VHSWD7031037
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 31 Aug 2015 19:28:32 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7VHSZfD021879;
	Mon, 31 Aug 2015 19:28:35 +0200
In-Reply-To: <CAPig+cRAYeF0ZDn5FsHioZr1g4pH3Ay69_3KDb8ZF1USZxzcEg@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 31 Aug 2015 13:16:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 31 Aug 2015 19:28:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7VHSWD7031037
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441646913.59527@Z207SMYAfARhXX186uuSpw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276895>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Aug 31, 2015 at 5:55 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Sun, Aug 30, 2015 at 3:10 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Sun, Aug 30, 2015 at 9:38 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>> On Sun, Aug 30, 2015 at 8:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>>> On Sat, Aug 29, 2015 at 10:12 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>>>> +               } else if (!strcmp(name, "align"))
>>>>>> +                       die(_("format: incomplete use of the `align` atom"));
>>>>>
>>>>> Why does %(align) get flagged as a malformation of %(align:), whereas
>>>>> %(color) does not get flagged as a malformation of %(color:)? Why does
>>>>> one deserve special treatment but not the other?
>>>>
>>>> Didn't see that, I think its needed to add a check for both like :
>>>>
>>>> else if (!strcmp(name, "align") || !strcmp(name, "color"))
>>>>             die(_("format: improper usage of %s atom"), name);
>>>>
>>>> I had a look if any other atoms need a subvalue to operate, couldn't
>>>> find any.
>>>
>>> Hmm, I'm not convinced that either %(align) or %(color) need to be
>>> called out specially. What is the current behavior when these
>>> "malformations" or any other misspelled atoms are used? Does it error
>>> out? Does it simply ignore them and pass them through to the output
>>> unmolested?
>>
>> It just simply ignores them currently, which is kinda bad, as the user
>> is given no warning, and the atom is ineffective.
>
> Warning about unrecognized atoms may indeed be a good idea, however,
> the current behavior isn't a huge problem since user discovers the
> error when the output fails to match his expectation.

It's a bit worse than it seems: without this change, using --format
'%(align)%(end)' results in Git complaining about %(end) without
matching atom, which is really confusing since you do have a %(align) (I
got it for real while testing a preliminary version).

> This behavior of ignoring unrecognized atoms predates your work,
> doesn't it? If so, it's probably not something you need to address in
> this series.

I wouldn't insist in having it in the series, but now that it's here, I
think we can keep it (if only to shorten the interdiff for the next
iteration).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
