Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1858CC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF26261057
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 14:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345369AbhIBOOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 10:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345461AbhIBON4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 10:13:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354DFC061757
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 07:12:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id x11so4801272ejv.0
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=w7OVfNk8wsXT+s7XdUcDVM1pWCzTZmuaPdElGaZq6Ag=;
        b=ASASESxdakuirgNwPAYVkgIaEACludj0aus8DPtgvhTh3jgUVX4diuDy5yXgMXRZJR
         W+RNjgKM4UsRKZFm7IVaDNhKS3uV6Rrm/Zqz7YzTzBucIApg9TVl+wiPJkw4K4ZglQoJ
         A2GybMV0N2hkHDl1VIhtarZVmRT8fFwQaI4ADU1jRa/UunO4eMakSR1RbpVwGqIlQ0hY
         3iXMjQuBr4fQlriEw4jkY0X60uXg3tRNbjgj1IdYUqoWCsLdv+Zq81nuXv1JBSSEQWdk
         lSix9DdKEJIAhto5oF1Tl5/co18Bai1hZ98H5iqAhIZGNFA8SZH3+fmSzXbBp207FQlQ
         kKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=w7OVfNk8wsXT+s7XdUcDVM1pWCzTZmuaPdElGaZq6Ag=;
        b=G7IuvLMo83LnWsqlZmpgMgQJcdmbk9wn5RTTx1jVEKZicakamx+A76CZiVCCRCWmRm
         ewt1AC4oFoxs1lJn7bfiZgjbG9fttM9uMnXcikv4XblrSMyDzHEzgC6pt5lMX64I9j4h
         gYBtI9acWn3R5eLk3JQP+xG16ktuuseie1JEUg/ssVvCkkVH9LCi3/S7Wr7Nu/2OjqRD
         HjNuJM+Or5mB0Nfcun8qmZ7OVzHqRrWmjcjQRX8IAByHdQn+XjGAEww1vPGPBKHpSoQt
         ls1fw12WZQ4+foNwtevt5VHO2XQ9q9CImRm0EDSJyTzVaiGtUzxL3z0h+LOZS7x8ODL4
         VERg==
X-Gm-Message-State: AOAM530L+7wTKL+ZNfZjpmSRfl7le4RrfInqTwcHA2sEU0sEbKvACmeB
        0GTYOdSS3kGBVOZ4QbfYFAqjABZ7EvcbwQ==
X-Google-Smtp-Source: ABdhPJyI4Vz1arLsOTV7c6m65g1kNdwW9NPMJyvvHt2ohkbRpyQOOLTsFJQVbVSGvTmTMopl/LmB4A==
X-Received: by 2002:a17:906:6547:: with SMTP id u7mr3938847ejn.544.1630591976596;
        Thu, 02 Sep 2021 07:12:56 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x9sm1299122edj.95.2021.09.02.07.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 07:12:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH v2 5/7] rebase: drop support for `--preserve-merges`
Date:   Thu, 02 Sep 2021 16:11:09 +0200
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
 <eb738b1bf05dceb1d119e3adcd732d968407c757.1630497435.git.gitgitgadget@gmail.com>
 <8735qowknu.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2109021553510.55@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <nycvar.QRO.7.76.6.2109021553510.55@tvgsbejvaqbjf.bet>
Message-ID: <87y28f9ic8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 02 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Wed, 1 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>
>> On Wed, Sep 01 2021, Johannes Schindelin via GitGitGadget wrote:
>>
>> > -	struct strbuf script_snippet =3D STRBUF_INIT, buf =3D STRBUF_INIT;
>> > +	struct strbuf script_snippet =3D STRBUF_INIT;
>>
>> You end up removing all uses of script_snippet except the
>> strbuf_release() for it, so this & that can be removed too.
>
> Valid point, I missed it because compiling with `DEVELOPER=3D1` did not
> complain (because `strbuf_release()` "uses" the variable).

As an aside I was looking the other day to see if some variant of
-Wunused was smart enough to exclude (preferably a configurable) list of
functions. E.g.:

    void *some_var =3D malloc(123);
    free(some_var);

Could be unused if something was smart to see that a thing only
interacting with "malloc" and "free" wasn't otherwise used, and likewise
we could add "strbuf_release" and other such free() functions to such a
list.

But I didn't find anything...
