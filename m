Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A98A21F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 21:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbfJDV7I (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 17:59:08 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40703 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730969AbfJDV7I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 17:59:08 -0400
Received: by mail-pl1-f196.google.com with SMTP id d22so3740656pll.7
        for <git@vger.kernel.org>; Fri, 04 Oct 2019 14:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uGRQdo72ga1rH+Lx43aTF/JRx+An1EYlCRTNpV3dyVQ=;
        b=s5SQBd1Rzu4vn++GZyTfUh33GfPeaENeNBBdDTpHiamc/GKO5bHoJ7DU+2KgwV9LC4
         KrxmyWrESE/Xc8venS1LWBmiQTUwZPkXDDenBmn3QGHzhm1XiXQf9TBIpUVA1OnPwbgL
         s+dBjkoxjiqM1LCEJYOk9KL31ttF2t99N6LztsyvbIDQ9Fr3bbha/mIwYgHoLV/4pxkD
         idHuH2ze0UeMx9skPn8qykyAw+cYQTNtgdcabZQAAwPZ9UGqtVzuNazl3dbDpNkAyEpo
         8d2oYsbiKNSw6IFobh3tgtLLIiVYRngwk1tUpiM39uiL/DBWGK8f4X8Wg9eGjCmZ/ccZ
         p2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uGRQdo72ga1rH+Lx43aTF/JRx+An1EYlCRTNpV3dyVQ=;
        b=fG1cAi0SzZPp8+YRUagtdvpxedCSb8eXE9BoMwCnnwb1njba6f8c0FLGiMTjGZbPR1
         uFl2JmMMRNMQL1ZF5vmtK3IroRW4DSnnXYFlFagMzViinHW13TbAUCM4a+/QzD/IbGRn
         DPKQ8oYBJSIkknZVKecTVZbpx1OKcmFaTGKTXCuThWwb/++CRvfsmnYFV1t6PShwyc2z
         5yPFi2V/y5Onz0rYQ/3zMPDiRM4APoQTWI3v64Q5ITto6Ckk0UdQ7nEHqbtS9Iun3zuK
         lBQ62Te0bYSdoMlTjumxlY9I3DC7PJScU4XFRAPb3ymzRDBBXvKZBAwQ+ByR3AQT9CyX
         EHSw==
X-Gm-Message-State: APjAAAWIO2pRaz47IMgfLkBblsV4lUALDLH3Koyawsi1qoqqDladXv4X
        Lf0SujeG+Jw8e3c/tyMa5nUxo6yT
X-Google-Smtp-Source: APXvYqx0xZHmp7RFowQM0360TtCdQAPzPIB7gFt87J/23hsm8CBRuqvckiaIaUOE87VvS5WpU8+u4w==
X-Received: by 2002:a17:902:7610:: with SMTP id k16mr17468510pll.260.1570226346674;
        Fri, 04 Oct 2019 14:59:06 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id k5sm6024115pgb.11.2019.10.04.14.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 14:59:05 -0700 (PDT)
Date:   Fri, 4 Oct 2019 14:59:03 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Paul Tan <pyokagan@gmail.com>
Subject: [PATCH] apply: tell user location of corrupted patch file
Message-ID: <ec38908d05f0d40190173158ef3f0753fa9f1184.1570226253.git.liu.denton@gmail.com>
References: <20191002184546.GA22174@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002184546.GA22174@generichostname>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `git am` runs into a corrupt patch, it'll error out and give a
message such as,

	error: corrupt patch at line 87

Casual users of am may assume that this line number refers to the <mbox>
file that they provided on the command-line. This assumption, however,
is incorrect. The line count really refers to the
.git/rebase-apply/patch file genrated by am.

Teach am to print the location of corrupted patch files so that users of
the tool will know where to look when fixing their corrupted patch. Thus
the error message will look like this:

	error: corrupt patch at .git/rebase-apply/patch:87

An alternate design was considered which involved printing the line
numbers relative to the output of `git am --show-current-patch` (in
other words, the actual mail file that's provided to am). This design
was not chosen because am does not store the whole mail and instead,
splits the mail into several files. As a result of this, this would
break existing users' workflow if they piped their mail directly to am
from their mail client, the whole mail would not exist in any file and
they would have to manually recreate the mail to see the line number.

Let's avoid breaking Junio's workflow since he's probably one of the
most frequent user of `git am` in the world. ;)

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 apply.c                | 2 +-
 t/t4012-diff-binary.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index 57a61f2881..b0ba2e7b1a 100644
--- a/apply.c
+++ b/apply.c
@@ -1785,7 +1785,7 @@ static int parse_single_patch(struct apply_state *state,
 		len = parse_fragment(state, line, size, patch, fragment);
 		if (len <= 0) {
 			free(fragment);
-			return error(_("corrupt patch at line %d"), state->linenr);
+			return error(_("corrupt patch at %s:%d"), state->patch_input_file, state->linenr);
 		}
 		fragment->patch = line;
 		fragment->size = len;
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 6579c81216..42cb2dd404 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -68,7 +68,7 @@ test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch correctly' '
 	sed -e "s/-CIT/xCIT/" <output >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=$(cat detected) &&
-	detected=$(expr "$detected" : "error.*at line \\([0-9]*\\)\$") &&
+	detected=$(expr "$detected" : "error.*at broken:\\([0-9]*\\)\$") &&
 	detected=$(sed -ne "${detected}p" broken) &&
 	test "$detected" = xCIT
 '
@@ -77,7 +77,7 @@ test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch correctly' '
 	git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=$(cat detected) &&
-	detected=$(expr "$detected" : "error.*at line \\([0-9]*\\)\$") &&
+	detected=$(expr "$detected" : "error.*at broken:\\([0-9]*\\)\$") &&
 	detected=$(sed -ne "${detected}p" broken) &&
 	test "$detected" = xCIT
 '
-- 
2.23.0.687.g391267506c

