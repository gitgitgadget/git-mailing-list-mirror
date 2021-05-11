Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91D6C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 13:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E0A61363
	for <git@archiver.kernel.org>; Tue, 11 May 2021 13:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhEKNo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 09:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhEKNo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 09:44:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D419BC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 06:43:51 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z9so28687670lfu.8
        for <git@vger.kernel.org>; Tue, 11 May 2021 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DQHb5ACSB74gtiGF6IL3Dtu11phvZ3dUhL3b/KD9R/M=;
        b=UQbDWgPv+rOyaz5jeCWqZE+OREVYkPewbQ45Gms6Zdlo7txulaR1XymOz69looezym
         KHUiPI4gLc3Q7lMuuG9T9GTtAT1V71fGVLg9kh8V6YXN7yCW8qIBWnf8ILNTMCf4Y7/d
         8tFTRSLluLO7c5GSHYR6iDWsHXlTXIaQq6DlUeMuysq/OXet8xNlH91dh5Ve3rqSiWjv
         jCLZVTzBa74J5VMZMSg6t02jJcujqwlzEXyPP0LLiYNperNFqcCojB3L8pZKgaz2pij3
         Bcf9jYvZts4D6sFJiy9VDV1fO4RS3gXyhVYYyyzrTMOaMECBYbf6DV3P4HuBU7OBpZPt
         WdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=DQHb5ACSB74gtiGF6IL3Dtu11phvZ3dUhL3b/KD9R/M=;
        b=Udw95IPjn+j9lnlTAjs5BE7F32oSPbK6YWC9K5P+oX6rCFwy2VW6EtR3zOdcwjsJEQ
         aT/o9EeF5TrWUs7zJkYJCgCjY08yyqeivN8wk0Q5s1MfLuYBn+P5SVe3o09EO6EPailK
         HHGp9YbgCQARIZ+Tw5/66sbCx5qOEv/q26GhrPk6DIYm1wDHRxmA0lcOalhJzdtlnxcd
         tWpw2VzcpsPApznt6Y5MwW/YLh8vElLVaIOFolAYOitmo2c76Eqr8O5+nK6BoGMDuzI/
         Vzi+YNgtPVkHlGtk2C+089JH8s6p94WLp5wvzmIfSuZDvCezw/iMttzyA+G89FG3glhl
         09QQ==
X-Gm-Message-State: AOAM530jjcQIT6motZv7lYEy8xjxTmugyptV3fR6gPfqQaxs5UwgbPK6
        0jaGdFZEhL8bBKPvcYlnH/5x5g0+XY8=
X-Google-Smtp-Source: ABdhPJzML/RelHDMz+T+7yUPa/kt1SZE0vT5X+3RUXuBnxtSeptgJHX7wuwrf4g6QzpeoF6qJPzJtQ==
X-Received: by 2002:ac2:42d5:: with SMTP id n21mr20163583lfl.164.1620740630110;
        Tue, 11 May 2021 06:43:50 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id g24sm3067230lja.63.2021.05.11.06.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 06:43:49 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/6] diff-merges: move specific diff-index "-m" handling
 to diff-index
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210510153451.15090-1-sorganov@gmail.com>
        <20210510153451.15090-3-sorganov@gmail.com>
        <xmqqwns5oqrm.fsf@gitster.g>
Date:   Tue, 11 May 2021 16:43:48 +0300
In-Reply-To: <xmqqwns5oqrm.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        11 May 2021 13:09:33 +0900")
Message-ID: <871radwfl7.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>  int cmd_diff_index(int argc, const char **argv, const char *prefix)
>>  {
>>  	struct rev_info rev;
>>  	unsigned int option = 0;
>> -	int i;
>>  	int result;
>>  
>>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>> @@ -27,17 +53,16 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
>>  	rev.abbrev = 0;
>>  	prefix = precompose_argv_prefix(argc, argv, prefix);
>>  
>> +	/*
>> +	 * It's essential to parse our distinct options before calling
>> +	 * setup_revisions(), for the latter not to see "-m".
>> +	 */
>> +	argc = parse_distinct_options(argc, argv, &rev, &option);
>>  	argc = setup_revisions(argc, argv, &rev, NULL);
>
> This change is risky, as the loop below (which this patch moves to
> parse_distinct_options()) has no knowledge of other options that
> setup_revisions() helper is prepared to handle and that takes an
> argument.  When parsing "git cmd --opt --cached A", setup_revisions()
> may know that --opt takes an argument and eat both (i.e. the
> "--cached" is not an option but an arg given to "--opt"), but the
> new parse_distinct_options() helper does not; it will happily skip
> "--opt" and leave it in, mistake "--cached" as an option and remove,
> and instead make "A" the arg given to "--opt".
>
> Picking up the remnant _after_ setup_revisions() ate what it
> understands would not have such a downside, as long as none of our
> "distinct options" take any argument.
>
> Can't we make "-m means something special for diff-index" without
> butchering the command line processing in this step?  diff-index
> does not care about --diff-merges, so letting setup_revisions()
> remember only the fact that "-m" was given while parsing, and then
> postprocess what "-m" means depending on the command (i.e. everybody
> else would treat it as a short-hand for "--diff-merges=m" plus "we
> need some form of diff output, while allowing "diff-index" to treat
> it differently) should not be rocket science.

I have already considered a few ways of doing it, and what I came up
with looked least destructive to me at the moment, especially as it
broke no tests whatsoever.

I'll now re-consider my approach because of your observations, thanks!

-- Sergey Organov
