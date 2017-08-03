Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A5392047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbdHCJVL (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:21:11 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35651 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbdHCJU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:26 -0400
Received: by mail-wr0-f195.google.com with SMTP id c24so578647wra.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f5WfkmnDbJJ9CUJyy4j/CduvCHGtz69Wkws4uuDdWVw=;
        b=V0i+Or3zd7TPUIaahwH3K3eIh6e0aSa3PK7EbjBWOqb3O9uyR2AqmzJ4GkvwtD0iaQ
         SNc8y//CMj6F6yZ92K9Yw7ftD0IbbAg+Usr1vjCdSnkvyYvAnZhMgFLbHcvgQHX32M4d
         A2PjwdzwJlkd3WneupE/DCbpBu+4xEdvPvduf6Rtsbvy/oM3MMK/zoJzJ1T4S7A85ic6
         41Z8HjpUFxYTdBSwOqlvHGafxF0IuiHn4qtsQfrFxiO80cm6QmeeG11YqP3lxa+K9OOW
         E1GD8HxYUjr1B1LoKSurHY9EobrcCtR1mbWTgfGVnBSGIrxDdfJhXJID+VPoRw0GwmFK
         fvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f5WfkmnDbJJ9CUJyy4j/CduvCHGtz69Wkws4uuDdWVw=;
        b=D7ZtQcBPFDkIAhOwgq7UMlhL4TKRGE42AQ9NaMPaYZG/isCVmnxdQeoCiAYrHnWOOx
         P56ysQKt4ZPlK0tTQlPEORxccBpQPjurEyPZW53Cs95RU+vP9alJK/YTOTLFtAdGlJPd
         GrUa/XW9PUFZYu1lGH7vC0fVN0FOHKMapccXvIn+iJDRzrvvcPO2/elWibR9SKFLbLn1
         GlEfYmsh8bzgBZ8EmWQrvU29MEl2hYVxSvDtR2CcO1tqSSH+aBrJfiqqRtVu6Hdz0GHv
         CjrG4zDP0lQ1o9cLcrbJQcUnLFAyxLwFtzmSzc4+BPbAQLuRfO3EDfx6AkSNm+SNXz/a
         xqww==
X-Gm-Message-State: AIVw112FFXCPy+A5R9gsRkhMriK0no4tIecR4QMXN7ZjsvwZkBiJALG6
        diWZ8Jevac2KrCOk
X-Received: by 10.223.167.73 with SMTP id e9mr762394wrd.205.1501752025404;
        Thu, 03 Aug 2017 02:20:25 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:20:24 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 38/40] clone: disable external odb before initial clone
Date:   Thu,  3 Aug 2017 11:19:24 +0200
Message-Id: <20170803091926.1755-39-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make it possible to have the external odb mechanism only kick in
after the initial part of a clone, we should disable it during the
initial part of the clone.

Let's do that by saving and then restoring the value of the
'use_external_odb' global variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 76e561534d..dc57eabd40 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -934,6 +934,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	struct refspec *initial_refspecs;
 	int is_initial;
+	int saved_use_external_odb;
 
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
@@ -1079,6 +1080,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
+	/* Temporarily disable external ODB before initial clone */
+	saved_use_external_odb = use_external_odb;
+	use_external_odb = 0;
+
 	if (option_bare) {
 		if (option_mirror)
 			src_ref_prefix = "refs/";
@@ -1162,6 +1167,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		fetch_initial_refs(transport, refs, initial_refspecs,
 				   branch_top.buf, reflog_msg.buf, is_local);
 
+		use_external_odb = saved_use_external_odb;
+
 		mapped_refs = wanted_peer_refs(refs, refspec);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
@@ -1203,6 +1210,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					option_branch, option_origin);
 
 		warning(_("You appear to have cloned an empty repository."));
+
+		use_external_odb = saved_use_external_odb;
+
 		mapped_refs = NULL;
 		our_head_points_at = NULL;
 		remote_head_points_at = NULL;
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

