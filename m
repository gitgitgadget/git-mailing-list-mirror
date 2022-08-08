Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAFFC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 05:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiHHFfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 01:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbiHHFfR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 01:35:17 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB97100D
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 22:35:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id A14EA32003F4;
        Mon,  8 Aug 2022 01:35:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 08 Aug 2022 01:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659936913; x=1660023313; bh=wb
        OHNg4h2l7C6VcRA/GtR8XiFqyybizvDDDoggrIP50=; b=nSESrpVRXoUOxdDzeM
        8UGhYzciCMDQ8+B6T+/nYNJblrn+KCnzhQWoAT+ORW/ji1jAUhnvOoqCt5jW+6Bu
        ijFfSsWRjXs81kmJQumyJHPcFiS9QhllCdgyOvXMglBgzZRkcbRkfyyp9fuU/8LP
        myTTJJjQdOCVf1T9U8+TPfjyAEmmuf3livKpMTxuhm/CbQVJQIMpGrsRAwoqgaou
        2XYI/yBnw2Ob8WYZI5ml3LJJMyYgn4rNk8bjFIJ5kNsb1Ws+mZxAzA+18mOq+icJ
        d1r7XpYySy5uwSJf+cZl0CfWfNf52rLJyfnTF0NCzcPT/x6aSlaHrgE38tDG4Nqe
        Uycw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659936913; x=1660023313; bh=wbOHNg4h2l7C6
        VcRA/GtR8XiFqyybizvDDDoggrIP50=; b=gVQw9yXc59moFmDCWnWAgCyC5az0X
        p9Mcqj9vympZJMAS/zWrk8h0d1ZBElJpUz2+btpW5VMb9lzQZ75GaEGPnfRdzZaP
        tjp90LBexyi3OQ+1KOjHilMfX9knFTm8CZQkyg1MNHUEqbWiUatHygW5nd6ng9qR
        1WRtnnrofZlEARnHlt7QDghp7jJRDJdaplSuw9qprWP9xkaCOyD2HKkpZgaLA12U
        qeBCx/106TEzeK1TrnPyigxUuvJkG9gUhewbIxWoiVkxze8pyuegPx1AmUCcalkX
        m9HQXobVQsgdDsk/sc6wCVqPhJiKwC9z6kvxfPtp+6t6sc2JXoTLB6bUA==
X-ME-Sender: <xms:kKDwYtdgpFIiPgfHGwNH5307RLTs78_RNztBBQfpqjqPwHKLA2xaWA>
    <xme:kKDwYrOBKN_LDXpVsp6_akMbKtk5n8XdMczY6Opnet2i3DB_JUN2itsmscoeMHPwH
    3ExN9wGdeD4CrxLAw>
X-ME-Received: <xmr:kKDwYmhjKit0HnLutZq4kXjTrBzB0EraQnp0lUa1VxKP24AlamQKZ0vGWK59HmyLS0-XXBcRwMwm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhephfgvrhhnrghnughoucft
    rghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrthhtvghrnhepie
    euvdeggfdvteetkeevtedtgfehudettdelvdegvdfffefgffevgfeujeehveeunecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfoh
    hosehuledvrdgvuh
X-ME-Proxy: <xmx:kaDwYm8vH49yhlMbZUhqNy95NCbofLxBarX0ofdBCir1ATV3jWXm6w>
    <xmx:kaDwYpuwfC2lFCW2o4FTuZVo19Rj-9xjGFHzfejE_So7CeWv_58f4g>
    <xmx:kaDwYlEQjR5Z7UsSr6n-u7cUXiir-8HSML-pEJP-opFPzmj58QA9ow>
    <xmx:kaDwYqUZ3biOlhwkUTPOtrEEFoLXG_Cg0JJSnQJJi09JDrWxLgXU0g>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 01:35:11 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     greenfoo@u92.eu
Cc:     felipe.contreras@gmail.com, git@vger.kernel.org
Subject: [PATCH v3 3/3] mergetools: vimdiff: update unit tests
Date:   Mon,  8 Aug 2022 07:34:59 +0200
Message-Id: <20220808053459.184367-4-greenfoo@u92.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808053459.184367-1-greenfoo@u92.eu>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
 <20220808053459.184367-1-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Fernando Ramos <greenfoo@u92.eu>
---
 mergetools/vimdiff | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index f8cd7a83f0..f04dad24ce 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -584,22 +584,22 @@ run_unit_tests () {
 	TEST_CASE_15="  ((  (LOCAL , BASE , REMOTE) / MERGED))   +(BASE)   , LOCAL+ BASE , REMOTE+ (((LOCAL / BASE / REMOTE)) ,    MERGED   )  "
 	TEST_CASE_16="LOCAL,BASE,REMOTE / MERGED + BASE,LOCAL + BASE,REMOTE + (LOCAL / BASE / REMOTE),MERGED"
 
-	EXPECTED_CMD_01="-c \"echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_02="-c \"echo | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_03="-c \"echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_04="-c \"echo | 4b | bufdo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_05="-c \"echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_06="-c \"echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_07="-c \"echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_08="-c \"echo | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_09="-c \"echo | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_10="-c \"echo | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_11="-c \"echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_12="-c \"echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_13="-c \"echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_14="-c \"echo | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | 2b | wincmd l | 1b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_15="-c \"echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
-	EXPECTED_CMD_16="-c \"echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | tabdo windo diffthis\" -c \"tabfirst\""
+	EXPECTED_CMD_01="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_02="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove vertical split | 1b | wincmd l | 3b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_03="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 4b | wincmd l | 3b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_04="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | 4b | let tmp=bufnr('%') | execute 'silent 1,4bufdo diffthis' | execute 'buffer '.tmp\" -c \"tabfirst\""
+	EXPECTED_CMD_05="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove split | 1b | wincmd j | leftabove split | 4b | wincmd j | 3b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_06="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_07="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove vertical split | 4b | wincmd l | leftabove split | 1b | wincmd j | 3b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_08="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_09="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove split | 4b | wincmd j | leftabove vertical split | 1b | wincmd l | 3b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_10="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_11="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'windo diffthis' | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | execute 'windo diffthis' | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | execute 'windo diffthis' | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_12="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_13="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | leftabove vertical split | leftabove split | leftabove vertical split | 1b | wincmd l | 3b | wincmd j | 2b | wincmd l | leftabove vertical split | leftabove split | 1b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_14="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | execute 'windo diffthis' | tabnext | leftabove vertical split | 2b | wincmd l | 1b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_15="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'windo diffthis' | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | execute 'windo diffthis' | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | execute 'windo diffthis' | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
+	EXPECTED_CMD_16="-c \"set hidden diffopt-=hiddenoff diffopt-=closeoff\" -c \"echo | -tabnew | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | 2b | wincmd l | 3b | wincmd j | 4b | execute 'windo diffthis' | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 1b | execute 'windo diffthis' | tabnext | -tabnew | leftabove vertical split | 2b | wincmd l | 3b | execute 'windo diffthis' | tabnext | leftabove vertical split | leftabove split | 1b | wincmd j | leftabove split | 2b | wincmd j | 3b | wincmd l | 4b | execute 'windo diffthis'\" -c \"tabfirst\""
 
 	EXPECTED_TARGET_01="MERGED"
 	EXPECTED_TARGET_02="LOCAL"
@@ -664,7 +664,9 @@ run_unit_tests () {
 	cat >expect <<-\EOF
 	-f
 	-c
-	echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | quit | wincmd l | 2b | wincmd j | 3b | tabdo windo diffthis
+	set hidden diffopt-=hiddenoff diffopt-=closeoff
+	-c
+	echo | leftabove split | leftabove vertical split | 1b | wincmd l | leftabove vertical split | quit | wincmd l | 2b | wincmd j | 3b | execute 'windo diffthis'
 	-c
 	tabfirst
 	lo cal
-- 
2.37.1

