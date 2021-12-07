Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D1FC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 18:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbhLGSaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240489AbhLGSaL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 13:30:11 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8A1C061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 10:26:41 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d24so31501359wra.0
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 10:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fQiDBoUv4PoVV50Mi4s1PrR/XLFDdMZ4hpU2GP7lv5U=;
        b=J6bFt0pR5BUHIhSZZjAaQHKHUo3+nrq8LJrLa4kre1o8ER66SWsfksctR3l4wYqxId
         SzmMNHD7iTRf0OpZNejZMrD1zRhIiZvwD8DuEhDW5Jlo4/Si5k7wI6DyK+7LcglimqBh
         fZnJBlFHoCdeNJH6oN+x07eiVuEd09VF9aFp+RuJKvX7aKwlJiCckxtQvJASn2HxBByF
         mN/T+CpDytqvHcQI4s4qx5hiNpNR4c3w6+9ZqanGe++6BGq3xrs3Aj+bUoJNDcd8xpj0
         fq1IWYGzr4weyESWrKtVHfUkTajgoGA78kxBmhi4JNVlYpeNu1gLQchtvEn+pj7HXVC+
         qmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fQiDBoUv4PoVV50Mi4s1PrR/XLFDdMZ4hpU2GP7lv5U=;
        b=AQExzHbJ6NreZyI//Kqe91Kx63VHFjP6kAnIalxP8N3eJKruwu2JpT6xNFCvwjawG8
         rpdWRzlzFoWciRABtNpe+0FrlrgbTL0z4J0SwjI3ujvObLsYzj98ecO3dqwYl90Xi1Q9
         qaMtHZ/+rVFd8HtlKbRLZ4ttVfoZ9cJoplJg+c8nzHeuL2Csj8JQ00BjiYZmSpDNzYSH
         FnJsX+6n6Qk+9+RhV87K7KTV2/WXilGClR0WOCZn15jtOEoOLAC+5jzEFngqaXheINXq
         eQ3GZvuHwPbAo1LovkXvC5WXBKyPl31ImadGOrnV7+bMwOomfOu+U4lNKSJmSw1Hu52u
         36tw==
X-Gm-Message-State: AOAM531wXIVX2VkNkjDDpc6HyEafshFmc1x7P9rrbxH2++nSYmiN+SiL
        /0mWWdsAU86SavGMVXvzQ7M0WqQcanPu/A==
X-Google-Smtp-Source: ABdhPJwT9dv+jlpv75g95U+GyFAr7Tcx/26l9TcVX/wsuv6tW/HWtbzpFPxZRmH7g90QAtO9kRkmlQ==
X-Received: by 2002:adf:8bda:: with SMTP id w26mr52649747wra.534.1638901599407;
        Tue, 07 Dec 2021 10:26:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm450496wrv.30.2021.12.07.10.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 10:26:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] usage.c API users: use die_message() for error() + exit 128
Date:   Tue,  7 Dec 2021 19:26:31 +0100
Message-Id: <patch-v2-3.6-c7d67fd41fa-20211207T182419Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.898.g5a552c2e5f0
In-Reply-To: <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20211206T165221Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211207T182419Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the migration of code that printed a message and exited with
128. In this case the caller used "error()", so we'll be changing the
output from "error: " to "fatal: ". This change is intentional and
desired.

This code is dying, so it should emit "fatal", the only reason it
didn't do so was because before the existence of "die_message()" it
would have needed to craft its own "fatal: " message.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/notes.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 71c59583a17..2812d1eac40 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -201,11 +201,12 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 static void write_note_data(struct note_data *d, struct object_id *oid)
 {
 	if (write_object_file(d->buf.buf, d->buf.len, blob_type, oid)) {
-		error(_("unable to write note object"));
+		int status = die_message(_("unable to write note object"));
+
 		if (d->edit_path)
-			error(_("the note contents have been left in %s"),
-				d->edit_path);
-		exit(128);
+			die_message(_("the note contents have been left in %s"),
+				    d->edit_path);
+		exit(status);
 	}
 }
 
-- 
2.34.1.898.g5a552c2e5f0

