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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F24C432C3
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65ADF6510B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 16:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbhCPQSg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 12:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238597AbhCPQSE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 12:18:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E40C061756
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e18so7741011wrt.6
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 09:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MtCav4KWt1syzHsHDbfgPm6VU5dv31bdnl77nmT93O0=;
        b=Vo8Nv1SGACtbbFEAIEHU3v49rEk8OFAH70QJ91REOSHWdkpTc15S6gHR+pg87mW3kf
         yQXmDCzOLkyGZRvDHcjvn4lAf7NUg8RsVpW0xClwreEThpzj1ONF/Rz8dQAuX2GbV0HM
         md3znaURReS84mn1IlyN0FwxXRy/Y1WTJeEqNnDt8aGN1CX6+exbgRkSQPU6rzsALTrn
         zI4mE98tAgL/DO7PeY+e8xAGJL4Ka6ivOfX7ehqxi6TdBz0rKA+2i1aQEq+aM+SnWDY1
         Ib7/fAK8TEBJm3grBilEmkorRBENYaufQ92xtePMX7VWJwnKPug3Yd1XCkmyS1dNGQke
         mMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MtCav4KWt1syzHsHDbfgPm6VU5dv31bdnl77nmT93O0=;
        b=MvhwMETyMG1s5EXNjiD+HLOLO1eoX5QX2bCBW3Bum7BqSemubJwL5JAKhNvIqQz7Uf
         EVNzmNYMOrUQ4yWg0pWAoS3Azv3gT8fHQ/P46e65lh/sbg0Z5+Wzqg3JsMwCuKQTbqd7
         ezF1COkFbsjH+9nvEIBAUobMG6MmT/fCYBjVl7OAZLdhQArVtha2lGDRvr+Ip84SFVy0
         SnXfSJbjh0HD58WC5aWoHEC+nsafn8/ytZ4oCBdvl//fhGA9jjU4y0YgQC1148FZlaYo
         TiSWRts7+qtCrcwRdr9CnucWnb2I/tzf07c8FusPwQY70p7DwaHJzhmWVCx4nXR1sr0s
         hulw==
X-Gm-Message-State: AOAM530P6m0AUB+ocp9ZRzPA3pYiIYAvo3kY/pTwpXrxGFzAlgBxuJ/E
        dZB6KCpqvAMJDJq3iGi1CS27d8dOPReZ1A==
X-Google-Smtp-Source: ABdhPJxZJ2fVFjpXZXZcm2ao9zrTrt8AxO5ADcoQogM1619+Z5jFSlVaVVxWXtFzY5Njhf7PM3wNRw==
X-Received: by 2002:a5d:58c9:: with SMTP id o9mr5793784wrf.181.1615911481970;
        Tue, 16 Mar 2021 09:18:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r11sm22369206wrx.37.2021.03.16.09.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:18:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/22] fsck.c: refactor fsck_msg_type() to limit scope of "int msg_type"
Date:   Tue, 16 Mar 2021 17:17:26 +0100
Message-Id: <20210316161738.30254-11-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.260.g719c683c1d
In-Reply-To: <20210306110439.27694-1-avarab@gmail.com>
References: <20210306110439.27694-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor "if options->msg_type" and other code added in
0282f4dced0 (fsck: offer a function to demote fsck errors to warnings,
2015-06-22) to reduce the scope of the "int msg_type" variable.

This is in preparation for changing its type in a subsequent commit,
only using it in the "!options->msg_type" scope makes that change

This also brings the code in line with the fsck_set_msg_type()
function (also added in 0282f4dced0), which does a similar check for
"!options->msg_type". Another minor benefit is getting rid of the
style violation of not having braces for the body of the "if".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fsck.c b/fsck.c
index 6b72ddaa51..0988ab6579 100644
--- a/fsck.c
+++ b/fsck.c
@@ -167,19 +167,17 @@ void list_config_fsck_msg_ids(struct string_list *list, const char *prefix)
 static int fsck_msg_type(enum fsck_msg_id msg_id,
 	struct fsck_options *options)
 {
-	int msg_type;
-
 	assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);
 
-	if (options->msg_type)
-		msg_type = options->msg_type[msg_id];
-	else {
-		msg_type = msg_id_info[msg_id].msg_type;
+	if (!options->msg_type) {
+		int msg_type = msg_id_info[msg_id].msg_type;
+
 		if (options->strict && msg_type == FSCK_WARN)
 			msg_type = FSCK_ERROR;
+		return msg_type;
 	}
 
-	return msg_type;
+	return options->msg_type[msg_id];
 }
 
 static int parse_msg_type(const char *str)
-- 
2.31.0.260.g719c683c1d

