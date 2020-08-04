Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BA8C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 10:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85C6B22C9F
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 10:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAJgvzTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgHDKKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgHDKKP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 06:10:15 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5483C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 03:10:14 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i19so22039718lfj.8
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 03:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6gQ9eJ5uXvr8TRvdcNEhyZ1HCeEYM/AIuEPR+EvdJpo=;
        b=KAJgvzTJVFugl9sVqVei+BEgquh6zWDFxUb2ekwvXUrJtzIxA9GrLEgoSVg8z79AU2
         PgayNfAiXXuapa9k2kOmIItyiPpzjJo/QE/ldOLadhlzKkKTowlAL60vZhnHvLqtF+ib
         V56PgpqXJzB13dP3w8zSXN+9uyMjTwpHv+bXyUiQF60SYfn1irrzfl8nkMRKe99wwz4+
         ol6bQyF/d7fWR17DB8pmIgsdvF3KPvCg3IqJlHykKtugIlve5ZhCHT3sPm2sA2w+xHM1
         ZVbG22Ecw4himUoNWsttgDNoHMjs08opsN0DSf5rCkitLk6M6DIXMpExPVxqjpfW3NlW
         qUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=6gQ9eJ5uXvr8TRvdcNEhyZ1HCeEYM/AIuEPR+EvdJpo=;
        b=HYOnM9hsjReTzdRrJi14mL1V/y3AxwbrI87ihraYl45YqlDZgEXjsfhYcm1IzBA+av
         VGNWY979uAcdakOyw7/DXPxAceYpSwp3tUV1gV83Ta60pePQEt+z4RyfAGVC5HjChf76
         OxtEUj5o6ucomQXmPMcXdaeoKsmTnhg5iQRP/89JQXQScPPrroiFqALrVfxNC6CQMIHm
         xzKpCJNRd/IF1/Kkcs53nzYZQT3nc0vW7Wp4IXxOkwAlTDvZ30ANlR7t/1RCZaB9n6LL
         XjlE2ffdfCm0lWIjOLSUWwaSToTZLxUVxu+L4jQXxQcwD4u8XAabLwK6OIFj+CT293TZ
         uWdQ==
X-Gm-Message-State: AOAM530hRB7xbJpJBZVmmjmdEZNt997U4XaBZr2s5m1cvTvQfYxOnD4y
        35XeN/g5ZGUq2UEIRGSlidY=
X-Google-Smtp-Source: ABdhPJydWZJBD/kgjVInIvL2iimCCkPByatjkEhudxc5AsyA4mG/llRl0Et7aeGSOY1FSZIPT6RJkA==
X-Received: by 2002:a19:cbd2:: with SMTP id b201mr10564868lfg.106.1596535813001;
        Tue, 04 Aug 2020 03:10:13 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id u21sm3868966ljl.11.2020.08.04.03.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 03:10:12 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Subject: Re: [PATCH 1/6] commit-graph: fix regression when computing bloom filter
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
        <91e6e97a66aff88e0b860e34659dddc3396c7f28.1595927632.git.gitgitgadget@gmail.com>
        <85eeonutj4.fsf@gmail.com> <20200804005658.GB75662@syl.lan>
Date:   Tue, 04 Aug 2020 12:10:11 +0200
In-Reply-To: <20200804005658.GB75662@syl.lan> (Taylor Blau's message of "Mon,
        3 Aug 2020 20:56:58 -0400")
Message-ID: <85wo2eu3gc.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> On Tue, Aug 04, 2020 at 02:46:55AM +0200, Jakub Nar=C4=99bski wrote:
>> "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com> writes:

[...]
>>> diff --git a/commit-graph.c b/commit-graph.c
>>> index 1af68c297d..5d3c9bd23c 100644
>>> --- a/commit-graph.c
>>> +++ b/commit-graph.c
>>
>> We might want to add function comment either here or in the header that
>> this comparisonn function is to be used only for `git commit-graph
>> write`, and not for graph traversal (even if similar funnction exists in
>> other modules).
>
> I think that probably within the function is just fine, and that we can
> avoid touching commit-graph.h here.
>
>>
>>> @@ -144,8 +144,9 @@ static int commit_gen_cmp(const void *va, const voi=
d *vb)
>>>  	const struct commit *a =3D *(const struct commit **)va;
>>>  	const struct commit *b =3D *(const struct commit **)vb;
>
> Maybe something like:
>
>   /*
>    * Access the generation number directly with
>    * 'commit_graph_data_at(...)->generation' instead of going through
>    * the slab as usual to avoid accessing a yet-uncomputed value.
>    */

I think the last part of this comment should read:

[...]
     * 'commit_graph_data_at(...)->generation' instead of going through
     * the commit_graph_generation() helper function to access just
     * computed data [during `git commit-graph write --reachable --changed-=
paths`].
     */

Or something like that (the part in square brackets is optional; I am
not sure if adding it helps or not).

>
> Folks that are curious for more can blame this commit and read there.
> I'd err on the side of being brief in the code comment and verbose in
> the commit message than the other way around ;).

I agree.

>>>
>>> -	uint32_t generation_a =3D commit_graph_generation(a);
>>> -	uint32_t generation_b =3D commit_graph_generation(b);
>>> +	uint32_t generation_a =3D commit_graph_data_at(a)->generation;
>>> +	uint32_t generation_b =3D commit_graph_data_at(b)->generation;
>>> +
>>>  	/* lower generation commits first */
>>>  	if (generation_a < generation_b)
>>>  		return -1;

Best,
--=20
Jakub Nar=C4=99bski
