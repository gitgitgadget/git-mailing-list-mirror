From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [BUG-ish] diff compaction heuristic false positive
Date: Fri, 10 Jun 2016 09:29:43 -0700
Message-ID: <CA+P7+xp=bTPiwRRTH=h7v5pV8+=he4+789_3PNz227mv1387MA@mail.gmail.com>
References: <20160610075043.GA13411@sigill.intra.peff.net> <20160610083102.GA14192@sigill.intra.peff.net>
 <xmqqvb1hf35y.fsf@gitster.mtv.corp.google.com> <CAGZ79kZLT8AfmWTrrW+a-v7aXw5sm68P2H=vT7QZr2hj4Z2gDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 18:30:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBPK4-0003gq-Lj
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 18:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933478AbcFJQaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2016 12:30:07 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35213 "EHLO
	mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932855AbcFJQaE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 12:30:04 -0400
Received: by mail-yw0-f178.google.com with SMTP id z186so52838063ywd.2
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bSK8cZoCwkpPu8Ze3t2+eRVrBmQcmczSHjZeemhMs8s=;
        b=zblbkRWN7db/bncIfOEGKheZQKrXALkK9DvwnZJcOq/+wAWy2eMGOT8q0Ad7CODEKK
         sKirZyQXpuu6KaDgc4ZeiWf+x60qmbL8us9i5orgAdQrqABWCwVWLerr6LtYNrMLaMwV
         MwBqf7g6EW3RdcAHSAXXnXuwsWd2rAhbC6l2TKVE4viRAGZR1tHn4iRVCR/bjuGO4G70
         /er6RhFgEiUFGc/cDicwY8JTQzffm2Y+xmWjtwmaJt+kiFcAvnuUj6xzoHQdTYXrZUEo
         x8rSKwZ15Lr2FEDYM4mR3zeKoe8e1JTG71NDu1VIG5TR/R+1BS0v6dDc7Awf04zr5sKe
         1mPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bSK8cZoCwkpPu8Ze3t2+eRVrBmQcmczSHjZeemhMs8s=;
        b=MH8mv7wcB0sa8NgV7Nm0ltUw9WIw1ApC7GhCKUyUonHEgt0lOS2rfPEg3dUAKgh4J+
         VuRDt5oqZWZfE83+AkuDBy3osP4d019SJpS3ws5GrUzrc2A1x8YCaRmCZr3ILipH8EBS
         V9rxjQ2nRnKu4GJXy6JItW0W8t6DGVgWnRSpkLP0MlrPc8DNfs3P9HcVN/0URbA4bk9f
         S1JcF1UrYo9/u/wdj0aeVe+zQW0L9uLOMtr0OeMY+UK9Jp36rFMdnemRtQw8Fi7ZyVa2
         m3ghdmNdQqtAbY7bg3L546SnfGlzheRHtUCzeMsySvXgofvrEvuzUBZaA5SkKvW06Ryl
         6PSw==
X-Gm-Message-State: ALyK8tJ73kAP0QA33ITUGGd7F0L/WJQo8KtxUii1LYGhye3yzGyx7wR0up1AZqLBA0Sy1KM8xLEq8NUtmY+TYA==
X-Received: by 10.13.227.196 with SMTP id m187mr1729935ywe.18.1465576203055;
 Fri, 10 Jun 2016 09:30:03 -0700 (PDT)
Received: by 10.37.34.133 with HTTP; Fri, 10 Jun 2016 09:29:43 -0700 (PDT)
In-Reply-To: <CAGZ79kZLT8AfmWTrrW+a-v7aXw5sm68P2H=vT7QZr2hj4Z2gDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297011>

On Fri, Jun 10, 2016 at 9:25 AM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Jun 10, 2016 at 8:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> On Fri, Jun 10, 2016 at 03:50:43AM -0400, Jeff King wrote:
>>>
>>>> I found a false positive with the new compaction heuristic in v2.9:
>>>> [...]
>>>
>>> And by the way, this is less "hey neat, I found a case" and more "wow,
>>> this is a lot worse than I thought".
>>>
>>> I diffed the old and new output for the top 10,000 commits in this
>>> particular ruby code base. There were 45 commits with changed diffs.
>>> Spot-checking them manually, a little over 1/3 of them featured this bad
>>> pattern. The others looked like strict improvements.
>>>
>>> That's a lot worse than the outcomes we saw on other code bases earlier.
>>> 1/3 bad is still a net improvement, so I dunno. Is this worth worrying
>>> about? Should we bring back the documentation for the knob to disable
>>> it? Should we consider making it tunable via gitattributes?
>>>
>>> I don't think that last one really helps; the good cases _and_ the bad
>>> ones are both in ruby code (though certainly the C code we looked at
>>> earlier was all good).
>>>
>>> It may also be possible to make it Just Work by using extra information
>>> like indentation. I haven't thought hard enough about that to say.
>>>
>>> -Peff
>>
>> I recall saying "we'd end up being better in some and worse in
>> others" at the very beginning.  How about toggling the default back
>> for the upcoming release, keeping the experimentation knob in the
>> code, and try different heuristics like the "indentation" during the
>> next cycle?
>
> Sure. I thought about for a while now and by now I agree with Junio.
> No matter what kind of heuristic we can come up with it is easy to construct
> a counter example.
>
> That said, let's try the indentation thing, though I suspect
> one of the early motivating examples (an excerpt from a  kernel config file)
> would not do well with it, as it had not an indentation scheme as programming
> languages do.
>
> Thanks,
> Stefan

I think we could use the indentation trick and it might help in this
case. I agree, let's disable this for this cycle and experiment in the
next one. Good catch, Peff.

As others have said you will always be able to produce counter
examples, that's the nature of heuristics. The idea is to see if we
can come up with something simple that mostly improves the output,
even if sometimes it might have a negative impact on the outputs. But
I think we should avoid changing behavior unless it's mostly an
improvement.

Regards,
Jake
