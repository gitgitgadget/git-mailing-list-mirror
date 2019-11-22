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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE727C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B422071B
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 19:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3Am2BHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfKVTAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:00:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45682 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfKVTAc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 14:00:32 -0500
Received: by mail-pl1-f194.google.com with SMTP id w7so3441664plz.12
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 11:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F3CD46bgyFQj9l/7EiIQ1M5XllH8qoZ3x+cmdl8pVb0=;
        b=s3Am2BHc+p3bAwhk0vn8Soc8jQJOfJchgBKrMUSv1ACV8+mbwQgKk48DodXjUEe5wI
         R9vaIGGUQi/85drQzJ4WBeQc3TPIbFZzwbTNHNyI3sAWdX2WknOgqJoQ1UUMwRxGNfCA
         jvqCTTTJpLKd0YKp4L2M7BzBl0eDj36rdw3CIno+VmelzF/mzA+IQzl15uzkvMhb5841
         muBiU680wRBg8/artvvThxee794vhHE0HKfP5qpKMyiJaYwfWd+NaS2QiKiVg8cwt2AT
         v4cVsEKzsyZ9cskOYNYoKm/SsTlzhbhM1/uWThxNi027sYq7hRuXG5ooS7eTSGMJ8pkf
         htQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F3CD46bgyFQj9l/7EiIQ1M5XllH8qoZ3x+cmdl8pVb0=;
        b=WHMzXbmvX32yMcfgvJPhCsrKplN92mvEWhZ9qoJnNYWgkt6XXv8v2miW7tWE3EOw1w
         4lzqsCNdVN4/Qg31Nb1xQD3TxsCnvpsyVKM789Xc+mHJJHWVHZ4CHd95bYiIoQVpuVfS
         EYRBmuueTJB5/1LIqp+Nmf7JIdiyvOEwztp2Zug9fWnoLNv5QGTsbu43w1tHQvD+d7x/
         hio/3OfhUB9nCqBl7B5kqXgmRpeL5nFpoy2Orrq4bYk0PpJTsKz6KTKoDdSjiz+MJt0P
         U8XfitcmnATb8r5AePobbf6tf7jW728hqobckVAYRK5CnhKXJgSqiPYc3e0Tzx/ZjEzB
         j15g==
X-Gm-Message-State: APjAAAVSmrXNPLYZf0lk549g3pXGJ8fw9BapFM6F7CkKfIDK2meg8gHP
        gkexOBTmO9lAAq9V1OOGJaNLwGLO
X-Google-Smtp-Source: APXvYqz3Z6y3I8lzt9lqNlPbDhEzGq0H0Cb8mv00gghoXhHH/NeyRA38jZM03b5NWV0BlysWJgyuhA==
X-Received: by 2002:a17:902:ac84:: with SMTP id h4mr16133244plr.328.1574449230306;
        Fri, 22 Nov 2019 11:00:30 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id e198sm8112244pfh.83.2019.11.22.11.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 11:00:29 -0800 (PST)
Date:   Fri, 22 Nov 2019 11:00:28 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 19/22] t7700: remove spaces after redirect operators
Message-ID: <2521ade74df0a0aebbb70abeff64d67ef8b00201.1574449072.git.liu.denton@gmail.com>
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

For shell scripts, the usual convention is for there to be no space
after redirection operators, (e.g. `>file`, not `> file`). Remove these
spaces wherever they appear.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index e1a689d6a9..8936928387 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -11,8 +11,8 @@ commit_and_pack() {
 }
 
 test_expect_success 'objects in packs marked .keep are not repacked' '
-	echo content1 > file1 &&
-	echo content2 > file2 &&
+	echo content1 >file1 &&
+	echo content2 >file2 &&
 	git add . &&
 	test_tick &&
 	git commit -m initial_commit &&
@@ -75,8 +75,8 @@ test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
 
 test_expect_success 'loose objects in alternate ODB are not repacked' '
 	mkdir alt_objects &&
-	echo $(pwd)/alt_objects > .git/objects/info/alternates &&
-	echo content3 > file3 &&
+	echo $(pwd)/alt_objects >.git/objects/info/alternates &&
+	echo content3 >file3 &&
 	objsha1=$(GIT_OBJECT_DIRECTORY=alt_objects git hash-object -w file3) &&
 	git add file3 &&
 	test_tick &&
@@ -111,7 +111,7 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
 
 test_expect_success 'packed obs in alt ODB are repacked when local repo has packs' '
 	rm -f .git/objects/pack/* &&
-	echo new_content >> file1 &&
+	echo new_content >>file1 &&
 	git add file1 &&
 	test_tick &&
 	git commit -m more_content &&
@@ -169,12 +169,12 @@ test_expect_success 'packed unreachable obs in alternate ODB are not loosened' '
 	mv pack-* .git/objects/pack/ &&
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
 		egrep "^$csha1 " | sort | uniq | wc -l) &&
-	echo > .git/objects/info/alternates &&
+	echo >.git/objects/info/alternates &&
 	test_must_fail git show $csha1
 '
 
 test_expect_success 'local packed unreachable obs that exist in alternate ODB are not loosened' '
-	echo $(pwd)/alt_objects > .git/objects/info/alternates &&
+	echo $(pwd)/alt_objects >.git/objects/info/alternates &&
 	echo "$csha1" | git pack-objects --non-empty --all --reflog pack &&
 	rm -f .git/objects/pack/* &&
 	mv pack-* .git/objects/pack/ &&
@@ -186,7 +186,7 @@ test_expect_success 'local packed unreachable obs that exist in alternate ODB ar
 	mv pack-* .git/objects/pack/ &&
 	test 0 = $(git verify-pack -v -- .git/objects/pack/*.idx |
 		egrep "^$csha1 " | sort | uniq | wc -l) &&
-	echo > .git/objects/info/alternates &&
+	echo >.git/objects/info/alternates &&
 	test_must_fail git show $csha1
 '
 
@@ -196,7 +196,7 @@ test_expect_success 'objects made unreachable by grafts only are kept' '
 	H0=$(git rev-parse HEAD) &&
 	H1=$(git rev-parse HEAD^) &&
 	H2=$(git rev-parse HEAD^^) &&
-	echo "$H0 $H2" > .git/info/grafts &&
+	echo "$H0 $H2" >.git/info/grafts &&
 	git reflog expire --expire=$test_tick --expire-unreachable=$test_tick --all &&
 	git repack -a -d &&
 	git cat-file -t $H1
-- 
2.24.0.497.g17aadd8971

