Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21B120229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756271AbcJWJ1T (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32849 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754677AbcJWJ1R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id d128so5248831wmf.0
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=emC/517Jbt9GQaIbNJFGQudQ2E7WjquMy07/xw6Mi0g=;
        b=bFl4ZWyOOwpkeR/rR7M4LrIRUHHJaw5i3KDISjMggbYOa/PYaurZn4pLAmf4Ek4Iy0
         bdcsuIBTz9y11yYbOee3o7aOkN+h58pQdA4SFzQShZhjp5AGK73ZIfmN0VXGhAqi43t+
         2y8VIp/6uPw0bvoCxnvHJqAA/ltC95et9QHXRXv/R9ASL7PdgItB++H/vHNjtm0Ng+rB
         a+lvJRnvla0xzVepoPBlXM8MGkf0e7nC4XCd4rmG7sn6RQaCL41NUGmIq4vXvuiysvqW
         IBJn6NI1uJkKmn460TPkGL44AQ7rqMqjeY7EQwYVe/Jrm2Eya1mQxMObBf936l9Y6zvg
         VyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=emC/517Jbt9GQaIbNJFGQudQ2E7WjquMy07/xw6Mi0g=;
        b=MtKLt5lA5zIQkLiUeI7VxQn2kYIZ5OteIOSevW3ZsSQC9QLFV6lqTrjkRkvvVRXg+N
         33409d6w7LyxwhMz3n757j/8exi0u6XH7YfjQBMniOasvVl3sBFPNNMDZSKjI6597enW
         qFykaXddjA+IpcfYXDvv+8pIvf/Q/umtlV0o3ytROyjzrG8vBP8pmNFJXEA3Xs4zpiWf
         zLqJIcmEEhMIZh6mQaD4rd469smON6TSDPspLwAu5OdsMWoEgvf29N+7PthcGkgIh7S4
         BfcHJdvqrrgWRuPGBH5ZmoK9RGXVxgIFTbNvWUhwdcp5OECYoXOCD6d16wg0n4Zh5O7j
         LlXw==
X-Gm-Message-State: ABUngvfYAr3MX3/GZDtKUisg6k+9WIEuiqohFXKzUTCESCV1jqk0Pg2KvcyH+QCMeHBGfA==
X-Received: by 10.194.43.74 with SMTP id u10mr7351694wjl.12.1477214835545;
        Sun, 23 Oct 2016 02:27:15 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:14 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 05/19] update-index: warn in case of split-index incoherency
Date:   Sun, 23 Oct 2016 11:26:34 +0200
Message-Id: <20161023092648.12086-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When users are using `git update-index --(no-)split-index`, they
may expect the split-index feature to be used or not according to
the option they just used, but this might not be the case if the
new "core.splitIndex" config variable has been set. In this case
let's warn about what will happen and why.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index b75ea03..a14dbf2 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1098,12 +1098,21 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	}
 
 	if (split_index > 0) {
+		if (git_config_get_split_index() == 0)
+			warning("core.splitIndex is set to false; "
+				"remove or change it, if you really want to "
+				"enable split index");
 		if (the_index.split_index)
 			the_index.cache_changed |= SPLIT_INDEX_ORDERED;
 		else
 			add_split_index(&the_index);
-	} else if (!split_index)
+	} else if (!split_index) {
+		if (git_config_get_split_index() == 1)
+			warning("core.splitIndex is set to true; "
+				"remove or change it, if you really want to "
+				"disable split index");
 		remove_split_index(&the_index);
+	}
 
 	switch (untracked_cache) {
 	case UC_UNSPECIFIED:
-- 
2.10.1.462.g7e1e03a

