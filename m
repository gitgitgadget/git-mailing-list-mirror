Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02BC1F406
	for <e@80x24.org>; Mon, 14 May 2018 21:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbeENV64 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:58:56 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:36617 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbeENV5u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:50 -0400
Received: by mail-yw0-f201.google.com with SMTP id l36-v6so3916678ywa.3
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=oBvI7lBt/6A7GHGTnoV6oBVH8aJzea19xSVVlD1fa7Q=;
        b=v/0ENELk+wO1vGL46JyZwZdc1w8sW64fWF8SD2hEQRrw6EbqCsAoKNuEr5cirVYgIK
         m3G76cUb32KcmpEcKPB1lzrtZn1q6esKafA6rbE89L+DsTDJVNhZN22ye3QZVglqVIYc
         gac+C55oPNnYHsjnG1HgoIAcLjufj5hmuC1xV8brazRWtaI9DpyugDp/auvIpyqJ+hfb
         FcUFELNG6U1Wq6iivGRaOi6E27Dn0SeYNlc0J9SN/sSv8ASMchy3POvKmfcVe6OmXFTI
         njCR1ojxOetOJ1tbvyjNPKC3ame5bDvbhbeeabjKkT9p3nZcGM+yQ1YdorwmqKlyi38g
         gR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=oBvI7lBt/6A7GHGTnoV6oBVH8aJzea19xSVVlD1fa7Q=;
        b=CKav8XBrvumfnPCSO0GB4LOVyCgQdqDGc6dW6V8p9ixTaq4rWcLtyO2rszModEwMqI
         5Jx8R0GCapgK/395s0IpQnru8DhWHBH3fiImPlOgnGOK+oZznPwTW+RGTlOoxzJ8zxCK
         dChgEY3ajrQMkW94+YUdC65KtBJrtHqB/gb2387UrMJbgOo3gN77wuYkpf5P0frMaGYG
         r73och5atjHfSyp6PH+xhti4Wo4j1RYEwWSyUhKW8ZTqpEbCLjbUkvtZ9bDX9NE+fDzV
         4TWHJURj5+ZKkBKHPVPYQ3ie5A3ph3VPD4kjoRnvgfCfiEP6w9iSjxmzA8abQpnWJzQ0
         hTDg==
X-Gm-Message-State: ALKqPwcxpLvZUJ5r+oQHLsAn1FpE3u+czjF90g9chHXQdonn4gHNy5wu
        NHK/NTBlAjMZ8aDUavin2v+8fn/igHvgcrJn//pzBXlwkpD3OBsv12NP8jfJ9nkFopSXQuiyTN1
        jgKPaYi06ENP4fyPfx0aN4hFFBY3DD4IE7FtdD+BXf4Cm06A+LMOvWQ774Q==
X-Google-Smtp-Source: AB8JxZoyZc5q13fd16LIMdkxbQUebqrxO+Bq7O5kJ4H9MTHfnpT/us1Al6mVpngg1Z+W4Pjbn7pk9CVCgok=
MIME-Version: 1.0
X-Received: by 2002:a25:9907:: with SMTP id z7-v6mr5053174ybn.4.1526335069839;
 Mon, 14 May 2018 14:57:49 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:20 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-30-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 29/35] transport: convert transport_push to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'transport_push()' to take a 'struct refspec' as a
parameter instead of an array of strings which represent
refspecs.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/push.c |  3 +--
 transport.c    | 17 +++++++----------
 transport.h    |  2 +-
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index ef42979d1..9cd8e8cd5 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -355,8 +355,7 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 
 	if (verbosity > 0)
 		fprintf(stderr, _("Pushing to %s\n"), transport->url);
-	err = transport_push(transport, rs->raw_nr, rs->raw, flags,
-			     &reject_reasons);
+	err = transport_push(transport, rs, flags, &reject_reasons);
 	if (err != 0) {
 		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_ERROR));
 		error(_("failed to push some refs to '%s'"), transport->url);
diff --git a/transport.c b/transport.c
index 181db4d4d..a89f17744 100644
--- a/transport.c
+++ b/transport.c
@@ -1093,11 +1093,11 @@ static int run_pre_push_hook(struct transport *transport,
 }
 
 int transport_push(struct transport *transport,
-		   int refspec_nr, const char **refspec, int flags,
+		   struct refspec *rs, int flags,
 		   unsigned int *reject_reasons)
 {
 	*reject_reasons = 0;
-	transport_verify_remote_names(refspec_nr, refspec);
+	transport_verify_remote_names(rs->raw_nr, rs->raw);
 
 	if (transport_color_config() < 0)
 		return -1;
@@ -1111,16 +1111,14 @@ int transport_push(struct transport *transport,
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int push_ret, ret, err;
-		struct refspec tmp_rs = REFSPEC_INIT_PUSH;
 		struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 		int i;
 
-		if (check_push_refs(local_refs, refspec_nr, refspec) < 0)
+		if (check_push_refs(local_refs, rs->raw_nr, rs->raw) < 0)
 			return -1;
 
-		refspec_appendn(&tmp_rs, refspec, refspec_nr);
-		for (i = 0; i < tmp_rs.nr; i++) {
-			const struct refspec_item *item = &tmp_rs.items[i];
+		for (i = 0; i < rs->nr; i++) {
+			const struct refspec_item *item = &rs->items[i];
 			const char *prefix = NULL;
 
 			if (item->dst)
@@ -1143,7 +1141,6 @@ int transport_push(struct transport *transport,
 							       &ref_prefixes);
 
 		argv_array_clear(&ref_prefixes);
-		refspec_clear(&tmp_rs);
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
@@ -1155,7 +1152,7 @@ int transport_push(struct transport *transport,
 			match_flags |= MATCH_REFS_FOLLOW_TAGS;
 
 		if (match_push_refs(local_refs, &remote_refs,
-				    refspec_nr, refspec, match_flags)) {
+				    rs->raw_nr, rs->raw, match_flags)) {
 			return -1;
 		}
 
@@ -1186,7 +1183,7 @@ int transport_push(struct transport *transport,
 
 			if (!push_unpushed_submodules(&commits,
 						      transport->remote,
-						      refspec, refspec_nr,
+						      rs->raw, rs->raw_nr,
 						      transport->push_options,
 						      pretend)) {
 				oid_array_clear(&commits);
diff --git a/transport.h b/transport.h
index e783cfa07..e2c809af4 100644
--- a/transport.h
+++ b/transport.h
@@ -197,7 +197,7 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 #define REJECT_NEEDS_FORCE     0x10
 
 int transport_push(struct transport *connection,
-		   int refspec_nr, const char **refspec, int flags,
+		   struct refspec *rs, int flags,
 		   unsigned int * reject_reasons);
 
 /*
-- 
2.17.0.441.gb46fe60e1d-goog

