Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3748C433E6
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9084264E85
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 19:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbhBHTjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 14:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbhBHThc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 14:37:32 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A3DC061788
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 11:36:52 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id r77so15616173qka.12
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 11:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=We1z4WjsMfB7oLZVfSyIgnT1EkSjSETjb155mnSchIU=;
        b=g6j4xmkRLZmxOKHAexaZTabHNe44Hez5sns8F3mgxqawxJ9s0jIp/xsc+cf72eR0AP
         f5stUoY99o/a1/8k/jGApNoOHMSiszHYgWATuAM7+UxnudukHaeUcWGPlz1U8zCjo65a
         Fx2tNFf+3AjBp1TGSs0/9LGPRbeVqMlYNEuFsesDfYTxi/h1S7uPWtzuOAD9c6W4nSj8
         e/TdiHV3INs9SOLxgw+Fy7CTZuavV1X3QigyBoMqm1aiV2tKUAFW9xyvY95KGnjTQy+d
         j4ibaKIvgsHxPSKljsCIFzo71wE0MkGtUIzNoB9gzjtF0rgIFtoKtCAw5yv83/bE4iN4
         7pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=We1z4WjsMfB7oLZVfSyIgnT1EkSjSETjb155mnSchIU=;
        b=ExLO1apgbyerjIZ+p0iLrF+8NmdzVLG0N/3o3z+cHW49/5inxgklSXVFhwVoXTw7ZM
         9q+ws19G0DsRCcKCH7M3YWM78jul1KyZdiCbzHI2LAPD7W4a58PbRKVS1MMvgALraDuk
         4aw1WFNTWc9P0xerbSGVxFV6YI4UYHOr+Xn1v/28DcGnCMTCrQL5BAE08Ow7Z9hFuPpZ
         RScUm5GhSLrRXYzsEXib9wTa3J9lBnNKsG2oYoV7UE3nbv08mOuh8/RwzjzyPGjUMJ9V
         +LMj38kg+plzG7eYJaytRII/SPJyVpMrpQGgzwZZBtxhFMddJlUukrtjNafOegKxd89P
         Ks0Q==
X-Gm-Message-State: AOAM532W0i5mfc9fRL4uG9n87UTk8kvC6J6+xMHAVxac83jIvxkIsIDA
        WgHvoO1jbAhVjm9neVGLScg7kXKOWH2QaA==
X-Google-Smtp-Source: ABdhPJzbr059CqdmqffszgmVf6dzJDlqFhQz55AqOFQuN8bRWfiWN+4sMpZIQ+oKkzsN0RWQ6W68nA==
X-Received: by 2002:a05:620a:146a:: with SMTP id j10mr18149727qkl.166.1612813010881;
        Mon, 08 Feb 2021 11:36:50 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id h6sm15143808qtx.39.2021.02.08.11.36.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 11:36:50 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] checkout-index: omit entries with no tempname from --temp output
Date:   Mon,  8 Feb 2021 16:36:32 -0300
Message-Id: <1275701345b7e198ec83ad4fdcc2dda6d9775ef3.1612812581.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612812581.git.matheus.bernardino@usp.br>
References: <cover.1612812581.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With --temp (or --stage=all, which implies --temp), checkout-index
writes a list to stdout associating temporary file names to the entries'
names. But if it fails to write an entry, and the failure happens before
even assigning a temporary filename to that entry, we get an odd output
line. This can be seen when trying to check out a symlink whose blob is
missing:

$ missing_blob=$(git hash-object --stdin </dev/null)
$ git update-index --add --cacheinfo 120000,$missing_blob,foo
$ git checkout-index --temp foo
error: unable to read sha1 file of foo (e69de29bb2d1d6434b8b29ae775ad8c2e48c5391)
        foo

The 'TAB foo' line is not much useful and it might break scripts that
expect the 'tempname TAB foo' output. So let's omit such entries from
the stdout list (but leaving the error message on stderr).

We could also consider omitting _all_ failed entries from the output
list, but that's probably not a good idea as the associated tempfiles
may have been created even when checkout failed, so scripts may want to
use the output list for cleanup.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/checkout-index.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 4bbfc92dce..a9f0f0a225 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -23,25 +23,38 @@ static struct checkout state = CHECKOUT_INIT;
 static void write_tempfile_record(const char *name, const char *prefix)
 {
 	int i;
+	int have_tempname = 0;
 
 	if (CHECKOUT_ALL == checkout_stage) {
-		for (i = 1; i < 4; i++) {
-			if (i > 1)
-				putchar(' ');
-			if (topath[i][0])
-				fputs(topath[i], stdout);
-			else
-				putchar('.');
+		for (i = 1; i < 4; i++)
+			if (topath[i][0]) {
+				have_tempname = 1;
+				break;
+			}
+
+		if (have_tempname) {
+			for (i = 1; i < 4; i++) {
+				if (i > 1)
+					putchar(' ');
+				if (topath[i][0])
+					fputs(topath[i], stdout);
+				else
+					putchar('.');
+			}
 		}
-	} else
+	} else if (topath[checkout_stage][0]) {
+		have_tempname = 1;
 		fputs(topath[checkout_stage], stdout);
+	}
 
-	putchar('\t');
-	write_name_quoted_relative(name, prefix, stdout,
-				   nul_term_line ? '\0' : '\n');
+	if (have_tempname) {
+		putchar('\t');
+		write_name_quoted_relative(name, prefix, stdout,
+					   nul_term_line ? '\0' : '\n');
 
-	for (i = 0; i < 4; i++) {
-		topath[i][0] = 0;
+		for (i = 0; i < 4; i++) {
+			topath[i][0] = 0;
+		}
 	}
 }
 
-- 
2.29.2

