Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C0FC77B72
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 02:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjDRCEG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 22:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjDRCEF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 22:04:05 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F80E6
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 19:04:03 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6a5e8baad21so77614a34.2
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 19:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681783443; x=1684375443;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmUEeBpU8xbCdnFDU653iWtwR311FpHJWM5G2zA8vYQ=;
        b=ca/9oukLxYvG8H1ozvMM14GhDE3aNkehi0im/qxLZswZSKoG2IJi7mCnkua9LdpwQg
         h+HlDJf90YVmR7K1hSHmyB73S28KJ0KUYepJNdKz3DB0tEn7JJLUTav3cjwRCmGhoacb
         TmiwMN0KnJVeZtoKrTlVPWAOUlmrecqc5nh9n26AfQLP1i6lk7fz512uKpqPa1UQluAu
         hAO8E4KPSMw1eeL+Y0k4m8B5EM8sGqrxy3/b8R6Y8S61e4x7YGBt8PsVEatNLuHcxzO+
         rKiaInHPtgvW0CnLMHZmfLbRhltZaeY6n2B3MFxtb850HXtdFrmI2blWL7Gxb4KXKvDy
         0EVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681783443; x=1684375443;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OmUEeBpU8xbCdnFDU653iWtwR311FpHJWM5G2zA8vYQ=;
        b=WAnbPw9TkWq29gD2zyt1KGZDupBPYt1qkOn0INGjPpl5TeQTaHKBSeIhGK+x0lQM3c
         t03a/0xvLvoHzdpo9OER+1HDxDnC79IK1pNLwqT4z9rFr/O7l1SKLQQvVGJZbgNPIGam
         QaAAmFYRvRbEq4SSftarrui45h4NSQsWokjXQEqY+9F1TwrT4LTE9FxSeyPq0nzrzyxR
         oaEZzJwKxVrC4u5RNzoXCVbO/GitPtP++B1G3zjiOimrjizO/NE5JBpZ9bH9WPUhxL9W
         YAEztJzC725W+15daxN4WyN+VL5z68WsRyJ+QAGhwi+uVwxAXQeeum+liTuMdHQcy8h4
         Cq0A==
X-Gm-Message-State: AAQBX9fiV/SQbqvg5dFHldqggaSl8S4u2y+88ktDtqAtOQD/xyIiQPNF
        WQoszNL3/w2YFDqJ0kyyrYcmDIbLAhA=
X-Google-Smtp-Source: AKy350b9nfJ8ef1WP2EkBA6sRYI8Bkp6/35DcBfDa8Uin78+dueGtFijrt0bRi8lz0Y42tO+Iksvyg==
X-Received: by 2002:a9d:7383:0:b0:6a5:e61d:aa86 with SMTP id j3-20020a9d7383000000b006a5e61daa86mr263492otk.6.1681783443008;
        Mon, 17 Apr 2023 19:04:03 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id o19-20020a9d5c13000000b006a3f8f7b686sm5180007otk.28.2023.04.17.19.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 19:04:02 -0700 (PDT)
Date:   Mon, 17 Apr 2023 20:04:01 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Samuel Ferencik <sferencik@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Message-ID: <643dfa919c8e1_19bb029491@chronos.notmuch>
In-Reply-To: <xmqq7cuamjmu.fsf@gitster.g>
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
 <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
 <969a4399-a6db-7c72-f96c-8bbe5f6208d4@iee.email>
 <xmqqk03jcwxz.fsf@gitster.g>
 <CABwTEiRz+-+Zdx3Ed7O09Ch8GoXH-SnmJyc-vFOdF-hk_uO-yA@mail.gmail.com>
 <xmqq7cuamjmu.fsf@gitster.g>
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Samuel Ferencik <sferencik@gmail.com> writes:
> 
> >>>> Let's introduce a new condition: `os:<uname-s>` where `<uname-s>` is the
> >>>> system name, i.e. the output of `uname -s`.
> >
> > The discussion about https://github.com/gitgitgadget/git/pull/1429 seems to
> > have stalled on several points. I'll try to summarise; let's see if we can move
> > forward.
> >
> > (I am the reporter of https://github.com/git-for-windows/git/issues/4125, which
> > led to this PR. I am vested in making progress here.)
> >
> > 1. name of the setting (`os` vs `uname-s` vs `sysname`)
> 
> I do not think it is a good idea to squat on too generic a name like
> 'os', especially when there are multiple layers people will care
> about.  But I think the original thread discussed this to death, and
> I do not see a point bringing it up again as the first bullet point.

"platform" is the term I've seen to be less OS-centric.

-- 
Felipe Contreras
