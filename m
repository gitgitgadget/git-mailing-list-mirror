Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76249C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 14:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CFB06109F
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 14:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFGOgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 10:36:16 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:39814 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhFGOgO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 10:36:14 -0400
Received: by mail-wr1-f52.google.com with SMTP id l2so17917292wrw.6
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 07:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XxfhuH9tpUQwPjf5FKoDEEe8VJdl4relcOqoCJFKZ6Y=;
        b=PEtLpdEvxnFwgIJ2eNOKQCCk/zPQeeGbaZ5uxazLWHIFaF+kocSZURHQLFTWBIcse2
         YFW5vvxA+5YMCqiJ11jIlxz971rYExhnEmumsEIPGadOJ8EJOZVU8id79DVGb+YL0yXv
         lMA1FoaIgodwKsitdhYjNraLEZdr4gS54Yj0j6EmAqYXN+Avff0CU3mAbsC+o0awY6Q/
         Q/Q4ErzuhCExuv2Zq/McxZgMoH1H5xg1I5S9G2yvZQ4tJG0uSoMSt4QqtViN/ErIr3jR
         BRdB+8sw20Ia16+Fzo0t3yQF0K7TZrZ87YKB1d4HR7ZJO+J2cbOV/jlwoSjMTVLTgbJ/
         RZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XxfhuH9tpUQwPjf5FKoDEEe8VJdl4relcOqoCJFKZ6Y=;
        b=hSc+sfbYQ3YbNGTQ02S5sPq2R6i6Qc2Whhb8mz4ZXbCNe/4A3LHJYprZgl2G+ukb1w
         zhqvkbsFiJB+xh05E/BOmvUWiEZ2PaCBzF+MV54CvMeXuLtQoBV3yYh7k1HNLH3+KOTi
         5QxI70zZvB5FcgV4Pg0qno4Ghwo0QnTKWiHthh/es3k5ROj6Eb/Ben4xr9hZxq/d3CPa
         cnEJ0ztzxMNv1b9zZ3K3bg1XkbW05h21+dV7jHN26qZhusetaW7C1lKj24Q5zDU2l5Ti
         +cG5NbqsI+iMuil288auHw45gVQf28Eo/5WGRXJbZm6CDbk9NvvDcA5trYmx7luzdDMW
         +Wdg==
X-Gm-Message-State: AOAM530yVh9x/uQOONfIBMOjTQQ1omEewrMQbeDCOPI6CCv8r98rc8e0
        tWMf3f6DwMRLsX8uuhpLX3/ARMIQWLvyAQ==
X-Google-Smtp-Source: ABdhPJxbJWTyEP8YRhhabTZWiGpm/AisyEvQ/KSpTKpNi1WMJCBPC3r4patrnBcfQKG11GqLXtj+Jw==
X-Received: by 2002:a5d:59af:: with SMTP id p15mr7163319wrr.292.1623076387774;
        Mon, 07 Jun 2021 07:33:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d5sm16262944wrb.16.2021.06.07.07.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:33:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bruno Albuquerque <bga@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] protocol-caps.h: add newline at end of file
Date:   Mon,  7 Jun 2021 16:33:05 +0200
Message-Id: <patch-1.1-2302c9d522-20210607T143157Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <20210420233830.2181153-1-bga@google.com>
References: <20210420233830.2181153-1-bga@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a trailing newline to the protocol-caps.h file added in the recent
a2ba162cda (object-info: support for retrieving object info,
2021-04-20). Various editors add this implicitly, and some compilers
warn about the lack of a \n here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 protocol-caps.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/protocol-caps.h b/protocol-caps.h
index 6351648e37..0a9f49df11 100644
--- a/protocol-caps.h
+++ b/protocol-caps.h
@@ -7,4 +7,4 @@ struct packet_reader;
 int cap_object_info(struct repository *r, struct strvec *keys,
 		    struct packet_reader *request);
 
-#endif /* PROTOCOL_CAPS_H */
\ No newline at end of file
+#endif /* PROTOCOL_CAPS_H */
-- 
2.32.0.rc3.434.gd8aed1f08a7

