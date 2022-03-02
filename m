Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E79C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 18:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244763AbiCBS6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 13:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiCBS6W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 13:58:22 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9570C2E6B7
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 10:57:38 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a8so5692831ejc.8
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 10:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=nh+chtN4z+LQeWiohJ3W79mO+UT8iZ5W3TKTG2oUN+E=;
        b=baOOFIMf6dL9Z5jP1p+SqLsRbuR1eENWqAtBuUq6yEulGCUL+H9cXkOUMoeUWfVaup
         rZq3Bs9OCmu+Bcceo9Nws2fFE8dBGlBHLnLIZE0WJMMZyHYfsBdfl56LrzzRqYkmAcox
         FgbBnGZUeoBFxV0hV9rzf3cSZ4X3ZKaMEDCChPsd95mp9HT0Ys+r480tnTcAMhA6940J
         eIyAmgb/aeoLTRCyISVibdXUFZB6bI76pETBqQuJm9QekRYAbnAB5NqRbZwLjNLK/SPT
         8zp1olerw0DuyglAbtyKVWa3yRz811YGe2m4rdUZMEGCCeMUqXvLenJ/XfyNfH3485AA
         ouWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=nh+chtN4z+LQeWiohJ3W79mO+UT8iZ5W3TKTG2oUN+E=;
        b=ouPMSAR1yu72kmITGfoHR8fhXpMheiZviDsK8sywR4vpoEfi3rIqshUQw60wB12loP
         KK7kjkyOogYejt8ZpdFE08rBteU0lWXvq5mtp6fKrjxmmBuozJgzB3JV5zUDwWrSxJV1
         OZ/yhic+yy6nu/v1exKRJkVwkC3ZVXsGOdrrQ5b0phZPXGNi0eOSFCHZe6tStCtO1UoA
         SvtwLmw81GilGsosHJUiLcPKL2KsfMOhbogLSaFFhbT9qsgN+Pi/JNAzEzOEiTFKVs9t
         xop2246xQ7fi9PGcxR3jkLgqcRrIBKGq9C1SnZDgLev9MYzjBjxO4avyjxyOm0IRI5nv
         IREQ==
X-Gm-Message-State: AOAM5317qv20SAV7V5lWMSuuhj/l4I8MGokXIdtAw/Hh+tEmWmzjeZ0q
        ZqABtGbECptWV0bEv38iI2gSMSoyzXOTGw==
X-Google-Smtp-Source: ABdhPJyVilcSb3MF0zZmonZUFT/g2WehDxBIYWklnzMKoKMPdZU5siljlQSGmUDcQo2GdSyhRCrEfA==
X-Received: by 2002:a17:907:94cd:b0:6d9:89e1:3036 with SMTP id dn13-20020a17090794cd00b006d989e13036mr3946699ejc.231.1646247456819;
        Wed, 02 Mar 2022 10:57:36 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b00415a1f9a4dasm1620401edv.91.2022.03.02.10.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 10:57:35 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPUAI-000Ihf-QR;
        Wed, 02 Mar 2022 19:57:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai <johncai86@gmail.com>
Cc:     git@vger.kernel.org,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/3] libify reflog
Date:   Wed, 02 Mar 2022 19:55:52 +0100
References: <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
 <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
 <YhkwG5JGNKB2yl3i@nand.local>
 <69041BB1-569D-4462-A1CE-2F1BDA9A76C0@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <69041BB1-569D-4462-A1CE-2F1BDA9A76C0@gmail.com>
Message-ID: <220302.86a6e86v35.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 02 2022, John Cai wrote:

> Just wanted to bump this thread. It'd be good to get another ack on these
> last set of changes.

Hi. Sorry that I didn't look at it earlier.

This looks good to me and I think everything that's been brought up has
been addressed.

I left a nit on 1/3 suggesting a way to make that diff a bit smaller by
using a subshell instead of refactoring an existing function.

But I think with or without that & a ro-roll this would be good to
advance to "next" etc.

Thanks!

