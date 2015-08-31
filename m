From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Mon, 31 Aug 2015 14:02:33 -0400
Message-ID: <CAPig+cRig+zk=D1SDF7wBHuQgcQqb-4cHkmeVgLs5BaWzk9WRg@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	<1440857537-13968-5-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
	<CAOLa=ZTHtps2gJb9asSzG_4NOwx_xiA7OuCzjW=BTTFfkaYoQg@mail.gmail.com>
	<CAPig+cQF=1FPFP_7Bn2m2J+ay5ZupG25USWc9LT9SqO1=VDZvg@mail.gmail.com>
	<CAOLa=ZS53BNNvnYv2TU6xQbEihi1GiKBaEEZ=KT6p_gDBR9Y9Q@mail.gmail.com>
	<CAPig+cRAYeF0ZDn5FsHioZr1g4pH3Ay69_3KDb8ZF1USZxzcEg@mail.gmail.com>
	<vpqpp235pvg.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 31 20:02:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWTPj-00037N-JF
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 20:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbbHaSCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 14:02:35 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35627 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753919AbbHaSCe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 14:02:34 -0400
Received: by qkcj187 with SMTP id j187so9070100qkc.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 11:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=UTh06Cn4QtNV47MSzn8zoZE6Ife3Bj/YEzM85U/08ns=;
        b=OuHEyieyCRmsaSKmmMYGY7fKHk3JqR2wrDWgZ2hvQ9Eio9xhlLXWA4U/5t074QTexp
         tW1NpBfMpt4eQRT3GH4CYp1yLs1eGv18DerWuQdoObAQSLbg5vwrvuViVqKM9UG2rnIx
         IRqWxps7e4W4RzCq36TP8UPlK30z6GEsBbkcEIfT+7Nlg82urlbE2ZTnK0nkAqMG38Tm
         yZ8/rp+aWKSY+P5mnL0FWrNU2E+/864LF2URl1dX3hYW+dXba0xDbofryGCIjQKSyT5e
         5GH5QKX4OJ7AgQ0Sbn5lhWS2jEBg9mIxjB7KXuQ7/cocGzrhHhrYVylEvVZCBJPrPEfh
         58ZA==
X-Received: by 10.129.134.3 with SMTP id w3mr21903954ywf.48.1441044153985;
 Mon, 31 Aug 2015 11:02:33 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Mon, 31 Aug 2015 11:02:33 -0700 (PDT)
In-Reply-To: <vpqpp235pvg.fsf@anie.imag.fr>
X-Google-Sender-Auth: D9-tkSJBIV5e-kifKiP6wfHN77c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276900>

On Mon, Aug 31, 2015 at 1:28 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> On Mon, Aug 31, 2015 at 5:55 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> On Sun, Aug 30, 2015 at 3:10 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> On Sun, Aug 30, 2015 at 9:38 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>>> On Sun, Aug 30, 2015 at 8:57 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>>>> On Sat, Aug 29, 2015 at 10:12 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>>>>>> +               } else if (!strcmp(name, "align"))
>>>>>>> +                       die(_("format: incomplete use of the `align` atom"));
>>>>>>
>>>>>> Why does %(align) get flagged as a malformation of %(align:), whereas
>>>>>> %(color) does not get flagged as a malformation of %(color:)? Why does
>>>>>> one deserve special treatment but not the other?
>>>>>
>>>>> Didn't see that, I think its needed to add a check for both like :
>>>>>
>>>>> else if (!strcmp(name, "align") || !strcmp(name, "color"))
>>>>>             die(_("format: improper usage of %s atom"), name);
>>>>>
>>>>> I had a look if any other atoms need a subvalue to operate, couldn't
>>>>> find any.
>>>>
>>>> Hmm, I'm not convinced that either %(align) or %(color) need to be
>>>> called out specially. What is the current behavior when these
>>>> "malformations" or any other misspelled atoms are used? Does it error
>>>> out? Does it simply ignore them and pass them through to the output
>>>> unmolested?
>>>
>>> It just simply ignores them currently, which is kinda bad, as the user
>>> is given no warning, and the atom is ineffective.
>>
>> Warning about unrecognized atoms may indeed be a good idea, however,
>> the current behavior isn't a huge problem since user discovers the
>> error when the output fails to match his expectation.
>
> It's a bit worse than it seems: without this change, using --format
> '%(align)%(end)' results in Git complaining about %(end) without
> matching atom, which is really confusing since you do have a %(align) (I
> got it for real while testing a preliminary version).
>
>> This behavior of ignoring unrecognized atoms predates your work,
>> doesn't it? If so, it's probably not something you need to address in
>> this series.
>
> I wouldn't insist in having it in the series, but now that it's here, I
> think we can keep it (if only to shorten the interdiff for the next
> iteration).

The unstated subtext in my original question is that the approach
taken by this patch of warning only about unrecognized %(align) is too
special-case; if it's going to warn at all, it should do so
generically for any unrecognized %(atom). Special-casing the warning
about malformed %(align) sets a poor precedent; it's code which will
eventually need to be removed anyhow when the generic warning
mechanism is eventually implemented.
