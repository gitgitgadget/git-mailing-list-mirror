Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38AFC61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 18:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBUSv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 13:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBUSv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 13:51:57 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E362A6D6
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 10:51:56 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u14so2190485ple.7
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 10:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oytvGmJ99iGvfWx3m4jp0m8X3CvoGuYJqWbFsQiKikM=;
        b=NNZgw8wZrOdHC1KDNmHliQa1Hq962PGkcdzRFtWeqhEiMb/UlC/MhjKrfMymBnI+UP
         Iu7iBlGSeJi0X38fZ2+IJIO/JBq9E3c8n39qzEtcS75850iocV/Rao01i6ipg2VuIU30
         U9XJY2HuEJR9BtoigLkhZf8U009VX2lER3/ULnqLLNmee47IPkmryre82ijAesklJ7yP
         nykqrN5ob/serJUcpMC+ctHu3xqkHLqPVsL6cV1tO88RjdzXm9Jxw4569hdejBkADOF9
         Y3ol66ID8gBfRTMy/NGtFhfLCMrDZTB5ZXgRru8vI1DClhDZ3ncS1+XpLTiTJBbNI3tZ
         ykEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oytvGmJ99iGvfWx3m4jp0m8X3CvoGuYJqWbFsQiKikM=;
        b=dU+b5YHwEh50yZMfG2OVAr1DsyD0fDW3nq/DESK+mu7JDlEDXGfgkgf7c4Hp9fiZKn
         zDEbUGhz25iHx5GaX7A/ANpL37RKVNZMGunbbV3jHXWMFo/k45Lhl5KbeIw28IlPoXBX
         dtciuYHiHqYQaUb6wdeIioHLsHnVmGZlCuTsZVIjWFitA8Wz85BvVTYn8sK/0t0U0LFj
         x7ysCDfXmO/ei8eLr30qvz6vC6x5MzEzw0OC4xFxoU+XyCSDtCieEWCUchL6weZeiERL
         vtVJZE0PK4bovUfisJR02MtbotfvGL3886NE467GUPSsXBvWw4ez9IwescIe+3InNgVS
         n+vA==
X-Gm-Message-State: AO0yUKVGc5/Ta2vv+4i5DR9nGDv/Vj/FvF+A+ELahy9D2N3wF8Oy+1tQ
        zz+0KGXYFwkxIzQRSpwnwu9WsWt3ofY=
X-Google-Smtp-Source: AK7set/bXka6jHU6n5zrTSHo17d1AAGeIlu8ftd2y4pn8z4lCdmyhAjTkXrUzZ5X1WTpNrisNLkgPA==
X-Received: by 2002:a17:902:a702:b0:19a:a9d8:e499 with SMTP id w2-20020a170902a70200b0019aa9d8e499mr6756108plq.44.1677005516298;
        Tue, 21 Feb 2023 10:51:56 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b0019a86c610dasm2611982plc.20.2023.02.21.10.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:51:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v4 0/2] Teach diff to honor diff algorithms set through
 git attributes
References: <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
        <pull.1452.v4.git.git.1676927082.gitgitgadget@gmail.com>
        <xmqq5ybuhqhc.fsf@gitster.g>
        <CABPp-BEAB6jKXeo=DHiimQUDj=5i7U5MQPXTEsAagLVAuk7FOQ@mail.gmail.com>
Date:   Tue, 21 Feb 2023 10:51:55 -0800
In-Reply-To: <CABPp-BEAB6jKXeo=DHiimQUDj=5i7U5MQPXTEsAagLVAuk7FOQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 21 Feb 2023 10:05:50 -0800")
Message-ID: <xmqq1qmig8c4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I'll leave that up to you and John, but are we risking merging code
> that could go unused or that we need to fundamentally change?  I don't
> see how to handle the issues over at
> https://lore.kernel.org/git/647D3D49-B85B-4B66-A857-695CFF9685EE@gmail.com/

If this is useful enough for desktop users already, then that is a
good enough reason to take it, I would say.

GitLab can easily add WebUI that says "You can define what diff
algorithm is used for files with which suffix" to allow you to
configure a table like this:

	json | histogram
	c    | patience
	*    | myers

and populate the server-side equivalent of .git/info/attributes and
.git/config based on that, and without anything further than the
posted patches, the result should just work, no?
