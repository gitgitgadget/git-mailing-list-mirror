Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED7FC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241710AbiCDSde (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241708AbiCDSdV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:33:21 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03BF1D3ACC
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:32:29 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bk29so13944157wrb.4
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1alrgmIKTTfkeQGsRpqIaUCurK58c/F6Sbwglv2dEE4=;
        b=WNM/3ZLa8Z2Zt8wjF4HMkZwy9MCwSQE92X727rdRMXGUZaRZAZHT2kpaQKB5af7kQ5
         5GvKaQBYMmyTXaG5zKh3C3QN7jw3UfZVqmnJlaQvuM/v2YcMTHaNyxQF9wmaeEjlk6nj
         FW08vpCjNgsWctjKXUIT7xqyrEiJM7AaE8c9pkVkiYEeAXQ8h0F4hvcnKEIBu/jFnq4f
         bG8Ba/MBYedBj45jOaaE/PM2Vqo95AIanRTZH2LbVmRNr27ho9IVgcce06PosNU95hPZ
         lM4iIUT7ogBinUAB6/9PuyYeo97DhTp2KU/bNLInzvbECtUlabKWQIj+qlMG5MSYSE1R
         tC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1alrgmIKTTfkeQGsRpqIaUCurK58c/F6Sbwglv2dEE4=;
        b=AweQoOx97EueeJRIs6Yy7TA1BAsujRsvWbnodVqHb+AG1gsI9MAmjcTTUIuvZlZMDx
         EYWmSLdkuVIVwwpZBtjv9Ukq0IB/VW6393DV7mx3MzS2KV/Jqdz6zbfNVoXnXcP8bbJM
         Qv6nbwRU5aJY9xhPNqU5G0phbLhs74/F3hoAf+4ZsBS7HUHFYT4jQLpy16ao3ou4IjOD
         9FnkdlDVzZo2h4ipwMB9JvI4iRso1PezhPQQ4v8X82MAt0w2PfWe+Op8d9RNcIEnf4Ci
         D+3/369Z430cv/BFpPNF5b89Mvs5lP8LgfiluQRIrtAdd+pGHlaIYE5rKEPSiRSo1AFb
         sDlA==
X-Gm-Message-State: AOAM531oocKmoXtMPNmdj+tvNQvktL3K/Dj+HNDds9Zz36ow156dRo9W
        eRIAZrss6HJOPjiQ/twsPXF0yY9wfddQLw==
X-Google-Smtp-Source: ABdhPJxleUw1/T7vsz/0/SkGZnLa2+r3D/z2KvTdXDPJVefX7qvYs8kup9ZV8h0me+8VPcA9pZvN/A==
X-Received: by 2002:a5d:6241:0:b0:1ed:b534:e04e with SMTP id m1-20020a5d6241000000b001edb534e04emr56657wrv.68.1646418747722;
        Fri, 04 Mar 2022 10:32:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm10573990wmg.7.2022.03.04.10.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:32:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/14] transport: stop needlessly copying bundle header references
Date:   Fri,  4 Mar 2022 19:32:10 +0100
Message-Id: <patch-v2-07.14-b3f7753a790-20220304T182902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1248.gb68c9165ad8
In-Reply-To: <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the logic added in fddf2ebe388 (transport: teach all vtables to
allow fetch first, 2019-08-21) and save ourselves pointless work in
fetch_refs_from_bundle().

The fetch_refs_from_bundle() caller doesn't care about the "struct
ref *result" return value of get_refs_from_bundle(), and doesn't need
any of the work we were doing in looping over the
"data->header.references" in get_refs_from_bundle().

So this change saves us work, and also fixes a memory leak that we had
when called from fetch_refs_from_bundle(). The other caller of
get_refs_from_bundle() is the "get_refs_list" member we set up for the
"struct transport_vtable bundle_vtable". That caller does care about
the "struct ref *result" return value.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 transport.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/transport.c b/transport.c
index 253d6671b1f..70e9840a90e 100644
--- a/transport.c
+++ b/transport.c
@@ -125,16 +125,9 @@ struct bundle_transport_data {
 	unsigned get_refs_from_bundle_called : 1;
 };
 
-static struct ref *get_refs_from_bundle(struct transport *transport,
-					int for_push,
-					struct transport_ls_refs_options *transport_options)
+static void get_refs_from_bundle_inner(struct transport *transport)
 {
 	struct bundle_transport_data *data = transport->data;
-	struct ref *result = NULL;
-	int i;
-
-	if (for_push)
-		return NULL;
 
 	data->get_refs_from_bundle_called = 1;
 
@@ -145,6 +138,20 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 		die(_("could not read bundle '%s'"), transport->url);
 
 	transport->hash_algo = data->header.hash_algo;
+}
+
+static struct ref *get_refs_from_bundle(struct transport *transport,
+					int for_push,
+					struct transport_ls_refs_options *transport_options)
+{
+	struct bundle_transport_data *data = transport->data;
+	struct ref *result = NULL;
+	int i;
+
+	if (for_push)
+		return NULL;
+
+	get_refs_from_bundle_inner(transport);
 
 	for (i = 0; i < data->header.references.nr; i++) {
 		struct string_list_item *e = data->header.references.items + i;
@@ -169,7 +176,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
 		strvec_push(&extra_index_pack_args, "-v");
 
 	if (!data->get_refs_from_bundle_called)
-		get_refs_from_bundle(transport, 0, NULL);
+		get_refs_from_bundle_inner(transport);
 	ret = unbundle(the_repository, &data->header, data->fd,
 		       &extra_index_pack_args);
 	transport->hash_algo = data->header.hash_algo;
-- 
2.35.1.1248.gb68c9165ad8

