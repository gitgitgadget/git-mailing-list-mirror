Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E8D81F424
	for <e@80x24.org>; Wed, 25 Apr 2018 18:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756332AbeDYSV2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 14:21:28 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42784 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752902AbeDYSVP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 14:21:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id o16so15921854pfk.9
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 11:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sLaOBXo8sMUkIz6UeLQzKCXGK2J0scXOZSrw+BfoTTA=;
        b=Z6u+EH+uPUzorTaEMJaCEl++3h0vXGFJ5NEcEfDn2VNT5iJsSEzDjdYIzl3/AjUj5J
         L0pi4/ae3o+fblWVBhg8qX2i4MWV4XlcXvkNIFXjPvPjk/GVBdxFO/9szmxm5MGz43Bp
         8KUCZtQrHRsuA3nWhyxD6tAx5UeY1+Aa5HYtEMzfR203ANRSpI1uSbXeYxik+crW8lDT
         2Qbkj1cfi5kgedd0gqmczvKpZBbqSSt1GHkZaTFSlc/H28FX7gdXaiLZXBeUsbSeV4zB
         hShB91PB1zekCtOxtl+m9lZiJgJXT+9/XVYbkGr7bClJwvU/e9ZKljVrDaFICZX01nxv
         WTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sLaOBXo8sMUkIz6UeLQzKCXGK2J0scXOZSrw+BfoTTA=;
        b=qZlRuyJSKx8utZEFPAuF4NLv6w0xlny6/6IsT66RkFuXANTtBx6iM+YMeEA+PcUD9R
         hF9IXJdS1X40KImxadQWnd5kbbtj4madE/AhwNLrAYTMyKW45u7Tdydu0HCUC9hj5v9l
         aF+j+hKBbOzbgqTalYZy5IMsbHK1/uoFtxMWcmi8ahaf6cmSyIrLwXCnNHO4MzadPlyj
         IGPrty3cdG7vhRy7xiPmkw3j3RQKbQpRw7tf++3gMv6cWsoFPk4nW4HgdwICdWyZfDP6
         ImHKKHQ6aq2lFK2qvMRMfQ20Q2J+CL4jOs+atHc4XJxddYpKWyKFdPaeIrCPuWrer3+l
         nijw==
X-Gm-Message-State: ALQs6tBsmT6dz88E9myOEImMeYrNqxDUk5kBystf4iRUkEP5h+weJmu/
        5o5cWsyisKSQjLWJHdjQwkQ3Ew==
X-Google-Smtp-Source: AIpwx4/5H2z5U9OCIXI7YqEwKZhtsz68bgvmAwg0JwbPvH6D7kkJ0JwSl+LQFolxZIsYlWsNf5Zy0Q==
X-Received: by 10.98.86.204 with SMTP id h73mr27861571pfj.47.1524680474388;
        Wed, 25 Apr 2018 11:21:14 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id j14sm8041249pfn.63.2018.04.25.11.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 11:21:13 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sandals@crustytoothpaste.net,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv3 3/9] packfile: add repository argument to retry_bad_packed_offset
Date:   Wed, 25 Apr 2018 11:21:00 -0700
Message-Id: <20180425182106.162972-4-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180425182106.162972-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
 <20180425182106.162972-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of retry_bad_packed_offset
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 packfile.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/packfile.c b/packfile.c
index 80c7fa734f..d2b3f3503b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1104,7 +1104,9 @@ static const unsigned char *get_delta_base_sha1(struct packed_git *p,
 		return NULL;
 }
 
-static int retry_bad_packed_offset(struct packed_git *p, off_t obj_offset)
+#define retry_bad_packed_offset(r, p, o) \
+	retry_bad_packed_offset_##r(p, o)
+static int retry_bad_packed_offset_the_repository(struct packed_git *p, off_t obj_offset)
 {
 	int type;
 	struct revindex_entry *revidx;
@@ -1153,7 +1155,7 @@ static enum object_type packed_to_object_type(struct packed_git *p,
 		if (type <= OBJ_NONE) {
 			/* If getting the base itself fails, we first
 			 * retry the base, otherwise unwind */
-			type = retry_bad_packed_offset(p, base_offset);
+			type = retry_bad_packed_offset(the_repository, p, base_offset);
 			if (type > OBJ_NONE)
 				goto out;
 			goto unwind;
@@ -1181,7 +1183,7 @@ static enum object_type packed_to_object_type(struct packed_git *p,
 unwind:
 	while (poi_stack_nr) {
 		obj_offset = poi_stack[--poi_stack_nr];
-		type = retry_bad_packed_offset(p, obj_offset);
+		type = retry_bad_packed_offset(the_repository, p, obj_offset);
 		if (type > OBJ_NONE)
 			goto out;
 	}
-- 
2.17.0.441.gb46fe60e1d-goog

