Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA43C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 22:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLOWTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 17:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLOWT3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 17:19:29 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAFC5214F
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 14:19:28 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g10so423606plo.11
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 14:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlaepv4I6o8yIuH/dLql20qbgK/S3gI363HyxtfZbB4=;
        b=gC7jxJJW0x1yJhoiO5YyloZQRpaw6tZDdf2P7Af24HHQHMRbH17cBWZOeciUpbUdBU
         fVR48jDIF4LvSyGYwFwxIwMQffqfENg1QzkpJP5Jx343k8MwR2kvLiSb0E5GBLODEKCz
         9qeXFfVZNU+ivPB4EvKeEu0SEasYIBcqd0YXv15vNSAJb4BOPkPbnnEmNZmZo3XL6Z88
         f5afppqA8iRA1iavRvPgJLpfCRSDue9FbIPJ8PfUQREozOxnW2PflMsdAXWc/8FQtQS7
         kuZk4hVkZfBE38hhrOrdYNpQ9r8JTBGqJ04WUQLKYzvMk+x/O0tIea8OQqByyZBKE5d6
         SlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlaepv4I6o8yIuH/dLql20qbgK/S3gI363HyxtfZbB4=;
        b=CEZyWVV0UFyvxhfeDfE7c2MXy3tmIbaWhNtkal0yZQScth4lHZlkndx/fQ51ZN0Xfd
         LuDXq4BXlvBQvKKXLKVyZhU3Qqr0H+Je5/sX5t/OCn8fCe7nnJwDIH81UuY0JT+oLqSQ
         r3MzzYen9BP5x9p1QXHz6wQPlZV90IhrJRO87+4N0kVwJtC7dsOclXaf6C6kURqnv1P+
         Rod0C55CHfax0cBDL/NHsHi2U9UUj7+5mDdUSmbyk/smA85iVwwiKFSVB+yUhNtQB9IZ
         +++jUut8rtQ4WofHOySYQD0r+IWJWyNNx5oWab76asKrOPhcJDG2bBvx/W0CRY1YqgMD
         WuIg==
X-Gm-Message-State: ANoB5pnvfQSzb8KKrtUO9FCtLO3hst1yGkCIengr8fjpFI8wGE8qefna
        HlJ8kmlMfcq8lHBM0IPgJJw=
X-Google-Smtp-Source: AA0mqf6yObrMsSWONP8gXbjpZQyB6EkZDQoTQ4llaC3dZRvC7HlalO4z63AgtreCDZA0d62w26SW8w==
X-Received: by 2002:a05:6a20:d2c5:b0:9d:efbe:2065 with SMTP id ir5-20020a056a20d2c500b0009defbe2065mr12599532pzb.27.1671142768239;
        Thu, 15 Dec 2022 14:19:28 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h5-20020a656385000000b0045ff216a0casm213069pgv.3.2022.12.15.14.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 14:19:27 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v4 0/9] Get rid of "git --super-prefix"
References: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>
        <cover-v4-0.9-00000000000-20221215T083502Z-avarab@gmail.com>
        <kl6lzgbocqki.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Fri, 16 Dec 2022 07:19:27 +0900
Message-ID: <xmqqwn6sqphs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Thanks! I only spotted typos this time, so I think this is ready to
> merge once we fix those.
>
> (FYI I will be OOO for the next 3 weeks or so, so don't wait on a
> response from me :))
>
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> Changes since v4:
>> * I ejected the previous 10/10 to refactor "git fetch". I have more
>>   patches on top of this to do some post-refactoring (e.g. saving
>>   memory churn by getting rid of "submodule_prefix" from "struct
>>   repository"), but none of that's essential for now, so let's drop
>>   that patch.
>
> Okay, dropping the "git fetch" refactor probably makes sense in light of
> bigger refactoring.
>
> This might be premature (since the patches aren't out yet), but I'm a
> bit apprehensive about removing "submodule_prefix" from "struct
> repository". You've noted that it isn't needed right now (which I'll
> grant), but it feels taking away API features that we'll need soon™ to,
> e.g. run library functions against arbitrary repositories, some of which
> may need additional submodule information. Feel free to CC me on those
> patches, perhaps my fears will be unfounded :)

Thanks, both.  Will await for the hopefully final update.

