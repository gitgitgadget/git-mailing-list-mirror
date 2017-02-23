Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3522022D
	for <e@80x24.org>; Thu, 23 Feb 2017 18:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbdBWSwW (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 13:52:22 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35650 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbdBWSwV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 13:52:21 -0500
Received: by mail-pg0-f53.google.com with SMTP id b129so18159998pgc.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 10:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SY7Ef4lHuWKYFkJWLDgySspW30IXrQk//I2/BRGZgNs=;
        b=wGDdLz6Ms7MEcvSibVuI24U9IIlqz3MwODVXeA5Qe4gpU7fS/iOOzuRGpxsIO1v6oX
         /bvMNAyvz5pJv17ya+iomnbuDTnIOq7D3ME93TAnIRb74MBFfMrwbJnemTlT1IhdwaEN
         jsVxCCuF6CLbQlYPWtuxM3tkpBMMCHYl2BxksMC9eQkyxDm2f9lEU7dxqvH8dnjwcrcZ
         0qae7cUJhmXM3ZhD8h0pW/gglIV+IIA/wqayDMiCJuJTbU3PU9rpSCSPB4bsM49I1soi
         9fgQi4/Klfi0jBcVhn71FOAq21YRNa16+EsGinl/fjMb+FPJZj321u4zfVHAF5vl31DZ
         PYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SY7Ef4lHuWKYFkJWLDgySspW30IXrQk//I2/BRGZgNs=;
        b=rfAKmNoPOv7uCSwvNugQM0Uk+mc8R4k98xu7X2GoL63mQvgfolMcJfT84s8ZcOwYN2
         zq3L1R5BDklbAYHX2H84WUPBqEvoID67fvo3Y64/Sey7j2+kBGG4yDru2/HPyRwiY7tn
         SauFLPw398xgTcF/NyQiyR1I+34ZKImPd9eIiZPQt4EudmSF56sOLsc2Yp9L49CR+PcK
         Sggk226n2U2SS/AHi65X871VDDCN37V+TeiiRCrQquYP6xqLBJFAuo5oehBBG4gAgyMV
         mOWqqvaUSUnrtdfknOPg9lJHiZU7DyBOy5+W42OMdNWlq6AyMdKMWwPQdcyH5YB9Pxsv
         985A==
X-Gm-Message-State: AMke39n/kf5xRmoYPPGAa9KzWFrp4vxT+lPruFjl2xIrgyXJfG+IaAQ3m/ojotDkdtO2H/i0
X-Received: by 10.84.225.18 with SMTP id t18mr57402864plj.154.1487875390895;
        Thu, 23 Feb 2017 10:43:10 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id l3sm11213604pgn.10.2017.02.23.10.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 10:43:10 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH] upload-pack: report "not our ref" to client
Date:   Thu, 23 Feb 2017 10:43:03 -0800
Message-Id: <20170223184303.26530-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <xmqqo9xtajcu.fsf@gitster.mtv.corp.google.com>
References: <xmqqo9xtajcu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make upload-pack report "not our ref" errors to the client as an "ERR" line.
(If not, the client would be left waiting for a response when the server is
already dead.)

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

Thanks, here is the independent patch.

 upload-pack.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index 7597ba340..ffb028d62 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -822,9 +822,13 @@ static void receive_needs(void)
 			use_include_tag = 1;
 
 		o = parse_object(sha1_buf);
-		if (!o)
+		if (!o) {
+			packet_write_fmt(1,
+					 "ERR upload-pack: not our ref %s",
+					 sha1_to_hex(sha1_buf));
 			die("git upload-pack: not our ref %s",
 			    sha1_to_hex(sha1_buf));
+		}
 		if (!(o->flags & WANTED)) {
 			o->flags |= WANTED;
 			if (!((allow_unadvertised_object_request & ALLOW_ANY_SHA1) == ALLOW_ANY_SHA1
-- 
2.11.0.483.g087da7b7c-goog

