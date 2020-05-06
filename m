Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22426C47247
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F35F9206A5
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="VYntB3yJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgEFAHp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 20:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbgEFAHn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 20:07:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E9EC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 17:07:41 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t9so14601pjw.0
        for <git@vger.kernel.org>; Tue, 05 May 2020 17:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S+j2Q8wZMBdb2cFeNRFmMRJNgzicKJJKA/eqQ+F3t3w=;
        b=VYntB3yJi3J3ljNSz/11uQItIs3Yuf+xOcIk3vGYiDH3hRyLQaSb3dNGuOFYfCfBB+
         T1kZJ8HY7QI5f39k0zJnE7ZQ5fddaP+C1EDuxexV6Ufz+MPPWgjopjp9YZCSBtnizmB2
         IMMKlMGS05cxHgZfBM09u5JSU4SnSeSt1vggsJ5S5ANnsZd0cOR6r23ml95cBK0lYgjU
         pmjSo8ZBJuym+P+htX9l2eBwowxoUZZkND7cgqcXc/K6tFeAjnQ+xN6V5jqA11s0wtwS
         FTdU60y1N+CyF8VwlzPA5fuK4B62Npj6uh/NTJNzSvdFB3YyoSL9lo7x4aDUXRzmnpr+
         Axiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S+j2Q8wZMBdb2cFeNRFmMRJNgzicKJJKA/eqQ+F3t3w=;
        b=HV6woV4Z51n95LhLnDXPhNNE8n2D/X5fJeIrH+xJYHEnUjGXv72T67tTiDS51u2Rbw
         bngbLdPTc6IOITZoeik0lb3bRJDR++leUI8Z/zQdPSVUwMFzOu7N78zMZXp9YsBgmAGx
         vR3N0MI0jmqfPqXsKST7N594wmixJpr+eyq+tcHN7eoQdGkksxfkkeOfY1HNSwQKvp1Q
         iymYMO+KuCiGWSYpmBksTLvT2nRF0tlOb0M82oKe5fqmKsly76BiAw/sbFki2Tys8WJY
         8JC1OqNb1OtZgxD7Nn+yCUFWmfz8VTSLt9WHvfuoZxeOY0r1GOGJjSBzrMKWGj6mlnF2
         KvsQ==
X-Gm-Message-State: AGi0PuYn5+KHrE9RGXo5z6fHZGlY+Tu5eaLMW2NydO2UwCLOcQQARQ5A
        O0TQ+mwALq+XDFv++wu3gnsEKeCwm8Y=
X-Google-Smtp-Source: APiQypJ4W16I1OZE9wEdp7IZwN0xyGoRTsMUaYt4Mur6F7yCYhmo5foU+GDQj139JNcoGnWWCy5bmg==
X-Received: by 2002:a17:902:7241:: with SMTP id c1mr5318212pll.113.1588723661079;
        Tue, 05 May 2020 17:07:41 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a196sm142081pfd.184.2020.05.05.17.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:07:40 -0700 (PDT)
Date:   Tue, 5 May 2020 18:07:39 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net,
        szeder.dev@gmail.com
Subject: [PATCH v2 3/8] commit-graph.c: peel refs in 'add_ref_to_set'
Message-ID: <85c388a077ed9b43ad4876e6b3efaa0358c78715.1588723544.git.me@ttaylorr.com>
References: <cover.1588641176.git.me@ttaylorr.com>
 <cover.1588723543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1588723543.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While iterating references (to discover the set of commits to write to
the commit-graph with 'git commit-graph write --reachable'),
'add_ref_to_set' can save 'fill_oids_from_commits()' some time by
peeling the references beforehand.

Move peeling out of 'fill_oids_from_commits()' and into
'add_ref_to_set()' to use 'peel_ref()' instead of 'deref_tag()'. Doing
so allows the commit-graph machinery to use the peeled value from
'$GIT_DIR/packed-refs' instead of having to load and parse tags.

While we're at it, discard non-commit objects reachable from ref tips.
This would be done automatically by 'fill_oids_from_commits()', but such
functionality will be removed in a subsequent patch after the call to
'lookup_commit_reference_gently' is dropped (at which point a non-commit
object in the commits oidset will become an error).

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index d0397f2a23..2c3b5fd09d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1327,11 +1327,15 @@ static int add_ref_to_set(const char *refname,
 			  const struct object_id *oid,
 			  int flags, void *cb_data)
 {
+	struct object_id peeled;
 	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
 
 	display_progress(data->progress, oidset_size(data->commits) + 1);
 
-	oidset_insert(data->commits, oid);
+	if (peel_ref(refname, &peeled))
+		peeled = *oid;
+	if (oid_object_info(the_repository, &peeled, NULL) == OBJ_COMMIT)
+		oidset_insert(data->commits, &peeled);
 	return 0;
 }
 
-- 
2.26.0.113.ge9739cdccc

