Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D74C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 20:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787032075C
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 20:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTdOBxSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfLFUQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 15:16:00 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:45277 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfLFUQA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 15:16:00 -0500
Received: by mail-pj1-f65.google.com with SMTP id r11so3186076pjp.12
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 12:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mr0XFPIClcusKf6Rx7Xj/y46/nvxOEMC78qoleAMLX0=;
        b=VTdOBxSR4+0V7SA3k+zzgXaqj+mOrQKgz4Om1jqsQtCNyhQBCVJtOK3OCr3xPiIRRn
         tBxs6hUmAJRLKWhKSZBw0fCzq1gudEVKfj3guCKG2dAwvjbV3Pz4KZbDfIRQSwHhSQoI
         ceCoBJenX//T3tOOqNpIWbcilfFj1SapETLaa9feccOkOTKSA3E62M8ICwRub3Nh1pkm
         GyppOzxhvb6pve8zHbe1bVzPkV4hYU+bdJnjITW5PFV+oWPObYgm7dz+ig6LaS1YXvL8
         IvpQLPBpJDSgRoOfAQEkiXV0CCwUdExghHOekqkxGn1BYOYAC/SYjesjQ75WJH2TWetU
         7fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mr0XFPIClcusKf6Rx7Xj/y46/nvxOEMC78qoleAMLX0=;
        b=IhRcGKrTPGmrX4HjLjvNM7av8mulVO7ECIrn2haJrEhHGPm9phTjM5cowZMjhwGo1G
         ub3d+c897VCNUH61UYYOkWMFaHfawX1LdzIFxWuEdLaGJmqoZPu76ZAxu/CxmRFQn7Ei
         L6SVAZo/b0xEBjiNieFZRlpipPzSqsbRGkvPeylpX8+F/jUEg/BI6pApiwntAdM8CarM
         OFKcMM0T3lNwachkoAg+B7QuCroiT71iMHboj4SCzaVZiZQI3YXcRt4NonzQhUMo4OY1
         jNCk5n33uh12r7TTDbV303B2JMvoXidy7Age9hJHDkwtccB+pJiNUVVwBkm5qxor7h+7
         f66w==
X-Gm-Message-State: APjAAAXA4FhGSQFt/EAJfb2MRfyPehVqUx8LsG6njNka7x+oT/PJIPio
        qhFLbGXosJ5Ucy3HR6e2b9FvBbYP
X-Google-Smtp-Source: APXvYqym/JCr/hQfVkZz9keyh+za0wsqq5Ja5lbaRNXa7w+/LqjiPozJeg9e47MFTMQoxMdkDVzpRw==
X-Received: by 2002:a17:90a:c390:: with SMTP id h16mr17934448pjt.131.1575663358901;
        Fri, 06 Dec 2019 12:15:58 -0800 (PST)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id b73sm18199519pfb.72.2019.12.06.12.15.57
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 12:15:58 -0800 (PST)
Date:   Fri, 6 Dec 2019 12:16:22 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] t3206: fix incorrect test name
Message-ID: <766adb34858c39c446dc9d0211c3f9b34693b99e.1575663345.git.liu.denton@gmail.com>
References: <cover.1575663345.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1575663345.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The name of the test used to indicate that it was testing the `--notes`
option but it was really testing the `format.notes` configuration.
Correct the test name to reflect this.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3206-range-diff.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index ec2b456dbb..0575dd72b1 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -638,7 +638,7 @@ test_expect_success 'format-patch --range-diff with --notes' '
 	test_cmp expect actual
 '
 
-test_expect_success 'format-patch --range-diff with --notes' '
+test_expect_success 'format-patch --range-diff with format.notes config' '
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
 	test_when_finished git notes remove topic unmodified &&
-- 
2.24.0.612.g9b7bad38f5

