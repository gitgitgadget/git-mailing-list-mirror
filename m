Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73FBB1F4BE
	for <e@80x24.org>; Mon,  8 Jul 2019 16:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfGHQh7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 12:37:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35921 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfGHQh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 12:37:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so17906237wrs.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 09:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O0O/eXuhEnD5jx/0ReEjojd9SJEmu2xsvsKP7ud/r9I=;
        b=oVEtB3VPjspaubwa4fG9YWmCAxUsdLXOWG9Mm3xZOlGLtemQudjOGXJowrmP+vL/3O
         699Tu+dN2eytj28Q/uxZbGb8XxnQinpPM4qWSUq0LQmaZCgS39rnSNSKXHousI54MHgj
         lBnAydvK0L1JSiv/3VnB32ylozl7p/YIgpp1hiFo0k8SKALpTwq05457K2hsIkfz1FeD
         C8Lel62D+d4PLFSnYVmB+tJMVzgZUt3lwUA+8ho+5HQBUzXLfOA/A6o6YUhtwG5KuFj1
         42WzXFWF7hr3S31hCu7tktZKypnhmadysSvJKz5GPOf9RxjRcWZ1jBO4DAetP4hCRazW
         E+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0O/eXuhEnD5jx/0ReEjojd9SJEmu2xsvsKP7ud/r9I=;
        b=LdwQZdmHnQGAY4+9+cqkkRtnRVQAeXVQ11CpSi72L6nEGWu038hFuZznPPfFwB91eE
         z8b2/94Lg9Ld0R/cgxrHRZPynUkdgymzBsKC98oGMpXSO2u8y1JnRPaef37117QEDo8W
         smNLn1S8hRYEgmyQzl7j2lWEQrKkZrb1R17/+lpyUwCSCF1NIZ1sBDgcXEVKAr7kafj6
         Zs7v9orn6BHvKqM0ik2VIEBDstzYCJqKMlTggWx9Xl1BPSgvjG0NoHwuiJy2QSwlH9gP
         T+eQsCjg3nSg/XTQ9b29ys4fBR0H+ynSo82Z+z/HVOspyb5PwioDcaww8D2LABRB6frd
         FK/Q==
X-Gm-Message-State: APjAAAUNTL1YD2yIBNP1kiKAx9eFN9tGGQbNIJ5oanO6PeXIrunMIzl1
        VZczfN/B82k16I7585w8HhPGkdR+
X-Google-Smtp-Source: APXvYqw8vTVvlj5P7J9hoWkJTVqhX41JNIPWAvPm+Fex7pCiXsmIXYDoWaSf7PtpdE9XlsC1XRq8vg==
X-Received: by 2002:a05:6000:11ca:: with SMTP id i10mr20922439wrx.56.1562603876708;
        Mon, 08 Jul 2019 09:37:56 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id x20sm129193wmc.1.2019.07.08.09.37.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:37:56 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 04/14] apply: only pass required data to check_header_line
Date:   Mon,  8 Jul 2019 17:33:05 +0100
Message-Id: <20190708163315.29912-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190708163315.29912-1-t.gummerer@gmail.com>
References: <20190705170630.27500-1-t.gummerer@gmail.com>
 <20190708163315.29912-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the 'check_header_line()' function takes 'struct
apply_state' as parameter, even though it only needs the linenr from
that struct.

This function is in the callchain of 'parse_git_header()', which we
want to make more generally useful in a subsequent commit.  To make
that happen we only want to pass in the required data to
'parse_git_header()', and not the whole 'struct apply_state', and thus
we want functions in the callchain of 'parse_git_header()' to only
take arguments they really need.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 apply.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/apply.c b/apply.c
index ac668e754d..1602fd5db0 100644
--- a/apply.c
+++ b/apply.c
@@ -1302,15 +1302,15 @@ static char *git_header_name(int p_value,
 	}
 }
 
-static int check_header_line(struct apply_state *state, struct patch *patch)
+static int check_header_line(int linenr, struct patch *patch)
 {
 	int extensions = (patch->is_delete == 1) + (patch->is_new == 1) +
 			 (patch->is_rename == 1) + (patch->is_copy == 1);
 	if (extensions > 1)
 		return error(_("inconsistent header lines %d and %d"),
-			     patch->extension_linenr, state->linenr);
+			     patch->extension_linenr, linenr);
 	if (extensions && !patch->extension_linenr)
-		patch->extension_linenr = state->linenr;
+		patch->extension_linenr = linenr;
 	return 0;
 }
 
@@ -1380,7 +1380,7 @@ static int parse_git_header(struct apply_state *state,
 			res = p->fn(state, line + oplen, patch);
 			if (res < 0)
 				return -1;
-			if (check_header_line(state, patch))
+			if (check_header_line(state->linenr, patch))
 				return -1;
 			if (res > 0)
 				return offset;
-- 
2.22.0.510.g264f2c817a

