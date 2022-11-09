Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD16C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 09:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiKIJHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 04:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiKIJHL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 04:07:11 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DECB1F9E5
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 01:07:09 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y4so16532272plb.2
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 01:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+y0xl2LRAkhu0hgz/ipF4yfkTjx6weXuh8Cbfg37rk=;
        b=QTAIYYc+837vgfxU1FY9/wHVp/XLthlikgOp/Jq4qi5GbwB+bF9iJ7MBDH0GOZR2E2
         sNlRUCiJ+HK0ZRS5nlpv81lVJTHjAI51XZ8RLtsBJWdpUkC5ZM5EJtUKWohqpmBUVpvi
         A7jvL1/VYslslN0HXdKqWUQX+YBa8/zRPDLUyM5AqLbm2OjGOrVj93chW/WNaa/ukO+J
         Frh0bI/zqB6+PBSetvDI7ovSqrlvb1IXvuKbJ6BVZGueYadbTqgUeNOtk/ZCxStCU4Cu
         4xsNW5PLHsBPjRvXdcEk9ehrC7mDna8TncfPVTAQHgyQugil/1PaQs1M/4mCVnZfd73l
         O5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+y0xl2LRAkhu0hgz/ipF4yfkTjx6weXuh8Cbfg37rk=;
        b=u0c8PIL0p7RUy1FRUy9NRQNj8OGHyfJIGLSRylqbGP6jBWOIpj7vviKPb49KH16U40
         c7eUHgjpnKpnClvi+9VI/xlEVisF79BVgAmnRjUGzTnFwi8sp5J4j3lOom1wprYUvp0V
         r78qfFr/tzdnWuv6zdFuEjBgzKiOtSnpiU/Y2aBl2P3r7vZv0KwqwA2WZwPG3JsUHsqo
         7hBBpxiud0rQA6Eo8ZluNNg44BwHs/KsTp9iLi3Ep/ZXGBKH6+byMS1OfLBw1v6eKP1M
         nLYtK4xc6IH3iG05l+gn03czS0UtEMX7Sd8iKsuUmmtqNjf62B/FtkMzOQwvFLXIQ8Yo
         c2mw==
X-Gm-Message-State: ACrzQf39m1SJcJx6/uguOxnYv6VII2ZbAq8AB0jMOXpuahTDb/1BkVpZ
        aeecMqU47yJ99hVTU6+Z/bbpZZBkEZna1/t1
X-Google-Smtp-Source: AMsMyM7fdpP8MfGxyM3qu/fc+8Hv0ActFszkkx7zfXk4+4zMexKv1+tI+lTK83AjNxupaX/59+hybg==
X-Received: by 2002:a17:90a:3c8a:b0:213:8043:4b7f with SMTP id g10-20020a17090a3c8a00b0021380434b7fmr69367907pjc.99.1667984828590;
        Wed, 09 Nov 2022 01:07:08 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.63])
        by smtp.gmail.com with ESMTPSA id mg7-20020a17090b370700b00212d4cbcbfdsm727509pjb.22.2022.11.09.01.07.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Nov 2022 01:07:08 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 3/5] notes.c: drop unreachable code in 'append_edit()'
Date:   Wed,  9 Nov 2022 17:06:54 +0800
Message-Id: <62a952ba3e7ad8599495119723b0fcd7044c819e.1667980450.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.386.g196e80358e8
In-Reply-To: <cover.1667980450.git.dyroneteng@gmail.com>
References: <cover.1667980450.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Situation of note "removing" shouldn't happen in 'append_edit()',
unless it's a bug. So, let's drop the unreachable "else" code
in "append_edit()".

The notes operation "append" is different with "add", the latter
supports to overwrite the existing note then let the "removing"
happen (e.g. execute `git notes add -f -F /dev/null` on an existing
note), but the former will not because it only does "appends" but
not doing "overwrites".

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/notes.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 485439c901..8c3a1cd913 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -630,13 +630,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 		if (add_note(t, &object, &new_note, combine_notes_overwrite))
 			BUG("combine_notes_overwrite failed");
 		logmsg = xstrfmt("Notes added by 'git notes %s'", argv[0]);
-	} else {
-		fprintf(stderr, _("Removing note for object %s\n"),
-			oid_to_hex(&object));
-		remove_note(t, object.hash);
-		logmsg = xstrfmt("Notes removed by 'git notes %s'", argv[0]);
+		commit_notes(the_repository, t, logmsg);
 	}
-	commit_notes(the_repository, t, logmsg);
 
 	free(logmsg);
 	free_note_data(&d);
-- 
2.38.1.386.g196e80358e8

