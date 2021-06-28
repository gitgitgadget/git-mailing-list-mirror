Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1695C2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 05:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FFA5614A7
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 05:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhF1Fbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 01:31:37 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:33859 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229808AbhF1Fbg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jun 2021 01:31:36 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C2EF0320014C;
        Mon, 28 Jun 2021 01:29:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 28 Jun 2021 01:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beshr.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=DQF5cku/ZUc6E
        rf7qDwXGQnT+OOEEqgRd9rk5HtcIY4=; b=JL1/1HSTOxkx6/DA30au1pwtNffRU
        9ZL4F0ROQXMv07DKo7WykEFydGoaLcXvpsxp2SUAiR80mLS64EUdggXNq5vfjlzX
        vpUdwm/61RmM4X4btZ2XxuUTEzrvfIqa6CQJ/SzOuIRy1UcqZC6VDTxhn1JCvksX
        W5jOLXlAdAIXrfGy/W0CsOjWRgQL7GgGDgSN/SoLeMiYuP+ure2me/aVfx35i+5g
        x4XkqKIfssVxTzbrSZlSHP9iXS3JjkuSWrlDUN4CDDkMCJgy4XCMyQ6crMjke7nC
        gneTvQ6pZg3YwDvNCB7Y/jY/Qp/cj5rVtNqyywy+4PV5j2Oyh3/KyOnqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=DQF5cku/ZUc6Erf7qDwXGQnT+OOEEqgRd9rk5HtcIY4=; b=eoiEiCMW
        V3ULEjodpRx4G0U0OciHzklDwyAq9gyrT2kDcLeOpnmvnpeLGUlDM53cDOSWuKMp
        oscBVw1OG04Qw9TBVncuEcBnh1xGJqqsRUB22CIx+Uf99nLiVy8sAM8F1hhwCHTn
        PUkNFUMWX3YkbMXjOcuD09SvhmRVDw6MNAAHyKKiNaZza8FcNUdTdGZjZXwHOpmW
        gJZYNfSUKK6j+/SbBk/16MudZ3ghaNS/h4Rf+a2YZHb0GXLHpnxr46hGNs3+oC58
        7PS4HLKmYr9i5fAKGgWThaiEkkzhDGF6uOtJ3Rmcf9NqFcDC6zyrOrFrkt/8BMLl
        V7FX9x6KKk9dZg==
X-ME-Sender: <xms:Jl7ZYHJ-HYRLFVPufk1ZWrFGshiv_VbzCt7NGZXA9dL9hB6xYLZruA>
    <xme:Jl7ZYLJeN3Va1s4PS20srGOcmibOU5nM61utI0z3HSisvf7e-YbEpRm1hV0-8wj_u
    R6XDMujJo9E2Ilky0c>
X-ME-Received: <xmr:Jl7ZYPuVH0dThdipUGQFhVO_WlT96WIuetgkf0G3XTB2vONzr1RwpNaLKiJlHqIxt-qaEqG7spUSlN0Q5ONCqLEClopnzg1Oo5EFEFTnFMxkFdzK-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehfedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuegvshhhrhcumfgrhigrlhhiuceomhgvsegsvghshhhrrdgt
    ohhmqeenucggtffrrghtthgvrhhnpeejtedufeetgedtvdevveektddtudethfdtvdekle
    fflefhgedvveetgfdvhfduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmvgessggvshhhrhdrtghomh
X-ME-Proxy: <xmx:Jl7ZYAbKeduHayL2_im6No43zzpTtLmQSL7MGa_UY5bc9B34ABCSjA>
    <xmx:Jl7ZYOYsKIztAHCjcbgIG8cVpDRsDvBc3Bc3wmYQMUGmFcFpCQmpPg>
    <xmx:Jl7ZYEBeYB4RUDzQhJ69LU4Ui_JRJa4DjtQUMEHz59A8dZysaGFxvg>
    <xmx:Jl7ZYHBXzYMnIyRoLzt3V9yVVzPE3f3vB5j1tXjXLsx8BOsWEUPh7w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 01:29:09 -0400 (EDT)
From:   Beshr Kayali <me@beshr.com>
To:     git@vger.kernel.org
Cc:     Beshr Kayali <me@beshr.com>
Subject: [PATCH 1/1] Documentation: commit patch typo
Date:   Mon, 28 Jun 2021 07:26:31 +0200
Message-Id: <20210628052631.345601-2-me@beshr.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210628052631.345601-1-me@beshr.com>
References: <20210628052631.345601-1-me@beshr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 Documentation/git-commit.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 340c5fbb48..95fec5f069 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -72,7 +72,7 @@ OPTIONS
 
 -p::
 --patch::
-	Use the interactive patch selection interface to chose
+	Use the interactive patch selection interface to choose
 	which changes to commit. See linkgit:git-add[1] for
 	details.
 
-- 
2.32.0

