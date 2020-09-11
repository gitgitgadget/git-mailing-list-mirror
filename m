Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1832FC433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 04:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F0F221E5
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 04:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg3yzBeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbgIKEhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 00:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgIKEgw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 00:36:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081B8C061756
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 21:36:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u13so5739961pgh.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2020 21:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W5frZQAk47m9IDhVoICZ9i/dtgnJZdvRUcq/E2p4uw0=;
        b=kg3yzBehauOq/kYfh1bfFuc8KV62w9YsNRn+bd38gYOI/SMY95UPiFC4mJqGma71mu
         RTKG/3WgSrxAGDkyFcKMNZbjPEWE5f2A+DSOAa0LL8RVR+M48m2wdEtXy7lKvETAR0wL
         iIySfkSS5nX7xo2NSdWuukg27jRNNJsY1dLwylO0uvyV9Swc+SiJMrxMqGa1cqu3Zrwy
         FE6lUWLZdPj240C2ZDKVMlQT31s41ymWYNgiJeeiyBmXDKWVdum/JCFJEJyw8aBgrlvH
         IC2YfMgjtdoR+vVPNvkNfW0V9/my+RgRHLjccIhcJkk4LNfw7zfb1AgP5sV4LO/Wj7aj
         RU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W5frZQAk47m9IDhVoICZ9i/dtgnJZdvRUcq/E2p4uw0=;
        b=o2R7VwZdSBIHlOdJYd60cvMefPI/awVIA0ci2a+kAHuqFnGpZ3WBEohKGSjG8blLoE
         eQKElS/Byle+trChiXejK39HVlc/XLlAG3cpDZ+DPq1t+IjFBAt+bl5PsZ2jwswjuR83
         rvuvOifSEe26TwCbGwn3EetdnZbOJimZ7s34a3vZ04ipr5uoB3MKakra519WPziLDzqe
         LHbC7Z/br5VQuYk7BPtJrCc8PBYVpscVJNkHDDxa64lWUs3OXqonDLqoLl5YrYCPmTi6
         k0XnQb9C6msmO96Ppd1HGVqYdapZCKU4PukPnmIZqVzp9oFN5YAZmLc7+5kiav7Rly0C
         Uzsg==
X-Gm-Message-State: AOAM530XcEZjbZLI9KOp9MCmMIGLJNXA3TnDWLzUQ/O4Uo4FWDywQFii
        3u7kdaIVPOOUyV8e5PH2HR4gvuHhs30=
X-Google-Smtp-Source: ABdhPJyLv36lq4mr/MRSW+ogXQWuMZPisCRI73RIwUOg7Wguh6cYw1WMuLiaR/y9BwVLZocpGeZYyA==
X-Received: by 2002:a63:ff63:: with SMTP id s35mr391007pgk.14.1599799011353;
        Thu, 10 Sep 2020 21:36:51 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:5900:d670::1ab5])
        by smtp.gmail.com with ESMTPSA id x25sm527804pgk.26.2020.09.10.21.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 21:36:50 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH v2 2/2] gitk: replace commented tab with space
Date:   Thu, 10 Sep 2020 21:36:34 -0700
Message-Id: <85d669828bf9455ac101f8177a7f46a94d30a114.1599798976.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
In-Reply-To: <cover.1599798976.git.liu.denton@gmail.com>
References: <cover.1599726439.git.liu.denton@gmail.com> <cover.1599798976.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous commit, the tab indents were mechanically replaced with
spaces. However, one tab, in particular, was missed. This tab was not
considered an indentation because it's hidden behind a comment. Manually
replace this tab with spaces too.

The only tabs that remain in this file are in the "Gitk key bindings"
table where they are used for visual alignment in a user-facing table so
leave those alone.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 1dae9861ac..0380cd8976 100755
--- a/gitk
+++ b/gitk
@@ -4451,7 +4451,7 @@ proc addviewmenu {n} {
     .bar.view add radiobutton -label $viewname($n) \
         -command [list showview $n] -variable selectedview -value $n
     #$viewhlmenu add radiobutton -label $viewname($n) \
-    #	-command [list addvhighlight $n] -variable selectedhlview
+    #    -command [list addvhighlight $n] -variable selectedhlview
 }
 
 proc showview {n} {
-- 
2.28.0.618.gf4bc123cb7

