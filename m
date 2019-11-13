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
	by dcvr.yhbt.net (Postfix) with ESMTP id 004C31F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 18:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfKMSzp (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 13:55:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37768 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfKMSzo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 13:55:44 -0500
Received: by mail-lj1-f195.google.com with SMTP id d5so3798326ljl.4
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 10:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d40Dds3jNN7XULFo+RkjUoC3XaUYu9dtW1GObHWalOY=;
        b=CwXWXpaXqPl4mUSMTrGDuGOcPMZOBi9+xa/+MprfAMJv6I6xJz2lNwb3tsFoY5TVYI
         G3AR8wkmzAtXP2RL9yd9WAo3vP2Q8uyKYnLOr8qdfqO5H7wkRqrKuuVJiC/CmTJ81pPQ
         i6oZkIdlkWbF7JRW9za8HCvdAslRDClD6yaywDtgD09yWyVXIYUKEPtPGUzBuxr1vbfP
         rhm0tsg/xsQ2E9tvnM+sfMac79bV9q6MCCU/6c0R5bKwp2jQUQ0Py1hqAhwmHO4DnJYS
         oBIcsb8khtdyi/yjBYPrj7iy8eDPNG5Ipig9AtDmlpizpNquTEJ+IzLX7owyPRwE/vPW
         oWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d40Dds3jNN7XULFo+RkjUoC3XaUYu9dtW1GObHWalOY=;
        b=pdRfQLkBUEFCoeTcY+KafQlhm3JXkXG+3j7A4weoysO5+1opFjmzisk27CZwbBfpPl
         XhvxDz57New63OKZ9qcI0s6e2wLWRCTThTxABVcvjpOS9Iebu9bc0V1kYVnqYlCbRY+4
         A3L6E6rWCLreBWjIMKho0BlfxEnDqF2Q6uiGdPKJyAUeYJnm3u5vJjhWcQ5jz4P6wWn1
         +iz7xjCE+GU95x6a+26tVMIV2pKS6N2q3rV0rsFlqTDy0I2XlqmWlUr8vK7Hh14yJ1Sv
         DkECl656BCqn+HMa40GkCU8NM6Fg59ghGIEFwruZ4grhLNDwG5jZerugTzvhjj5w2O92
         GYVw==
X-Gm-Message-State: APjAAAXq3MlkOjVtcts595OWNcHX0DAdzdWcezkn6WDQ1WrU4BysVdUG
        WOoAYetvr3PJU2z1kwmpqYtzGsIp
X-Google-Smtp-Source: APXvYqycnnNiflg+11XRyhw/342QQ2nmGarLMe9/uxT5XeDd/Ne23PiLVbZ66KhiJDgEx562mb+Naw==
X-Received: by 2002:a05:651c:111a:: with SMTP id d26mr3670592ljo.168.1573671342581;
        Wed, 13 Nov 2019 10:55:42 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id c24sm1422765lfm.20.2019.11.13.10.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:55:41 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/8] builtin/config: collect "value_regexp" data in a struct
Date:   Wed, 13 Nov 2019 19:55:03 +0100
Message-Id: <336eaa77e4974f84ea1eef473672e1d300f3a43d.1573670565.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1573670565.git.martin.agren@gmail.com>
References: <cover.1573670565.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git config` can take an optional "value_regexp". Collect the
`regex_t`-pointer and the `do_not_match` flag into a new `struct
cmd_line_value`.

Rather than signalling/judging presence of a regexp by the NULL-ness of
the pointer, introduce a `mode` enum. After this commit, we just have
two modes, "none" and "regexp", but we will gain another one in the next
commit.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin/config.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index e675ae0640..d812e73e2b 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -14,12 +14,15 @@ static const char *const builtin_config_usage[] = {
 
 static char *key;
 static regex_t *key_regexp;
-static regex_t *regexp;
+static struct {
+	enum { none, regexp } mode;
+	regex_t *regexp;
+	int do_not_match; /* used with `regexp` */
+} cmd_line_value;
 static int show_keys;
 static int omit_values;
 static int use_key_regexp;
 static int do_all;
-static int do_not_match;
 static char delim = '=';
 static char key_delim = ' ';
 static char term = '\n';
@@ -270,8 +273,10 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 		return 0;
 	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
 		return 0;
-	if (regexp != NULL &&
-	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)))
+	if (cmd_line_value.mode == regexp &&
+	    (cmd_line_value.do_not_match ^
+	     !!regexec(cmd_line_value.regexp, value_ ? value_ : "",
+		       0, NULL, 0)))
 		return 0;
 
 	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
@@ -283,19 +288,21 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 static int handle_value_regex(const char *regex_)
 {
 	if (!regex_) {
-		regexp = NULL;
+		cmd_line_value.mode = none;
 		return 0;
 	}
 
+	cmd_line_value.mode = regexp;
+
 	if (regex_[0] == '!') {
-		do_not_match = 1;
+		cmd_line_value.do_not_match = 1;
 		regex_++;
 	}
 
-	regexp = (regex_t*)xmalloc(sizeof(regex_t));
-	if (regcomp(regexp, regex_, REG_EXTENDED)) {
+	cmd_line_value.regexp = xmalloc(sizeof(*cmd_line_value.regexp));
+	if (regcomp(cmd_line_value.regexp, regex_, REG_EXTENDED)) {
 		error(_("invalid pattern: %s"), regex_);
-		FREE_AND_NULL(regexp);
+		FREE_AND_NULL(cmd_line_value.regexp);
 		return CONFIG_INVALID_PATTERN;
 	}
 
@@ -372,9 +379,9 @@ static int get_value(const char *key_, const char *regex_)
 		regfree(key_regexp);
 		free(key_regexp);
 	}
-	if (regexp) {
-		regfree(regexp);
-		free(regexp);
+	if (cmd_line_value.regexp) {
+		regfree(cmd_line_value.regexp);
+		free(cmd_line_value.regexp);
 	}
 
 	return ret;
-- 
2.24.0

