Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C58C2D0E4
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 01:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2132068D
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 01:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bw0e9zvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgKYBRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 20:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgKYBRu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 20:17:50 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC53EC0613D4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 17:17:50 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id z24so518521pgu.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 17:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7vHcTl2rVlknje/nRY5u3+GsnKumcUenhMtaj0vUbUQ=;
        b=Bw0e9zvIK/S3SwWZgXOMgSaqfrIgzUHVM7PD5GG5QI9TALWt3TMunsRzDCyRTv9FGf
         sOGPX05ibSajfb974TwaLfdjZFnquR0cqvIlNwR+PvxugCS659bkyZOoP/NfUy8VuvMb
         m09fVUggNaalmxA5b84ydT58tzFofJx83RZKQj8KhiTOvi0c9DZEL1TQdmi8WQo0MdXI
         7c8aOwgkQY6Clm8adWdY6EjAyYHwZiD9YTCUV0BoleIybTVILnZVFo06lspZASMW89BR
         eZRVYkJA+gD4b48Uu04U641EGeF/gpZfyUD2hzt3ljkR1pKdXK/KvVjoZXVKXcDccGj9
         g+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7vHcTl2rVlknje/nRY5u3+GsnKumcUenhMtaj0vUbUQ=;
        b=UzVSpAZ1ACFR6tqElgY5QDhPtusDzOLxUv9ax8FvWdvMSczsTZbZwAeKh56r/Zr9fn
         tU8wMR50IV6zvhh2yg1q41JNmTYuHJV9sPhQJI1MWmNEDmzU4eWE+niJl/bGbjzLI8E2
         umpDCvmsuQ72Pm9moesQQYAdyeeDDRCwGJsMn4fhwEtBT12h1wns3O456RKoqZtCwkiV
         bMOh1o9AeGE7j0XTCgIcveKVWNAkBRwAas/R3PVVNG5hkJ5ZDjqjKR3cuSbt223cC20Y
         00K8A4HPfPH31TA0ouKr/CvxzhBSeYRbdUmfZdNKL3U8al3J5knmC6sXPQOKs1poko+M
         y5qg==
X-Gm-Message-State: AOAM530hvrV2PEiQrWBcuVfIDGZP42iw846gsDfeznrtmKirdqZR3dL/
        9zRTlN8cqYFScLfbuDBw7f4QZww8B46yCg+xhaow
X-Google-Smtp-Source: ABdhPJzNLE8a2IqdsvZHdJIZj1fUX+iceLIlcyaTAKXzJhQEqu7WPLkOsrnS5+cTobfjKqYieGgrZcVrSLBtSiiDNvEj
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:293:0:b029:197:96c2:bef6 with
 SMTP id 141-20020a6202930000b029019796c2bef6mr1013089pfc.62.1606267070171;
 Tue, 24 Nov 2020 17:17:50 -0800 (PST)
Date:   Tue, 24 Nov 2020 17:17:48 -0800
In-Reply-To: <8b5d23933301988e42ddd57687e0535f8749367f.1605649533.git.me@ttaylorr.com>
Message-Id: <20201125011748.944638-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <8b5d23933301988e42ddd57687e0535f8749367f.1605649533.git.me@ttaylorr.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: Re: [PATCH v2 15/24] t5310: add branch-based checks
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The current rev-list tests that check the bitmap data only work on HEAD
> instead of multiple branches. Expand the test cases to handle both
> 'master' and 'other' branches.

[snip]

> +rev_list_tests () {
> +	state=$1
> +
> +	for branch in "master" "other"

Would it be worth including "HEAD" in the list here? It would make more
sense with the commit message saying "exstend" instead of "replace".

[snip rest]

The 2 prior patches (13 and 14) look good to me.
