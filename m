Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3D1C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 22:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbiJZWa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 18:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiJZWa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 18:30:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C1C537D4
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 15:30:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9so5406316pll.7
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 15:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bfx2ajxDL/hW1Xu2RyBHT4YLdXSSoUYcIRoiZ73AcH8=;
        b=PC2NSMCc1g5WBn45mn63qM+Z4bAvKyIMwPOlI1foiiyKF7LhYQStGOahqyIBoafSa/
         jR2FtRHSXnZmFV1TvbEjoIPxYGV8JthwC/+g8Lw0Jb1t6gQXDlwDZTXkl6erpeDYfaUZ
         O3tINh9cDQ22PpKF28cZdxdkimJ9UmExGAvky2r89zZU9ZEFGTuH417a5RyYuo7AG3Wj
         +/XuwDSmbmf/sld4zk++NG08EZiFwTB+8WD7sXPcVW2bV7wp2r/1CPqghk9gHq/ZDfAj
         Xhq+1eayz7tduEs7mnMvF37F+7oZQNxkQJ57JuixZ2Je3Pus3rN85kZ3temjAIUg8Wui
         esbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bfx2ajxDL/hW1Xu2RyBHT4YLdXSSoUYcIRoiZ73AcH8=;
        b=nN7OJEz6nECOhfcKzuz2axN+mdgnh7fM3321vs0haqZ1Rz57G149kLV5oSbd2TYKtK
         NkGsnxNNR9pr/iYvgHpU6XZ2vl/+HYNAmDm/GRTXVMcagRne7SVi+lRzrChi92/M8n+J
         OfdHZWrfB8tbfbrwcpyAcbiDpK8z8Nyy9UvzvvPRl1ICQFKyetOyEZ3EkgmdQLwZlGRl
         tPmTWPnsUt5wgTOnMgknfOesHoRuxcEjYuP3Yt0Xpzb0MJl9EAETF/6RqazfprzPQjPP
         Vs9Mfr9/dxUfmrMWmmEmtMFK9N8T9L3gbWDCj1F1tR62H/Zvu4N75CgyNvtb07QN6fVT
         d1zQ==
X-Gm-Message-State: ACrzQf2BCem0c9enewXDxKjMLTSRTC5FX1doEzdVptGjV6/YpJ5JZ/Lx
        vU+cRCY7vp2LpQVbCwjHskU=
X-Google-Smtp-Source: AMsMyM78eit5d1jPMpnqR2mA3zDOP7lUHiwtvUjAieil6asLBzENhRUuWiUm8m8xscRfWIYRDpPE8A==
X-Received: by 2002:a17:90b:4b4a:b0:213:35c:bf7 with SMTP id mi10-20020a17090b4b4a00b00213035c0bf7mr6538841pjb.14.1666823425657;
        Wed, 26 Oct 2022 15:30:25 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090311ce00b001754fa42065sm3408759plh.143.2022.10.26.15.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 15:30:25 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH v4 7/9] Makefile: document SHA-1 and SHA-256 default and
 selection order
References: <cover-v3-0.9-00000000000-20221020T223946Z-avarab@gmail.com>
        <cover-v4-0.9-00000000000-20221026T145255Z-avarab@gmail.com>
        <patch-v4-7.9-847be3d32e2-20221026T145255Z-avarab@gmail.com>
Date:   Wed, 26 Oct 2022 15:30:24 -0700
In-Reply-To: <patch-v4-7.9-847be3d32e2-20221026T145255Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 26 Oct
 2022 16:56:45
        +0200")
Message-ID: <xmqq7d0mfcan.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> For the *_SHA1 and *_SHA256 flags we've discussed the various flags,
> but not the fact that when you define multiple flags we'll pick one.
>
> Which one we pick depends on the order they're listed in the Makefile,
> which differed from the order we discussed them in this documentation.
>
> Let's be explicit about how we select these, and re-arrange the
> listings so that they're listed in the priority order we've picked.

That makes sense.  What is not explicit enough, at least at this
stage, is that, even though we say "if you do not choose one, the
default is used" (which by the way is an awkward thing to see---that
is the definition of being the default, so the statement itself has
zero bit of useful information), we do not say what implementation
exactly is used as the default.

> This behavior makes it easier to e.g. integrate with autoconf-like
> systems, where the configuration can provide everything it can
> support, and Git is tasked with picking the first one it prefers.

Well explained.

> +# ==== Default SHA-1 backend ====
> +#
> +# If no *_SHA1 backend is picked we'll fall back on using the default.
> +#
> +# Multiple *_SHA1 backends can be selected, the first supported one
> +# listed in "Other SHA-1 implementations" will be picked.
