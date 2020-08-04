Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E98C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 07:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85CFA2076E
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 07:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E++tLrMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgHDHzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbgHDHzV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 03:55:21 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5929C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 00:55:20 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so32280512ljj.7
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 00:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uQxuV719rYGxbkfJBfBktP5a22j9lYM6EsR8Dip+3Tw=;
        b=E++tLrMIGQy6LV7W5yfc+SkpHsKAypx4DGNANDLzohaJDR66wIMG7bDANHPwe3JFZN
         u2K32xIYLhwCBIp2OkDu+rX35AMCnl0A+loJh7CRhshIZjY/xS86GqcWnoEcySxuZTAx
         qpD2BE16SlGN1ZJnnbLjo0ifudZ2dqMNaoE6UoliHzcLMzYNFa0ZfdyPZ/bw4VUR2nZ6
         CWdFvjqjqIUbEYS2jmQOIx3UGPpMHy7xbVGL/bqzoS/6PRlchAETWT/4Jicw0i4EAYCw
         neC0kuqmc/T71QGnb7Ery98/SiDi0Lnp7mqc2LBeRAhmsi8kg4ESdZFXf6xrTs4Iof+X
         XFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=uQxuV719rYGxbkfJBfBktP5a22j9lYM6EsR8Dip+3Tw=;
        b=PrY+fOrEdW15lcJUgpWW7XIZiMIRfb0DDE3R9tShjPxJmF4rFuzufyjboqn2nNORvO
         0bIX/ZoFtYLIFQU6ex4GdJwTD8OVB2YuuniogOFrUpx0znKCbZvFNPSHOcOk6XlHr9Pu
         p/tn+g/7xSCuXqRq7MVMsqRvK/WZR4QZ8xjbg8zwNof2ESd5Tg3Ot8126GkDQxQXfTG0
         MTXSpriCSW4weQbfEdt4GK35OLPWlufL2gOuN4FcOEMJjEKV4eY1cm4/2CzbO9FaFmH1
         wNKqbPaWpE0Hu8pmOHVy8JxhJhsv4NeAc68SLPwuW5+alP4FNXvRL9rLJUYhjpjg23Wa
         vO5g==
X-Gm-Message-State: AOAM530xDEjJdqdHdtfNdArI2sybxkkcW1ew/DqihOnMWpBMkNKByPME
        3H8lA6AGBCTjU83sY085FQo=
X-Google-Smtp-Source: ABdhPJybfoMDvs5ioWWA4DFjHyTq/JSZSq/25ovmtT0FgA+/SMvWxAvLUo/T46yyDPsZfHhu9y8X+w==
X-Received: by 2002:a2e:b70b:: with SMTP id j11mr8645623ljo.259.1596527719338;
        Tue, 04 Aug 2020 00:55:19 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id 132sm5955883lfo.16.2020.08.04.00.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 00:55:18 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/6] commit-graph: fix regression when computing bloom filter
References: <pull.676.git.1595927632.gitgitgadget@gmail.com>
        <91e6e97a66aff88e0b860e34659dddc3396c7f28.1595927632.git.gitgitgadget@gmail.com>
        <85eeonutj4.fsf@gmail.com>
Date:   Tue, 04 Aug 2020 09:55:17 +0200
In-Reply-To: <85eeonutj4.fsf@gmail.com> ("Jakub \=\?utf-8\?Q\?Nar\=C4\=99bski\=22\?\=
 \=\?utf-8\?Q\?'s\?\= message of "Tue,
        04 Aug 2020 02:46:55 +0200")
Message-ID: <857duevo9m.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

[...]
>> @@ -144,8 +144,9 @@ static int commit_gen_cmp(const void *va, const void=
 *vb)
>>  	const struct commit *a =3D *(const struct commit **)va;
>>  	const struct commit *b =3D *(const struct commit **)vb;
>>
>> -	uint32_t generation_a =3D commit_graph_generation(a);
>> -	uint32_t generation_b =3D commit_graph_generation(b);
>> +	uint32_t generation_a =3D commit_graph_data_at(a)->generation;
>> +	uint32_t generation_b =3D commit_graph_data_at(b)->generation;
>> +
>>  	/* lower generation commits first */
>>  	if (generation_a < generation_b)
>>  		return -1;

NOTE: One more thing: we would want to check if corrected commit date
(generation number v2) or topological level (generation number v1) is
better for this purpose, that is gives better performance.

The commit 3d11275505 (commit-graph: examine commits by generation
number) which introduced using commit_gen_cmp when writing commit graph
when finding commits via `--reachable` flags describes the following
performance improvement:

    On the Linux kernel repository, this change reduced the computation
    time for 'git commit-graph write --reachable --changed-paths' from
    3m00s to 1m37s.

We would probably want time for no sorting, for sorting by generation
number v2, and for sorting by topological level (generation number v1)
for the same or similar case.

Best,
--
Jakub Nar=C4=99bski
