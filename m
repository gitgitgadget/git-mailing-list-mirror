Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5472FC433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 16:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237938AbiCVQGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 12:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237278AbiCVQGc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 12:06:32 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4383AE05
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 09:05:04 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id z9-20020a637e09000000b003836f42edfbso1376387pgc.22
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 09:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=JHwEYY+4J7bGQo2F3G2StxyjK/qt3nZ7awpu58gTU3U=;
        b=CfhcOHG4YxPDDH+gD2Puxdymf4CMowLYOYEmwTJArLOL8ruRvb7UtW9YU68SJjct6p
         JNBKYUK3a75Wgs7HBV3TRFELi2Agg4dXMag3ekPtovvEoyKTGXLrlto7XM7l4Pxtiyi6
         kE2HypidnYUiGvN2Yp8aJ5DLpMq35f2EYKEAKy5mBtEE/Epwvr2n0rqfaYhLS5l3svOX
         AUa3DvrK3jzDB61Ev3Ng+uJLDUfJEC0csJGZBIiElF2s96Sbvkl2MYwMkKVClZwrH+WE
         ubKE7C/bVDYqgjd0b6KvSOnkvgVYmrV4GmVSHaJ93VPyBc8s2KODfhOZb4xYRcd9k4lX
         KcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=JHwEYY+4J7bGQo2F3G2StxyjK/qt3nZ7awpu58gTU3U=;
        b=eb+8m6k4jyOLY0arTmaFrnIoBRnUqDZLSu3JSz4jfazIVm9UqlVYzRKHDsVzEs4llD
         J4uk4oNSK4CvD8KOxKGwQLomdI0EPos/QG9s03aNev0/FP/YeQOZA3MounSdBdmSEvGT
         IxfAT7edqmF8RAtY03j4yihbbnsw4noB3wE4jtZwSZ90bzLXRms5G8Xdf6ukHHAKZYEU
         xsoZlktFKM1OyEawLwVcybLSFJeq6A5NG2IJFge1sRJOcUmPy8a6JlL5eY4t8UOlg+M0
         aUjd+6GGyMjJcprj2o63HlSEWUIFBUobTWqz5T7ONp0IeGrvf1vZ40/whkmPHae39qBG
         IC4A==
X-Gm-Message-State: AOAM533kMPu3ibIydGvSSPirxe67SBVxtvn3l7QBadRa1XQ6F1FaeRom
        WAIuhS1bnVCLdX1/VNX7cWmh5v9E4leWxg==
X-Google-Smtp-Source: ABdhPJyPiGUdnS1GqFEWuzC8/YSJoRsB3JgAIQL1k+o+/zWEpRlV9Aj+ZqJIftmVCuQloOYQcXdi98umZA38SA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:858b:b0:1c6:5bc8:781a with SMTP
 id m11-20020a17090a858b00b001c65bc8781amr66249pjn.0.1647965103469; Tue, 22
 Mar 2022 09:05:03 -0700 (PDT)
Date:   Tue, 22 Mar 2022 09:05:00 -0700
In-Reply-To: <xmqqv8wcizi4.fsf@gitster.g>
Message-Id: <kl6ly212j7mb.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqqv8wcizi4.fsf@gitster.g>
Subject: gc/submodule-update-part2 (was Re: What's cooking in git.git (Mar
 2022, #04; Thu, 17))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * gc/submodule-update-part2 (2022-03-16) 8 commits
>  - submodule--helper: remove forward declaration
>  - submodule: move core cmd_update() logic to C
>  - submodule--helper: reduce logic in run_update_procedure()
>  - submodule--helper: teach update_data more options
>  - builtin/submodule--helper.c: rename option struct to "opt"
>  - submodule update: use die_message()
>  - submodule--helper: run update using child process struct
>  - Merge branch 'gc/submodule-update-part1' into gc/submodule-update-part=
2
>  (this branch uses gc/submodule-update-part1.)
>
>  Move more "git submodule update" to C.
>  source: <20220315210925.79289-1-chooglen@google.com>

=C3=86var looked at part 1, and I think he'd be interested in part 2 too.
That said, I'd welcome feedback from anyone :) This series is fairly
simple and doesn't require knowledge of previous attempts to convert
"submodule update".
