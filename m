Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518A5C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2434D206CB
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 21:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpjTXUdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfKTVSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:18:48 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34133 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKTVSr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 16:18:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id z188so375574pgb.1
        for <git@vger.kernel.org>; Wed, 20 Nov 2019 13:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=saq1sIiKvHUKZa9S6Brdpex6Ut71yq+oK+oYi6wLdkY=;
        b=qpjTXUduP5uz2PDLUmMoWaONLKLwW7Gp+diQ/I7sGnP/v4EfnCvVIgGreUT5Jmuo/X
         IjVBBWCWQiS5YuYAPolPZj4IlAyFQSd7gL/17IalWUrxrpM6GOZ4VFlDk+/j3P8v8BMY
         BvBlne1x+HgHJVzkCEqgzFrKXJM5FJ2bFwgM8u6nxXaMPM7C5c15L+0MtRqvsijrmj7j
         iq+UALxRMTUnH0JOEiHS9d/hWlTAUaRBcYftiGUstl4Q7NFiIslzNEd8dXUZTilScrHw
         OsMuoQbfTVcJSaOmcG+zA7ekLUkW2kWfsxzuG4IaZoPpE3cMicG1lZzZVQ6o9648U/Yg
         Q3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=saq1sIiKvHUKZa9S6Brdpex6Ut71yq+oK+oYi6wLdkY=;
        b=qMIKucQ/gSkM/Ug3q9q2sN/PI5Jd5CyQ0cg+9f3mje9r9Sd3XfAoMtxXoMp7+hVEq4
         i3IG1xRWAPGk6Ey7Q9M/fFBLDRxXLG6uuCXJwm5bPQXX81higBvgZqcFfqyKE4EHCtji
         FXhzOcP6AjPtR0vV3U8ZFVDSO++nQuA0jbS4d82I4CCyZeMNK/1F30v67049aWpmo6C2
         6nYd9AhZMrK3vrT55E78H6WdXsV0jEu9b6i0NeLJh+1Gm9MYCAMAJl4YpezKv3cx2zcp
         oQTv/JRklMhqux8crBFNUe5MlrH8XV4yS1QWVr9JGU+cBPzUicfpTZJWqqo7FaLhCQHS
         gRtw==
X-Gm-Message-State: APjAAAXZj6ev6P19M94BxJljbiALB88vJv/jBeIq45sBAY6EiMXr+5NO
        KOvAvQXCQqFqh+6/UvpuPk++xGYc
X-Google-Smtp-Source: APXvYqwS2JkiH16R79x/GTpvQ+2h3A+JfFqPv/Clhc3MbmSPgkavbOyL6/ip2yh3SQyLhFTZFomwCw==
X-Received: by 2002:a62:e519:: with SMTP id n25mr6403613pff.220.1574284725459;
        Wed, 20 Nov 2019 13:18:45 -0800 (PST)
Received: from generichostname ([204.14.239.83])
        by smtp.gmail.com with ESMTPSA id i22sm194465pjx.1.2019.11.20.13.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 13:18:44 -0800 (PST)
Date:   Wed, 20 Nov 2019 13:18:43 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 08/10] range-diff: output `## Notes ##` header
Message-ID: <2d1c849ecc30c14ace8a99753c35c96d168347bc.1574284470.git.liu.denton@gmail.com>
References: <cover.1574207673.git.liu.denton@gmail.com>
 <cover.1574284470.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574284470.git.liu.denton@gmail.com>
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
index 19ba644933..b936c16dd1 100755
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
2.24.0.450.g7a9a4598a9

