Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C441F406
	for <e@80x24.org>; Mon, 14 May 2018 21:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeENV5C (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:57:02 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:44974 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752318AbeENV45 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:56:57 -0400
Received: by mail-qk0-f201.google.com with SMTP id w205-v6so13563828qkb.11
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=xXvgX2d1jPkzcd9fc94WLoUl+Pnu9jSeEfNAA8vLiWY=;
        b=E5tHNLa47mwHyKhKRONcVhJNWnJAUu97TDG8Yd7gVNZFcDHkgIAjtfkOR1Uj9PicJQ
         /blKputUrinXsu3M8+K1ZwDnfK2HmExxCF2rdA97ZRQ36gHKZ1maAOjUFInxA2sC284Y
         hMfDPfUw69b5UwHkSoxsyYrU2SlY53bv+ox0yQvKjDPrztw1DQwzQW7q04rk6/yIwKAc
         U+0RIuMIptEBuwpU03TghPRpK4OFd29Lr/P1xSvZIvOS4rtA7JFYkXfF4r+14uxK8sRs
         wtyEjhmyaZK9Y86B8qOaC6b+TBz6cPGNpNuVM+Iwk8WwbuiGs9C5ybfyjlTJFvPtsnMo
         Bt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=xXvgX2d1jPkzcd9fc94WLoUl+Pnu9jSeEfNAA8vLiWY=;
        b=K1VkIZYLKxmwFC0svhgAUJUAzeTe7DntxUSzhmVS+Q1NcnNTHMMAfxqGdVJsrsuTk2
         OtprgjtbOHyh9Dl3xlTJCZ+UcGOWmpEmQG2mlS70MFnfKUm+NWojQQkXT1R1xfGiGSi/
         5+200BlZ1xqJtAgG2QcXbwUVJWVIWU2VSq4yi6oqE8hIACcNSFsgsG2nn6rGFRDeFAP4
         AV5WNIIQb1dP+Ejc1/37RTM0IajDiwijNWwGlK0K+LhWyKidXCeMQoIYFMvyxVXWghj+
         MEo2NGjy3iR8TO/Ou1zqg4o2R03MlfuWCT1sO8HYT0ndSFeVeXveY+KiEQeUO8lNurTi
         RZlw==
X-Gm-Message-State: ALKqPwfTNeCE6foNZJpFI1jj7TBvFkQZaPhAwEXE1kH8sA52jcrPltCd
        s5CNvmRjan5nuAPDe9z/szs9msE5juXZjYwm58skTozG0jLZXHYTGU8TqUavbZ8SOYSQmmYHitn
        aMqewyURcsktzWkE+/0jBMxFPOfnjH0jLVPwaOPGD4nXnS9Z6q9O9xM7QOg==
X-Google-Smtp-Source: AB8JxZqZfxAdcld+seUnDlHTBud09Du+g0k33x1jt0SVuJM9ILuYmCDEojd1onnOVZWxTPUuL1//9bWkbW4=
MIME-Version: 1.0
X-Received: by 2002:a0c:952f:: with SMTP id l44-v6mr18173179qvl.56.1526335017128;
 Mon, 14 May 2018 14:56:57 -0700 (PDT)
Date:   Mon, 14 May 2018 14:55:59 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-9-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 08/35] transport: convert transport_push to use struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the logic in 'transport_push()' which calculates a list of
ref-prefixes to use 'struct refspec'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 transport.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/transport.c b/transport.c
index 3ad4d37dc..181db4d4d 100644
--- a/transport.c
+++ b/transport.c
@@ -1111,21 +1111,22 @@ int transport_push(struct transport *transport,
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int push_ret, ret, err;
-		struct refspec_item *tmp_rs;
+		struct refspec tmp_rs = REFSPEC_INIT_PUSH;
 		struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 		int i;
 
 		if (check_push_refs(local_refs, refspec_nr, refspec) < 0)
 			return -1;
 
-		tmp_rs = parse_push_refspec(refspec_nr, refspec);
-		for (i = 0; i < refspec_nr; i++) {
+		refspec_appendn(&tmp_rs, refspec, refspec_nr);
+		for (i = 0; i < tmp_rs.nr; i++) {
+			const struct refspec_item *item = &tmp_rs.items[i];
 			const char *prefix = NULL;
 
-			if (tmp_rs[i].dst)
-				prefix = tmp_rs[i].dst;
-			else if (tmp_rs[i].src && !tmp_rs[i].exact_sha1)
-				prefix = tmp_rs[i].src;
+			if (item->dst)
+				prefix = item->dst;
+			else if (item->src && !item->exact_sha1)
+				prefix = item->src;
 
 			if (prefix) {
 				const char *glob = strchr(prefix, '*');
@@ -1142,7 +1143,7 @@ int transport_push(struct transport *transport,
 							       &ref_prefixes);
 
 		argv_array_clear(&ref_prefixes);
-		free_refspec(refspec_nr, tmp_rs);
+		refspec_clear(&tmp_rs);
 
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
-- 
2.17.0.441.gb46fe60e1d-goog

