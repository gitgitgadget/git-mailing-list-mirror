Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730CFC43215
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497C12068F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVQ+oIjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfKZBSM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:18:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34662 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZBSM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:18:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id z188so8115078pgb.1
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 17:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UZjQuhshmUTYkNjRds66IUkGFQ5n+5vfrrW8eCRBASk=;
        b=SVQ+oIjEH+Kt8F2Ad8Zaas8z9CV28JTTThhbhuFHax7ccJO8w52fBu+WepSkeWpfuJ
         xFys+9RykynCP1H12DqX2bA4Ye7WH/LAhwmJctYgKTt+YQWHpPU/RVHmWqHSoN/X/f8d
         GaTyqG8XvbkQyQ0eraMjzuaoMYsM5/SAb1hUcNb8HTTvfwlcnEn1EIPb2/ZceqoQGsPe
         l4+D8vf1Xvh8MaGkbAb4GPYkXTYJSI7MrtSIhzt9xeheYt5f3YDoXhs1mkloxe6vBwVB
         x23yzMywCJNTyVQZzcnXPKphw+R3Ezt4UpX081eFTRCe3/PsfaN3vpHlF/vDXOY/fmW/
         njtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UZjQuhshmUTYkNjRds66IUkGFQ5n+5vfrrW8eCRBASk=;
        b=aqbMf7nLlKEhSomgJsRbq0/BXSYMbblaT9N8b45tA7J42KYaMja3h3hN2tDGn+a7Or
         95AEZ/0AiToTCvCh77QvcCUcRGNk0q+gFKwakBZMUVuUnzrMQ936K5IZvbejR7oY05Ae
         ZuByV9W+LqZb+Ru0PiU4T0Tm1xwCbIbisE7dOTVxBWf/H8rETAHSpmDzX85C2ttunGDm
         sY6hDg5ocmXHRy3JX9SegHUYaQ84tONEPTy6qCIrlqqnrgM3hEeMfye0eThLsIFSC7gh
         xJPFsZigAf+wJ2s3q58rZVfQijCt5Vv1Wmavcj1ufxad4+QWBGyiEpKPbiqhrsILajyj
         e77w==
X-Gm-Message-State: APjAAAUxaPKmeBtuzCWOpN2JKZCyz8z836M1vE0V9uMKOFwJhWd+BEs8
        z+UdN/4gQ35v5MQYq57cR6m1pxqC
X-Google-Smtp-Source: APXvYqybLfAh8aWG7Jj3qjbFz/EvYee8Xj7S4xTL62ZISbnCg3lf0n8PtSbMIuepOVVkj9Be3RirpA==
X-Received: by 2002:aa7:9a86:: with SMTP id w6mr37640536pfi.169.1574731090860;
        Mon, 25 Nov 2019 17:18:10 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id l65sm9716708pfl.86.2019.11.25.17.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 17:18:09 -0800 (PST)
Date:   Mon, 25 Nov 2019 17:18:08 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 10/27] t4015: use test_write_lines()
Message-ID: <a44dd28b4d22cf9dfbb9344d3184d5d0bd4ac1da.1574731022.git.liu.denton@gmail.com>
References: <cover.1574449072.git.liu.denton@gmail.com>
 <cover.1574731022.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574731022.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of rolling our own method to write out some lines into a file,
use the existing test_write_lines().

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t4015-diff-whitespace.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 7fb83c8eff..4c540b1d70 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -771,9 +771,9 @@ test_expect_success 'checkdiff detects new trailing blank lines (1)' '
 '
 
 test_expect_success 'checkdiff detects new trailing blank lines (2)' '
-	{ echo a; echo b; echo; echo; } >x &&
+	test_write_lines a b "" "" >x &&
 	git add x &&
-	{ echo a; echo; echo; echo; echo; } >x &&
+	test_write_lines a "" "" "" "" >x &&
 	test_must_fail git diff --check >check &&
 	grep "new blank line" check
 '
-- 
2.24.0.504.g3cd56eb17d

