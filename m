Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36646EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 17:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjF1R32 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 13:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjF1R2a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 13:28:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F052102
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 10:28:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bb2fae9b286so7261755276.3
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687973308; x=1690565308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ku6zdV9BCXcCaHBtpLpCf4hPPzMx+N2Y/D7SLqOZ8U0=;
        b=KQHTohlW817jgpQ8TXPzR5iKz1tM+zZpViQiJnTtmNB+6Mu76BVxQL71M95rN1+4q2
         9G4S7C3RauD7e3KgQIUIGObtqD4TVgIeptrGjyt6680ANTfmZ6RX3Vi3e7uKWh20YXTy
         qHofbDQgnz7+gXmNZNl2QEt/HH/Exv4fK14ZaiPaelZtTvW6jxWkwWwq0iTcXaMP3HLZ
         ubazIPBh1NUQD5gXyw6TLHq8Bx+7jr550JMypRVd8emMSObQV6EiAUtsXuiMuqkywcFw
         jtF3fK29UIa4vXXMlPYxOUmbbrIvd5VGMlM5jnleQdta0kLniU9LVglPTDemCpjJT7vW
         e46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973308; x=1690565308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ku6zdV9BCXcCaHBtpLpCf4hPPzMx+N2Y/D7SLqOZ8U0=;
        b=bSH6Y1e4PEvoVlEs+mJovEro5mhBLIUmtMZ/CnVHA+ED/qxEur0P46i1RgFnQgOc72
         q/qg9A6mMkG0VG8dTLhlQMhGrFioQvgtW1IYhHmiV4yUJAEFbXf6apq2d54JiXcF/O5b
         Ro9Vgt77eWE0B5sEYi/dxQCNIZvDWycGZqOlsCrF2FBZGXaqViSc/Es/fj+7As1XxwpF
         bK9zpUDwz02MJ4u28XHECeN8+0BC2ppjCH+EoPTVYVLyT8oKDnjzpoZBJcd6XuaDN1EL
         ByQfVamcYzch9znU2b+4CJeD8/9jPCR5yatyMbab/87fRgAY0nq5lT9ViA5dDfFC8CmW
         bhSg==
X-Gm-Message-State: AC+VfDy+NBzxfSmKZrC/GR8B4//pymQSEatN38YLVm5JT4HfXWsd05qf
        /PvPDtnR//2GiAKHoXmC7+VUSTKozsvc2Q==
X-Google-Smtp-Source: ACHHUZ4DODLvNAvelMtvvxgqaOG+qwwDwV2e+Se8FAenJXabrDi2jQLwKLNDWCPKow+4iMPg3ZaAEZvxhwPGMw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:b13:b0:c17:4115:620a with SMTP
 id ch19-20020a0569020b1300b00c174115620amr3736751ybb.11.1687973308601; Wed,
 28 Jun 2023 10:28:28 -0700 (PDT)
Date:   Wed, 28 Jun 2023 10:28:19 -0700
In-Reply-To: <20230623203219.3255267-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230623203219.3255267-1-jonathantanmy@google.com>
Message-ID: <kl6lleg3qyx8.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 06/12] builtin/config.c: test misuse of format_config()
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> +test_expect_success '--show-origin with --default' '
>> +	test_must_fail git config --show-origin --default foo some.key
>> +'
>
> On my machine, this fails with
>
>   BUG: config.c:4035: current_config_origin_type called outside config callback
>   /usr/local/google/home/jonathantanmy/git/t/test-lib-functions.sh: line 1067: 3255109 Aborted                 "$@" 2>&7
>   test_must_fail: died by signal 6: git config --show-origin --default foo some.key
>
> (So it indeed fails, as expected, but test_must_fail seems to not like
> the exit code.)

Ah you're right. I was under the impression that this was doing the
right thing on MacOS, but it doesn't work there either.

I think a good way to assert that we run into BUG() (Maybe
test_match_signal on the numeric value of SIGABRT? But that sounds error
prone), so I'll either use test_expect_failure or squash this patch.
