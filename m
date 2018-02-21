Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B59C21F404
	for <e@80x24.org>; Wed, 21 Feb 2018 01:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbeBUBzg (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 20:55:36 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39257 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeBUBzV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 20:55:21 -0500
Received: by mail-pf0-f194.google.com with SMTP id c143so58292pfb.6
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 17:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0UBkWCyX0vcCpeJD7Z8/Q846uTNFr4XQhuxVMGJoZpY=;
        b=qGvQVmJQOTO7dMF/n9krr9hteHA5cY+djzsmBp3PX9TVg9+lu9c16Pi/TdRxQEC/PZ
         C+MfCEYwwRu0lY15s931w+PVzwIQhwCX/2IkRicuSwKc3GDRdoOaf8UQCiN0FXC5tJFj
         UPvpWOBG93jr9LIJ2x+vnAY4IelAcEwlOJVAkODjB5lB0AO1hm+mQvU/8ra14qCtZfoU
         /DcV5XhpZ/XoiB1InTOOQ4aYm3S8MwBvppqwfPxWuybRwLIccJAr0bam02D9al8Tmd4H
         doOrzh3YnOfm9PHPVfyAzamPnTm5uzR3GgDvFeKg8Z+XnR/oy92Et+mIzeup7zrUP6lj
         XFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0UBkWCyX0vcCpeJD7Z8/Q846uTNFr4XQhuxVMGJoZpY=;
        b=dc1FEY1wZKTvqBm5vh3ybEhoATTWKKlFYi0G08miJqMlS+q5J3hnIPOUF4apb+/YGA
         W7SsE1BfqC+z0sjbQPjC3XHM20MFK9lKybGiOSgilQQ0MZfFjUc2rVEzeymhGgdyDFN5
         pEP4gKJqB3MIjEX42Bsa6YNntakAkJOpgmMSGrOiPQT0iW1aR8oOmu7aetPHVd15ZJaf
         iW4fj+NcqfUbsG5amOnrdLZzQYX01Zj4pMrA6Ygx90nCVFGHvOsJffYqJMbUXGN+xr1g
         i+SPU76MpPbAFZB8wsMrw+0M/olNDCfOFXaDGjLPcUfEZeePhG3Hzfpy4SRYI6DOeZJf
         wGxA==
X-Gm-Message-State: APf1xPCm30nY+zheekx/t+AU05BQSBqxzK0KvKRklT2qnKQMRVZ+dngh
        KDEzjsMiP5M9SUAtCge+Xq3Wx/9nxHY=
X-Google-Smtp-Source: AH8x2254SwfFv+3b0Wn53ok99NLb/bQa+AQ9y4ElecG09IHwvxYQ2EZHoVGCR3ZynL5tGHahlM8nsg==
X-Received: by 10.99.47.132 with SMTP id v126mr1312153pgv.129.1519178120685;
        Tue, 20 Feb 2018 17:55:20 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 191sm22150409pfv.10.2018.02.20.17.55.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 17:55:20 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 25/27] sha1_file: allow map_sha1_file_1 to handle arbitrary repositories
Date:   Tue, 20 Feb 2018 17:54:28 -0800
Message-Id: <20180221015430.96054-26-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180221015430.96054-1-sbeller@google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Nieder <jrnieder@gmail.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 598acc5410..522804d9f0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -936,10 +936,8 @@ static int open_sha1_file(struct repository *r,
  * Map the loose object at "path" if it is not NULL, or the path found by
  * searching for a loose object named "sha1".
  */
-#define map_sha1_file_1(r, p, s, si) map_sha1_file_1_##r(p, s, si)
-static void *map_sha1_file_1_the_repository(const char *path,
-					    const unsigned char *sha1,
-					    unsigned long *size)
+static void *map_sha1_file_1(struct repository *r, const char *path,
+			     const unsigned char *sha1, unsigned long *size)
 {
 	void *map;
 	int fd;
@@ -947,7 +945,7 @@ static void *map_sha1_file_1_the_repository(const char *path,
 	if (path)
 		fd = git_open(path);
 	else
-		fd = open_sha1_file(the_repository, sha1, &path);
+		fd = open_sha1_file(r, sha1, &path);
 	map = NULL;
 	if (fd >= 0) {
 		struct stat st;
-- 
2.16.1.291.g4437f3f132-goog

