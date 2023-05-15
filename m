Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8D1C77B75
	for <git@archiver.kernel.org>; Mon, 15 May 2023 05:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjEOFDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 01:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjEOFDd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 01:03:33 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475FF26BB
        for <git@vger.kernel.org>; Sun, 14 May 2023 22:03:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1a50cb65c92so86498365ad.0
        for <git@vger.kernel.org>; Sun, 14 May 2023 22:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684127007; x=1686719007;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yq7787ABM/PtGDnBE3dPL5TqyMsYtt6XprA+tHCzcw4=;
        b=M4FHXcCxrppzJIjrz1nVFZuyCmJGj98e9P9RrZL2mgCeLzhXQoUOhWS9Sl2U/cS5XJ
         dnKZtHy9r9CT+9dBgbr4KNQYP4Fp/AzQVhD6QT+NiTWr4qR1F8cxZIhE8NfQzytQdseF
         2cHsc7c4qpoyHGKYKARGbNq1IHqEr/zu/pN8oBSJ+hY86zxIi1n6ZbPOeC0Cc925zLOz
         MACNAZyc7mTlmW8xLzmNbM6aKOQqDitDgww5+3y7iBxEMrSfHVL//F2xV/zwfM3ZBwhf
         6Md30c0kwZs6S2ZYPc8sgsjpXQC38uFYVgXyoeoijIRCvSJvOZl7+0lvmjuQ6eaNSHU5
         JUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684127007; x=1686719007;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yq7787ABM/PtGDnBE3dPL5TqyMsYtt6XprA+tHCzcw4=;
        b=Ou3iRwfrWMOUHOHu6Ddnbe2OniE/FQunsyyj6ApiBAAT0+s4PKk5lFnw9YBsJb19pz
         HuWAaB3V7StUqiy05Hz0wcu18bEnmkV4Tzmc18nTR+v+/YIVdKaR8xDYSTGdksILK9Ve
         Mj+VTO2bJqlz44q/lbz5vJ2xZQ//C/Q2vNgUeWxhZCBiU2iDpQBCOyXsTTNmDhNecaSC
         LBVPtr56Eave4zYf9JvFdjwSQMfR5sa+D0eTeGyKik76Pbfq11sC5fWFoEFixCVPvcvQ
         5HfSws/hggSYyTfNvSqWEQcy2CUFzqjLlCEo4wKYzG8T2Y36tS2I88kYKAYZFhTO4HDz
         xsGA==
X-Gm-Message-State: AC+VfDwOUyR6QeVQ4QHNI+bsIdDMmcXGzCaPJTnQqpKyAO4TnTwOdPBO
        VfocAAJbAVzPwo9X1xjw/Wk=
X-Google-Smtp-Source: ACHHUZ4/6ikqXqWZrxHesQGJvwiZIdl8Yubcs0RI9SMFhOiaFkPu2nuYHMbIdwVcUSsBXeIfRA2EmQ==
X-Received: by 2002:a17:903:1248:b0:1ab:224b:d1fc with SMTP id u8-20020a170903124800b001ab224bd1fcmr44390736plh.41.1684127006612;
        Sun, 14 May 2023 22:03:26 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090332c200b00198d7b52eefsm10061038plr.257.2023.05.14.22.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 22:03:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Martin Monperrus <martin.monperrus@gnieh.org>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 2/2] ls-files: add %(objectsize) atom to format option
References: <pull.1533.git.1683969100.gitgitgadget@gmail.com>
        <95f1d7140814cc1598d52a4cfab33bf8aa0bf83c.1683969100.git.gitgitgadget@gmail.com>
Date:   Sun, 14 May 2023 22:03:25 -0700
In-Reply-To: <95f1d7140814cc1598d52a4cfab33bf8aa0bf83c.1683969100.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Sat, 13 May 2023 09:11:39
        +0000")
Message-ID: <xmqqa5y6chk2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Sometimes users may want to align the feature of ...

Exactly the same comment applies here to this patch.

If these two are the only ones missing and after these patches
ls-files and ls-tree become equivalent in the support of atoms,
then explaining that in the log message and do these in a single
patch would make the most sense.

Thanks.

