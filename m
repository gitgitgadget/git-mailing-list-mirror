Return-Path: <SRS0=hslh=3A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30764C3F68F
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 22:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0519A20866
	for <git@archiver.kernel.org>; Sat, 11 Jan 2020 22:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuv5Xnbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbgAKWfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jan 2020 17:35:05 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:50149 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731579AbgAKWfE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jan 2020 17:35:04 -0500
Received: by mail-pg1-f201.google.com with SMTP id u14so3820854pgq.16
        for <git@vger.kernel.org>; Sat, 11 Jan 2020 14:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R2CPxES3jKHCKRiHMq5mwg70LsAKEUGcXGoOB8zRyWI=;
        b=nuv5XnbdcL/Tmk44vgARoxM5tqZT33sniTEv14C6LfL8JkdBoPxcTT4W6Ij5r0ehMh
         nMZh0ymEX3vuwd+bclULCOmt1ndJzsPKEF3BUSarFhCOyAlRK7PKwfZ4yEhTgp6JEFAI
         u/dY5R+ijGd5Jxfecos6tM6tfLvaJ+fgUlzchGBKebGSRupK1FguxOcrqvv9EVK9W4yd
         CEJ4KBDdKhMvEFHxgoHMuFvK8epSFcWVmKDYUxxTWiXI76LWTUoTakGzlbvr+bzI6WCX
         hn6XMoiHCBiRcZYM5ALU59tqLN+RHSsiZm7075qiPunF5W1nHVIDpq1mOnvOHQmHEG9j
         DA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R2CPxES3jKHCKRiHMq5mwg70LsAKEUGcXGoOB8zRyWI=;
        b=eiiy/CL5+No/zJyNqDnvNvhvDlYUa383CsHL1xv/8cSc8JaJ+bd607PrDFCzyq1u/n
         otT6LYdgtB3HQ9obnl0V97+qaSinpbDAqWQLuabri8JSJkaOVnocnEzh3BYlIkM45s/C
         qB7dgmCpZi9JQoQbS1MUX6zMHVXtP5+nWxF8M0APDN4EUj0oWdoa4YXwXPXH05ULpYAF
         /ayVRINa4/ZnU0+BQv2agcHB6vZL9uhJSIm+s8BNwHvliPYOTlCuBd5GGR8T0sqZhy/I
         Bb9K5uE02qhz2Yr4wlh4lXZUx2rudjgkhvuZjZRUfEJK2qhwVfdkxg1Hks6S1cvll3UJ
         TOfA==
X-Gm-Message-State: APjAAAV/VUk4qB5QPYBrq0gUF7kBiUghWrkzdpI+h4ZKPpdxs2bPRde2
        CmrrYeMBhMU0dArxGgZnvnRvARq7pc0tnxCRWOK86s1914Byjd07Uja404g46eJ4JBrs+bZIB/R
        5FTHC/EgNR7UZa61axJKSpDb3RF+Bb8kRTCC+KohN465wOAaUGFzQE314HPSnzVQFiR6kzktYxM
        DO
X-Google-Smtp-Source: APXvYqyeb/kh7OzsZcac/JHct0mRxgk9ste8ZK+a41IYV9Dp/x2WMRw7CIRCvPCtTjF8sWYzgKY0grJUgk6ZZPMJ8q/F
X-Received: by 2002:a65:5788:: with SMTP id b8mr13208967pgr.324.1578782103683;
 Sat, 11 Jan 2020 14:35:03 -0800 (PST)
Date:   Sat, 11 Jan 2020 14:34:55 -0800
In-Reply-To: <cover.1578781770.git.jonathantanmy@google.com>
Message-Id: <6dce9c79be3b9264f832852e9068347f42cf3ee0.1578781770.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191228003430.241283-1-jonathantanmy@google.com> <cover.1578781770.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.25.0.rc1.283.g88dfdc4193-goog
Subject: [PATCH v3 1/2] revision: document get_reference()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In particular, document the behavior when the object is corrupt. The
existing behavior when parse_object() encounters a hash mismatch has
been there since cc243c3ceb ("show: --ignore-missing", 2011-05-19), and
the existing behavior when the code disagrees on whether an object is a
commit has been there since ec0c5798ee ("revision: use commit graph in
get_reference()", 2018-12-28).
---
 revision.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/revision.c b/revision.c
index 8136929e23..91ca194388 100644
--- a/revision.c
+++ b/revision.c
@@ -355,6 +355,16 @@ void add_head_to_pending(struct rev_info *revs)
 	add_pending_object(revs, obj, "HEAD");
 }
 
+/*
+ * Returns the object corresponding to "oid" and sets the given flags on
+ * it.
+ *
+ * If that object is missing or corrupt, this function returns NULL if
+ * "revs" permits it (that is, if revs->ignore_missing is true or if
+ * revs->exclude_promisor_objects is true and the object is a promisor
+ * object), and dies otherwise. Note that corrupt objects are treated
+ * like missing objects, to preserve existing behavior.
+ */
 static struct object *get_reference(struct rev_info *revs, const char *name,
 				    const struct object_id *oid,
 				    unsigned int flags)
-- 
2.25.0.rc1.283.g88dfdc4193-goog

