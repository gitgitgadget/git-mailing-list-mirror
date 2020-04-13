Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E20C3815B
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 11:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2267D20732
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 11:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkDY1KQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgDMLyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgDMLyw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 07:54:52 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FF6C03BC88
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 04:54:51 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 103so8806996otv.0
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 04:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ieI9RwG6oRTSLxmx+CV+LH0w7EFJKAmeGvRk7DNTnFY=;
        b=kkDY1KQRdEWuu7qBVw+wSL2HpCoz/W7Bi86lh5AqYHbnF4mz/TH+YjJtGjA/x1CEWX
         /3+ULIG+DpuwHGQ8cybXcKJzOVobAX04Va5AxVPzBEjRskWWr8x8vap3mSEmxfy06Kgx
         8vfBc2vpMuCvOSf5CMF5E1GZjQwUGM22E8mEnn3WEjt2j5UzL2CsEnyY2zojSyXMnh5E
         fop2mPG6+QznkMcdHePayMlQp6R1zhrzYDmdYM2d0ijHlOZJxrl/QXKBY22ah/pZRA6F
         OCrSsnbGKCyi6yrXHj9RXDzwt5MTVLRzbLqFw2kz59uKXKfI1IIeg0qi6EVQTAz9KauZ
         sRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ieI9RwG6oRTSLxmx+CV+LH0w7EFJKAmeGvRk7DNTnFY=;
        b=dWPaqBBbf2mGtg8AG3EuniWaN/j8qbOWdhZEMuZoQSaJ3tZ/kgCfbhAJt16FMeLeUw
         yJ8hqSjjXC7b5Sbms4ozjNzSYy93/dT3ZkEi8bT8J/tNYkUNGc9rufEWLh9M0FQNs2LU
         O7VtSmskH/zAGjpTtu7U5NEeIwwGe2X3M521ZIhpOH28bzoAIsXd3U5AcFJ8yzsKgjqS
         aBZjjgvzpWabxc13kKBCSCGkVQBVCIIQU+5EmHRIjHM/OkKauHdN9EgouQpurC51wsOh
         28NwEKhdBDlvfTbS62975Sh19VqyAbE26ZjhfU4QMeGvLLE6qIKUWfbN7SnV0fSgNv5t
         VCQQ==
X-Gm-Message-State: AGi0PubWFCNs1QomW4u/5nFVlCmQ/g4fnR2eemJ60r6OV3HZYhL0C0T7
        RXHG+rNIRseSYPllSa1OyJECURMHX+k=
X-Google-Smtp-Source: APiQypLu7/UZZJYOq+ytbKFDL+ZYC2gkA21eCRF8Xgs1Du3vGuDpY3ntzEvGirIux3B2xFfTt82UmA==
X-Received: by 2002:a05:6830:200c:: with SMTP id e12mr14525748otp.198.1586778890898;
        Mon, 13 Apr 2020 04:54:50 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id i2sm5274296oon.0.2020.04.13.04.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 04:54:50 -0700 (PDT)
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jnareb@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
 <20200412222210.GA53057@syl.local> <xmqqa73gcp74.fsf@gitster.c.googlers.com>
 <20200413000748.GA55122@syl.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4a3af6a9-50ef-1759-7e4c-56f6c5af542a@gmail.com>
Date:   Mon, 13 Apr 2020 07:54:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:76.0) Gecko/20100101
 Thunderbird/76.0
MIME-Version: 1.0
In-Reply-To: <20200413000748.GA55122@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/12/2020 8:07 PM, Taylor Blau wrote:
> On Sun, Apr 12, 2020 at 03:30:07PM -0700, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>>> I certainly wouldn't complain about a comment here explaining these
>>> three checks, but I suppose that the rationale is only a 'git blame'
>>> away (and I guess that is faster now after this series ;-)).
>>>
>>>> +	if (revs->prune_data.has_wildcard)
>>>> +		return;
>>>> +	if (revs->prune_data.nr > 1)
>>>> +		return;
>>>> +	if (revs->prune_data.magic ||
>>>> +	    (revs->prune_data.nr &&
>>>> +	     revs->prune_data.items[0].magic))
>>
>> This says "any magic", but it is overly pessimistic to disable the
>> optimization for "literal" magic.  That magic is the one that lets
>> well written scripts to say "I have in a '$variable' that the user
>> gave me as a pathname (not pathspec), and it may have a wildcard
>> letter in it, but please treat it as a literal string" by prefixing
>> ":(literal)" before that user-supplied data, so it is punishing well
>> disciplined folks.

This is a good point. I'm unfamiliar with these advanced pathspec
tricks.

> I hadn't thought of that, but it makes sense to me. How about something
> like this squashed into this patch? I moved the if-chain that Stolee
> introduced out to its own function, at least since they seem
> well-contained and related to one another. I figure that this simplifies
> the implementation of 'prepare_to_use_bloom_filter' by giving the reader
> less to think about up-front.
> 
> diff --git a/revision.c b/revision.c
> index 534c0bf996..15bf4ccff5 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -654,6 +654,18 @@ static void trace2_bloom_filter_statistics_atexit(void)
>         jw_release(&jw);
>  }
> 
> +static int has_bloom_key(struct pathspec *spec)
> +{
> +       if (spec->has_wildcard)
> +               return 0;
> +       if (spec->nr > 1)
> +               return 0;
> +       if ((spec->magic & ~PATHSPEC_LITERAL) ||
> +           (spec->nr && spec->items[0].magic & ~PATHSPEC_LITERAL))
> +               return 0;
> +       return 1;
> +}
> +

Perhaps flip this on its head?

+static int forbids_bloom_key(struct pathspec *spec)
+{
+       if (spec->has_wildcard)
+               return 1;
+       if (spec->nr > 1)
+               return 1;
+       if (spec->magic & ~PATHSPEC_LITERAL)
+		return 1;
+	if (spec->nr && (spec->items[0].magic & ~PATHSPEC_LITERAL))
+               return 1;
+       return 0;
+}
+

>  static void prepare_to_use_bloom_filter(struct rev_info *revs)
>  {
>         struct pathspec_item *pi;
> @@ -665,13 +677,7 @@ static void prepare_to_use_bloom_filter(struct rev_info *revs)
>         if (!revs->commits)
>             return;
> 
> -       if (revs->prune_data.has_wildcard)
> -               return;
> -       if (revs->prune_data.nr > 1)
> -               return;
> -       if (revs->prune_data.magic ||
> -           (revs->prune_data.nr &&
> -            revs->prune_data.items[0].magic))
> +       if (!has_bloom_key(&revs->prune_data))
>                 return;

Then this would be "if (forbids_bloom_key(&revs->prune_data))"

Generally, I like pulling this stuff out as a method to isolate and
label its purpose. If we wanted to allow certain :(icase) things
later, then we know what to modify in order to "allow" it.

Thanks,
-Stolee
