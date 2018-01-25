Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1408F1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 23:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeAYX7c (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 18:59:32 -0500
Received: from mail-io0-f201.google.com ([209.85.223.201]:46744 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbeAYX72 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:59:28 -0500
Received: by mail-io0-f201.google.com with SMTP id g24so8446098iob.13
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ZBcseXfLf/LWiklmecEFnCScOiRMDqmUfsSyKBpHnEI=;
        b=ZCNRdNAStsiam3pSgU84472MFf8cM4cK4KEE7TkzqZE9GxkMDVjkpEHjx0W1MJh0qW
         kCAOxWCIRm2oxFbBhr8fYzyryNFT+YM5vn/ggkGBbSUCWtvoPyyS7n6/HtT5RIrBJO6p
         yBzUOwaIK470NOud/DV9k5U0igdNShqyw4iVwosZJSwssL/uOx9NSh5SwQQhgoZJd45Q
         Rc/AaJlm2xxOGnwa2cHPuoj4OwHMY2bXS+MFWWPi5cdG7ShMINu6NEutf/8L68+TtGhz
         LSGoUBZvjIyI7SB4ojYlBVPuux+OWT11UJDVoMOCMuNpBWZjIzaBW1F7s5cQCB4M4QHm
         bVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ZBcseXfLf/LWiklmecEFnCScOiRMDqmUfsSyKBpHnEI=;
        b=RTa28/aQPk5ngJ65qAXIuFZX7axHoFJfNTLuB6d+NXX0FeHSuViqV7fAiqu8cKBA/m
         jj93ai6ANHs3lu9YO28jjgz6BgbCeqxhP7c7ByamJwWnwftKLQUsFtaiDnsBHNxxxXp2
         PmQCPluM+m+/RPFA++JNCHvYIpuJFehLTVY3gZRQI58qgHkHkPC4XgMVwx+Ifd+D+2Ep
         u9OtzSkfSDDLe2x3IwJSIfmueLeNzReR0j9ZKSSzzLZvFrec8VAYqYVGh4UWeZ56fYGo
         mHLMo6YD2uq9kIC43jP7kF4WpnxdMlTbKBVRfTJx2jfLdwgfVPzy5uqBvFeC8zHf0XGu
         3v0w==
X-Gm-Message-State: AKwxytd248fclgbunHk0C8ag6ggPGgSdDV+qEz211zvm7PNvEoxbj+wl
        nNG1EO871+VMQ3LWNIOao6JzbocpLVQpV+S19ADX1TizFQkKt9Apq/4KSO+2R99dqQFpDrSgrWs
        HLuzTo8dOzEhVdJrGRDFA6sfk/7O1aUJOodP0I9dnM/7iCUyUtdn4qtpKng==
X-Google-Smtp-Source: AH8x226UwyyKUFH6n0tsckLgOnh0pKQBs8Kvc96u7PxDUfW+2bKbivuQ8PLylwc3sd315BUATeTQHA5g4d4=
MIME-Version: 1.0
X-Received: by 10.36.104.211 with SMTP id v202mr8674471itb.28.1516924767794;
 Thu, 25 Jan 2018 15:59:27 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:30 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-20-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 19/27] push: pass ref patterns when pushing
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
        Brandon Williams <bmwill@google.com>
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
 transport.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index dfc603b36..6ea3905e3 100644
--- a/transport.c
+++ b/transport.c
@@ -1026,11 +1026,26 @@ int transport_push(struct transport *transport,
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
+			if (tmp_rs[i].dst)
+				argv_array_push(&ref_patterns, tmp_rs[i].dst);
+			else if (tmp_rs[i].src && !tmp_rs[i].exact_sha1)
+				argv_array_push(&ref_patterns, tmp_rs[i].src);
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
2.16.0.rc1.238.g530d649a79-goog

