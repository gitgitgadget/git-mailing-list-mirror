Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA77E1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbeHMV1Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:27:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53117 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbeHMV1P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:27:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id o11-v6so9831179wmh.2
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Y/sJFVIiiOdpvw0/v14VFojI/39pohExYhI12jawIvA=;
        b=UrZFLWd4579wfxq5L43QIccr2TTsnYAKaoggkKzvKfRr0XwTCb8qmOiV4q9q+yOJXy
         CleKMNi/yMkEuV1CYzPC4dnN0pIPjbYqon5y8yOASiQea4HoJKbmcX+1Egfo4z9J+jSb
         9OHaFT9q3At02siFKoavf2hIxXQxdHUGje8xlSIySfj9+Gx8jEpE4JXinBwHEwapTDO7
         Lz6s4lFZ8clxE5pTjPFnMrwZr3/V7fc+yKvrHkrThVTdyTwpv88NI+Umyvvk1/ibWahK
         qaww2hy4Ky/Wqj7oxtsxqxytWuWObCaiknGmEi/A2VLXP6asBGldTIUi5tIzNF5y8s1I
         R4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Y/sJFVIiiOdpvw0/v14VFojI/39pohExYhI12jawIvA=;
        b=HjorIwqhuTt5f+8rvlFLx7YLWQSuhBXVW2wIaC/mb5HTCnyXGBMRCUjkN7cXIJ2QVG
         AKdmW5Z5UsVsQ/NZ2XNG4Tlb5NQLO01WAI3I3Wj2+BXs6ffde9MS27J9lQSOFulkCUAS
         uFeL6zV6Fc4MZVGMWUIqgoKXSN9i0uPJD3N2ZqNgbnJGOc6vAHIuBzuwtYuJwHFi00ik
         3Jf3wzP9B0ACB4WDjQ7xY/bsqwqS81qQOSsx4nI2Za0awhEV5743KmZ2QOq8xEeQs1q9
         WGh2BW3IKMbdOcA0lpZ6KFhFNoKUVu405F5Pao/RTmRWQCzBz/cODTieGVBbbukUjzty
         t4MA==
X-Gm-Message-State: AOUpUlHA2l0hQ9KB09/Ml84BHyLvm6rKgeEoIvMsAAKVw+7X9ECVqeBI
        ewBZpxW5zGcu2WVIHv8JSW4=
X-Google-Smtp-Source: AA+uWPwrwMCAcgL3l7UAFJlpLqIZnk7BPyfYv+bP5Vd8y4ymf23PUvZSBHSe7Pi2VCTTYIslvMD1jQ==
X-Received: by 2002:a1c:6709:: with SMTP id b9-v6mr8407893wmc.30.1534185829211;
        Mon, 13 Aug 2018 11:43:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m68-v6sm24510266wmb.10.2018.08.13.11.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 11:43:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
        <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
Date:   Mon, 13 Aug 2018 11:43:47 -0700
In-Reply-To: <54a5367f-f832-402c-f51b-3225c92b41ad@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 11 Aug 2018 17:47:56 +0200")
Message-ID: <xmqqmutq5cpo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> @@ -182,19 +181,10 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
>  static void init_skiplist(struct fsck_options *options, const char
> *path)
>  {
> -	static struct oid_array skiplist = OID_ARRAY_INIT;
> -	int sorted;
>  	FILE *fp;
>  	struct strbuf sb = STRBUF_INIT;
>  	struct object_id oid;
>  -	if (options->skiplist)
> -		sorted = options->skiplist->sorted;
> -	else {

That SP before '-' on the removed line is the most curious aspect of
this patch; I do not recall the last time I saw a corrupt patch from
you---changed where you read/write your mails recently?

> @@ -317,9 +300,7 @@ static void append_msg_id(struct strbuf *sb, const char *msg_id)
>  static int object_on_skiplist(struct fsck_options *opts, struct
> object *obj)
>  {
> -	if (opts && opts->skiplist && obj)
> -		return oid_array_lookup(opts->skiplist, &obj->oid) >= 0;
> -	return 0;
> +	return opts && obj && oidset_contains(&opts->skiplist, &obj->oid);

OK ;-)

