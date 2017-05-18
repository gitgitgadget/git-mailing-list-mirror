Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC313201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932640AbdERXWl (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:41 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34292 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932638AbdERXW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:29 -0400
Received: by mail-pf0-f171.google.com with SMTP id 9so30792909pfj.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LxL4AVvM/G3XE1So8yabpBdBdPcXBNIbrnIyVTViOeE=;
        b=Za5P3dk8Y6JZtPP1CYn2HsL/EBuGjKe3z5dasZwSZGErWqUZAHpfyJDB0dfG3Gu+Gc
         ltDjxPrjZOggLMMszeD27Y2WJg8poZCTvMEZuyt5LfPcDj88mvaNklNuqxitLlDdXv0y
         rM8V/5rDSOqDSXfySmcciw8FA49Vf7fCQNm07McJUxDhf4I7VWDXEM7D9gEd4iCcYndn
         BfCs0OVvBOOdEUam+ADfnxzdQIBVEAf6lhGT5KIwru/B/UWMNpd1lyYBTMrDhCNqVo6i
         nLsEnXS+rAv6AmaoC50A6AaiXOl08kqKYDvMuerLCNjyTUi/Nf0KNHKvW3HJofHAoQsZ
         gPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LxL4AVvM/G3XE1So8yabpBdBdPcXBNIbrnIyVTViOeE=;
        b=Av7OVcnJz/s3XEQ/TXj9d6MZuz15cxuwecYQzex99t2hdwISiruiAdap7WSGeBjV2P
         M4JCciBdq6AI1BJ1m5C8hIh5D9QAXbUfwKjkuSVn+/IoAh9Ggl0Nwf//epS2MdqskAAf
         wlSUhEpWQLtl9HBxq+q0XCxYeXqUZqiFpSFmmAXrk0tdl0tlF8/jAmbCMNvpvJUIelOp
         P9DAsi5XbG18nDSX9rxjsVaH+wmub+bmkaNaIg3t63kxPB9H/68rDM9bUMlDS7wPOhCu
         MyTYClTGKE9czq8pUVyp76aZpvxLJ334Kbperwrh/up6pBkV37I+mEBwuAUH5eVoA7q+
         wevQ==
X-Gm-Message-State: AODbwcAdP5LySS/gaFTXq7tOYvYfXzVTRmPe0QhBVGwfm7ew8oUqo5ou
        kvu1OuseA37HNWgb
X-Received: by 10.99.98.66 with SMTP id w63mr6923837pgb.223.1495149738996;
        Thu, 18 May 2017 16:22:18 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:18 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 08/23] ls-files: convert write_eolinfo to take an index
Date:   Thu, 18 May 2017 16:21:19 -0700
Message-Id: <20170518232134.163059-9-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
In-Reply-To: <20170518232134.163059-1-bmwill@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7d306f418..9313452e3 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -53,17 +53,16 @@ static const char *tag_modified = "";
 static const char *tag_skip_worktree = "";
 static const char *tag_resolve_undo = "";
 
-static void write_eolinfo(const struct cache_entry *ce, const char *path)
+static void write_eolinfo(const struct index_state *istate,
+			  const struct cache_entry *ce, const char *path)
 {
-	if (!show_eol)
-		return;
-	else {
+	if (show_eol) {
 		struct stat st;
 		const char *i_txt = "";
 		const char *w_txt = "";
 		const char *a_txt = get_convert_attr_ascii(path);
 		if (ce && S_ISREG(ce->ce_mode))
-			i_txt = get_cached_convert_stats_ascii(&the_index,
+			i_txt = get_cached_convert_stats_ascii(istate,
 							       ce->name);
 		if (!lstat(path, &st) && S_ISREG(st.st_mode))
 			w_txt = get_wt_convert_stats_ascii(path);
@@ -105,7 +104,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 		return;
 
 	fputs(tag, stdout);
-	write_eolinfo(NULL, ent->name);
+	write_eolinfo(NULL, NULL, ent->name);
 	write_name(ent->name);
 }
 
@@ -275,7 +274,7 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 			       find_unique_abbrev(ce->oid.hash, abbrev),
 			       ce_stage(ce));
 		}
-		write_eolinfo(ce, ce->name);
+		write_eolinfo(&the_index, ce, ce->name);
 		write_name(ce->name);
 		if (debug_mode) {
 			const struct stat_data *sd = &ce->ce_stat_data;
-- 
2.13.0.303.g4ebf302169-goog

