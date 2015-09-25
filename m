From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/2] Another squash on run-command: add an asynchronous
 parallel child processor
Date: Fri, 25 Sep 2015 12:19:26 -0700
Message-ID: <CAGZ79kYdrV2fyzWOCmrgEZBXDtEd+HMb9N3yrPquzCDfVogXCQ@mail.gmail.com>
References: <xmqqzj0cv9v8.fsf@gitster.mtv.corp.google.com>
	<1443129187-18572-1-git-send-email-sbeller@google.com>
	<xmqq4mijuwyz.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbpLwODzPrGcuvz2oY+XMMPAy9SRh1s_5wV8cvY-J79iw@mail.gmail.com>
	<xmqq612y48x5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 21:19:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfYWr-0007ea-5f
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 21:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933094AbbIYTT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 15:19:28 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34566 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932918AbbIYTT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 15:19:27 -0400
Received: by ykdg206 with SMTP id g206so122636551ykd.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WT637tsfs/LMqDopvcbbHIdko9LNe3kpTNlCq67Gq1Y=;
        b=pSL323DYPdXOJH79Z4hiK4d8qIOx+x2IJkXE4bZrjyis8uFFDC05fM92rTRJfK0aPY
         ZJ8gGwLncejsJuTs5OeGZYNr51lxixLOX4yUJrRpSciOEW8uVmc3KUiF4GgONMRoE+Lc
         Hh2a+97zgDhfCOpaVewD0LjbUhPGX0bTulqDt8GEIp/J3t/zfd7ZBMLx/v2n9Pp/lavz
         oRlGFHzYebgYgcL7L+G7zscI9rjARHqS/SkSwuOXMURvJJFM+zfTSTxhgvrP2XicRidG
         LZUbwEkuPgMaxlwOvIcR4R+59W7WEXWfGVlqZ08NkdnJpxb/itfYr5sAZwerk9TbFfTX
         uKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WT637tsfs/LMqDopvcbbHIdko9LNe3kpTNlCq67Gq1Y=;
        b=TF/nDDO3Ek3oUxAf1B+CsRegwXRjlCJNUKgiAplVAtovkhDjJtTe6QZebsbrSGqmZ0
         zKTL087veqoFn9nCRqmV75Pt6FUBET04liVQepS3SROmJmyxvcI0P+HXDtMyQ90QXA+D
         /uCIX1M1Vw93bXvJGgVYcJ6Rsz7QSQ6CONjIIq0mvyRJKUI+uB4ppHTGUM3vODwOqEkJ
         ThWP1P93vWCwZdsTkfUIvISsn2q8mENfubmw4mkj/CWvOjnAxBAyemx1ciLskda9dJGi
         KePi3JibIR90jlH88fPV4lcwi671o3gKCxgkbThRR6VcQabyXR+cQBzFmv74HTu/vRLr
         71ow==
X-Gm-Message-State: ALoCoQkSAOTbAH6bD3Xw6fHvcoK6BREA2XppAc4HQX1Dhm0b9cZc6qRTj2TmEMQcZ8tLGrzCchYv
X-Received: by 10.129.56.194 with SMTP id f185mr6568146ywa.142.1443208766964;
 Fri, 25 Sep 2015 12:19:26 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Fri, 25 Sep 2015 12:19:26 -0700 (PDT)
In-Reply-To: <xmqq612y48x5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278677>

On Fri, Sep 25, 2015 at 12:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> I think two sensible choices that start-failure and return-value can
>>> make are
>>>
>>>  (1) This one task failed, but that is OK.  Please let the other
>>>      tasks run [*1*].
>>>
>>>  (2) There is something seriously wrong with the whole world and I
>>>      declare an emergency.  Please kill the other ones and exit.
>>
>>   (3) There is something wrong, such that I cannot finish my
>>       job, but I know the other 15 processes help towards the goal,
>>       so I want to let them live on until they are done. E.g: fetch submodules
>>       may want to take this strategy if it fails to start another sub
>> process fetching.
>
> How is that different from (1)?  Do you meann "let other ones that
> are already running continue, but do not spawn any new ones?"

Right. "Phasing out" before gracefully dying. Well to achieve this,
we don't need more options here. (Just set a flag to not return more
work in get_next_task).

>
>> We could also offer more access to the pp machinery and an implementation for
>> (2) might look like this:
>> ...
>> By having the pointer to the pp struct passed around, we allow
>> for adding new callback functions to be added later to the
>> pp machinery, which may not be expressed via a return code.
>
> What you are suggesting would lead to the same "different smart
> participants making decisions locally, so you need to run around and
> follow all the detailed codepaths to understand what is going on"
> design.
>
> I was hoping that we have already passed discussing that stage.
>
> The whole point of that "SQUASH???" commit was to correct the design
> of the overall structure so that we make the central dispatcher that
> uses bunch of "dumb" helpers (that do not make policy decisions
> locally on their own) as the single place you need to read in order
> to understand the logic.

And I thought the discussion there was focused on the internals of the
dispatcher. (You need to only read one place inside _that_ file now)

This discussion would have focused on the public API side (What do we
want to hide, how do we want to hide it?), which would be different enough
for me to warrant a new discussion.

But I guess I'll just go with your suggestion for now to have the return value
indicate a full stop or keep going.
