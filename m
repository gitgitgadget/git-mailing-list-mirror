Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2C0C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FD82071F
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ7/vpoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfKVTAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:00:36 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:44749 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfKVTAg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:00:36 -0500
Received: by mail-pg1-f170.google.com with SMTP id e6so3727925pgi.11
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fQcLUMB3ZLUncM5kpVD9oZr/STQVDcPMIdEGhXp/9gg=;
        b=OZ7/vpoaBGFVRjkOL27AYg8Xo9PMRl03h0xK+JY0F9QNmQurnaGJm/12q6f0VS/Ke5
         MPC7Sr+Si3x8eit9BZgdK97aS0Rj1ugkP9DQ/HFVwAvws/UUEkZeywW7D6q2KVigFYlA
         glVZEXqOa28Pqgh9pOhAKydrFDunILzH4tkcrU8rPpGhLvq93malY0BBLqKB0B/38fg5
         ieU56AaU4LiZmlELHQTVWRjZla8HZk7puZt6iQ3lmZr+KdM+/jZsjdXwUchj10xpyAXp
         5UWi3B9u4YW1P5lkixVlaCDXOxPoZkliL6hSgS+8K6BhlmnvjBaobnDU5+YzRlfaRn+Z
         6xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fQcLUMB3ZLUncM5kpVD9oZr/STQVDcPMIdEGhXp/9gg=;
        b=pZsJ90K6jVKCwuaOGKBycIwei5rJIs+CuWUvz/0FJzm8TaK7aTqFKtzsUPE1ujUP1k
         GOmlnrkl9OHy9aFLtX2YXqPHil7ohIMJShUJ3xE946Zsr28ETQxYgN+qhMR+NyCO3B7y
         zPB+fdIpZNW4CvzSFAaf66s0SAYUtX3+G0/B5ymsjks5TbK5FFXepHirBTQYxEA3cDMN
         IYps11smzLSYwiDJY7gx1Rx2R1EBxmiqJGnoZjQDUCDS1Xp74jWQIb1izTzwgNEL4BGD
         EbkG7h39E/gpa5TIljMoFkymDIqjWY/YTka+JSCndva+LFDSr5UB1klBNSrphXd2i4Ji
         /kEQ==
X-Gm-Message-State: APjAAAWtUomiLL3//XVpxGPaIAdw/aadDrukDHp79p6hvukQWhjbYFui
        0XFj8lD+jfFt50jh1JBruoVgaLQe
X-Google-Smtp-Source: APXvYqwS+X9W+vbJzDLboUnQx5QXgfW3J1isup/mu6xDt+fL1sYHv0icGVZ+OoOqgeDtVVC/BSCe4Q==
X-Received: by 2002:a62:1914:: with SMTP id 20mr18566203pfz.68.1574449235089;
        Fri, 22 Nov 2019 11:00:35 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id e7sm8326294pfe.173.2019.11.22.11.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:00:34 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:00:33 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 21/22] t7700: s/test -f/test_path_is_file/
Message-ID: <bd27805e4bbd7493be6abc6820213913b95107be.1574449072.git.liu.denton@gmail.com>
References: <cover.1574296987.git.liu.denton@gmail.com>
 <cover.1574449072.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574449072.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we have debugging-friendly alternatives to `test -f`, replace
instances of `test -f` with `test_path_is_file` so that if a command
ever fails, we get better debugging information.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index a96e876c4e..1d14ddcbdb 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -106,7 +106,7 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
 	mv .git/objects/pack/* alt_objects/pack &&
 	git repack -a &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test -f "$myidx" &&
+	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
@@ -129,7 +129,7 @@ test_expect_success 'packed obs in alt ODB are repacked when local repo has pack
 	git repack &&
 	git repack -a -d &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test -f "$myidx" &&
+	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
@@ -148,7 +148,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	for p in alt_objects/pack/*.pack
 	do
 		base_name=$(basename $p .pack) &&
-		if test -f alt_objects/pack/$base_name.keep
+		if test_path_is_file alt_objects/pack/$base_name.keep
 		then
 			rm alt_objects/pack/$base_name.keep
 		else
@@ -157,7 +157,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	done &&
 	git repack -a -d &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test -f "$myidx" &&
+	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-- 
2.24.0.497.g17aadd8971

