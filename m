Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A045C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 13:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJLNwW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 09:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiJLNwP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 09:52:15 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A520CF86A
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:52:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u10so26357369wrq.2
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 06:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNRIoDjURwK5311I9SWzJpQEc3gjGouBtnKfgO4kKPk=;
        b=qi1Za0HyRFDLwj7AXklTCRLHzBI2wvbQL5IjY03Awyxm8/SuIpFP1+m8DwYRLN6AuD
         aDfKaJU3TuaGnmqF+TJ3Y5tdMzbzArQeGlO5wXm+RN36IXFYF8p4QFfsKG5op3es6UKG
         iIWOircdLTuwHSfkWIWx8FS4oeK0wM/xyYE8mz1w1MVyHhZKyo0olZh7RiGDC2yk+1S+
         hOCoOiEUCBMprkV//ybvZJ7MUmVTTZA0FFQQ3wHDGh4HQwtWZpEFJQW8/AOADAsP7J6B
         cDbMX6FTjNNw7lB49XVFiY+Wv1eKQnhBQRIflb6rJjj94NxUdgQtPwKSsUg06yL7139R
         x1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNRIoDjURwK5311I9SWzJpQEc3gjGouBtnKfgO4kKPk=;
        b=lVm8X4RmLTUPXH9z0xXThGf39wdO5msaO0uxprEotrFYjBGHYF87D46l59luwn7jVE
         H2w0RKeYXhMKBeuvl5rT/4+mhpw9AqpVsUivNC7i3CItpZAYECjkIbO4PhYzZ5AKxkus
         fsi9iWD/hwYdb+fKAED6dMBY30TnfDGsOZkXdN068+I1GFjr0yCPFYyEzBCXEJWFU9ZM
         jKGVrI4g1jQ+sk8IA30YeI32kjI1xIdieATfS7TzMrjeYr/DMFGqTkoVyvawU3nfNc9e
         j3XqWXLhY7d8MVDJqMwhdqcwvor7xaBGs7bsWFtDnSQGzzQF081sFKzQi8L5P2cRcgfq
         KZ5g==
X-Gm-Message-State: ACrzQf0RQOOqrDWk7CV6JtaOSASI0iFbORq5/w/jkekCz+Y3E6ZrxqAU
        mIkZIBgKK9YgFI/DOAbr++ZTCuOmqKA=
X-Google-Smtp-Source: AMsMyM646df/KmBfpEuqlGvzHRTyL4NXNoj3GgMosDcTCoDIwiEcGRVdMVTkPm/Mqk4AGhbievGStw==
X-Received: by 2002:adf:e381:0:b0:22e:335b:7c60 with SMTP id e1-20020adfe381000000b0022e335b7c60mr18663345wrm.332.1665582730647;
        Wed, 12 Oct 2022 06:52:10 -0700 (PDT)
Received: from Precision-5550.. ([2a01:e0a:595:6400::ae22:851d])
        by smtp.gmail.com with ESMTPSA id m5-20020a056000180500b0022f40a2d06esm11396284wrh.35.2022.10.12.06.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 06:52:10 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] pack-objects: allow --filter without --stdout
Date:   Wed, 12 Oct 2022 15:51:12 +0200
Message-Id: <20221012135114.294680-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.38.0.4.g7f9724c7bf.dirty
In-Reply-To: <20221012135114.294680-1-christian.couder@gmail.com>
References: <20221012135114.294680-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <chriscool@tuxfamily.org>

9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)
taught pack-objects to use --filter, but required the use of
--stdout since a partial clone mechanism was not yet in place to
handle missing objects. Since then, changes like 9e27beaa23
(promisor-remote: implement promisor_remote_get_direct(), 2019-06-25)
and others added support to dynamically fetch objects that were missing.

Remove the --stdout requirement so that in a follow-up commit, repack
can pass --filter to pack-objects to omit certain objects from the
resulting packfile.

Signed-off-by: John Cai <johncai86@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/pack-objects.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3658c05caf..d707e6230d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4385,12 +4385,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	if (pfd.have_revs && pfd.revs.filter.choice) {
-		if (!pack_to_stdout)
-			die(_("cannot use --filter without --stdout"));
-		if (stdin_packs)
+	if (pfd.have_revs && pfd.revs.filter.choice && stdin_packs)
 			die(_("cannot use --filter with --stdin-packs"));
-	}
 
 	if (stdin_packs && use_internal_rev_list)
 		die(_("cannot use internal rev list with --stdin-packs"));
-- 
2.38.0.4.g7f9724c7bf.dirty

