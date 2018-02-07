Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7CBA1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932234AbeBGBN7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:13:59 -0500
Received: from mail-qk0-f202.google.com ([209.85.220.202]:36599 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932229AbeBGBN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:13:58 -0500
Received: by mail-qk0-f202.google.com with SMTP id z192so3145717qkb.3
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=TKAQutYfLKNEFF5uCAodZKOdyGfax+qkLTXuG+mEqxA=;
        b=uEJOTPvOpGcoAAJicQqHZo+JqNF7Gg8qJJ4YviodXrGM/553x7InUkf4Aj9GEQtjF8
         1Fl9gv01Sss5kvepBA9oDBM/7oZsn/uJY2pHvOQu9Rkz/Ey0ccynGbMT6Vhi19hY0Sfg
         9nJZBLnDj0LISb+j76LKWLuI0Fh8ru52jPuYCeDAh1pwEEPGPNnLM4d3UqGc0Gds4Dus
         00azi9jrxq8T+RyQ3VDhVuhqLod6PLlDEEwfTlRTaOyXjPm+2UTLD2xU4XJBGwie46ps
         J9mlfRnBz0Ytgv0RvqTjEVvgA9QpJ/7rkQa1OSQdpggLl14ftzuoxxkpRnFbyk33G0lN
         2+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=TKAQutYfLKNEFF5uCAodZKOdyGfax+qkLTXuG+mEqxA=;
        b=t9mHfmJ0ZM95B1mphJFaGsmgWJLPdb+kWUCuEDZ9TMa+/lDlydgCo8k7kq4OXMTyLE
         ydslSYCV0D1LGPadQXmTTDTJT19pP9vf7lDdRNgr0m6qvg6T4FfH37zJ3AtH5EImQ8oM
         L/ha0PX9qaT4dblPs1cPNogqqacRSDWDMptbClStO1GPT+Amakz0qyCemcPEGi17zcSm
         HID9MjhcuquT9emkSVyANq5S/4SVPayjuua6uqPnrx6dvSUkHHC4jUw8uaoBMuwJ3GX8
         0l8GLmiyr8p5zzL70ljtTItGFuyDrx9QbFRYVqZAMM7I0tIBYEN1nLUgXK6F/ye0kji7
         wehQ==
X-Gm-Message-State: APf1xPBK0uYj8aooqHSbaJY0PHiNpLIOGbfdVm2VfzcnYocsmAXXelIo
        bxGaeBy4/hBeYJZSFBSIwcAStkPDGbW6WRb86W7B2UU5yNuz7uWw5lFVvp71m7yyde63lV32DV9
        Lr1GZU12LCXn09EwpKBsn9nzx7YOv1Hu+VZk8yRvANz47TG5AHB8mv/x8uQ==
X-Google-Smtp-Source: AH8x226s7ng1/kkx+mreU4h986N3eFdz1jEuWCWJsEM/55Kn53HXeQempWS2tXDTmq+CFjCEJx160nt1fis=
MIME-Version: 1.0
X-Received: by 10.200.3.13 with SMTP id q13mr3459243qtg.2.1517966037272; Tue,
 06 Feb 2018 17:13:57 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:55 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-19-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 18/35] fetch: pass ref patterns when fetching
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Construct a list of ref patterns to be passed to
'transport_get_remote_refs()' from the refspec to be used during the
fetch.  This list of ref patterns will be used to allow the server to
filter the ref advertisement when communicating using protocol v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 850382f55..8128450bf 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -332,11 +332,21 @@ static struct ref *get_ref_map(struct transport *transport,
 	struct ref *rm;
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
+	struct argv_array ref_patterns = ARGV_ARRAY_INIT;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
 
-	const struct ref *remote_refs = transport_get_remote_refs(transport, NULL);
+	const struct ref *remote_refs;
+
+	for (i = 0; i < refspec_count; i++) {
+		if (!refspecs[i].exact_sha1)
+			argv_array_push(&ref_patterns, refspecs[i].src);
+	}
+
+	remote_refs = transport_get_remote_refs(transport, &ref_patterns);
+
+	argv_array_clear(&ref_patterns);
 
 	if (refspec_count) {
 		struct refspec *fetch_refspec;
-- 
2.16.0.rc1.238.g530d649a79-goog

