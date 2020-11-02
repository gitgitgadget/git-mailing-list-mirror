Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70277C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D24722280
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 22:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JirHhxOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgKBWb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 17:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgKBWb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 17:31:28 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613F7C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 14:31:27 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id t195so22074pfc.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 14:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=9M8WtY0YgSD4L4mm5bxqFaLbq4HZfD92RxkJHLBNgDo=;
        b=JirHhxOsxkLct53r/cy6R8Bs+k0HhUa+4khA2grQVqoXHqEc6YCcmtayhwQ8Z0Rwo6
         mqlwOkARqyY0isUjLUpgYrdxiWElVTyF8NoWqgJw35DuByc39D6TbJdOYXQO/2a5GF9b
         93/ZOFczFUb722RfddNDI6dNn5CnozI6J5rqJZ16VTjUA8sAlcchdMmfbuwNjbrt8F9l
         RIjPJRbEI/tndDn+FYJjtQ44MwWU1dUFQOpCSisjtrJkXMqQb39Ewm+pO8VX2qth7H/R
         jHYymA2MkheIe4ItejVzGLDGRGs5Lq35TnNhcj+Mbdgmf3EhOKbd1g2D5itVsaN5ALBm
         6DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=9M8WtY0YgSD4L4mm5bxqFaLbq4HZfD92RxkJHLBNgDo=;
        b=X1nwok9phIgd1L3jIRNnS4fQBHOrnMgsafn1IvbXN/AF+VqGXSypHYfM8oHKUuOAEm
         z4wIWHcVNq5AtTRDVcO3/4iPmo6s1/+Icf+o9F8wUl+MPmmrKXt4tq3f9hhl/JlKHaKQ
         Rq4Pk015/aidOJoyP/7uZtnH0nLGKrEsaUvmhzev7vY5Z3miWgRWnzB90b6+e7XEiKVy
         9f+ED7OhvW6x1Kfxcv/W/DxcLBPj+uXo5R/fev53ow8xThN6FWWqqE4XcEPUI3TR0/T4
         sV8KXj8+S+Zo2GYENAANkO/Zm3jxGanW/cuoKujFxpvHEVtZirZS0UUPtCilwfd6Ibc4
         6WPw==
X-Gm-Message-State: AOAM532F6W6gyGgWe9C9K0Dj4RQvB6kivRepmZ+B2Tm7LKu6oH4Ga31y
        193F2g1Xi7HlOLW9tkJhc2w11ROFgNndFcMOLk5qpHOLU9PUFkBL8nX/mmZcYWEYAGIjGnp17UH
        HLDhZwW+Z+Zh/J4MWgEWHJY8svS5M+2/YkKE9uzX2C5+rzLvniK5ErRTJaCO+FJo=
X-Google-Smtp-Source: ABdhPJwtGcGm8xbuCDtqkSNr66fM3m4Ipd8RAPKhVcR/DnpNojKo1WjZUe+LcN8GzuMtfv6XnJEFPWPPq4CLkw==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a05:6a00:856:b029:18a:b222:403b with SMTP
 id q22-20020a056a000856b029018ab222403bmr12178268pfk.46.1604356286776; Mon,
 02 Nov 2020 14:31:26 -0800 (PST)
Date:   Mon,  2 Nov 2020 14:31:06 -0800
In-Reply-To: <cover.1604355792.git.steadmon@google.com>
Message-Id: <11b5b1b54f14354f08c9eb230d5b4e6a3de1996b.1604355792.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1604355792.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 08/11] fetch-pack: advertise trace2 SID in capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When trace2 is enabled, the server sent a trace2-sid capability, and
trace2.advertiseSID is true, advertise fetch-pack's own session ID back
to the server.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 fetch-pack.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index b10c432315..7fbefa7b8e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -35,6 +35,8 @@ static int fetch_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
 static int agent_supported;
 static int server_supports_filtering;
+static int server_sent_trace2_sid;
+static int advertise_trace2_sid;
 static struct shallow_lock shallow_lock;
 static const char *alternate_shallow_file;
 static struct strbuf fsck_msg_types = STRBUF_INIT;
@@ -326,6 +328,8 @@ static int find_common(struct fetch_negotiator *negotiator,
 			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
 			if (agent_supported)    strbuf_addf(&c, " agent=%s",
 							    git_user_agent_sanitized());
+			if (advertise_trace2_sid && server_sent_trace2_sid && trace2_is_enabled())
+				strbuf_addf(&c, " trace2-sid=%s", trace2_session_id());
 			if (args->filter_options.choice)
 				strbuf_addstr(&c, " filter");
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
@@ -979,6 +983,9 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				      agent_len, agent_feature);
 	}
 
+	if (server_supports("trace2-sid"))
+		server_sent_trace2_sid = 1;
+
 	if (server_supports("shallow"))
 		print_verbose(args, _("Server supports %s"), "shallow");
 	else if (args->depth > 0 || is_repository_shallow(r))
@@ -1191,6 +1198,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 		packet_buf_write(&req_buf, "command=fetch");
 	if (server_supports_v2("agent", 0))
 		packet_buf_write(&req_buf, "agent=%s", git_user_agent_sanitized());
+	if (advertise_trace2_sid && server_supports_v2("trace2-sid", 0) && trace2_is_enabled())
+		packet_buf_write(&req_buf, "trace2-sid=%s", trace2_session_id());
 	if (args->server_options && args->server_options->nr &&
 	    server_supports_v2("server-option", 1)) {
 		int i;
@@ -1711,6 +1720,7 @@ static void fetch_pack_config(void)
 	git_config_get_bool("repack.usedeltabaseoffset", &prefer_ofs_delta);
 	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
 	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
+	git_config_get_bool("trace2.advertisesid", &advertise_trace2_sid);
 	if (!uri_protocols.nr) {
 		char *str;
 
-- 
2.29.1.341.ge80a0c044ae-goog

