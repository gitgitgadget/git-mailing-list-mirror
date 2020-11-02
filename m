Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FEBC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC2BD22275
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+/ysCqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgKBWbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgKBWbM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:31:12 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306DCC0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 14:31:12 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id 97so9417902plb.4
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 14:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=sf/Y7R8dkE3JSqMQgNVPioYSuKeIY+yvpbD+AsmXoyQ=;
        b=L+/ysCqTYU2VfEzgZkESRjfz3aP7+hTkslJKJ7uThad8/nh64E69kSZteS0hf0ErvV
         h/QPqTMBLSDVrPN1lsfBVKp4B3AEAjM2quAYKJRF56PGv2oG3zbFrORhqLOUkAM9Zr1R
         zT3IA3pxQAQlXlBXZEu9+Q5z27f9sBHszMYvS7bl8uv2cWvSqA8c0VRqu5ffDzcxlRq/
         6IOuvViegQIvcrm0H+x2fuEEhw+DFMJNGKmBprOeUK2cPeuiWZksra8ZJvZ4hIGXPAnQ
         TJXNAYoeh/k3YaqdjS0dckBEJUl/9UI92GvobaN1POBhYcFj6Msgpb19dvrenIBbBba3
         QpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=sf/Y7R8dkE3JSqMQgNVPioYSuKeIY+yvpbD+AsmXoyQ=;
        b=g+vBgG7s6xS6VGdrVnGfti+7ere5178FYIni5swq9xdN94LNZ7ZnA+PXPpcUW3rLzq
         bXb8Zj9W0ViaaPS4s+sbKkP6WO60l0cnM9BmjiA93Rvy3xYl1cMQiuRXYAJcTrOg4Bg6
         zgiFrN8w22mTfmIdyOa4yxtjb2rdadENpL9Pa7HSeIjGV1Sq4m5I3tNuKmld4IpOlp05
         PumD0+eW2o+zD7XEPuxXt/2V4KZP04pEBCQHUIHFSO32GOzZxslJV8FG4HzQYijY1iki
         W6lrFDHMji3Bp0sVj5bpSxRzan8v3CQnDyK7T9rXPIO9DhcxhxNHKOd3iIIZh9g31LOk
         IwRA==
X-Gm-Message-State: AOAM532KKDUym9LVroQMUZiQSwV34LV/3+45RArwk4hA7HaobpN7dmci
        JAnaJlaMGOEJRPBOYkLHbgz4amhtdmXvB3zoWJzweagKPYBynR/fItsjFST2hUTJDLrJEmKDAFf
        OyevMQdA3/cVpYHP8ei1EkrHYVtMZzQtAJw2m2AgZCUvrikfYjx6rKggs/ZrxI7A=
X-Google-Smtp-Source: ABdhPJwkiwwe7yNVi14vQLHrng+qi/uS4dd3FqaEEfdqbz9sMD3lMA2mlzE/Rc1lithzgqyhrlyvZzvP4uy8Cw==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a17:90b:1011:: with SMTP id
 gm17mr355314pjb.73.1604356271589; Mon, 02 Nov 2020 14:31:11 -0800 (PST)
Date:   Mon,  2 Nov 2020 14:30:58 -0800
In-Reply-To: <cover.1604006121.git.steadmon@google.com>
Message-Id: <cover.1604355792.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 00/11] Advertise trace2 SID in protocol capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to more easily debug remote operations, it is useful to be able
to inspect both client-side and server-side traces. This series allows
clients to record the server's trace2 session ID, and vice versa, by
advertising the SID in a new "trace2-sid" protocol capability.

Changes since V1:
* Added a public trace2_session_id() function to trace2.{h,c}. Used this
  in place of tr2_sid_get().
* Fixed a style issue regarding using NULL rather than 0.

Josh Steadmon (11):
  docs: new capability to advertise trace2 SIDs
  docs: new trace2.advertiseSID option
  trace2: add a public function for getting the SID
  upload-pack: advertise trace2 SID in v0 capabilities
  receive-pack: advertise trace2 SID in v0 capabilities
  serve: advertise trace2 SID in v2 capabilities
  transport: log received server trace2 SID
  fetch-pack: advertise trace2 SID in capabilities
  upload-pack, serve: log received client trace2 SID
  send-pack: advertise trace2 SID in capabilities
  receive-pack: log received client trace2 SID

 Documentation/config/trace2.txt               |  4 +
 .../technical/protocol-capabilities.txt       | 13 ++-
 Documentation/technical/protocol-v2.txt       |  9 +++
 builtin/receive-pack.c                        | 15 ++++
 fetch-pack.c                                  | 10 +++
 send-pack.c                                   |  8 ++
 serve.c                                       | 18 +++++
 t/t5705-trace2-sid-in-capabilities.sh         | 79 +++++++++++++++++++
 trace2.c                                      |  5 ++
 trace2.h                                      |  2 +
 transport.c                                   | 10 +++
 upload-pack.c                                 | 22 +++++-
 12 files changed, 192 insertions(+), 3 deletions(-)
 create mode 100755 t/t5705-trace2-sid-in-capabilities.sh

Range-diff against v1:
 -:  ---------- >  1:  d04028c3c7 docs: new capability to advertise trace2 SIDs
 -:  ---------- >  2:  5d5097b671 docs: new trace2.advertiseSID option
 -:  ---------- >  3:  7f42aacd2b trace2: add a public function for getting the SID
 1:  c07bf8aede !  4:  4912af5f2b upload-pack: advertise trace2 SID in v0 capabilities
    @@ Commit message
     
      ## upload-pack.c ##
    -@@
    - #include "commit-graph.h"
    - #include "commit-reach.h"
    - #include "shallow.h"
    -+#include "trace2/tr2_sid.h"
    - 
    - /* Remember to update object flag allocation in object.h */
    - #define THEY_HAVE	(1u << 11)
     @@ upload-pack.c: struct upload_pack_data {
      	unsigned done : 1;					/* v2 only */
      	unsigned allow_ref_in_want : 1;				/* v2 only */
    @@ upload-pack.c: static void format_symref_info(struct strbuf *buf, struct string_
      
     +static void format_trace2_info(struct strbuf *buf, struct upload_pack_data *d) {
     +	if (d->advertise_trace2_sid && trace2_is_enabled())
    -+		strbuf_addf(buf, " trace2-sid=%s", tr2_sid_get());
    ++		strbuf_addf(buf, " trace2-sid=%s", trace2_session_id());
     +}
     +
      static int send_ref(const char *refname, const struct object_id *oid,
 2:  d42118ac41 !  5:  7003189c81 receive-pack: advertise trace2 SID in v0 capabilities
    @@ Commit message
     
      ## builtin/receive-pack.c ##
    -@@
    - #include "commit-reach.h"
    - #include "worktree.h"
    - #include "shallow.h"
    -+#include "trace2/tr2_sid.h"
    - 
    - static const char * const receive_pack_usage[] = {
    - 	N_("git receive-pack <git-dir>"),
     @@ builtin/receive-pack.c: static int receive_unpack_limit = -1;
      static int transfer_unpack_limit = -1;
      static int advertise_atomic_push = 1;
    @@ builtin/receive-pack.c: static void show_ref(const char *path, const struct obje
      		if (advertise_push_options)
      			strbuf_addstr(&cap, " push-options");
     +		if (advertise_trace2_sid && trace2_is_enabled())
    -+			strbuf_addf(&cap, " trace2-sid=%s", tr2_sid_get());
    ++			strbuf_addf(&cap, " trace2-sid=%s", trace2_session_id());
      		strbuf_addf(&cap, " object-format=%s", the_hash_algo->name);
      		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
      		packet_write_fmt(1, "%s %s%c%s\n",
 3:  ff80f70d33 !  6:  9573428cc0 serve: advertise trace2 SID in v2 capabilities
    @@ Commit message
     
      ## serve.c ##
     @@
    - #include "ls-refs.h"
      #include "serve.h"
      #include "upload-pack.h"
    -+#include "trace2/tr2_sid.h"
    -+
    -+static int advertise_trace2_sid;
      
    ++static int advertise_trace2_sid;
    ++
      static int always_advertise(struct repository *r,
      			    struct strbuf *value)
    + {
     @@ serve.c: static int object_format_advertise(struct repository *r,
      	return 1;
      }
    @@ serve.c: static int object_format_advertise(struct repository *r,
     +	if (!advertise_trace2_sid || !trace2_is_enabled())
     +		return 0;
     +	if (value)
    -+		strbuf_addstr(value, tr2_sid_get());
    ++		strbuf_addstr(value, trace2_session_id());
     +	return 1;
     +}
     +
 4:  1519767ead =  7:  21bdbf23f3 transport: log received server trace2 SID
 5:  ee4b3a7a55 !  8:  11b5b1b54f fetch-pack: advertise trace2 SID in capabilities
    @@ Commit message
     
      ## fetch-pack.c ##
    -@@
    - #include "fetch-negotiator.h"
    - #include "fsck.h"
    - #include "shallow.h"
    -+#include "trace2/tr2_sid.h"
    - 
    - static int transfer_unpack_limit = -1;
    - static int fetch_unpack_limit = -1;
     @@ fetch-pack.c: static int fetch_fsck_objects = -1;
      static int transfer_fsck_objects = -1;
      static int agent_supported;
    @@ fetch-pack.c: static int find_common(struct fetch_negotiator *negotiator,
      			if (agent_supported)    strbuf_addf(&c, " agent=%s",
      							    git_user_agent_sanitized());
     +			if (advertise_trace2_sid && server_sent_trace2_sid && trace2_is_enabled())
    -+				strbuf_addf(&c, " trace2-sid=%s", tr2_sid_get());
    ++				strbuf_addf(&c, " trace2-sid=%s", trace2_session_id());
      			if (args->filter_options.choice)
      				strbuf_addstr(&c, " filter");
      			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
    @@ fetch-pack.c: static int send_fetch_request(struct fetch_negotiator *negotiator,
      	if (server_supports_v2("agent", 0))
      		packet_buf_write(&req_buf, "agent=%s", git_user_agent_sanitized());
     +	if (advertise_trace2_sid && server_supports_v2("trace2-sid", 0) && trace2_is_enabled())
    -+		packet_buf_write(&req_buf, "trace2-sid=%s", tr2_sid_get());
    ++		packet_buf_write(&req_buf, "trace2-sid=%s", trace2_session_id());
      	if (args->server_options && args->server_options->nr &&
      	    server_supports_v2("server-option", 1)) {
      		int i;
 6:  b160941c65 !  9:  23f44bc904 upload-pack, serve: log received client trace2 SID
    @@ upload-pack.c: static void receive_needs(struct upload_pack_data *data,
      		if (data->allow_filter &&
      		    parse_feature_request(features, "filter"))
      			data->filter_capability_requested = 1;
    -+		if ((arg = parse_feature_value(features, "trace2-sid", &feature_len, 0)))
    ++		if ((arg = parse_feature_value(features, "trace2-sid", &feature_len, NULL)))
     +		{
     +			char *client_sid = xstrndup(arg, feature_len);
     +			trace2_data_string("trace2", NULL, "client-sid", client_sid);
 7:  609958bd1a ! 10:  c0b1ffc6d8 send-pack: advertise trace2 SID in capabilities
    @@ Commit message
     
      ## send-pack.c ##
    -@@
    - #include "gpg-interface.h"
    - #include "cache.h"
    - #include "shallow.h"
    -+#include "trace2/tr2_sid.h"
    - 
    - int option_parse_push_signed(const struct option *opt,
    - 			     const char *arg, int unset)
     @@ send-pack.c: int send_pack(struct send_pack_args *args,
      	int use_sideband = 0;
      	int quiet_supported = 0;
    @@ send-pack.c: int send_pack(struct send_pack_args *args,
      	if (agent_supported)
      		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
     +	if (advertise_trace2_sid && server_sent_trace2_sid && trace2_is_enabled())
    -+		strbuf_addf(&cap_buf, " trace2-sid=%s", tr2_sid_get());
    ++		strbuf_addf(&cap_buf, " trace2-sid=%s", trace2_session_id());
      
      	/*
      	 * NEEDSWORK: why does delete-refs have to be so specific to
 8:  3bc412fc39 = 11:  c47eddd9df receive-pack: log received client trace2 SID
-- 
2.29.1.341.ge80a0c044ae-goog

