Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBD1ECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbiIEI1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbiIEI1F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:27:05 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06135FF2
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:27:04 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m3-20020a05600c3b0300b003a5e0557150so6610028wms.0
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=I7n5HxFONnoJ4LneWpZsZe7jVggp1jsX+GfjFy6uvRw=;
        b=Sn6sNYQAOYyeVDpaSeJjFdMLcdV0YGFkEVeHN6xdHaYnGSe/KwWkfOEqkJm6YfWXym
         LCmrRdpzj1pwK2vjbk7rYhrgwkTEMMVVLXnoLBohYk1N1ubys0wsjwhCZVpX6unKcEg4
         SYifBidq2lN3Sai8I75AuGIbXtACtkJcVkr+wgDN2q0A9lIcot3coJB005HFa/REijg2
         aTVDdz/wcDF5vSxdoJr7QKYYoeLE10A8n9uRQFXcVNWweVx9Kl+gor85ayuX/oZ7PpqO
         pXVzRFQdAaSC3qTMwFWcx0VdgC57PGI3/OtjBW0Z5tl6VVPCQ06pRHUUxUtIA7oSfxXd
         YH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=I7n5HxFONnoJ4LneWpZsZe7jVggp1jsX+GfjFy6uvRw=;
        b=Lru1QCegH1OJxVx1jG+/Z9GXqsyvpnE4obzcFk55YBWkgF/E4hdi4GsoqOGHgcmLQT
         IrnlXES6E+YX4NWYgF/BMOu+JE+0CYNN0ct4RvlXqPD7WgzLbjXYDz2KWsVHUzr9qJPk
         0q5HcrhQqTLGQIQWi4vnjXP+h6KkoFeLlwGWBqfXR6GRsLRAJOgyOGvolPXa8vf1E8rT
         +zlReNvjjTK38SvHubQySfQbCIR6mMgiW3zqbAorkEkBTV4hk90+IrvbDOyoZVs6Of3O
         COY4jwQakhWVsWNmTm70sgBwD3D3RjJuuMon0nmv4YqMAtn4SPrGQ8Ek+kT8h5HIR+HX
         301Q==
X-Gm-Message-State: ACgBeo0SMylVfv9pqsJE+cuBNQAEcw+eHzjCsTs9lJSy2GCOpk1oGFki
        7DfUwuN1tCtXXUZGEUR5b+mfTkhXrcleqg==
X-Google-Smtp-Source: AA6agR4plffuCJ7rkut66UDsqXDPwJQ7xFdhVoJmoAjOKmbsD1uNSBNCx50IGlcFDb+ykvqThU+b1w==
X-Received: by 2002:a05:600c:444b:b0:3a6:6b99:2394 with SMTP id v11-20020a05600c444b00b003a66b992394mr9968692wmn.43.1662366423115;
        Mon, 05 Sep 2022 01:27:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:27:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/34] doc txt & -h consistency: add missing "]" to bugreport "-h"
Date:   Mon,  5 Sep 2022 10:26:23 +0200
Message-Id: <patch-12.34-55ce0f8632f-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a "-h" output syntax issue introduced when "--diagnose" was added
in aac0e8ffeee (builtin/bugreport.c: create '--diagnose' option,
2022-08-12): We need to close the "[" we opened. The
corresponding *.txt change did not have the same issue.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/bugreport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 23170113cc8..bb138161943 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -61,7 +61,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 
 static const char * const bugreport_usage[] = {
 	N_("git bugreport [(-o|--output-directory) <file>] [(-s|--suffix) <format>]\n"
-	   "              [--diagnose[=<mode>]"),
+	   "              [--diagnose[=<mode>]]"),
 	NULL
 };
 
-- 
2.37.3.1425.g73df845bcb2

