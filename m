Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABBCC56201
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF1C207DE
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1AAtTjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390548AbgJ1Xgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390288AbgJ1Xgx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:36:53 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7E0C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:36:52 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id f6so667365ybr.0
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G6NS/tgl44RBz5qaxl4GSsC/HY/YUYK+BGZzF5no6is=;
        b=T1AAtTjADZEUP71vNxX980UaCoQzznrVegfSwTxhrQW1g2z1e+GYSrC2rLdwbxxJms
         knAHgzwKvvjARCyBoAVyDsCSCH8XsNJ3OnSYoU3+vOIC1Uo+KP2XXK/7mHKm+/WmHVRY
         KSQS2G480SXi8aaG+OFetPNJjsjSQ6CgcHOdLhkssku+UsP+T9UEFapFb/I/Iuh7ot+f
         Yp6noBX5Y/Am12t84i5t1O1a3lSzdz1nI6VAwaxCLooHpFWlRiwp1q23+o+Z+3GZ79b2
         lh7uFc1AvZUdSsEGzDUkVZzu6F91Mp/wwMOzS9UufWGc3iGXJdW3JCWjnkK6vzrRwEzB
         RVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G6NS/tgl44RBz5qaxl4GSsC/HY/YUYK+BGZzF5no6is=;
        b=kzwkWfnhqQl/1qmXMnnLgwVZhdIQK+NVf1pZi51QAsR+zRBgrwI35F1TcFJVB9vHhT
         0YX0gngvMaN3jDbKHy0RuPpC1VI6F9pqTZmOrbVWMSQAtg54vGlhEJR5LN1m1BugYJeD
         5f60RK+KN13ukqJg1Zhx1TaGS8zU16C3wLkeRT6WqFY+uyPUrqppvIgC87K6Sk9ubokh
         pkauONu9/doJHYro6OoYd8Mp4FT17CQrTdeCQr8IobCp6oipOvtIAk2joKZJl4bkuoUr
         chgGPHX1zm2N+1ciupeX0WlHB4FSwiEiKcaS6Qr6oLA54ci4S43vf29lZ+jj/XHOo/br
         bqLw==
X-Gm-Message-State: AOAM530kDS+/WEKlCjyUg4Xxm6CAYoPYGizE8i8PdbwIt+8I+uFPMXfz
        ZBXY4CEatvVhsW+tryCsz7nDr3uuKsv5ULHA
X-Google-Smtp-Source: ABdhPJwxyzH0aKXepjeBWYpGYm2E+GX43DdvCZ7gaMla4Jn6fYuIYHu/ebYyAus8NSP7vTvSX9C32A==
X-Received: by 2002:a9d:685a:: with SMTP id c26mr3669960oto.40.1603850862340;
        Tue, 27 Oct 2020 19:07:42 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 7sm2199891ois.3.2020.10.27.19.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:41 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 17/29] completion: zsh: trivial cleanup
Date:   Tue, 27 Oct 2020 20:07:00 -0600
Message-Id: <20201028020712.442623-18-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 3689bcbd6c..234e4278a2 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -136,7 +136,7 @@ __gitcomp_file ()
 {
 	emulate -L zsh
 
-	compadd -p "${2-}" -f -- ${(f)1} && _ret=0
+	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
 }
 
 __git_zsh_bash_func ()
-- 
2.29.1

