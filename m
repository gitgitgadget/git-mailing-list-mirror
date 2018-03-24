Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A1B51F404
	for <e@80x24.org>; Sat, 24 Mar 2018 20:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752968AbeCXUiN (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 16:38:13 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37854 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeCXUiK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 16:38:10 -0400
Received: by mail-lf0-f65.google.com with SMTP id m16-v6so19183159lfc.4
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yF8enE6usX576LVcYTPIj2cDfxwjt6hzP/VdlWTRJqk=;
        b=T51j8qLYUVKDZPPA3RATMfY9Z5aOO32Ix4G3ht2FWm+4PGnpDAc+6OMLKmdK24pQTj
         SIISEKSh30ZWZHDtgMOkqFOHGh4T+wLg8vnXzdpn5v7onxw1CnQKTFEY3ZoAAMID9Pnp
         oDrjn49oLs1729TyofKwSJ3ZPq7IJrS3UIaY3nt8oQ0gYzBDQfXcy2kgfBOlRd3s2xg2
         BuQa/MwVNPHW9LqNsmmrI2YGqkFOhoLoN7ILPrEfOnBCjEPAveQ7RbaecMQaKwKFshMJ
         iAUaJoWY0Mo4ZfAYH46z/BeiiN7Uq6c6xrZ0Qx/mcS1eD92DsNe8N6Avhbezkuy0zKjV
         HE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yF8enE6usX576LVcYTPIj2cDfxwjt6hzP/VdlWTRJqk=;
        b=dhK33xXQRC/cuP9rzI1MqCXTKnzJMMH/pYosQ414PW7V5pZrXRkm2U6jwNk0CPHaZU
         ZyF8OxUT6QSRY0KTgXC3BTS5lOVwnajdY3J7C3tPaKDmWAXn89hiIteZc4SxWPEE+gjR
         rs0KOo9VNYF1STb2XwqFiBQoI52Odb+IXTYsXNVxhxIN2236O0/iZH9bmHMgl6mxzUMR
         cI63mjSrjbcrzFzQ+n0FX+a3zNLHOmxEt8Isl2U1X7aR3hZey3JjvyM07GndH87k7Fil
         TgqV3hGF3wthaeppMNwF+zJvp6AxDiAQuFCmQjMycvMjfA9tEg1z6yvdzDNRiqKLr7ow
         iTYg==
X-Gm-Message-State: AElRT7G57mLhNQRYfndk09YIMdDxB4NIB6FOzOkfAP+oLPo+sBkxCtUS
        Epb21iFyL2164/SPr3NkEvU=
X-Google-Smtp-Source: AG47ELuIh+flReWfbqILWQIDf1k80aqu21GhehhyfVZLKyQs4Mx6sh3eOsEaJbOkVa39cw4NgrR0NA==
X-Received: by 10.46.152.88 with SMTP id e24mr7370379ljj.7.1521923888889;
        Sat, 24 Mar 2018 13:38:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id n2sm972680lji.75.2018.03.24.13.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 13:38:08 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/8] completion: factor out _git_xxx calling code
Date:   Sat, 24 Mar 2018 21:35:21 +0100
Message-Id: <20180324203525.24159-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324203525.24159-1-pclouds@gmail.com>
References: <20180321193039.19779-1-pclouds@gmail.com>
 <20180324203525.24159-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9bef457792..b3a9ecfad0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3034,6 +3034,17 @@ _git_worktree ()
 	fi
 }
 
+__git_complete_command () {
+	local command="$1"
+	local completion_func="_git_${command//-/_}"
+	if declare -f $completion_func >/dev/null 2>/dev/null; then
+		$completion_func
+		return 0
+	else
+		return 1
+	fi
+}
+
 __git_main ()
 {
 	local i c=1 command __git_dir __git_repo_path
@@ -3093,14 +3104,12 @@ __git_main ()
 		return
 	fi
 
-	local completion_func="_git_${command//-/_}"
-	declare -f $completion_func >/dev/null 2>/dev/null && $completion_func && return
+	__git_complete_command "$command" && return
 
 	local expansion=$(__git_aliased_command "$command")
 	if [ -n "$expansion" ]; then
 		words[1]=$expansion
-		completion_func="_git_${expansion//-/_}"
-		declare -f $completion_func >/dev/null 2>/dev/null && $completion_func
+		__git_complete_command "$expansion"
 	fi
 }
 
-- 
2.17.0.rc0.348.gd5a49e0b6f

