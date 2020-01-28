Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D70BC2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1C5207FD
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 14:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSV4flHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgA1Olb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:41:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44183 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbgA1Ol1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 09:41:27 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so16294463wrm.11
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 06:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xdOCVLhEYsS6m8fOTgnZDYNINbR6VSsTJq3b7TR1ZE8=;
        b=MSV4flHZBOQ48yFHHIk9c7DJ69kCSblymkSBrW0t2ikfl/gmr0Gu0Ms7falv2fuvIM
         nlQPcWSThfrptGo3AFa8/AOm8vPnMRhI39960/UMODxu6Z016cCKIWMH6exLAhNwFESu
         pYyIqLhPvlNwx95PsqBqauwnH0OMTIwPNMpL4eJZEy2UuI9z8qRuRnNa8Moq6l0vGqU5
         DFx1za1C392uWnNkeMMU3P5EM+SFHsHuE16hXH9CKiI8o0LDyT0PrSeHjw11aMXlDJFC
         m/px0hWXvsDjxb6riZqJhXZCLwU6feTcffr6wFqr0A5GQhsGef6qs+rzTpdeCyygT6S6
         JjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xdOCVLhEYsS6m8fOTgnZDYNINbR6VSsTJq3b7TR1ZE8=;
        b=XIm723GTSBwsNu3AZlViGKK8ms/QkCblKPaQ+/1nroW7CRp3R7V0+puzpCcwWHtxZG
         1wR6bMisl/tKImFDUhHhAXvnR3aQagJQnTM4xvPI4xkWp0KVtAQ24SDj3+lKXV6FiHCt
         04ZP1twqoZXJpLR6MjiapZYyhaNTnoIgmIjbJCNz8mvpDafIue/2Gy09hD78tj52B/to
         CbDiRVeohFcObiQ50OFN38eCAsdph5pleU+1ZCMnY9RNj0Cpjz7NDzfl0XdkNIPIy8vO
         xDMyfkit/b6skXRw67JVjQ5lBcoJk8W8jUkUL8iiR8XYy/BksRgByaSfmlp89zVS3nyM
         /F5Q==
X-Gm-Message-State: APjAAAVwwA1DQcYUSYNXB8sw6k1BnKhEXe6C9IWMQ+XmYCfKSz5Rau4R
        bKLxGx4k6zkTlBu4ceu/HHXLPQdH2D8=
X-Google-Smtp-Source: APXvYqxx+6C7G5CL2QQlgplUHZIlBcNpAmvrKkogZxwy8xml6LqI+2C2SutRQSMBsqL9U7R1gv4o6Q==
X-Received: by 2002:adf:ef49:: with SMTP id c9mr30625222wrp.292.1580222485263;
        Tue, 28 Jan 2020 06:41:25 -0800 (PST)
Received: from localhost.localdomain ([139.47.115.4])
        by smtp.gmail.com with ESMTPSA id g7sm25732439wrq.21.2020.01.28.06.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jan 2020 06:41:24 -0800 (PST)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 10/11] bisect: libify `handle_bad_merge_base` and its dependents
Date:   Tue, 28 Jan 2020 15:40:25 +0100
Message-Id: <20200128144026.53128-11-mirucam@gmail.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
In-Reply-To: <20200128144026.53128-1-mirucam@gmail.com>
References: <20200128144026.53128-1-mirucam@gmail.com>
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
index d519e10827..43baa3df28 100644
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

