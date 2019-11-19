Return-Path: <SRS0=OLpm=ZL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4104DC432C0
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E252240C
	for <git@archiver.kernel.org>; Tue, 19 Nov 2019 23:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sd/ev4LW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfKSXzq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:55:46 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34645 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbfKSXzp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 18:55:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id h13so12879682plr.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 15:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lDbKAsqwfSSLgujNFaQKKcEhVVoQRGwCu6adEJ3ftL4=;
        b=sd/ev4LW3naGbduTuEVsgA9JsNUVU62b84lb+Pwf2EwKVJ/LWlu1Q3SO3wZ1L7ElVX
         +R0hklWE6BoiLwE02oQOuBW+Y4l7HpSSZrdY+9IYhuXNvKNHTrp26jc17IE0Rz/8AY1S
         V35jUU8nDu38AnZizqJPrLM7z3+lXFSzGR+8w8PxOoeJeL+N/r6fHnS4u0mL02tJzM+6
         8jzJfoBiVNM6l7X4wFtDCzc87d3lDLttX652Vaap5w49xtCsrTP9AxqptnGxFYdrZwsb
         lXNVpFVPVLi3MVnb94Sj88u5xayL3ywNn8nb+Y1cMrKS3Uxq8W7YLeV2F006BmqpSPSY
         MN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lDbKAsqwfSSLgujNFaQKKcEhVVoQRGwCu6adEJ3ftL4=;
        b=DcKZJ7cX1+lkUJWA1UWj11hZqDcg3q4HWuAadnULi8P0naXwL1RBn/rI1cfJr1w+jF
         7ZP4XsPxc+CkB2Yq/jR61I4d4y//xcAiUz6SSlKwLAlG4wG1UfQgu1qQVp1dv7YQXjCT
         e7maXZzNxLYzuPBEK9mUkhjnD6+ijJ8b7wcOYbKCI/Mjsvc9oF+Q4JdayXsPiAVKjzlp
         oOJIAs7Dh2X1pzt/srOni6FQTO5AFd2ofgVZaMKjzWYjOuk2d7b+AzU2rWy3ipsQ+yU2
         P1XS6fc49OMW1q6qVcST6lbhvVX2PcZCo74jouzd0APHbi49O2nfBO5JoWj69FKea/tc
         7G0A==
X-Gm-Message-State: APjAAAVNJi5mltLXjBR6rsKqMin+xjA5ytiArp1oSIZp2VzlVWIPPd5V
        0ulpcfqPnJ9KDRD2ic0bh5IGpwKN
X-Google-Smtp-Source: APXvYqxEPxTRPsI0Z2fukHZYijUgnOeS+CogpAfPbaXyWUq7wjqJfExLHqcJjLwEhyewJC1DlefTVg==
X-Received: by 2002:a17:902:26d:: with SMTP id 100mr263090plc.7.1574207744385;
        Tue, 19 Nov 2019 15:55:44 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id j17sm26173635pfr.2.2019.11.19.15.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 15:55:43 -0800 (PST)
Date:   Tue, 19 Nov 2019 15:55:42 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/8] range-diff: output `## Notes ##` header
Message-ID: <abba44082930450bbe577585f6c294c5f796a8ef.1574207673.git.liu.denton@gmail.com>
References: <cover.1574125554.git.liu.denton@gmail.com>
 <cover.1574207673.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574207673.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When notes were included in the output of range-diff, they were just
mashed together with the rest of the commit message. As a result, users
wouldn't be able to clearly distinguish where the commit message ended
and where the notes started.

Output a `## Notes ##` header when notes are detected so that notes can
be compared more clearly.

Note that we handle case of `Notes (<ref>): -> ## Notes (<ref>) ##` with
this code as well. We can't test this in this patch, however, since
there is currently no way to pass along different notes refs to `git
log`. This will be fixed in a future patch.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 range-diff.c          |  6 ++++++
 t/t3206-range-diff.sh | 14 +++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 7fed5a3b4b..623397221d 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -144,6 +144,12 @@ static int read_patches(const char *range, struct string_list *list)
 				strbuf_addstr(&buf, line);
 				strbuf_addstr(&buf, "\n\n");
 				strbuf_addstr(&buf, " ## Commit message ##\n");
+			} else if (starts_with(line, "Notes") &&
+				   line[strlen(line) - 1] == ':') {
+				strbuf_addstr(&buf, "\n\n");
+				/* strip the trailing colon */
+				strbuf_addf(&buf, " ## %.*s ##\n",
+					    (int)(strlen(line) - 1), line);
 			} else if (starts_with(line, "    ")) {
 				p = line + len - 2;
 				while (isspace(*p) && p >= line)
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 69babdcf03..5bb33efdff 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -516,10 +516,10 @@ test_expect_success 'range-diff compares notes by default' '
 	2:  $(test_oid t2) = 2:  $(test_oid u2) s/4/A/
 	3:  $(test_oid t3) = 3:  $(test_oid u3) s/11/B/
 	4:  $(test_oid t4) ! 4:  $(test_oid u4) s/12/B/
-	    @@ Metadata
+	    @@ Commit message
 	    Z
-	    Z ## Commit message ##
-	    Z    s/12/B/
+	    Z
+	    Z ## Notes ##
 	    -    topic note
 	    +    unmodified note
 	    Z
@@ -543,17 +543,17 @@ test_expect_success 'format-patch --range-diff compares notes by default' '
 	grep "= 3: .* s/11/B" 0000-* &&
 	grep "! 4: .* s/12/B" 0000-* &&
 	sed s/Z/\ /g >expect <<-EOF &&
-	    @@ Metadata
+	    @@ Commit message
 	    Z
-	    Z ## Commit message ##
-	    Z    s/12/B/
+	    Z
+	    Z ## Notes ##
 	    -    topic note
 	    +    unmodified note
 	    Z
 	    Z ## file ##
 	    Z@@ file: A
 	EOF
-	sed "/@@ Metadata/,/@@ file: A/!d" 0000-* >actual &&
+	sed "/@@ Commit message/,/@@ file: A/!d" 0000-* >actual &&
 	test_cmp expect actual
 '
 
-- 
2.24.0.420.g9ac4901264

