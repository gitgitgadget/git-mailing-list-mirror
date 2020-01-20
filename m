Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB4BC2D0DB
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CE8217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 14:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6Z5/yvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgATOin (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:38:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45747 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgATOim (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 09:38:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so29782240wrj.12
        for <git@vger.kernel.org>; Mon, 20 Jan 2020 06:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KgrNvyZ4hU4hCrIsAMfvAtcrnW/D/9n/Gv8WyOb52nQ=;
        b=u6Z5/yvBGvPx1SGQbFCnHhKf9FM2GFzSSl5vPxcp5YkbaK0mLH8ycIQ2YAy1Buqhkc
         dBBErlALdY/SeMDIrYwT3nH3SpG0hWcZHnMCNUMw7uhmwtSgFMn9wgpWDHX8TL/8AfXM
         pdBNREbCkpOJxIpaHDF+Q0Xooitqphp0K2IyyH9fl1VJElYCJGwtIqssIn34qw2U5rMt
         yuRTmUM1XVW08sPqk6wiHRFuLMup41OSicE5P1nXcv2ZCa1RkoD0E/F1ZUzVhoQsAx2Y
         JRIUdhf+RMkFrTDv96vGWcffSzvMqxiqmFY4zs8+p5PANQ2NhwMc0Bn0HNTxtpUPW7Pm
         rsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KgrNvyZ4hU4hCrIsAMfvAtcrnW/D/9n/Gv8WyOb52nQ=;
        b=CHpHXuAjK9e0kuM7YnM2k420VvIPTBhBa/zoDMj0BTkUF811G4U7AaZLOr4b9DcWZ+
         5gYd8BdjAdH2dvvAadl1RFzuRCNmOFEcNikpAJbWobxkuCjNaxbr0SHp+b55MWTfxwAo
         76apB/8KgIJa7raTjXeX5esGQklPgivg7rFmwnCXmJWkP5EYXl2cUS9EadN0E+pgUPcj
         ntqqMlJzRQgRZYFptQGLuOdKpzLp0KIpRyBVa2LAEG34lwD/dzeM6keVNfQAY3uIDF0I
         8mSrWnCtU1vPmiDi2ZtYpbIvWpk+VAOn4eO9e5TsYV+w04r77EHWkPjc+8lxWkoNCnnu
         OvEw==
X-Gm-Message-State: APjAAAWCvGknk4gYWIIUFAnugn++RcfpgpNcONKpKkRuOfaBUKbzBk/m
        Tk8doIf8ecr7KFMPE7yv75W7I+I321k=
X-Google-Smtp-Source: APXvYqyJM8lV0V2ec4jKfYObJEmcAH1sE8W8vtUU/GdJg//cxokzjBjBX+pndROaNsJXueyRO5exeg==
X-Received: by 2002:adf:e70d:: with SMTP id c13mr18440111wrm.248.1579531120270;
        Mon, 20 Jan 2020 06:38:40 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id u8sm23192588wmm.15.2020.01.20.06.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 06:38:39 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH 10/29] bisect: libify `handle_bad_merge_base` and its dependents
Date:   Mon, 20 Jan 2020 15:37:41 +0100
Message-Id: <20200120143800.900-11-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200120143800.900-1-mirucam@gmail.com>
References: <20200120143800.900-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Since we want to get rid of git-bisect.sh it would be necessary to
convert those exit() calls to return statements so that errors can be
reported.

Emulate try catch in C by converting `exit(<positive-value>)` to
`return <negative-value>`. Follow POSIX conventions to return
<negative-value> to indicate error.

Turn `exit()` to `return` calls in `handle_bad_merge_base()`.

Handle the return value in dependent function check_merge_bases().

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 bisect.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index 2b80597a1d..acb5a13911 100644
--- a/bisect.c
+++ b/bisect.c
@@ -756,7 +756,7 @@ static struct commit **get_bad_and_good_commits(struct repository *r,
 	return rev;
 }
 
-static void handle_bad_merge_base(void)
+static int handle_bad_merge_base(void)
 {
 	if (is_expected_rev(current_bad_oid)) {
 		char *bad_hex = oid_to_hex(current_bad_oid);
@@ -777,14 +777,14 @@ static void handle_bad_merge_base(void)
 				"between %s and [%s].\n"),
 				bad_hex, term_bad, term_good, bad_hex, good_hex);
 		}
-		exit(3);
+		return -3;
 	}
 
 	fprintf(stderr, _("Some %s revs are not ancestors of the %s rev.\n"
 		"git bisect cannot work properly in this case.\n"
 		"Maybe you mistook %s and %s revs?\n"),
 		term_good, term_bad, term_good, term_bad);
-	exit(1);
+	return -1;
 }
 
 static void handle_skipped_merge_base(const struct object_id *mb)
@@ -823,7 +823,8 @@ static int check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
 	for (; result; result = result->next) {
 		const struct object_id *mb = &result->item->object.oid;
 		if (oideq(mb, current_bad_oid)) {
-			handle_bad_merge_base();
+			res = handle_bad_merge_base();
+			break;
 		} else if (0 <= oid_array_lookup(&good_revs, mb)) {
 			continue;
 		} else if (0 <= oid_array_lookup(&skipped_revs, mb)) {
-- 
2.21.1 (Apple Git-122.3)

