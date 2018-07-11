Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B29401F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 19:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbeGKTh2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 15:37:28 -0400
Received: from avasout07.plus.net ([84.93.230.235]:57101 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387634AbeGKTh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 15:37:27 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id dKpqfR2IcjlDzdKprfStEg; Wed, 11 Jul 2018 20:31:39 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=PqHdBl2iVxsiLaieH8MA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] fsck: check skiplist for object in fsck_blob()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
References: <2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com>
 <20180628114912.GA12901@sigill.intra.peff.net>
 <0a18acbd-0124-1c92-0046-05b8b035dd28@ramsayjones.plus.com>
 <20180628174501.GC31766@sigill.intra.peff.net>
 <db7683ab-1025-d7bb-d0ce-fc4ee28681e1@ramsayjones.plus.com>
 <20180628220332.GA5128@sigill.intra.peff.net>
 <9162ed69-d245-8b2f-0dcc-3b345264b029@ramsayjones.plus.com>
 <20180703143416.GA23556@sigill.intra.peff.net>
 <80fad203-8196-c4b6-ed9e-10def0890d59@ramsayjones.plus.com>
 <20180707013239.GA4687@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <2ad1b00c-70ff-c4b2-8cbc-9ef55c174221@ramsayjones.plus.com>
Date:   Wed, 11 Jul 2018 20:31:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180707013239.GA4687@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBeUYsBbPJQEsY77m1K8O7sQR+aM9VOefPves1derkQTl9BIl0XYUgNcJozz0YE3tz51z8ehArpYCLMXXhvMVCt7C3CJnhVZcPczGgdDgTnS43NBzaHp
 uPGBzKzTHFkWSouE9iiQ9ejFWS3vzAhyb5y7IpABD2Bpjr/ardWBaDuu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 07/07/18 02:32, Jeff King wrote:
[snip]
>> I'm not interested in any savings - it would have to be a pretty
>> wacky repo for there to be much in the way of savings!
>>
>> Simply, I have found (for many different reasons) that, if there
>> is no good reason to execute some code, it is _far_ better to not
>> do so! ;-)
> 
> Heh. I also agree with that as a guiding principle. But I _also_ like
> the principle of "if you do not need to do add this code, do not add
> it". So the two are a little at odds here. :)

I agree with that also! ;-) However, in this case, I can't
imagine having to do less, to do nothing - if you see what
I mean! So, I think "don't execute code you don't need to"
trumps "don't add code you don't need to" here.

[snip]
> What next? I was kind of leaning towards loosening, but it sounded like
> Junio thought the opposite. One thing I didn't like about the patch I
> sent earlier is that it removes the option for the admin to say "no, I
> really do want to enforce this". I don't know if that's of value or not.

Yes, it would be good to let the admin set the policy.

> In an ideal world, I think we'd detect the problem and then react
> according to the receiver's receive.fsck.* config. And we could just
> flip the default for receive.fsck.gitmodulesParse to "warning". But
> IIRC, the fsck code in index-pack does not bother distinguishing between
> warnings and errors. I think it ought to, but that's too big a change to
> go on maint.
> 
> It _might_ work to just flip the default to "ignore". That leaves the
> paranoid admin with a way to re-enable it if they want, and I _think_ it
> would be respected by index-pack.

Ah, that would be good, if it works.

> [goes and looks at the code]
> 
> Hmm, we seem to have "info" these days, so maybe that would do what I
> want. I.e., I wonder if the patch below does everything we'd want. It's
> late here and I probably won't get back to this until Monday, but you
> may want to play with it in the meantime.

Sorry, I've been busy with other things and have not had the
time to try the patch below (still trying to catch up with
the mailing-list emails!).

> diff --git a/fsck.c b/fsck.c
> index 48e7e36869..0b0003055e 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -61,7 +61,6 @@ static struct oidset gitmodules_done = OIDSET_INIT;
>  	FUNC(ZERO_PADDED_DATE, ERROR) \
>  	FUNC(GITMODULES_MISSING, ERROR) \
>  	FUNC(GITMODULES_BLOB, ERROR) \
> -	FUNC(GITMODULES_PARSE, ERROR) \
>  	FUNC(GITMODULES_NAME, ERROR) \
>  	FUNC(GITMODULES_SYMLINK, ERROR) \
>  	/* warnings */ \
> @@ -76,6 +75,7 @@ static struct oidset gitmodules_done = OIDSET_INIT;
>  	FUNC(NUL_IN_COMMIT, WARN) \
>  	/* infos (reported as warnings, but ignored by default) */ \
>  	FUNC(BAD_TAG_NAME, INFO) \
> +	FUNC(GITMODULES_PARSE, INFO) \
>  	FUNC(MISSING_TAGGER_ENTRY, INFO)
>  
>  #define MSG_ID(id, msg_type) FSCK_MSG_##id,
> 

So, just squinting at this in my email client, if this allowed
a push/fetch to succeed (along with an 'info' message), while
providing an admin the means to configure it to loudly deny
the push/fetch - then I think we have a winner! ;-)

Sorry for not testing the patch.

ATB,
Ramsay Jones

