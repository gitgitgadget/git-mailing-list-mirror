Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CACC74A5B
	for <git@archiver.kernel.org>; Thu, 16 Mar 2023 22:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCPW4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Mar 2023 18:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjCPW4J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2023 18:56:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732C17432B
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 15:56:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-541a39df9f4so29717097b3.20
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 15:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679007366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HE9/MRY9Ma4iN4Z4RnTO7E43yegF+o15WjN2cMRCa+o=;
        b=ceGGWMFnb1X/oWLJvcJ3cRpb2qisERdgDKV9CecLojlEvLymUy7UlYQkHd1NsXqThz
         HCeEO1Gj5a+e0pYg17+O+tSN42mKLXOVM2eNFAv5A8ggankmBsj0gxX/8zTJa/vlUkvN
         ymeULgou5RFAl3BTwMYoMZ39xUX2kOPxRJE1KCLX6XCP5O/fgFO9kTmWDsPE3i9WBuN5
         T9BTZC1cMddI5nxvf1ik2o8fjKT3xsMwct5sb7XlG3b+1VqAnVV0UTNzSAx7q5HkkXDD
         CchWHoXRlMb+6hM1c0QaV2TQl7jcmzflIwVr40M6PgAvAzi/1Zp1S9YOxdPw9NZnbkPg
         9mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679007366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HE9/MRY9Ma4iN4Z4RnTO7E43yegF+o15WjN2cMRCa+o=;
        b=z5qqWdUP25vdh5efefdaZbbnp1IFI8K3xE/WbVyO1iUQTwgKciGmB/X89k3h3Znw2P
         pKShRTFGTx6fCHq5i5qnS2yZT5/0RTRwDnJaYUkMvRfNX1NGVW809ALxqS+zuguUeQvG
         8e97GEfwMfTMu7p5yhf6Bz2O0abMx4drmunKoy/nlU21uFX+5rkBV7YUBIuvr5Y9id/n
         raUAcBNTAdL1OqT+R0f58xzNe3xVed+XH0+r5M7yYuZuXEcFCl+HBVJNdQpz5UseRPcf
         yuS4unMFxSRdyfwpg65Vu0M4OD/6O/wtUyJYUfERx9PexyL8095NxY+KfsvtzoKgnoiG
         3RTQ==
X-Gm-Message-State: AO0yUKUTlHQfemNP4I9/nA+Zo4eWTQDgjI6+81XOaIzzLfxoMWX88GWV
        32ULqH1520Y7yD8ca4IqzakLdOsLcOlRFA==
X-Google-Smtp-Source: AK7set9tOvMbKSnYncO+gG30zch1Mg/UXbV4h/YfpwfTOy1ZVfAAkDCLI6YKnfD3NjPnSSi3+u4dbwLrB4VcSg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:b306:0:b0:541:61aa:9e60 with SMTP id
 r6-20020a81b306000000b0054161aa9e60mr3189589ywh.6.1679007366727; Thu, 16 Mar
 2023 15:56:06 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:56:05 -0700
In-Reply-To: <20230316211821.313426-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230316211821.313426-1-jonathantanmy@google.com>
Message-ID: <kl6lpm98uwze.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 2/8] config.c: don't assign to "cf_global" directly
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Emily Shaffer <nasamuffin@google.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +static inline void config_reader_push_source(struct config_source *top)
>> +{
>> +	if (cf_global)
>> +		top->prev = cf_global;
>
> Don't we want to set prev unconditionally here (i.e. set it to NULL if
> cf_global was NULL)?
>
>> +	cf_global = top;
>> +}
>> +
>> +static inline struct config_source *config_reader_pop_source()
>> +{
>> +	struct config_source *ret;
>> +	if (!cf_global)
>> +		BUG("tried to pop config source, but we weren't reading config");
>> +	ret = cf_global;
>> +	cf_global = cf_global->prev;
>> +	return ret;
>> +}
>
> ...since we use it unconditionally here.

Ah, thanks. It's safe as of this patch, since we always zero-initialize
"struct config_source" and nothing else sets ".prev", but this asymmetry
is a bug waiting to happen.
