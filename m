Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB3EC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 18:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2677F21582
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 18:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkYH6p1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfLRSRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:17:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33169 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfLRSRS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 13:17:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so1706242pgk.0
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 10:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2FhRG4LIDOTvnnHRXP1otGcm6hbLJLndQ4Yo0nSAV1M=;
        b=dkYH6p1Ks8NOi8qn3RiK+g4RMhG9f3sr4e+N7U1nAJ/DROCs/u3zy83x5ml56dfu+Q
         a5yMwhJlHgB7AmqNkGCjH8oO/syZkOHkX8zoNM8rGHtnjtNAPn4JSaAb/mk4aeP0Fb3a
         qB1QeTuMe2XBprl9x3CT5AvCwA04Q13Q9nxGqf8rWglIM31d8m/eETQbCeRV3TQ12O70
         XjmgBV9dn6LUrSSGOn02RXPLSIycAb8vSxFNdQQxmCZyJhvihdXGVxo1nEHfjKlwbDNM
         8PIXM5e925+Bh6oNDFWVl1NQ6Zig30YD9fsvndaQOnwgq+rAGbOd6E5pnBAn/eg6fy1t
         7EhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2FhRG4LIDOTvnnHRXP1otGcm6hbLJLndQ4Yo0nSAV1M=;
        b=OzCv480ErNsxfpNhEB8AU7wFh0qqrnYdYmKILomaPrdRtaNCuWvJvGXrG5SHOc8yZ8
         imgC3S/UzBNKGrCWOD330YdSdFt7265DXCYiGGT6dipeTjey6t1Io5RZqsDKRgmBAOL5
         qEjWVt4RjLRpUf49fh2L5yUFajNfbue0AmfsFq+pm/CHYKR887pTIl2ZfGDGheQdpLoW
         pGR9o6SDmcD54BHwS7aipQ02znHJCOJA0BecPf/BJy9ejSViW9CqZjZ25HDK9DwvxbYK
         q/QyC3W3abnHlbWE9HocwKKh7tLI8fqakW9k4V0J9YrUBiNIq5jqmW+gxvirHOErP1t2
         CGbg==
X-Gm-Message-State: APjAAAWQ0CST0ZiZSmbjVTkbmfDd2oRrusZAdSjjrNtLHglPT0tKNYhB
        eRwPZ6q8HTo7XxvssJHuNtzh7r5R
X-Google-Smtp-Source: APXvYqxPI0nt4rqSHCu77e/dra5XYLlLjTqrWu3w7Gx1bEzp85TEuL8Uy1lD07hH9BbaaDtmK4rjbA==
X-Received: by 2002:a63:6946:: with SMTP id e67mr4378409pgc.181.1576693036854;
        Wed, 18 Dec 2019 10:17:16 -0800 (PST)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id e10sm4378030pfj.7.2019.12.18.10.17.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Dec 2019 10:17:15 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH] notes.h: fix typos in comment
Date:   Wed, 18 Dec 2019 10:17:43 -0800
Message-Id: <34bbdc1af3d76f556e26ac92fff35bf2ac853470.1576692900.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.703.g2f499f1283
In-Reply-To: <CAPig+cRVyfWceVZFgRuRyL-B3TMnX9fObC84t2LHsNoXm8TuqQ@mail.gmail.com>
References: <CAPig+cRVyfWceVZFgRuRyL-B3TMnX9fObC84t2LHsNoXm8TuqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 1d7297513d (notes: break set_display_notes() into smaller functions,
2019-12-11), we introduced a comment which had a couple of typos. In the
first typo, we referenced 'enable_default_display_notes' instead of
'enable_ref_display_notes'. In the second typo, we wrote "is a points to"
instead of "is a pointer to". Correct both of these typos.

Reported-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
This patch is based on top of 'dl/format-patch-notes-config-fixup'.
Thanks for catching the typo, Eric!

 notes.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/notes.h b/notes.h
index 3e78448181..bbab1961ca 100644
--- a/notes.h
+++ b/notes.h
@@ -268,11 +268,11 @@ void init_display_notes(struct display_notes_opt *opt);
 /*
  * This family of functions enables or disables the display of notes. In
  * particular, 'enable_default_display_notes' will display the default notes,
- * 'enable_default_display_notes' will display the notes ref 'ref' and
+ * 'enable_ref_display_notes' will display the notes ref 'ref' and
  * 'disable_display_notes' will disable notes, including those added by previous
  * invocations of the 'enable_*_display_notes' functions.
  *
- * 'show_notes' is a points to a boolean which will be set to 1 if notes are
+ * 'show_notes' is a pointer to a boolean which will be set to 1 if notes are
  * displayed, else 0. It must not be NULL.
  */
 void enable_default_display_notes(struct display_notes_opt *opt, int *show_notes);
-- 
2.24.1.703.g2f499f1283

