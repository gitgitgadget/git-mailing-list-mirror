Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76D2B1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeBFAV4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:21:56 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46518 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeBFAVw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:21:52 -0500
Received: by mail-pl0-f68.google.com with SMTP id 36so113011ple.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oFqT2qMtJ4W3L2UWOUTWsOSRmhDyYCtlDTlRii0/y0I=;
        b=rXDo47A2pz7RncPZkUoy4U5rV82GQ+yhQXkKVTatuphpNiKYOLDRG3suCekNxavY7p
         RGrJMNcD0VrCY3opMKBQX/8015UJ3yEDLg4WJNjLch5xZ5TQcIVhDwjHFB70xn68LrIA
         zI9DPNaSXToPusyWmH0bIPv3SHRZTwEam1et/LgpKYP2sgC5QVf5Vy5lgNZfoBNinLhV
         mzUTxp1H7Z4r3gY7YtFm3N93AZKH2GEOc6eguMAQiTVs6xlnPpAOVLr+L4sFgEOgVQ+A
         gKQau0lBUjiXVd0gtVkIx8vspRJaSxKPLkqOSBwiW57iCR+NVkMZIGg6+gEgLt35POec
         w/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oFqT2qMtJ4W3L2UWOUTWsOSRmhDyYCtlDTlRii0/y0I=;
        b=Ot+gsREt8wftPYzCGT3AH4ZWKtiAZ6a/A+OVh+nMpyO5/zfFdI16VVON79bYosyCTz
         4hnEaNw/qEKSa8NLyeqOKHlqW9mW/Jny88LiK1fjnn2RmxevJccT0UqR033wYLuiqk4l
         es6QN5ASf13+zQqjSV5gmdFZ5hHBvsWmC8rj3qbNyMMT7o4LL0YYJywDrt1qDo5eCE4n
         BAy2v7VxOdFADsxl6erAacwgxbd1wnXYdiAZQGDmy66Z0Pt22XlNaJ4qPLwt3hpK9zWN
         4nyC8xaXJZXjsE61HfT7MtSs+R3+zFjAVLz0f12r5NLlf1jdPK6O3Pre+22pwadRsc1J
         m57w==
X-Gm-Message-State: APf1xPAt1A6SWxqrag3Xwr+yRK+0BlJSdg2V8f9Bu11Cru5m2QI+MaFv
        USziJLcv5UFVpmpeCoXlqP2Az27evhM=
X-Google-Smtp-Source: AH8x225gCAQT9CiWDQ0eF0AnGlXGaly4Q6ZTz+0mwb1doKFDexQ0hOyU3hCEhj+P8sxT6VRAGY7d8g==
X-Received: by 2002:a17:902:70cc:: with SMTP id l12-v6mr550191plt.67.1517876511511;
        Mon, 05 Feb 2018 16:21:51 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w27sm15083538pge.54.2018.02.05.16.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:21:50 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 125/194] streaming: allow open_istream_loose to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:16:40 -0800
Message-Id: <20180206001749.218943-27-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 streaming.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/streaming.c b/streaming.c
index 21bd069315..cd52f517eb 100644
--- a/streaming.c
+++ b/streaming.c
@@ -342,11 +342,7 @@ static struct stream_vtbl loose_vtbl = {
 
 static open_method_decl(loose)
 {
-	if (r != the_repository)
-		BUG("r != the_repository");
-
-	st->u.loose.mapped = map_sha1_file(the_repository,
-					   sha1, &st->u.loose.mapsize);
+	st->u.loose.mapped = map_sha1_file(r, sha1, &st->u.loose.mapsize);
 	if (!st->u.loose.mapped)
 		return -1;
 	if ((unpack_sha1_header(&st->z,
-- 
2.15.1.433.g936d1b9894.dirty

