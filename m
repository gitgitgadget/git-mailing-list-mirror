Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905A4C4363C
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 06:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2663C2184D
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 06:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWbewfME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbgJHGov (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 02:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJHGou (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 02:44:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB1BC061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 23:44:49 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d23so2282976pll.7
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 23:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Un3y+/PsHNa5phm3AKwGaaNb1ueA6dh/0MtNumhWU8=;
        b=eWbewfMEB6jTvkDAmV6sDmu6fcns5ma9gjQwovFOW2R27poNbxnNn9BAXvyNiuhT7f
         eK/a5xyBN+pmIQj+unQUcOR4qrNdZDNOiZ1smmZbxQEw7vg51OexPf0zmwu/DE+gMFYU
         loiisc4u4OTW5ZiYHs3GkELZulgBVnp0tNZ0F7OHTjgF2i83mhihP2yXMFXAtmuya9sh
         eGu9jmbDhlLcc1cN+G3bprc/CtyEDNVY8g0PZjLXtXpSjCPEQVEZ9VlcUTc70Px7HWrP
         S8z7F9QMhrN1V8OFybNnS32ReIeoNrCsvTqZQywIzAdzHEtAfCiHTkDaTeQMGwVjwZaL
         gWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Un3y+/PsHNa5phm3AKwGaaNb1ueA6dh/0MtNumhWU8=;
        b=nrWH9QzRNWhK07MtbpawNImK/icBCl4qSPp2D2N4it8Sdvatk6oNgiCQq1a95y0hyS
         v1bHC7iZjB5KjJenHUZH2ojZaViWuERI7tGpI2+BRvrcYIBX8ldTwS69pPma7u60BqfB
         qi9aYFkPDXioTkY8Jlc1OxdICeYezy2UfyeYxhKRLl0ZYheG2qZDfiZ6RbbJEdifzDi/
         AoxzmLisDyunenIHRltxaqmHG9V4J9znlGPkWSh/ABQHcQAMuGpNx8vwnViW/lkpx+YN
         PCCGgypJgfVO/v379pMNGBrGEXNdhyDO5BoSDXfvWeNlwliGkHO2ERPuB8X7UtMWNcYC
         donQ==
X-Gm-Message-State: AOAM533G52QJBF+/Z3pYDWdsz8qknpTa1yPgnu83SU9UyASx60eMTNH3
        5c2vNLH4YmKJbTE3nGkGK1c7DIsChY8=
X-Google-Smtp-Source: ABdhPJy33dyisKcY+kD4hB9Ihif1xCkRJ+4syo2GNFxElyJPh5NuxbSrb/0Qv+IyRrY3s8zMem9SeQ==
X-Received: by 2002:a17:902:6545:b029:d3:d370:2882 with SMTP id d5-20020a1709026545b02900d3d3702882mr6411779pln.44.1602139488295;
        Wed, 07 Oct 2020 23:44:48 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id u6sm5228232pjy.37.2020.10.07.23.44.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 23:44:47 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/2] contrib/git-resurrect.sh: make it hash-agnostic
Date:   Wed,  7 Oct 2020 23:44:38 -0700
Message-Id: <cover.1602139448.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.29.0.rc0.261.g7178c9af9c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Git supports hashes other than SHA-1, the hardcoded $_x40 used to
match OIDs is no longer correct. Replace it with a hash-agnostic
version.

While we're at it fix some indent issues.

There are some other style issues in the script but I'll leave those as
out-of-scope.

Denton Liu (2):
  contrib/git-resurrect.sh: indent with tabs
  contrib/git-resurrect.sh: use hash-agnostic OID pattern

 contrib/git-resurrect.sh | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.29.0.rc0.261.g7178c9af9c

