Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 868C71F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965013AbeB1XYM (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:12 -0500
Received: from mail-yb0-f201.google.com ([209.85.213.201]:44468 "EHLO
        mail-yb0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964944AbeB1XYI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:08 -0500
Received: by mail-yb0-f201.google.com with SMTP id t18-v6so2372137ybb.11
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=g7ynaiosmUpdsFicHS+fDspoKjp/iacITh0ySCfYxwY=;
        b=IuF4ctfBXtsmC4Yk2v5GfdYF4OuYKrTg6DkKptaqDypvhPQvNYZwnBxz78/lnu20Xf
         cPO5/Ec46U9qnZ6MkUHVkByALvgxkgsENfFg/gsnLFosGT/RaBItj63k7F5uWwSieF+6
         QsCNW7w6iMqCMKu+1WB2ISi6lzJq2fu1li03Uy/VTMiFQgZa9yEPuCdwJAGLsCPrUAPG
         cPQragVKfjRAFxDgy8rq6eJ4qLtyQKRBe96O7O0DbaunxCxpumeNQKhjKxAIz95g/ysd
         c2O7ZfsHdXAj68sHATrkUp4uF7f1A8z2SO/qEaXS26Q5FqxcS7fLGuJODZD/x4QnFFgG
         kAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=g7ynaiosmUpdsFicHS+fDspoKjp/iacITh0ySCfYxwY=;
        b=SrCuMKLEiJ4Ot5ul3p3e+8PSoO9nOInaH6U49nrhcFpT1h5obFq8vfYdBj+yacdlpI
         SmpaL4pGS7cv1S0ERiVx1ehqCGMyZeYTfBF3SQwJ0uaEDDPn1UO5Qd7IEfLznH7Vlqce
         9OpXYvlmZhn6rAwHiCf6PC5mxTFxxBMc91r7Yx78NCYcv+hLMdwkbChN/sMItas+rdr0
         xUs3bLtlqlaPPrCjtFoPJdGZ21pOmnSUzahLw79hInDNGdi5oR1zOHrmJOpH3caiVJZp
         0kfmlvO8lJWVzKepnTqEzWmgWPjGtO9m2YWbJlTD1l14TwyF8WJnPyqPuiwJDRByzQCG
         yddw==
X-Gm-Message-State: APf1xPDx0WmM6FQzcWsNZb0fBSBPOVr2dEudmnvA5EZyqTOBJIsYSbFW
        v70131iP9fVBTmvQmkFH+fvjCnvfsP7OGfDRXMYPl8n4exfJtJW5I5nQ8v98uk9r16qAOw3EcnA
        v5u/BZS3pNtfDI9NwUCLj8/x0YqqK75OJzxd5SGLQiRfnwyBQHK6rFej3IA==
X-Google-Smtp-Source: AG47ELv2JJgSvyiE4IXmVtiYTsUZkCx5GD+80EatgSEplkg0H9I/GNUzFh13oOVtW3o5PQ6EFyur/pPU0sc=
MIME-Version: 1.0
X-Received: by 10.129.125.131 with SMTP id y125mr9897570ywc.94.1519860247901;
 Wed, 28 Feb 2018 15:24:07 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:36 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-20-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 19/35] push: pass ref patterns when pushing
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Construct a list of ref patterns to be passed to 'get_refs_list()' from
the refspec to be used during the push.  This list of ref patterns will
be used to allow the server to filter the ref advertisement when
communicating using protocol v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index dfc603b36..bf7ba6879 100644
--- a/transport.c
+++ b/transport.c
@@ -1026,11 +1026,35 @@ int transport_push(struct transport *transport,
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int push_ret, ret, err;
+		struct refspec *tmp_rs;
+		struct argv_array ref_patterns = ARGV_ARRAY_INIT;
+		int i;
 
 		if (check_push_refs(local_refs, refspec_nr, refspec) < 0)
 			return -1;
 
-		remote_refs = transport->vtable->get_refs_list(transport, 1, NULL);
+		tmp_rs = parse_push_refspec(refspec_nr, refspec);
+		for (i = 0; i < refspec_nr; i++) {
+			const char *pattern = NULL;
+
+			if (tmp_rs[i].dst)
+				pattern = tmp_rs[i].dst;
+			else if (tmp_rs[i].src && !tmp_rs[i].exact_sha1)
+				pattern = tmp_rs[i].src;
+
+			if (pattern) {
+				if (tmp_rs[i].pattern)
+					argv_array_push(&ref_patterns, pattern);
+				else
+					expand_ref_pattern(&ref_patterns, pattern);
+			}
+		}
+
+		remote_refs = transport->vtable->get_refs_list(transport, 1,
+							       &ref_patterns);
+
+		argv_array_clear(&ref_patterns);
+		free_refspec(refspec_nr, tmp_rs);
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
-- 
2.16.2.395.g2e18187dfd-goog

