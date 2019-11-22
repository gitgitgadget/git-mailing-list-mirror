Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801ADC432C3
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 23:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550F12071F
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 23:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtr/aZPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKVXL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:11:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36403 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKVXL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 18:11:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so10562363wru.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 15:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1qjf1kjExiEEHhh6JjlD7Jhjfs6nScMc7wOlaqiraLc=;
        b=mtr/aZPhN/243C8Dmj9g8ZECmXnEST3h/zM8LapC/Rrb1i230yzsslhSvadeyguAxh
         2lGsNQ5tPAKPI0dJmimQSgjpYtvtGzT9mbL+/N5ovcO0aSqOcTN9jwjLRGQcoxRLllE2
         qP0Q27qrDcjHZ3dHCs8RYCsu7V8W9CoaA1I+s8ysiEP2bmbUetoX6ET54IpRTBvleOtc
         o5IJPiAK0FeLcskwl92jpmETt1nNYCl5iaZgN3TIs7unQwR20fgvrVwNc3A4N4IgWY9U
         JgiZxjezDGdZ1Uv1dUNgT73Gv3crA+g9WL4ZZG4ghQpnHVPjuLu0TdtqItB3u6yPYdGO
         Z/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1qjf1kjExiEEHhh6JjlD7Jhjfs6nScMc7wOlaqiraLc=;
        b=g7/ZFGcqlQ0Gqt1a7foH3kDBIbKUGeiCMvNlGED/NWYuaGr2DzR8eyA/Q/3x7b6hNj
         JGoo+oHTwBbSDZcI7RUEsnjH1g2cmc9e3wvfXZ13QawwzO+0sSrhQJ+vHACSYZdkdTXk
         nWizDK31BJXv4VtZuPhi177gu001CvNfmdH0Y187T2CGQAV9aAOd50nwaLX1Y0ZeFodL
         meQTU0QHmLjdlZAPHUkaUKBmYyTX2M0+HcDXz2pv2idlD7x4/CSOQdHM9Mx+RUhnpn4O
         LefjE8Ylk+SOdWE10TITH5e5V4rEP5QlCTq1a8tEEGI+46EB4VvQALgqS/PHiJDqkfff
         0VAw==
X-Gm-Message-State: APjAAAW2laNliMd5KLHp1ZHeRJLG3Cki1liQXP4vjXlir+J+8PIgvd+D
        05wYQ3yKka29boV/VsdVUxo7d2s8
X-Google-Smtp-Source: APXvYqw87JRH2hwo7MLMCLNYew9ZouNc3uFUfudQN0Jnk0tlDvSZD+Ym4jV5IXoNkrRXe16dCy31qQ==
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr19574301wrq.210.1574464286885;
        Fri, 22 Nov 2019 15:11:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8sm9413408wrt.39.2019.11.22.15.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 15:11:26 -0800 (PST)
Message-Id: <0eabb27ba0c7a07bbf24f13f1766c0ff63995348.1574464285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.470.git.1574464285.gitgitgadget@gmail.com>
References: <pull.470.git.1574464285.gitgitgadget@gmail.com>
From:   "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Nov 2019 23:11:25 +0000
Subject: [PATCH 1/1] Documentation: Correct man page for the SHAs reported by
 'submodule status'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Manish Goregaokar <manishsmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Manish Goregaokar <manishsmail@gmail.com>

'git submodule status' reports the SHAs expected by the parent project,
not the SHAs that are actually checked out in the submodule. Checking
out a new SHA in a submodule will not change the output of 'git
submodule status' until you 'git add' the submodule.

Signed-off-by: Manish Goregaokar <manishsmail@gmail.com>
---
 Documentation/git-submodule.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 0ed5c24dc1..31e089454a 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -72,8 +72,8 @@ git-submodule will correctly locate the submodule using the relative
 URL in `.gitmodules`.
 
 status [--cached] [--recursive] [--] [<path>...]::
-	Show the status of the submodules. This will print the SHA-1 of the
-	currently checked out commit for each submodule, along with the
+	Show the status of the submodules. This will print the SHA-1
+	recorded in the superproject for each submodule, along with the
 	submodule path and the output of 'git describe' for the
 	SHA-1. Each SHA-1 will possibly be prefixed with `-` if the submodule is
 	not initialized, `+` if the currently checked out submodule commit
-- 
gitgitgadget
