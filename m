Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 806F71F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964965AbeB1XZS (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:25:18 -0500
Received: from mail-yb0-f202.google.com ([209.85.213.202]:47531 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965000AbeB1XYF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:05 -0500
Received: by mail-yb0-f202.google.com with SMTP id c3-v6so2371251ybl.14
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=cgmZDgLILJVRyFAffvM4nEjVehePKbZPsU9uA/8bn8c=;
        b=iVYQpaLM1u+2w+xdM2bByamQFqK1jvHdtZ87/JmOzqMHQ/RyEkCr1zq+hMCwOipM4X
         ha5rRj4ogkSfnPot9k4JsvKvCl93TITe5rNwnaV80XuEBbFh+1dFG+Wpdt+uAVr50GhR
         asA7PGjma4hy23ooxlaWb6nbvH9VO/Lmh/BtLexuphIF/NcEwQBu68dJElIbof/zaLVY
         jQAqQwL3HUuyWUv/5MxH+U6je7574kE+lIuYt3PL/QIf93264ZJVmnK2bKN6AhV69TU0
         FYoIHEFItJ0iVzw4kf7MwrzeSZZ7FtWWHj8nuQEut2DftvKt0qawZEZ42RQUNTf6za1o
         MVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=cgmZDgLILJVRyFAffvM4nEjVehePKbZPsU9uA/8bn8c=;
        b=Lx+cwzO4a4R1WYkgvxGPxpJZUvOnHwk27K0C/XtwG4pOvRHtFQygzbyHHMBRjl/2vn
         RaXdoW/TS039Mwq/zbAQM+fMBwFWkAnxGq1X75pdinO5hZTBLC+Uu6Mc89MrdNKW3G3B
         8PitflfLZFRuis9e29JJT53Ep6uQ3D6c8/nDf6Le1tpeyhT1ZYdgBbXpSWd+R6o+P2HD
         38PjAGG5TDgHq/HUn/2oVE9anEcyHSLVX4AnfV7oe/hRmXcaZl8jOx2ec8oi4QqGtBBt
         90WT2jIGfHSt17hYO4GlaEkJIOdwKABglA2muF6Xe4B7QajuSNV4XRVh8A/CL/ts6mqP
         5PLg==
X-Gm-Message-State: APf1xPACnNd+XQsWiX0F+OkqK4Z3t6XLs3NTkmp8z5khKK53iNImvfk/
        9pRtVP6Tojm9W8ZSwAdzGcStRJrxjqlYau0vm+nfYUYgIfO6g4T8RcLt9f32A3jooFn/iJHeUGA
        AeJROjXO/rqCS9GVLighWn4igCdOXmhnlHDBMAMBncqTPJCQtE3GK8U2F7Q==
X-Google-Smtp-Source: AG47ELv7EBAiYyVk95zp+W45hopAmlPsewY/gmvJWc1cMGy+ioL1/iWu+aY598P3Gt4EdV8aAteriCNEEyg=
MIME-Version: 1.0
X-Received: by 2002:a25:d90d:: with SMTP id q13-v6mr9940032ybg.39.1519860245259;
 Wed, 28 Feb 2018 15:24:05 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:35 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-19-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 18/35] fetch: pass ref patterns when fetching
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

Construct a list of ref patterns to be passed to
'transport_get_remote_refs()' from the refspec to be used during the
fetch.  This list of ref patterns will be used to allow the server to
filter the ref advertisement when communicating using protocol v2.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/fetch.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 850382f55..695fafe06 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -332,11 +332,25 @@ static struct ref *get_ref_map(struct transport *transport,
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
+		if (!refspecs[i].exact_sha1) {
+			if (refspecs[i].pattern)
+				argv_array_push(&ref_patterns, refspecs[i].src);
+			else
+				expand_ref_pattern(&ref_patterns, refspecs[i].src);
+		}
+	}
+
+	remote_refs = transport_get_remote_refs(transport, &ref_patterns);
+
+	argv_array_clear(&ref_patterns);
 
 	if (refspec_count) {
 		struct refspec *fetch_refspec;
-- 
2.16.2.395.g2e18187dfd-goog

