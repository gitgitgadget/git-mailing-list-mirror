Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6528C0007A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821F12085B
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 18:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbgLCS4D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 13:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgLCS4D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 13:56:03 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16449C061A4F
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 10:55:17 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id j1so1669764pld.3
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 10:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iITejF+sGX+kznbAquUDyGQvk9184dwFZBMkLSORcsU=;
        b=vuq90MrVxrMwgyR2SVzzbd61Zn2Mhk7F2tioXRVm42weHefAYfZ5lWsyCOA+OTKjb2
         j5xH3jVb5cEdFmJn6qWrAwwP0CizRzGDrGF4bRXsAYfFvnSWrJf46OkwCnpFShMXMYDK
         a2Od3MYcqdqcxkkSlX2Qqyrere3WlKDhuhhYExSssAZn7atUe6TEONMjswMUow7oxi+z
         CwOzVNtzMB8w5Xb30Dw56yLx+euvhSdkxUAYGb71Jb7helVSnHLVZMxbKzhkgYkTUC2W
         KnMXqmzAjUyOwkWhZCOfWag1KKG475ZTtFR8gLYAI7vJq8nOd+gGVNGJFN/zDMhyzmiR
         Czog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iITejF+sGX+kznbAquUDyGQvk9184dwFZBMkLSORcsU=;
        b=JoAUGTInxSnAIrCaIQbqETzc6t1+IdOZjPgfLsKOzOk5i2S+oMt2rmmEoUFCVxcdwp
         ZiekELM6mVl7h86309vpBHXXR7fbppyDY6POI3e2rpvTpus82lYO6Qa8cbYdAXbZGIWp
         UX2FPZkEHtP1h+2TFIcX3RNg5wyhp5XKvPd4BlYKhVLiCerf4/s2wvzQXmd6VfDI9+7y
         FdOkx7QIFReT1Db0qyYHaqMNcWxwG/hM5+mtAD+yL6RLYPHWl/9qQf81NVZODdNujCNg
         TZpZRxwyczi9coAn9QezaidSKeANi3nxm5XjC/1P4YQILvqBph4m6APewcxqh634Chfu
         4k4A==
X-Gm-Message-State: AOAM531p80brOrZKgb1IdLoc3VSYVn4MMy8N1at6qXJtjr+8gWX/x2LL
        6JBMTWY5yxlEjPTnnUHcQIyGm5Bk4CNG3tAV
X-Google-Smtp-Source: ABdhPJxeDDUP9afR4WQZwhkiA309mopXLQA1y6xsfi9s+IQXocXLdvS6ZFEG5Izrj+OH9r4xJkzPxw==
X-Received: by 2002:a17:902:7c0a:b029:da:62c8:90cb with SMTP id x10-20020a1709027c0ab02900da62c890cbmr330282pll.59.1607021716242;
        Thu, 03 Dec 2020 10:55:16 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id g8sm1825457pgn.47.2020.12.03.10.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:55:15 -0800 (PST)
Date:   Thu, 3 Dec 2020 13:55:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 1/2] builtin/clone.c: don't ignore transport_fetch_refs()
 errors
Message-ID: <27a817597850a2e6a13efe1d5ea105d70e1e4040.1607021483.git.me@ttaylorr.com>
References: <cover.1607021483.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1607021483.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If 'git clone' couldn't execute 'transport_fetch_refs()' (e.g., because
of an error on the remote's side in 'git upload-pack'), then it will
silently ignore it.

Even though this has been the case at least since clone was ported to C
(way back in 8434c2f1af (Build in clone, 2008-04-27)), 'git fetch'
doesn't ignore these and reports any failures it sees.

That suggests that ignoring the return value in 'git clone' is simply an
oversight that should be corrected. That's exactly what this patch does.
(Noticing and fixing this is no coincidence, we'll want it in the next
patch in order to demonstrate a regression in 'git upload-pack' via a
'git clone'.)

There's no additional logging here, but that matches how 'git fetch'
handles the same case. An assumption there is that whichever part of
transport_fetch_refs() fails will complain loudly, so any additional
logging here is redundant.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/clone.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a0841923cf..a5630337e4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1293,8 +1293,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 				break;
 			}
 
-		if (!is_local && !complete_refs_before_fetch)
-			transport_fetch_refs(transport, mapped_refs);
+		if (!is_local && !complete_refs_before_fetch) {
+			err = transport_fetch_refs(transport, mapped_refs);
+			if (err)
+				goto cleanup;
+		}
 
 		remote_head = find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =
@@ -1339,8 +1342,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	if (is_local)
 		clone_local(path, git_dir);
-	else if (refs && complete_refs_before_fetch)
-		transport_fetch_refs(transport, mapped_refs);
+	else if (refs && complete_refs_before_fetch) {
+		err = transport_fetch_refs(transport, mapped_refs);
+		if (err)
+			goto cleanup;
+	}
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf, transport,
@@ -1367,6 +1373,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	junk_mode = JUNK_LEAVE_REPO;
 	err = checkout(submodule_progress);
 
+cleanup:
 	free(remote_name);
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
-- 
2.29.2.533.g07db1f5344

