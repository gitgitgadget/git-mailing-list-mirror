Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257DBC00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 16:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbiGZQ1T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 12:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiGZQ1R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 12:27:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9B120F77
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 09:27:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id bu13-20020a056902090d00b00671743601f1so1593094ybb.0
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 09:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=m2wChQ0dDH7Ku0EAYnoZPzfTrPurklTeUHJ3FKP9F0U=;
        b=oDR1Esc4HL2xMR3UjC2qxXk03fdTNvn+XZzDRt1dgwUK8rYBdsgCpEJpl4wxVZwmuz
         v63YP6oArFgCaH3eSytn740LXJlqQxsuDo/BA5s91Twe4VqX/ghfCZu8nrWZfgiomHGH
         vgEeruzKmeQdtDTu5psqwSmLPlhyjawqKY9yxK+JXcawTNy1DxrqvsHz1VhvDPyzOVH3
         QbYGWdd5iMHo7HV2b05haoR2zXH1dUZuaqvPgoLNQy/YLw+F7hRIhd+QriD32ayH7RFw
         hdwiJzdKTWacxybKl2CEax+fUS8Ya0XRz/7fJGnxHY6XlNQHhRykHen4uvpWP0/qbgBc
         K1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=m2wChQ0dDH7Ku0EAYnoZPzfTrPurklTeUHJ3FKP9F0U=;
        b=hp08i7S80CFAxVEyyKxYW+bvxtDjSTNtk7pWdy5krcWkQQ1x4/gYOWAADd6YeJi3iY
         QZgRruO6wCiNQ6kUlW7yJmResNg546Yy1SaTrozZVrnOj4Xywzgn00fnbv0FJDO622l8
         YDzvQazxoSQyssmkapk8S7rupOYvZ4Q1xAqqus/qQaWo37AW7vX9N6FG1tcoO3Oa6ss8
         EneGTQ3yBuo92msO9/N3UuNsHNUt70NFGP5o4Fzm3PHFC9XDaZyth7AJzNehUtD58d9G
         dTo49y8H0+6iazrsTpuBldvviZj2V6o9w2Vrpq3YBpwdqJUmyCWMIO3uTGAcxpbPMKl7
         o9+g==
X-Gm-Message-State: AJIora9Mi2IDMc1A71LszMvL83Q4sC1SvdG6ZJ4FAV5nw/GIrOEpxmOG
        hnibFbLq8m6BBC42QcYJLLEPL6ZlFdMbFguu9XMRIgw1P+VxG9MgzzRiqy2TZ8jLtB8snQo1dtM
        mriHBqhFGxNZVgHeouPLfOPTxyUAxkambggoQPycMB+OrbhjWhNJ3FXIqrBolln/9VYbUuMJkiK
        9K
X-Google-Smtp-Source: AGRyM1vnRY4MTI+JCUmZ/8ol8wKp5zEfa0Fyps6t4CuC+sFqvusgk3hTlyGTTlVfftMZ2eeXBnBpALOtfKW2FSxZBcpN
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:154c:b0:66e:eb9c:ae60 with
 SMTP id r12-20020a056902154c00b0066eeb9cae60mr14533350ybu.200.1658852835722;
 Tue, 26 Jul 2022 09:27:15 -0700 (PDT)
Date:   Tue, 26 Jul 2022 09:27:11 -0700
In-Reply-To: <20220715172943.2681492-1-jonathantanmy@google.com>
Message-Id: <20220726162712.1774355-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20220715172943.2681492-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3] fetch-pack: write effective filter to trace2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Administrators of a managed Git environment (like the one at $DAYJOB)
might want to quantify the performance change of fetches with and
without filters from the client's point of view, and also detect if a
server does not support it. Therefore, log the filter information being
sent to the server whenever a fetch (or clone) occurs. Note that this is
not necessarily the same as what's specified on the CLI, because during
a fetch, the configured filter is used whenever a filter is not
specified on the CLI.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Here's v3, with an updated function name.
---
Range-diff against v2:
1:  d3ea7d3b95 ! 1:  17cef49fcc fetch-pack: write effective filter to trace2
    @@ Commit message
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
         ---
    -    Thanks everyone for your comments. I've renamed the keys and
    -    distinguished the case in which the server does not support filters
    -    following Jeff's suggestions.
    -
    -    A few small discussion points:
    -     - whether we need the print_verbose now that we have traces
    -     - should we log if no filter is specified
    -     - if yes, what key should it be logged under (I used "filter/none" for
    -       now)
    +    Here's v3, with an updated function name.
     
      ## fetch-pack.c ##
     @@ fetch-pack.c: static void mark_tips(struct fetch_negotiator *negotiator,
      	return;
      }
      
    -+static void write_and_trace_filter(struct fetch_pack_args *args,
    -+				   struct strbuf *req_buf,
    -+				   int server_supports_filter)
    ++static void send_filter(struct fetch_pack_args *args,
    ++			struct strbuf *req_buf,
    ++			int server_supports_filter)
     +{
     +	if (args->filter_options.choice) {
     +		const char *spec =
    @@ fetch-pack.c: static int find_common(struct fetch_negotiator *negotiator,
     -			expand_list_objects_filter_spec(&args->filter_options);
     -		packet_buf_write(&req_buf, "filter %s", spec);
     -	}
    -+	write_and_trace_filter(args, &req_buf, server_supports_filtering);
    ++	send_filter(args, &req_buf, server_supports_filtering);
      	packet_buf_flush(&req_buf);
      	state_len = req_buf.len;
      
    @@ fetch-pack.c: static int send_fetch_request(struct fetch_negotiator *negotiator,
     -	} else if (args->filter_options.choice) {
     -		warning("filtering not recognized by server, ignoring");
     -	}
    -+	write_and_trace_filter(args, &req_buf,
    -+			       server_supports_feature("fetch", "filter", 0));
    ++	send_filter(args, &req_buf,
    ++		    server_supports_feature("fetch", "filter", 0));
      
      	if (server_supports_feature("fetch", "packfile-uris", 0)) {
      		int i;

 fetch-pack.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index cb6647d657..a44eb32a71 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -292,6 +292,29 @@ static void mark_tips(struct fetch_negotiator *negotiator,
 	return;
 }
 
+static void send_filter(struct fetch_pack_args *args,
+			struct strbuf *req_buf,
+			int server_supports_filter)
+{
+	if (args->filter_options.choice) {
+		const char *spec =
+			expand_list_objects_filter_spec(&args->filter_options);
+		if (server_supports_filter) {
+			print_verbose(args, _("Server supports filter"));
+			packet_buf_write(req_buf, "filter %s", spec);
+			trace2_data_string("fetch", the_repository,
+					   "filter/effective", spec);
+		} else {
+			warning("filtering not recognized by server, ignoring");
+			trace2_data_string("fetch", the_repository,
+					   "filter/unsupported", spec);
+		}
+	} else {
+		trace2_data_string("fetch", the_repository,
+				   "filter/none", "");
+	}
+}
+
 static int find_common(struct fetch_negotiator *negotiator,
 		       struct fetch_pack_args *args,
 		       int fd[2], struct object_id *result_oid,
@@ -389,11 +412,7 @@ static int find_common(struct fetch_negotiator *negotiator,
 			packet_buf_write(&req_buf, "deepen-not %s", s->string);
 		}
 	}
-	if (server_supports_filtering && args->filter_options.choice) {
-		const char *spec =
-			expand_list_objects_filter_spec(&args->filter_options);
-		packet_buf_write(&req_buf, "filter %s", spec);
-	}
+	send_filter(args, &req_buf, server_supports_filtering);
 	packet_buf_flush(&req_buf);
 	state_len = req_buf.len;
 
@@ -1323,15 +1342,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		die(_("Server does not support shallow requests"));
 
 	/* Add filter */
-	if (server_supports_feature("fetch", "filter", 0) &&
-	    args->filter_options.choice) {
-		const char *spec =
-			expand_list_objects_filter_spec(&args->filter_options);
-		print_verbose(args, _("Server supports filter"));
-		packet_buf_write(&req_buf, "filter %s", spec);
-	} else if (args->filter_options.choice) {
-		warning("filtering not recognized by server, ignoring");
-	}
+	send_filter(args, &req_buf,
+		    server_supports_feature("fetch", "filter", 0));
 
 	if (server_supports_feature("fetch", "packfile-uris", 0)) {
 		int i;
-- 
2.37.1.359.gd136c6c3e2-goog

