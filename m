Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DDCC43217
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 11:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiDFLnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 07:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiDFLnG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 07:43:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA16D57EF29
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 01:28:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ot30so2625727ejb.12
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 01:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ag4A4S/rqrLDxhhJGdTGzdzaKlYNXdxXHsjhgjoPbZY=;
        b=Tpd2VofMNC9DDO7w9gJoX9lCfcOBBDsHMNLDRQIIh/ZD72mupq9duIw+LemS4UXqkP
         aJshz26R85TbrR/PyQUrDLRokhAhEf5S8i5PLkE5br5VEUIbuEWMkGoCpgWOl7ZBF46N
         lEaTldhO4qrEbVOiyIPkMCTjBm+RovfM462WBypac79l6xvreqMZXzmqVfwUHLwVpR4e
         A93Rrkk84dnlj0kXTqjvejhBFKpdEKE8xvilQind8i0P8zUD96RceF5frL1IcOYIKQmO
         kn2QlDOB/kSBuL/53ZPQqmDdS9e6X4F+aMmVWW2AsHtyeGzhQ1ZJhCPl3HPsbbPDHvQ3
         GeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ag4A4S/rqrLDxhhJGdTGzdzaKlYNXdxXHsjhgjoPbZY=;
        b=RwtkSgqWqXm6wH6up5W+0CaCcgPj9d5gJvMCkJG+WSF6Hj1anAeeV+D90nlwKzavGy
         mNQMRlX7bnZBPE47yYgBGb+gD33o0TanjTYeBrLYXJvcCLFwgMVth2GnDGheQCTLoVtJ
         7M5QtX9oN5KcO3IDBPDGhQjz49Ef8vdvlBrJlrGMHGiMooW1GvCAR2Rlyul5/kPDI/LH
         zeF1phjZ9jHk2fFPuvmG4Z/diiKUMpuu7pTq3UxQl5D+xJO8/i6EHuzqBliIZvaNpGhi
         9cfVAcvME3Plya6yYAxMBelFV7fkrTpA0YHPaLJXRCVxOp1sgMHhNUTQGB4GK2pVCDl5
         I0nw==
X-Gm-Message-State: AOAM533wqXo4KlxlgnJzObAKkUcA/ga1SWLZDvRzuU4lTGNfdVyk+n5m
        32Y6t0U+joNfAi4WwY8qnA0=
X-Google-Smtp-Source: ABdhPJyLpwtICD5T/xxMB94guZ0OveAackbYwNaof6qDKhrdURwcUSjXPHtx3v5HejdH6+pPT3r5rA==
X-Received: by 2002:a17:907:3f18:b0:6e0:df2d:c76a with SMTP id hq24-20020a1709073f1800b006e0df2dc76amr7403323ejc.55.1649233709426;
        Wed, 06 Apr 2022 01:28:29 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e22-20020a170906505600b006da7d71f25csm6322885ejk.41.2022.04.06.01.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 01:28:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nc11g-000ZlS-F8;
        Wed, 06 Apr 2022 10:28:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] contrib/scalar: fix 'all' target in Makefile
Date:   Wed, 06 Apr 2022 10:21:14 +0200
References: <pull.1205.git.1649198136190.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1205.git.1649198136190.gitgitgadget@gmail.com>
Message-ID: <220406.861qyafwer.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 05 2022, Victoria Dye via GitGitGadget wrote:

> From: Victoria Dye <vdye@github.com>
>
> Add extra ':' to second 'all' target definition to allow 'scalar' to build.
> Without this fix, the 'all:' and 'all::' targets together cause a build
> failure when 'scalar' build is enabled with 'INCLUDE_SCALAR':
>
>     Makefile:14: *** target file `all' has both : and :: entries.  Stop.

Thanks for the fix, and sorry.

I missed this because I build and install scalar locally with a patch on
top[1] to integrate it into the main Makefile, so I wasn't running this
part, even if I was building, testing and installing it as part of my
local build.

1. https://lore.kernel.org/git/patch-1.1-86fb8d56307-20211028T185016Z-avarab@gmail.com/
