Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8499AC3526C
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBE123B7E
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 17:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgLSRIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 12:08:31 -0500
Received: from mail-qv1-f50.google.com ([209.85.219.50]:39772 "EHLO
        mail-qv1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgLSRIb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 12:08:31 -0500
Received: by mail-qv1-f50.google.com with SMTP id s6so2508573qvn.6
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 09:08:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SxpvNlVSKSQnTLplEgnTC/9Ph35aak9UbvRG3CP9FME=;
        b=dO8dQ7L3NxFrGl/YXQv7ToeQd2seHuyDs5i2prwyR5vFeUS+CHzkrssZopalkqAjRB
         vKoj73VWFFLzxU2tUnAeqwU+Zg94Bh7TP0h5OG7kY69Xe0B6RnaLYqBtRZaBhznOSxzs
         9+nLZ1EwZ+Cc9/CJhSftOyVaPj+z40/VuXRwTslo+88P7AqmyF6vefE2rgWCQ3rMwI5b
         We/9q5uuXVjcmzwzVTiIpDvmHT19C3FoPHO8wo9fKrBCVNGwPwJIh+qZWpAOdrnXFPXO
         5f/ou8/tjoOUEqMUvpw/v5UwWm1LzY5iZKUi3quAXGrR+NkCYCmZztgiWYcxJ7+z+/t8
         48Jg==
X-Gm-Message-State: AOAM530F32Z/Sjxrc2V4XBPrLpQidu7ojdGpwy+8rDX1U5bEM3VjTv8P
        937AojunS4nUsaOVrU1PnqnNdi9av6U=
X-Google-Smtp-Source: ABdhPJzCLfoP/81ue0ylXiQ4T/tuGZhGtLc38GsSv5K7ypEFIMUsHdLRM7EUGzrJHr/GuB7VkLMyCw==
X-Received: by 2002:a0c:e583:: with SMTP id t3mr10484992qvm.42.1608397669822;
        Sat, 19 Dec 2020 09:07:49 -0800 (PST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id p58sm7654451qte.38.2020.12.19.09.07.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Dec 2020 09:07:49 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id z9so3726540qtn.4
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 09:07:49 -0800 (PST)
X-Received: by 2002:ac8:41cf:: with SMTP id o15mr10088576qtm.98.1608397669198;
 Sat, 19 Dec 2020 09:07:49 -0800 (PST)
MIME-Version: 1.0
From:   Ross Light <ross@zombiezen.com>
Date:   Sat, 19 Dec 2020 09:07:35 -0800
X-Gmail-Original-Message-ID: <CAEs=z9Pajgjnq56+umA+g9-NFv-Rzo9m5sa-7cow_byckLiJ0A@mail.gmail.com>
Message-ID: <CAEs=z9Pajgjnq56+umA+g9-NFv-Rzo9m5sa-7cow_byckLiJ0A@mail.gmail.com>
Subject: Documentation errors for HTTP protocol v2 and packfile
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git mailing list,

I'm working on a library to interoperate with the Git wire protocol.
While doing so, I noticed two omissions in the documentation:

1. In the protocol-v2 doc [1], the HTTP example implies that the first
bytes in the response are "000eversion 2\n" when in fact they will be
PKT-LINE("# service=git-upload-pack" LF) followed by a flush packet,
then the version 2 data.

2. In the pack-format doc, the Deltified representation section [2]
describes the instruction sequence well, but neglects to mention the
two size varints [3] at the beginning of such an object.

I think it would be good to correct these documents for others
attempting to work with Git internals. Let me know how I can help.

-Ross Light

[1]: https://github.com/git/git/blob/ae46588be0cd730430dded4491246dfb4eac5557/Documentation/technical/protocol-v2.txt#L72-L79
[2]: https://github.com/git/git/blob/ae46588be0cd730430dded4491246dfb4eac5557/Documentation/technical/pack-format.txt#L70-L76
[3]: https://github.com/git/git/blob/ae46588be0cd730430dded4491246dfb4eac5557/patch-delta.c#L29-L36
