Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE061F404
	for <e@80x24.org>; Tue, 10 Apr 2018 00:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbeDJASk (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 20:18:40 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40754 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752163AbeDJASc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 20:18:32 -0400
Received: by mail-pf0-f194.google.com with SMTP id y66so6754413pfi.7
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 17:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=25Una9zbUNbSSlW/iwRRn9fkgk7Jh2cTe7hVEpittqk=;
        b=GBVpsFfWgWuLaSIpBVwK0Sk3VeYPAI1hMr5nV2PcQohLFPkAllqF6o6LUlcRlFcvaO
         L1l96tWBX6KUSHMemZa8MUIS6ssqv7MxU+nsEHLkrUI23vaEsZZ5ysflF5LKUG3rr/9u
         K8XNJaRmUHchUGzCUlwQ6kmzPeZEm62SYQ+dnc6crP5GB8J5nhokBgq5KhV1RnxhuWG1
         dNz9lfslYJb3lG1tBGKT03g/RofCflFjKPP56m2BbwvDFJxjzuQKeBya/rxCOes4Hrrw
         Jh3fflMqhH3IeCYfuIbl34cOnuwpZ2nB0buGwb6FBaOG0ZuG9/8pd4WoWxZ9EKS8z+5D
         hjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=25Una9zbUNbSSlW/iwRRn9fkgk7Jh2cTe7hVEpittqk=;
        b=BjNOH1KuSLarLEBESBRPNtOirXAu4q/7QcswqQrmQTxdjKZRidWzljLboQ6/X4SjOD
         H2lskPTaHJCueA/41qVcVfOm1xKxUZmf8wPhPGaTtVc2zjCKmb3xmxFc5JzxOCsY9omB
         EP+yLkfTDbNN+DXZnqBRrj0KDos+bkfVGRGYJtFwRTBspdpLv8ajdMhTpEbTXNrF/buL
         5NakB4Qt75X+S94HHmUoUBgPNrkWrOO94fd4Z0uWw7K4WQl3SjVpPJ5FTjDlUW1yKRr+
         YnQJqS//2+0hQ+IqNM2DMtPg3y/VVohn1KgNkiPRZ6PBRCLXI05Ka9S+HKihCpDnmjlG
         EmhA==
X-Gm-Message-State: ALQs6tBZp+UGGnVJq1RoVB+pHQtYD8Ihcw5n/H3oJnWFDMlWiKroeNwj
        K7HKpcdfCNu4IgULNsWtDjFNGrmQiCY=
X-Google-Smtp-Source: AIpwx4/u3YwCMz+HH5oGJq/TQR8OVtC8rB6RjiR3/Kc1XCHLnnOdZ9sOif5tZy2lGs728JG4aERqMw==
X-Received: by 10.99.116.76 with SMTP id e12mr17452344pgn.270.1523319511112;
        Mon, 09 Apr 2018 17:18:31 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:1d66:22f3:ac1d:6007])
        by smtp.gmail.com with ESMTPSA id c187sm2412528pfa.181.2018.04.09.17.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 17:18:30 -0700 (PDT)
Date:   Mon, 9 Apr 2018 17:18:28 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH v6 2/3] config.c: introduce 'git_config_color' to parse ANSI
 colors
Message-ID: <20180410001828.GC67209@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <cover.1523319159.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1523319159.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for adding `--type=color` to the `git-config(1)` builtin,
let's introduce a color parsing utility, `git_config_color` in a similar
fashion to `git_config_<type>`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 config.c | 10 ++++++++++
 config.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/config.c b/config.c
index b0c20e6cb8..33366b52c7 100644
--- a/config.c
+++ b/config.c
@@ -16,6 +16,7 @@
 #include "string-list.h"
 #include "utf8.h"
 #include "dir.h"
+#include "color.h"
 
 struct config_source {
 	struct config_source *prev;
@@ -1000,6 +1001,15 @@ int git_config_expiry_date(timestamp_t *timestamp, const char *var, const char *
 	return 0;
 }
 
+int git_config_color(char *dest, const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	if (color_parse(value, dest) < 0)
+		return -1;
+	return 0;
+}
+
 static int git_default_core_config(const char *var, const char *value)
 {
 	/* This needs a better name */
diff --git a/config.h b/config.h
index ef70a9cac1..0e060779d9 100644
--- a/config.h
+++ b/config.h
@@ -59,6 +59,7 @@ extern int git_config_bool(const char *, const char *);
 extern int git_config_string(const char **, const char *, const char *);
 extern int git_config_pathname(const char **, const char *, const char *);
 extern int git_config_expiry_date(timestamp_t *, const char *, const char *);
+extern int git_config_color(char *, const char *, const char *);
 extern int git_config_set_in_file_gently(const char *, const char *, const char *);
 extern void git_config_set_in_file(const char *, const char *, const char *);
 extern int git_config_set_gently(const char *, const char *);
-- 
2.17.0

