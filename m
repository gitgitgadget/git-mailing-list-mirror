Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD6571FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 19:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758246AbcLPTDy (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 14:03:54 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34072 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757769AbcLPTDp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 14:03:45 -0500
Received: by mail-pg0-f48.google.com with SMTP id a1so12117110pgf.1
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 11:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NF4Q+uyuh/uNgdb7QcoI3bpLcjotXT8LLSCPVIPQ1S8=;
        b=CCjQcd2Ie1zYJ7rbRckxuybNw4Fm1Ec7qD1+Xr36t6aX4j7Y2gHlFyXTH/KDrqkN1b
         kbtpCPnm7kep5cXTILwnMRr5fP6xX1J2jpK9Hot0yQgSl4Sq4sMDYLGz/XGN79/zxsOl
         8/r3fHME4bOwtUbCWXP9ADQtDnmlquzA64U2ccJc8ykoUs2jWBB3pbkM6Wb6+MRgaLaK
         qJLVZ1GLvEUQZqY6ppecd+PDbP0C7coUiIgG97EMHXrcoyMhcMRa099PMpU8s6D9EK4Q
         zLZwDIW7PvixilJ462vQaNiNntcYuLtGBoEXVT7mmO+9agOuiF/PQZ8KpGhXXBg5GOm/
         MKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NF4Q+uyuh/uNgdb7QcoI3bpLcjotXT8LLSCPVIPQ1S8=;
        b=n++VWisiTNWWmRnY/yh4+ooBHOHiPxEDAdp8sid78XyXeRzagb8AVlv+UdcvAb9yK9
         HvrnwIMDpgqxVkR7XjApjxqZl/GEDMWmiocqmx57Ho129fHZxE7paQ6udsZ5kn5/sYXW
         7vyC4BHWE1dBmaNi8RGDVQALU9CDkpbZba7Adrh2Gdid3Rg1J83oXWNwWfd8ni4gUN/B
         Hfetn+EMoYfSv3FCq9CwPmeeUecNusOhWWhtMGU5PyuHSAIbAvNmUDJAkZSxXXnRZc6u
         mgO18zFQsNuftfWlsm4Kfd/shXo6rOpOoOYXiQ7SFO4VSdmH/tdQpi7zmZrEszI6vglG
         VpEg==
X-Gm-Message-State: AKaTC00hurW/QhwSJdaleeyondz27uuqOGSTQW2TuksWB+cxOW9z+/NB6DXDngbUzLmwnq9V
X-Received: by 10.98.160.29 with SMTP id r29mr4506860pfe.103.1481915019869;
        Fri, 16 Dec 2016 11:03:39 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id x90sm13573389pfk.73.2016.12.16.11.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Dec 2016 11:03:38 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sbeller@google.com, jonathantanmy@google.com,
        gitster@pobox.com, jacob.keller@gmail.com, j6t@kdbg.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v7 4/7] grep: add submodules as a grep source type
Date:   Fri, 16 Dec 2016 11:03:19 -0800
Message-Id: <1481915002-162130-5-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481915002-162130-1-git-send-email-bmwill@google.com>
References: <1480555714-186183-1-git-send-email-bmwill@google.com>
 <1481915002-162130-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add `GREP_SOURCE_SUBMODULE` as a grep_source type and cases for this new
type in the various switch statements in grep.c.

When initializing a grep_source with type `GREP_SOURCE_SUBMODULE` the
identifier can either be NULL (to indicate that the working tree will be
used) or a SHA1 (the REV of the submodule to be grep'd).  If the
identifier is a SHA1 then we want to fall through to the
`GREP_SOURCE_SHA1` case to handle the copying of the SHA1.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 grep.c | 16 +++++++++++++++-
 grep.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 1194d35..0dbdc1d 100644
--- a/grep.c
+++ b/grep.c
@@ -1735,12 +1735,23 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 	case GREP_SOURCE_FILE:
 		gs->identifier = xstrdup(identifier);
 		break;
+	case GREP_SOURCE_SUBMODULE:
+		if (!identifier) {
+			gs->identifier = NULL;
+			break;
+		}
+		/*
+		 * FALL THROUGH
+		 * If the identifier is non-NULL (in the submodule case) it
+		 * will be a SHA1 that needs to be copied.
+		 */
 	case GREP_SOURCE_SHA1:
 		gs->identifier = xmalloc(20);
 		hashcpy(gs->identifier, identifier);
 		break;
 	case GREP_SOURCE_BUF:
 		gs->identifier = NULL;
+		break;
 	}
 }
 
@@ -1760,6 +1771,7 @@ void grep_source_clear_data(struct grep_source *gs)
 	switch (gs->type) {
 	case GREP_SOURCE_FILE:
 	case GREP_SOURCE_SHA1:
+	case GREP_SOURCE_SUBMODULE:
 		free(gs->buf);
 		gs->buf = NULL;
 		gs->size = 0;
@@ -1831,8 +1843,10 @@ static int grep_source_load(struct grep_source *gs)
 		return grep_source_load_sha1(gs);
 	case GREP_SOURCE_BUF:
 		return gs->buf ? 0 : -1;
+	case GREP_SOURCE_SUBMODULE:
+		break;
 	}
-	die("BUG: invalid grep_source type");
+	die("BUG: invalid grep_source type to load");
 }
 
 void grep_source_load_driver(struct grep_source *gs)
diff --git a/grep.h b/grep.h
index 5856a23..267534c 100644
--- a/grep.h
+++ b/grep.h
@@ -161,6 +161,7 @@ struct grep_source {
 		GREP_SOURCE_SHA1,
 		GREP_SOURCE_FILE,
 		GREP_SOURCE_BUF,
+		GREP_SOURCE_SUBMODULE,
 	} type;
 	void *identifier;
 
-- 
2.8.0.rc3.226.g39d4020

