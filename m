Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFDEC05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 22:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjAWWjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 17:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAWWjP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 17:39:15 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28AE38659
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 14:39:14 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c6so12964171pls.4
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 14:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iaZSULnXvXyeKLAz+z4iVzehv31CpUtLtHo+DpZB7sI=;
        b=l7E00yaZkosu1+FXY5Xhzlp7Cd8LgAUmGR356k/Gbr+K9GV+tVTEEIVIGReyxs8ivO
         u26h6AZz5UCjx7UQNBRwtJUvc+A4GgJTJemp/dZ4INV2OoMBoM3xun09l4nMzxT/wII6
         HUZ5X9cJr/qZmfGSEU67JYb5WdLZlxRmWzsiV8NPi1oMe5cUYDOnc1xtOECewrpCj8Y3
         B8+hmki3xnxWWfOybQesdiJRvNR3MB3SI4yx0fD14Sw5yWbKz3M3RnICaqRwSUDcdLlC
         cg/r1ioORyxamoOCVc+weox7Vn5UQSL/EHQoHGQsWOBYbSbsgFqoprOOasryYKnkhoYW
         PiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaZSULnXvXyeKLAz+z4iVzehv31CpUtLtHo+DpZB7sI=;
        b=c4pecJTG2t002Asf7eNJkXJVeEL2YHJpaNBkD+ktkAjDWOJ8AGR3BnCPTKGU1Mj6Ci
         sUG0fBDxPtjp/pqdZI7X4LeAD309z+sPbp31N92V53AWM6srNp2WMNIWnFo62HI6Tt1L
         rN9woGZo9GluEXtHd5M+0GMPl2iYNC7FtEMdZuAK19ONffBWRkUJSUqezWpPaK1nvZCO
         lhhSjIfWCF5HP90/A5n/TLADpFQV3MC9mRK5SoJBuxsdAYNdR0ZCtlKqrzx0M47WLVZi
         Lq9l57coOzbRmL+J3vJp7TBfnWvXkujpoC5hjtPTuYw2AHulrTPmWzz9TTIh8IFv/Gmn
         PcHQ==
X-Gm-Message-State: AFqh2koAVgCXHW5XzHqRGczHiRFayFvkR8ifKnbrypS3+KZIXIWAWLXI
        soHPGwL1j0HHKIFGdLPCpB8=
X-Google-Smtp-Source: AMrXdXvTeET/4bZ48zHh0aj3np00Y7irlDw0kZVXlJA5bcdDNMUofESbz+8UFZotkN3yaZtOOLSokw==
X-Received: by 2002:a17:903:185:b0:194:dd86:587f with SMTP id z5-20020a170903018500b00194dd86587fmr20116039plg.54.1674513554282;
        Mon, 23 Jan 2023 14:39:14 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001960e9dd05esm213568plf.112.2023.01.23.14.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 14:39:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] ls-files: add %(skipworktree) atom to format option
References: <pull.1458.git.1673451741587.gitgitgadget@gmail.com>
        <pull.1458.v2.git.1674149666.gitgitgadget@gmail.com>
        <9ebd6b77a69be414388a52a482912173f2a4e7d8.1674149666.git.gitgitgadget@gmail.com>
        <CABPp-BGLmhoHAcuLoz_yQ4TmNBvDU6Ehymy_3rh0wguSw0hjGw@mail.gmail.com>
        <xmqqcz79xizc.fsf@gitster.g>
        <CAOLTT8TztbirR9FmD0s_5iPQ9+NETfecXHE8xeJDNXQUNojSJA@mail.gmail.com>
Date:   Mon, 23 Jan 2023 14:39:13 -0800
Message-ID: <xmqqmt68lvu6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> Perhaps it becomes useful in conjunction with %(if) and friends,
>> when they become avaiable?
>> ...
> Can this strange design be considered as a bad design of %(if) and
> %(else) in ref-filter?

Sorry, but I am not sure what "strange design" you are referring to.

On the ref-filter side, thanks to these conditional formatting
primitives, a boolean %(token) that gives an empty string vs a
non-empty string does make sense for a good design.  If another
--format="" wants to imitate it, it would be a good idea to first
see what part of the implementation can be shared and reused from
there.
