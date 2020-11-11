Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA81C388F9
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55004208B3
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 01:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6Pc7ClP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgKLBci (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgKKXbk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 18:31:40 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA7EC061A4C
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:56 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id w4so2897709qki.20
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 15:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to;
        bh=i+EAlozu6VIsnZugCRWqOwOMqEq9ylJlCNXpuvidHxE=;
        b=a6Pc7ClPvpjKan/IknDKt/TKhQuQ2v8kwPMn/cV0MeezbWa4noJGtWdL4U9FSWE6i6
         vyA74HabuhFi9FxxnRWWRkmAV3kWrqkkSOdUOMQTYXtooR6mbWCwKtUkm4uVfju5I6DK
         /KlW8ck0MvrhDXMi6gGi8lhhjHlcYfl34cNulcnPLtOAT09GcmyqhlnlLwWFqXGHM2ZS
         WHdRppvF3CQl4NrlhBok8rKwvwkTBCj2T2bsIpcVEhQKf9nBEpq59UrZBIQMPIi6BFy5
         yVUNOaBSxulp8roKLwFjhJFlt+/RLn1MsfCZBt4TiIWFjhz9w2OzT487mXcqXBYUp+IH
         PQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=i+EAlozu6VIsnZugCRWqOwOMqEq9ylJlCNXpuvidHxE=;
        b=FNKXuxjGJSvoX45w6JaKXT+SCiiXA/GaWV4hU89NvXELkgTYmTUaUJ4BU2rNlYJ6NJ
         u+BrWWkQdGq3LptkodtAQ909GajFTln1U26T5R6YItGNwmu8IQ+fGvWGmk32LiDsPBjS
         qcovWHwSg8Ii1ck04wY1KO9CrsFnC+0L07gL8hkvduXb5nN1SPTFU9oYeyvm5Sh9xcrb
         9AFO/jMXLEhvuf+V64EsMkXOtAvL2SIut2AXCKZ+trx48wPzsEoMiw5uMYxplrRwnVsR
         Y8paKSPSIQIts52VLATwihhzMF0xCgzwk9zn3dT+Gc47CS1jS1TxJdYSTaDMGT+5toSU
         C7vQ==
X-Gm-Message-State: AOAM530JtJM5SyZriQaCJJ7OUAV8IFiG67D5+LooQWGMa9me5MP3bWsJ
        sExRDtzSGEJXI29tQn6y4ULafd1qjKpti623lFJCL8SI3ZNpH/+CWpUBFANjOzQhLaIhS8JOql+
        83rGX6pG7aZWcJeRRnVk76y5f+mD/F7Aw2opoAqFZQJFn+gyiHx37v52QAgRlIt0=
X-Google-Smtp-Source: ABdhPJzS1HinnbpEYenKnEDXRsTJFP6qfxymZqiTu+4dK85kiEq2JNgSCMc+Me54xkxCPP8MgQLzfrWBHSCf4Q==
Sender: "steadmon via sendgmr" <steadmon@lunarfall.svl.corp.google.com>
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
 (user=steadmon job=sendgmr) by 2002:a0c:f951:: with SMTP id
 i17mr13130324qvo.22.1605137395431; Wed, 11 Nov 2020 15:29:55 -0800 (PST)
Date:   Wed, 11 Nov 2020 15:29:33 -0800
In-Reply-To: <cover.1605136908.git.steadmon@google.com>
Message-Id: <012949e7da24a9f9b8bb7ac7c098f04a1d35d6f7.1605136908.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1604006121.git.steadmon@google.com> <cover.1605136908.git.steadmon@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v3 10/11] send-pack: advertise session ID in capabilities
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the server sent a session-id capability and transfer.advertiseSID
is true, advertise send-pack's own session ID back to the server.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 send-pack.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/send-pack.c b/send-pack.c
index eb4a44270b..bda65c98f9 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -424,6 +424,7 @@ int send_pack(struct send_pack_args *args,
 	int use_sideband = 0;
 	int quiet_supported = 0;
 	int agent_supported = 0;
+	int advertise_sid = 0;
 	int use_atomic = 0;
 	int atomic_supported = 0;
 	int use_push_options = 0;
@@ -435,6 +436,8 @@ int send_pack(struct send_pack_args *args,
 	const char *push_cert_nonce = NULL;
 	struct packet_reader reader;
 
+	git_config_get_bool("transfer.advertisesid", &advertise_sid);
+
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status-v2"))
 		status_report = 2;
@@ -450,6 +453,8 @@ int send_pack(struct send_pack_args *args,
 		quiet_supported = 1;
 	if (server_supports("agent"))
 		agent_supported = 1;
+	if (!server_supports("session-id"))
+		advertise_sid = 0;
 	if (server_supports("no-thin"))
 		args->use_thin_pack = 0;
 	if (server_supports("atomic"))
@@ -506,6 +511,8 @@ int send_pack(struct send_pack_args *args,
 		strbuf_addf(&cap_buf, " object-format=%s", the_hash_algo->name);
 	if (agent_supported)
 		strbuf_addf(&cap_buf, " agent=%s", git_user_agent_sanitized());
+	if (advertise_sid)
+		strbuf_addf(&cap_buf, " session-id=%s", trace2_session_id());
 
 	/*
 	 * NEEDSWORK: why does delete-refs have to be so specific to
-- 
2.29.2.222.g5d2a92d10f8-goog

