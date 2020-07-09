Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5AFC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 15:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223922078B
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 15:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfE6vvxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgGIPyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGIPyX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 11:54:23 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C1FC08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 08:54:22 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j80so2269999qke.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 08:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bh5eB635IrSOUJ1R/mAOlC+KhGtpWp+Fqjtu1GCcczw=;
        b=PfE6vvxWMUBS47kWqAbQEpIha7kKUIJzvwg/nrLFJzeiuharnWOXPYBWpnLHwz358G
         H+687ns5FAgaPTgXClR3kPHgtyHMDgJ1ZVNdXVvAR9NiiX763Mea6m6AXDbq1KsnEvsQ
         XjnZPvPzPvwnS4GRcANIQQbwWnS3B/IYgrUjWpTT6RqvePyHZ+RS3+SCD1iDE8JNZvVN
         E/ReIeCfX1J3bI9mhokouVW93qG0WzGr8RxB37ZGTzWMTblNz/iiFa7kORGjFXFC5B4z
         Q1AlZM5URGp0seFCVI2hUFMLuywZNZNqsVTpxDPb4XG7FJgb4vUfAt7xNvq4tyYCEKel
         +q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bh5eB635IrSOUJ1R/mAOlC+KhGtpWp+Fqjtu1GCcczw=;
        b=rkzNa1TPB3vIv8SH/0go10nBpTw0a07TrzcIHFORqECBa7D79Dt9ESGsLTJ7Bppw1z
         Z1eAAMhZ0IokifhICv+EeOO6gS6wguMclYL+4MNbOdah+D/Vwzz4Ri2gGqEY2GfkhzPS
         VLT0UxVoF3IhIz+PGVRq/qfLTyl6ub3HxT+XeJlIDOP3c+59MotB4zkr1Rzh1ikNVOcN
         CW4nMOyYryiq3lglYQk1mcFj/QFNHVnNgzzrvfU1wG4FIm79q6/8nv6Ml1HkyB9lqWVo
         PQseLwyVCv/EdciWXJHvmH0xrxYzP6S2rQ/sR0S7ILdr0sFIDmYtAiPCTQkJ/K0FnE69
         6k/w==
X-Gm-Message-State: AOAM531qYBclLkGppTa9ftE/ir3MhmcDnLhXGJxB1nw7lpHQj2Qjagff
        HeBp0TFimF9dnftpDmxEbY0=
X-Google-Smtp-Source: ABdhPJylttf+n1iPZhUacI2wFmOf/BsdPVxUNN1S80bMlEmLmHJ9Z+MMHKlDnxEuORQYYMkOoWa6xQ==
X-Received: by 2002:ae9:e212:: with SMTP id c18mr40993096qkc.348.1594310061901;
        Thu, 09 Jul 2020 08:54:21 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id q13sm3824420qtp.42.2020.07.09.08.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 08:54:21 -0700 (PDT)
Subject: Re: [PATCH 00/21] Maintenance builtin, allowing 'gc --auto'
 customization
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <20200708235719.GA3189386@google.com>
 <ef6e2704-b122-f620-a952-75f3f9efab78@gmail.com>
 <xmqqv9iwyeac.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <52715fe8-a545-5c42-2f3a-e59bcbc43497@gmail.com>
Date:   Thu, 9 Jul 2020 11:54:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9iwyeac.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/2020 10:05 AM, Junio C Hamano wrote:
> For existing callers, "git gc --auto" may want to be left alive,
> merely as a thin wrapper around "git maintenance --auto", and as
> long as the latter is done in the same spirit of the former, i.e.
> perform a lightweight check to see if the repository is so out of
> shape and then do a minimum cleaning, it would be welcomed by users
> if it does a lot more than the current "git gc --auto".

It's entirely possible that (after the 'maintenance' builtin
stabilizes) that we make 'git gc --auto' become an alias of something
like 'git maintenance run --task=gc --auto' (or itemize all of the
sub-tasks) so that 'git gc --auto' doesn't change behavior.

That's a big motivation for adding all code into builtin/gc.c so
we can access these tasks inside GC without needing to move or
copy the code. I'm trying to preserve history as much as possible.

Thanks,
-Stolee

