Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156BDC433EF
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 16:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241090AbiBOQAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 11:00:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbiBOP77 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 10:59:59 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42C8BDE59
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:48 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so1812650wme.1
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 07:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SOxTtAs3wZOBGCxCwnBp9XRj5HCeVuYdhbP7LLvdJEw=;
        b=o/uH7BGY8F4zccmIk/lHijGezim/51aXn/KT5yqcBC/hAyjNDd1bJBNOxUYZvbzjiR
         lSTlxjec7/gPIAmLZ4pLDNhtLbGrbYZGacKNGi7MMYCfo9KBvAHRTJnKywqDvZ13T04J
         V0YsXeSHSUt35QSy7CTjLR6dj5C89OHNwyOMFmPCFMGxQJPxGPapfJ6BuqkO/cQZkDZt
         LRl5MuuCG568bIjF0GmGzvqFmLN00+ix1bYQthnrCWQdttid5m96vpy02dd1zd/ug49y
         LGvXGJIE24OHtI9ft4rqdgIHM6z6fgCnmtEz7ot+InqMVRkvtnCFIGrCKdUP1VmvihhW
         zTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SOxTtAs3wZOBGCxCwnBp9XRj5HCeVuYdhbP7LLvdJEw=;
        b=eqxeBcCqLvLXJuRs+NN70GQf2j3fkaQOwL9hj2prEOi0MZTFpfkhflm7xNIrjJQe62
         uTu/3kR+la5p39IK05Zp19fku7EAwflUpaH2Z3WNA0l95sSnVwuM1jE+n0cNCdtc4ogt
         NgUEWQPrB81j2iLAy7el4eaTgh+Vo//UE6yA+fFyd3wL26TP+ETcrPyNdjivtCJDUlpo
         bWQsk6w3keniFGk4mnOA8P8ZWw60l2SAmIJBnaXXEqwvinces/NpMtUlWE09krmsgiK9
         jeSQmtOKgOGoVlzSsMPbZaXZSOiWuQjWfpH9hzwnr07m+eDR434mRl01LywGIPjm4gZI
         Cdvg==
X-Gm-Message-State: AOAM531VEx5ivELQmI6cDPB5j5Ve3YXOptjQf3jf7IO0OGFJI2Cxf0xw
        SngGYJP2GNKlRGJv7ZcCDnnSgKPtOqA=
X-Google-Smtp-Source: ABdhPJwuVcB3H3riz2p0vEbWEgDr990gd3NJnYjgqe4/T9ZYcpHwbe2Dt+debIjN5mXB+d60jPbqjg==
X-Received: by 2002:a05:600c:1f05:b0:37b:d9aa:e210 with SMTP id bd5-20020a05600c1f0500b0037bd9aae210mr3640884wmb.63.1644940787244;
        Tue, 15 Feb 2022 07:59:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g22sm15573392wmh.7.2022.02.15.07.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 07:59:46 -0800 (PST)
Message-Id: <71babe7243a312c024e6bc6f7c54357cac12c9b1.1644940774.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Feb 2022 15:59:22 +0000
Subject: [PATCH 12/23] fsm-listen-darwin: ignore FSEvents caused by xattr
 changes on macOS
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Ignore FSEvents resulting from `xattr` changes.  Git does not care about
xattr's or changes to xattr's, so don't waste time collecting these
events in the daemon nor transmitting them to clients.

Various security tools add xattrs to files and/or directories, such as
to mark them as having been downloaded.  We should ignore these events
since it doesn't affect the content of the file/directory or the normal
meta-data that Git cares about.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 34 +++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 2aefdc14d89..79d08517d7b 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -172,7 +172,7 @@ static void log_flags_set(const char *path, const FSEventStreamEventFlags flag)
 	if (flag & kFSEventStreamEventFlagItemCloned)
 		strbuf_addstr(&msg, "ItemCloned|");
 
-	trace_printf_key(&trace_fsmonitor, "fsevent: '%s', flags=%u %s",
+	trace_printf_key(&trace_fsmonitor, "fsevent: '%s', flags=0x%x %s",
 			 path, flag, msg.buf);
 
 	strbuf_release(&msg);
@@ -197,6 +197,31 @@ static int ef_is_dropped(const FSEventStreamEventFlags ef)
 		ef & kFSEventStreamEventFlagUserDropped);
 }
 
+/*
+ * If an `xattr` change is the only reason we received this event,
+ * then silently ignore it.  Git doesn't care about xattr's.  We
+ * have to be careful here because the kernel can combine multiple
+ * events for a single path.  And because events always have certain
+ * bits set, such as `ItemIsFile` or `ItemIsDir`.
+ *
+ * Return 1 if we should ignore it.
+ */
+static int ef_ignore_xattr(const FSEventStreamEventFlags ef)
+{
+	static const FSEventStreamEventFlags mask =
+		kFSEventStreamEventFlagItemChangeOwner |
+		kFSEventStreamEventFlagItemCreated |
+		kFSEventStreamEventFlagItemFinderInfoMod |
+		kFSEventStreamEventFlagItemInodeMetaMod |
+		kFSEventStreamEventFlagItemModified |
+		kFSEventStreamEventFlagItemRemoved |
+		kFSEventStreamEventFlagItemRenamed |
+		kFSEventStreamEventFlagItemXattrMod |
+		kFSEventStreamEventFlagItemCloned;
+
+	return ((ef & mask) == kFSEventStreamEventFlagItemXattrMod);
+}
+
 static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			     void *ctx,
 			     size_t num_of_events,
@@ -262,6 +287,13 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			continue;
 		}
 
+		if (ef_ignore_xattr(event_flags[k])) {
+			trace_printf_key(&trace_fsmonitor,
+					 "ignore-xattr: '%s', flags=0x%x",
+					 path_k, event_flags[k]);
+			continue;
+		}
+
 		switch (fsmonitor_classify_path_absolute(state, path_k)) {
 
 		case IS_INSIDE_DOT_GIT_WITH_COOKIE_PREFIX:
-- 
gitgitgadget

