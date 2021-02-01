Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C7AC433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 14:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D91D64DF5
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 14:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhBAOzU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbhBAOuT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 09:50:19 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D01C061756
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 06:49:38 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i9so13437853wmq.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 06:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ygEfeIqwSJ+DrAmqSMqBSUORUOV/9T9/7zjVTnDj27M=;
        b=Dfxb5CE71yxW9kh5QpXECFfaQMHSm9xA3f/bnrtIvPACn0V9LOujuk4Qc0gRpqeySh
         XdAFzf9uj+rc79RzaIsThIXFLOUbo4/fF3mmSihGYk8o1UM/e6WQBpHoyrNlOZfr94FX
         GLR9bSpqWlB0kP4TOE8WpF1EnbePJN9BymZtOA0OWU7aRnWZ+Z2w7ZeGCMAO7AVfUvJl
         5Op9GLp9BHTC+Dhl3EAkL/AOli9S76VcD4sZ2RLpWRapEsbZCmuCKOWTyhfmmNVtipF3
         rVIl80AJvHpjCwjmxbtDrvXpRdAFpXERfBh90ppHa4eW2N6kdMvnMI0et//H+DXF3Zxz
         Sxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ygEfeIqwSJ+DrAmqSMqBSUORUOV/9T9/7zjVTnDj27M=;
        b=ASNcJbhMD06CJuO3tEFKO0lH/gscy9U35TZguiE6vY7VrmV9kkpn6RFO/yH5szEHTI
         5pCUafsIBIYBmAltc6UQGry0HT5MyGlyaIjq62Y6cWiDevIkqfJsijRuLilyfw7D5IKF
         CJax129We53YU71eRDDl7/CHzYz5YQIutoyja8U/Znrl+9/fWigkpAnjTStAbRawdDzN
         Iv+b3fWS+uDxFqjzWJ+C3vNyfgo+Ph6rA6pHCvsYNvjV3yo1sxY7L9wlu2PRGjj/wex8
         IBFK9GqSqC5V8wcE9w5mOYDEe6eUnVSCbUEvNjwqz08eOmHxLEJykDa7lePBJ/H+X62B
         ugDA==
X-Gm-Message-State: AOAM533xjG/tXun6KEnQWnhkkta9ahIGXDRiXtQbmgp2gw1pBIN0uaBH
        n1gjPrJKWL6AnleK/IUKW+HdKV74DFcP2A==
X-Google-Smtp-Source: ABdhPJwfo/fQCW/NLPiXE/1SBVo3g2+/2wmB37UaLgQKrM5E8oKKe52zj0x39rUxGWBZFU4f1xIVaA==
X-Received: by 2002:a7b:cc16:: with SMTP id f22mr14996716wmh.131.1612190977324;
        Mon, 01 Feb 2021 06:49:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k4sm28799954wrm.53.2021.02.01.06.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 06:49:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vincent Lefevre <vincent@vinc17.net>,
        Chris Torek <chris.torek@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] pager: test for exit behavior & trace2 bug fix
Date:   Mon,  1 Feb 2021 15:49:18 +0100
Message-Id: <20210201144921.8664-1-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <87im7cng42.fsf@evledraar.gmail.com>
References: <87im7cng42.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While reading the pager code I discovered[1] that we log the wrong
exit code when the pager itself exits with non-zero under trace2. This
fixes that bug.

I think whatever the consensus is on the SIGPIPE exit status
propagating it makes sense if we'd ignore it to rebase the patch to do
so[1] on this. I think the addition of a new "test-tool pager" there
is redundant to testing SIGHUP from git itself as 1/3 does here, but
maybe I'm missing something...

2/3 is not needed for the end-state here, but I figured it was a good
refactoring while I was at it.

1. https://lore.kernel.org/git/bc88492979fee215d5be06ccbc246ae0171a9ced.1611910122.git.liu.denton@gmail.com/

Ævar Arnfjörð Bjarmason (3):
  pager: test for exit code
  pager: refactor wait_for_pager() function
  pager: properly log pager exit code when signalled

 pager.c          | 18 +++++--------
 run-command.c    |  8 ++++--
 t/t7006-pager.sh | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 13 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7

