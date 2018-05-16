Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7D31F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeEPW7G (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:06 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:46514 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbeEPW7F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:05 -0400
Received: by mail-ua0-f202.google.com with SMTP id 69-v6so2251217uag.13
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=316Lcwfo9mWjCEoJF7bWMISM+WwSxWpHeyuv/a6fyQI=;
        b=qLL5nBG6GMy2YQNfJbSg80zMBwMqapGOGmwRFwf2rJtH/nZSZIjA3ttMuv7rN3gwLe
         2IEnTPcHPKVAzz2M2h6ydzdFIxpwFMgMIMBr+GFq/f0dUGaCRmau34Pa4eOCbtSaDiBA
         sa+uxlOR9ryOqy5e02x+j52ELf4et2dBN5mCGIh40bYiBctt1AKX4bvZGfSBYaXXgur5
         I+bTCCYktDl1pgXiBGv9ZkVHevpTUvrPP0tDn4cozkZRuW5pqMX9BShhfRJ4tFnRK+GU
         y19w4mkERhirGaoqhWl9bPQNQXQcoEWI+OPzAF2hXx0MUaj1Tz779twFpt1fXS5ba3md
         Cn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=316Lcwfo9mWjCEoJF7bWMISM+WwSxWpHeyuv/a6fyQI=;
        b=nznfpyh1/aeAJAjNz1HA9EVAWSWEVYrJNmxB7L7H1HUbyrHUZHnYYy42XhMQaYWIQJ
         5Lk+QSc50ZzUHFqb+a/2McBrAl8erXiYrhCCh2S8piEY0fFLp6O3FZoAef28SNf2qFVT
         hAOynlspEbqRsj++Tp5f+Z+1Hv7J+5gDC5zExW1T/wI0S7ObEE8HGuTsYraht1fmOIB4
         0SQ/0F4L6KKH75vYDv6501IZPNNroE6es0qMbQfUEX6noADqpAljYRvg5gf6Q2LqvvKj
         7JBX5FL1GITnisC9dU/3epnoYrfUyYrlKXmkPIQaUrvr6KZUmyWX92yBhU2bUXApQ4e5
         5sxQ==
X-Gm-Message-State: ALKqPwd2rsvjl751Qx2Ut1jR3HBd+sn6Ylg3dalbsukiYpCzeHPj0zJx
        3zpxKsi+674jF6Y9Tz8u9+rGDw+J2PSv63EO/v4n6uA89VzcGN1OyUKQftrrBtPxdEHKvoSCZIc
        jfKvf0bNBprWYixWnW4eWRLE5iVXefK0NMSlYQyfza6IYxf58pSVIaRUVUw==
X-Google-Smtp-Source: AB8JxZqwut6v+at9mJZqCh3zZ/CLPRhtTul5+/oc1azEpi6SkjFkWM2BxdyUvxgiPRJDG0pJKVlsklamhSI=
MIME-Version: 1.0
X-Received: by 2002:ab0:560e:: with SMTP id y14-v6mr2348639uaa.58.1526511544659;
 Wed, 16 May 2018 15:59:04 -0700 (PDT)
Date:   Wed, 16 May 2018 15:57:58 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-12-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 11/36] clone: convert cmd_clone to use refspec_item_init
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'cmd_clone()' to use 'refspec_item_init()' instead of relying on
the old 'parse_fetch_refspec()' to initialize a single refspec item.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/clone.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 854088a3a..8c5f4d8f0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -895,8 +895,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
 
-	struct refspec_item *refspec;
-	const char *fetch_pattern;
+	struct refspec_item refspec;
 
 	fetch_if_missing = 0;
 
@@ -1078,8 +1077,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
-	fetch_pattern = value.buf;
-	refspec = parse_fetch_refspec(1, &fetch_pattern);
+	refspec_item_init(&refspec, value.buf, REFSPEC_FETCH);
 
 	strbuf_reset(&value);
 
@@ -1139,7 +1137,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refs = transport_get_remote_refs(transport, NULL);
 
 	if (refs) {
-		mapped_refs = wanted_peer_refs(refs, refspec);
+		mapped_refs = wanted_peer_refs(refs, &refspec);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
 		 * in mapped_refs (see struct transport->get_refs_list
@@ -1233,6 +1231,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&value);
 	junk_mode = JUNK_LEAVE_ALL;
 
-	free(refspec);
+	refspec_item_clear(&refspec);
 	return err;
 }
-- 
2.17.0.441.gb46fe60e1d-goog

