Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FEE11F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeCORcc (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:32:32 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:53281 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbeCORca (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:30 -0400
Received: by mail-ua0-f202.google.com with SMTP id c23so4716686uak.20
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=5Ud7YE9bjhoZ+yIAi8MGxgUhxRuWfAfXX6ZykoFlZyY=;
        b=L4KaVP9ZvqYCXRzMG5Yy2UsTg+bFDxwdbkXPYLOvSy/tsYxt42KfCn9ml6VUe6pUlj
         bjASsQ8DxzkDtU9/qrSwmekowW/WnAKtiTRT1KRJlB/8b7zRP1/TWsnh18wxv3V/8rCq
         A0PL0+S16OjPhx3w+oUb54JveTStqDi4MRPf2/RoItX9YZf8llrYWCYyuszCKZrtwi2e
         pHcQPztVid6nC7GwrkhoAHe9iLyKWfYroGaZfP/jJT2+6df7caF3/b6VleoCgCX/imRj
         lZM6ayXPJpqD3R/+btaAOzxRsf6XLkKcWlx1UPFAshsWHmYpNR0BdCuMJZLBmaGmxVFH
         4VjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=5Ud7YE9bjhoZ+yIAi8MGxgUhxRuWfAfXX6ZykoFlZyY=;
        b=mjiYI3wzu5+DOB86sYiVQ4IZnVKzj4uzsgksBfKqyihxdSK8FTlA1Ctw60oiPPQEn5
         n9YDcaOQl+loMLZy62QKdQhvUWfpSKPwFUgXVvW28tCHNljal8u16BOqPMO4HTj6BD2h
         /GPms3zR41mWCsLI2l6GCmgE1XTYanDWWEkHH5tObOP2KKwHz3YS5+NUQdF6v8vAEPkU
         LwHkvQg/WqJdbDtPRZmq3y66wx9nqRkNY+8Y3FjlzoTDPIAGmtYpBSVOv4e1pqzvG3oo
         vEzS31hRr84Se4He9qvkfbovsfmWE4ZOxKkmwdYMctJTDhtu9OqAsDm1S5Nj7wqtmvz5
         xxig==
X-Gm-Message-State: AElRT7GWaacp2S+ODFTLDOLzSerJEbEk4P52mxJHeM00l5hl428ggU6s
        wOCIG9AuzlofXp4xLlvMXGfuJ89cdXzhZIlRhWJTe0vy6meN63Qeqg2imBu3H68TOx/MojSbEIL
        YG1YWf7GgRYerzHDoi+cinXlmHp0bOOzRDCEmHfT9Hp1UTqIeu1Du0dAO7w==
X-Google-Smtp-Source: AG47ELt/TYMAg2BrnCHlqspuwSuy8ZzgsgmLdF6PGHH5mkOkThxcM/aayiV6droxZvvZGcFFH8E+C3UoZ/Q=
MIME-Version: 1.0
X-Received: by 10.159.49.199 with SMTP id w7mr1261165uad.22.1521135150074;
 Thu, 15 Mar 2018 10:32:30 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:25 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-19-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 18/35] fetch: pass ref prefixes when fetching
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Construct a list of ref prefixes to be passed to
'transport_get_remote_refs()' from the refspec to be used during the
fetch.  This list of ref prefixes will be used to allow the server to
filter the ref advertisement when communicating using protocol v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 850382f559..8258bbf950 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -332,11 +332,28 @@ static struct ref *get_ref_map(struct transport *transport,
 	struct ref *rm;
 	struct ref *ref_map = NULL;
 	struct ref **tail = &ref_map;
+	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
 	/* opportunistically-updated references: */
 	struct ref *orefs = NULL, **oref_tail = &orefs;
 
-	const struct ref *remote_refs = transport_get_remote_refs(transport, NULL);
+	const struct ref *remote_refs;
+
+	for (i = 0; i < refspec_count; i++) {
+		if (!refspecs[i].exact_sha1) {
+			const char *glob = strchr(refspecs[i].src, '*');
+			if (glob)
+				argv_array_pushf(&ref_prefixes, "%.*s",
+						 (int)(glob - refspecs[i].src),
+						 refspecs[i].src);
+			else
+				expand_ref_prefix(&ref_prefixes, refspecs[i].src);
+		}
+	}
+
+	remote_refs = transport_get_remote_refs(transport, &ref_prefixes);
+
+	argv_array_clear(&ref_prefixes);
 
 	if (refspec_count) {
 		struct refspec *fetch_refspec;
-- 
2.16.2.804.g6dcf76e118-goog

