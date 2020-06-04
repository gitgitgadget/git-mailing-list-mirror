Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5ACC433E1
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4958B206DC
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHqu4py/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgFDRzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730313AbgFDRzW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:55:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55E1C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 10:55:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so7132422wru.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVVA927F6Ddsg0YqaC/pFt9jm0ZdWRv1/vx5O8QK2cw=;
        b=HHqu4py/ZKDHaMsgIljPvPB4A0JNvfZYHzRIab796bLVfk0wyqMa5an7VG2Fh5NwVm
         aWapIrDoQLgdLYtWaQ1eZeE/GyxduDZMPYJCmUzYOe7BTPEq45W3hLNtvmD0Gmv5HZYC
         H8qaGBfTisa83kUoRCTMyF47BAgIZJwGXatjDIUX/msnePL3vqXfUFnQcG0AbExQEdFY
         NQUXVDlr2/bzf+K2Bbf4a38Ktu3FZpOiuG8vBuEOnwSlEwYFK0VjQwoOkoSRMAUOS0h7
         r7ETBS1Z0IZEDAYjEFNi5oWpL+UIi0LxssiXNM7v0msaKP8rOsBIijPzz/KdTcKaxJMh
         O92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVVA927F6Ddsg0YqaC/pFt9jm0ZdWRv1/vx5O8QK2cw=;
        b=k8vj8Ax5I9j/0rPxCSaPalwT6ifhDV10+UqdGH0yKK59dZqI4HomLl5xVdd1e0evjE
         Ba0GQRTNln7ITHRcs9dheZK84pQRUA9LHmGMKgR9HcMtvDezA08xBeCnRclY9eFnKkgJ
         kDylO6WNMh24HpFfzfuHUZOt4ff105Xi4J3U9avzdrPY81bzdggbvYvPwotRDJ4sfBSK
         Q8hFHlKYOHnMnzCuI3Ntzyh3+3b4fx7Vz2/Rojz/+NLhJlbfvTToFNx3zxSbAiyEMmHb
         rLGEe497Qz5J/sBx5TPCKWp5p5bKrHGEZA4tsVTp9GaxLb8yl3hunFopQ9aIKtvEdhJl
         SiDg==
X-Gm-Message-State: AOAM5316k4AngLjoLAUZ/H9uhktpOg1X3kDvisdkcQHdOc3beCWYJAUb
        fQEhzbusIT1jbnWQYT3BKoxUz04HOh4=
X-Google-Smtp-Source: ABdhPJxH4a7wBwiagTZUcvEaKJqN50rSNtrUhIe8E8lsbZHtR/6MXYLavQDwNLxfQ4XNz3T329pnhQ==
X-Received: by 2002:adf:bbc5:: with SMTP id z5mr5614097wrg.269.1591293320060;
        Thu, 04 Jun 2020 10:55:20 -0700 (PDT)
Received: from localhost.localdomain ([185.228.231.251])
        by smtp.gmail.com with ESMTPSA id s7sm9173540wrr.60.2020.06.04.10.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:55:19 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 10/13] upload-pack: move allow_filter to upload_pack_data
Date:   Thu,  4 Jun 2020 19:54:47 +0200
Message-Id: <20200604175450.17385-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.rc0.26.gf2851482f5
In-Reply-To: <20200604175450.17385-1-chriscool@tuxfamily.org>
References: <20200602041657.7132-1-chriscool@tuxfamily.org>
 <20200604175450.17385-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's move the 'allow_filter' static variable
into this struct.

It is used by both protocol v0 and protocol v2 code.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 0eb4c32552..19b342d4b0 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -55,7 +55,6 @@ static int shallow_nr;
 static struct object_array extra_edge_obj;
 static const char *pack_objects_hook;
 
-static int allow_filter;
 static int allow_ref_in_want;
 
 static int allow_sideband_all;
@@ -102,6 +101,7 @@ struct upload_pack_data {
 	unsigned use_ofs_delta : 1;
 	unsigned no_progress : 1;
 	unsigned use_include_tag : 1;
+	unsigned allow_filter : 1;
 
 	unsigned done : 1;					/* v2 only */
 };
@@ -984,7 +984,8 @@ static void receive_needs(struct upload_pack_data *data,
 			data->no_progress = 1;
 		if (parse_feature_request(features, "include-tag"))
 			data->use_include_tag = 1;
-		if (allow_filter && parse_feature_request(features, "filter"))
+		if (data->allow_filter &&
+		    parse_feature_request(features, "filter"))
 			data->filter_capability_requested = 1;
 
 		o = parse_object(the_repository, &oid_buf);
@@ -1090,7 +1091,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 				     " allow-reachable-sha1-in-want" : "",
 			     data->stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
-			     allow_filter ? " filter" : "",
+			     data->allow_filter ? " filter" : "",
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
 	} else {
@@ -1142,7 +1143,7 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 		if (!data->keepalive)
 			data->keepalive = -1;
 	} else if (!strcmp("uploadpack.allowfilter", var)) {
-		allow_filter = git_config_bool(var, value);
+		data->allow_filter = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
 		allow_ref_in_want = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
@@ -1334,7 +1335,7 @@ static void process_args(struct packet_reader *request,
 			continue;
 		}
 
-		if (allow_filter && skip_prefix(arg, "filter ", &p)) {
+		if (data->allow_filter && skip_prefix(arg, "filter ", &p)) {
 			list_objects_filter_die_if_populated(&data->filter_options);
 			parse_list_objects_filter(&data->filter_options, p);
 			continue;
-- 
2.27.0.rc0.26.gf2851482f5

