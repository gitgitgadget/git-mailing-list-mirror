Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6A9C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiCINT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiCINTE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:19:04 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843D11728A9
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:53 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so1439459wmb.3
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLpiAwyfJn3k1peF3LyTYU4bHg9qPPSRHcITBovIYDE=;
        b=CFaSTdJu+TCU7UdCqY1aDiBK7bX8OINBFOh2PSZaeCkmJZ9Z3C4A5+SiCTBomWd3uG
         zoJ9NI1fa2aiXB1dcbNVTFMPuuXAvGSQlwIwOtbcBtfH/TMIQd5Gzcu5I/dixAXuWZnF
         SmTy5aPsxpGCoqhCmmlOhiYXRuoaLJaJ2HB0rdS7H0X+M75zXhI05rzIiXQUnCS55GfI
         4YGvYQ9VG+KLDuDsr5ZQLB9YtVu46Cpg3coY4jwko2iep9xosKiWYizo1Ttlzc1gH+pN
         VrFcSVZBpDjO9ZwDqxcVF/8Cap3KPrLKPh8QQ5rrLZaEz8UlreQUMBqVFqa3ud04VKpD
         tB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLpiAwyfJn3k1peF3LyTYU4bHg9qPPSRHcITBovIYDE=;
        b=OWpEYUzvcYZIrhosh+mlWJBxWs50/ZGk203lg7FFjU5aEgumIdd3G96NgtCE4G3FJP
         zYcPmkC4oTS94VHrPR9YtJrNMoTIFi1Zu/7RRUNVnwAAkktTDTLGuhC0AFWRy2N81FEC
         b3K3GHxwt0N6gncT+wAq0AWA0RVu3Nh5Xv1CwS3f/ICo4ijOYhUrqPlzvUTFfL20bLiJ
         b9GEN77GsiCT0azEBjGjwl+6lUmrmwnOjt4kiba1wnx+SyegsDdrWDBW+oHPOYlgVad5
         j0veBkLhCW44ZsduOH6KpZdG/+Y/1t84RKY50YK6QQHUU3TBW9aCHQEHUhuGGU8bBZRj
         ynJw==
X-Gm-Message-State: AOAM530GYzcwhIGyfyM9XJAJRU1x0NtrMYDPFVvpf+DChit6CvmRdHo3
        gJwiH2rA3ggxFWsNgvWnbOAFaEZtzJdU0g==
X-Google-Smtp-Source: ABdhPJzYEdAIk6mItRCpoHvg7OeK5Dy83mw8zXm7N7u55JwgAfK8uYzk4Wo+l83LkLv/JNJiU0j/+w==
X-Received: by 2002:a1c:2bc3:0:b0:381:3dd5:5707 with SMTP id r186-20020a1c2bc3000000b003813dd55707mr7380962wmr.31.1646831871727;
        Wed, 09 Mar 2022 05:17:51 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/24] revisions API users: use release_revisions() in http-push.c
Date:   Wed,  9 Mar 2022 14:16:39 +0100
Message-Id: <patch-09.24-8f93b87f369-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the case of cmd_main() in http-push.c we need to move the
deceleration of the "struct rev-list" into the loop over the
"remote_refs" when adding a release_revisions().

We'd previously set up the "revs" for each remote, but would
potentially leak memory on each one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 http-push.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index 3309aaf004a..8c18f01bb60 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1689,7 +1689,6 @@ int cmd_main(int argc, const char **argv)
 	struct refspec rs = REFSPEC_INIT_PUSH;
 	struct remote_lock *ref_lock = NULL;
 	struct remote_lock *info_ref_lock = NULL;
-	struct rev_info revs;
 	int delete_branch = 0;
 	int force_delete = 0;
 	int objects_to_send;
@@ -1825,6 +1824,7 @@ int cmd_main(int argc, const char **argv)
 
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
+		struct rev_info revs;
 		struct strvec commit_argv = STRVEC_INIT;
 
 		if (!ref->peer_ref)
@@ -1941,6 +1941,7 @@ int cmd_main(int argc, const char **argv)
 		unlock_remote(ref_lock);
 		check_locks();
 		strvec_clear(&commit_argv);
+		release_revisions(&revs);
 	}
 
 	/* Update remote server info if appropriate */
-- 
2.35.1.1295.g6b025d3e231

