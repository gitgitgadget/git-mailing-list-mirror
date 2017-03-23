Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4237B20958
	for <e@80x24.org>; Thu, 23 Mar 2017 21:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756723AbdCWVJf (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 17:09:35 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35613 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbdCWVJe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 17:09:34 -0400
Received: by mail-pf0-f174.google.com with SMTP id 20so62943518pfk.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 14:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uSm/aJrfjymxP+60udetLmY0ZmvtCISssK68/NmQRgk=;
        b=VGSDR7/TmG5FmU9X1vJ2fpmLaAUhd6x5yVzKlnxBXSgADR9zYeKnVFapdTZjf+erGX
         xP3a+/85MLavF/kJW5kOwkh2stt3OT2rlYpRDA0LJKy1NODnJQDwIFZk29SzWR0PoP8V
         FM57SnXTxBNnbIZ7hCT03P6oYWI3sy0VSuzo+91i2mxbzeIheFLH8ew1nb+WAusjvUND
         7NbEww2+FFjav7Sw3/fxuvpnGXBrlXNN/Bn7ibk9IsWN9KjvZW6YUCTjQYn4PWrNoe6w
         P7LkfHa4vhR+Wq6rl3DJ0XGoWMIt8M2Rb37/byDRZmCxj2CbiJws586xJynGIz2qt+Wy
         +hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uSm/aJrfjymxP+60udetLmY0ZmvtCISssK68/NmQRgk=;
        b=AwSWkVQ6SjzXaiWAbsFMh7giVQ4S/fMfd5AkCkJaPwIlb/J6rk4UKvtU+4RqPin04z
         Du+gCTvHM7CzNw4pnhExeO60nkdtI6+IcHvV6Mnq8KSK4YkQN6PIFVN+28jXkOk3Ycdn
         qdTfxW70h/ZEE2y2HGC9f8CEt6xpD6Vy0TIWWWfp/bZ7qccMinI9IkbiIp+clXIR8mOD
         lm3U274TjolQiCnuvTck9UVg4s8UD1W2uI7goiIJ+XdoTbo2tz/9jrB6awjrKbWRJnEl
         UzYupdp7YWMusQb6xAGU0h5L/uk0rFEwKpSN1zVkwcF8zdcksurUzyPK9HZpTJKZyTvl
         W19g==
X-Gm-Message-State: AFeK/H3rGgTctp8pkLK69BVw0Y5GAvfrRrzqBNgghvQXJCN1GI5SlvtpYDu5X5aPAMMMuG3B
X-Received: by 10.84.224.131 with SMTP id s3mr6334505plj.162.1490303372875;
        Thu, 23 Mar 2017 14:09:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c402:7caa:e939:6e82])
        by smtp.gmail.com with ESMTPSA id t6sm179801pgo.42.2017.03.23.14.09.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 14:09:32 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/8] submodule.c: factor out early loop termination in is_submodule_modified
Date:   Thu, 23 Mar 2017 14:09:21 -0700
Message-Id: <20170323210924.26818-6-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.gb674c4c09c
In-Reply-To: <20170323210924.26818-1-sbeller@google.com>
References: <20170323004329.15892-1-sbeller@google.com>
 <20170323210924.26818-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easier for a follow up patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/submodule.c b/submodule.c
index da1db90dda..93d6f08b50 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1072,16 +1072,14 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 
 	while (strbuf_getwholeline_fd(&buf, cp.out, '\n') != EOF) {
 		/* regular untracked files */
-		if (buf.buf[0] == '?') {
+		if (buf.buf[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-			if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-				break;
-		} else {
+		else
 			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
-			if (ignore_untracked ||
-			    (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED))
-				break;
-		}
+
+		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
+		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) || ignore_untracked))
+			break;
 	}
 	close(cp.out);
 
-- 
2.12.1.438.gb674c4c09c

