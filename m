Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF1DC6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 17:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjCQRRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 13:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCQRRE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 13:17:04 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112E5B854A
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 10:17:02 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so5905790pjt.5
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 10:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679073421;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Na2gaZpEGx1xTImw0+iVRCQ0jevvcclm8v2WcGjdSm0=;
        b=NN2M1QNV4jyCzPvhnG2SHOFoEcsAcmrsar2GDCZiBLNJde3f3CHrTeFkINd6mD9h2m
         /Hz/rP11GaGogsabNRDMZPfc05Ap5khEwP2uFpG6AMMlowDqzBGXs9MRp1SHME3I1Km2
         YidGm6pWdOTfp4Vbs9rfkdHtaTepvliKYOkjazYQ2fEkwcmwlbP0NDgPj80pElZo+Wzq
         O0odZfQ2TZ0Cr0FJ14KxqnCv+tO3PJr6nbdnzm3Oqrb2PdyvaidTMysJylCzYS5JJCdL
         MnP9L72nRgVUkd+3IaFsesdoWAvD3Gsg6MAd29FxJN7jHWsBEX9LW8MVgjm6Wya38fmM
         tpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679073421;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Na2gaZpEGx1xTImw0+iVRCQ0jevvcclm8v2WcGjdSm0=;
        b=Z5H3WlbbV9GVzmeOwx06GLO1/4aQ5rD9v3nitSJms9Yo0kyXcS8fUmaq+r9R6yukQa
         1Gqo8XOhmBTt+zzjmGHr/OgnrGyRfsAYqE+tGqoKYinE3ySrlW6D7oLo0m6or36/ogmA
         XG/+8s0/Mjmb4XsPP3aYeyabaXp+cLlbzMU/KLQs5PvFs9nFdoZ4AlaYCf3QL3Ob92GO
         n2ck+A4mHGpl0OhlGLnkcpyaEuSbqxpdYxQH151bu5tXT0ONgVEFZAy0ChbPcJZJwAMU
         95w0i0FJFXfFtH+b9tFVnOIdnYxpT0GY6jK0MMHL9u42tLCKGZOKzaW8V4LIqP9YObYV
         d/fg==
X-Gm-Message-State: AO0yUKUuS1p8vk80prB6lFeVM4tRAAYy/n5kCMMjvTefMjhpAPpnKTCE
        ro93TIkFzfrP5K0W+Hy+VTWjZcMORV8=
X-Google-Smtp-Source: AK7set+mFeb8iPnz75QVDZyoKgonHbT3Ud1xEJOTZt7nxg3/zXB3TnQqonuUhvagDmuMD8Phhgrm6w==
X-Received: by 2002:a17:902:e885:b0:19e:5965:8694 with SMTP id w5-20020a170902e88500b0019e59658694mr9291822plg.60.1679073421424;
        Fri, 17 Mar 2023 10:17:01 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id j1-20020a170903024100b0019f3cc3fc99sm1830518plh.16.2023.03.17.10.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 10:17:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [RFC PATCH 5/5] config API: add and use a repo_config_kvi()
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
        <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
        <RFC-patch-5.5-2b80d293c83-20230317T042408Z-avarab@gmail.com>
Date:   Fri, 17 Mar 2023 10:17:00 -0700
In-Reply-To: <RFC-patch-5.5-2b80d293c83-20230317T042408Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 17 Mar
 2023 06:01:10
        +0100")
Message-ID: <xmqqlejvguwj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Introduce a repo_config_kvi(), which is a repo_config() which calls a
> "config_kvi_fn_t", rather than the "config_fn_t" that repo_config()
> uses.
>
> This allows us to pass along the "struct key_value_info *" directly,
> rather than having the callback grab it from the global
> "current_config_kvi" that we've been maintaining in
> "configset_iter()".

Nice that you can plumb kvi through the callchain but without having
to touch the end-user-visible callback data *cb or the function
signature of the cllaback functions.

> This leaves the other current_config_*() functions. Subsequent commits
> will need to deal with those.

