Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AF436AE3
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="uqIFg28b"
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F643B0
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 10:23:01 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7788ebea620so382931185a.3
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 10:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1699381380; x=1699986180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uAIHW7rhds10ZgTT7ADJK5wsRDifl8IBm77/et8Wzgc=;
        b=uqIFg28bAUH6RWP5kIE/mY8RegPqFCIeOkjfjkHth0FiBeO/PlV5jqDCkdGm1yRdZT
         945xRlPra2ZDbrAasGB5//CjouHiPw4PqhufwlwWknvzVzNy/TJkFJ8B7ZfITdHTt7BD
         U2uC5pBUYRjNUArLM/qp81LeWER3koG9B5UQ8aOstm8xxMyNjUQ1UAZlLh6HQBsw8FlW
         mwQa5xCsjuAikuLGpvOysBdUOUE9VwVwoPtDJ7Fm5r0CBTUcGJvPajxrrOos1IYvFLyC
         9fFHH+RC+AhL7t2AfNXTfurazRfiZ6ZRU/ZOACnlbxCpJ2QKwtCBtHbs6OIduxPY3c26
         kGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699381380; x=1699986180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAIHW7rhds10ZgTT7ADJK5wsRDifl8IBm77/et8Wzgc=;
        b=uGQMIjxFFlfoXnbKb4pVtNgMWmFHnkX5Crmw8SJiY2peA6RVLDmcxkEeDRjhLWkypx
         i4TpKkp+ECqcruJHu19Q/mVDXwDEgk7EgQwi5sF+mx9MApWIq20/NZbHPa+kB37H+dkx
         MKlr4q22ze8/Zba8aC0af2zNwGckJ7JBjr1WTbwpthoIbF8Tk0SbCkY74IKzRnllyOEg
         rc1FC0shjcWw4FaHWXtay84HcPpCxv0uMes5Nb6kcyCdQNEvtNQ1xN1mH4TA0kbSf+Ts
         MKvfyhTKLcPN8IK4exVk9HnQUt7j1Thk5zuthVXpKbSdpItFUhIkgCwPtSNPA/dJHpp8
         VTvw==
X-Gm-Message-State: AOJu0Yz1uIJHzvG3B9/MdVhasXTtntgBRQgPB7s8pVcOQmBdze/YfNxG
	TtlqLxT2Rvfonq2S4lilleSNvxX023kQUTZBwlqqlQ==
X-Google-Smtp-Source: AGHT+IHrC+kj5waeXedKFUnaMXy7H2XxlUAdV6yLaiMs+41pRVPaQWHP/BKHhoPGTr5WW+z4NNxDyg==
X-Received: by 2002:ad4:5ca2:0:b0:66d:3723:294b with SMTP id q2-20020ad45ca2000000b0066d3723294bmr35165507qvh.64.1699381380429;
        Tue, 07 Nov 2023 10:23:00 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id mn22-20020a0562145ed600b006655cc8f872sm141393qvb.99.2023.11.07.10.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:23:00 -0800 (PST)
Date: Tue, 7 Nov 2023 13:22:58 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC PATCH 2/3] tmp-objdir: introduce `tmp_objdir_repack()`
Message-ID: <0f19c139ba9bb5105747f545038825d0c89f2e42.1699381371.git.me@ttaylorr.com>
References: <ZUpepnSCSxL8i96b@nand.local>
 <cover.1699381371.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1699381371.git.me@ttaylorr.com>

In the following commit, we will teach `git replay` how to write a pack
containing the set of new objects created as a result of the `replay`
operation.

Since `replay` needs to be able to see the object(s) written
from previous steps in order to replay each commit, the ODB transaction
may have multiple pending packs. Migrating multiple packs back into the
main object store has a couple of downsides:

  - It is error-prone to do so: each pack must be migrated in the
    correct order (with the ".idx" file staged last), and the set of
    packs themselves must be moved over in the correct order to avoid
    racy behavior.

  - It is a (potentially significant) performance degradation to migrate
    a large number of packs back into the main object store.

Introduce a new function that combines the set of all packs in the
temporary object store to produce a single pack which is the logical
concatenation of all packs created during that level of the ODB
transaction.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 tmp-objdir.c | 13 +++++++++++++
 tmp-objdir.h |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/tmp-objdir.c b/tmp-objdir.c
index 5f9074ad1c..ef53180b47 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -12,6 +12,7 @@
 #include "strvec.h"
 #include "quote.h"
 #include "object-store-ll.h"
+#include "run-command.h"
 
 struct tmp_objdir {
 	struct strbuf path;
@@ -277,6 +278,18 @@ int tmp_objdir_migrate(struct tmp_objdir *t)
 	return ret;
 }
 
+int tmp_objdir_repack(struct tmp_objdir *t)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	cmd.git_cmd = 1;
+
+	strvec_pushl(&cmd.args, "repack", "-a", "-d", "-k", "-l", NULL);
+	strvec_pushv(&cmd.env, tmp_objdir_env(t));
+
+	return run_command(&cmd);
+}
+
 const char **tmp_objdir_env(const struct tmp_objdir *t)
 {
 	if (!t)
diff --git a/tmp-objdir.h b/tmp-objdir.h
index 237d96b660..d00e3b3e27 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -36,6 +36,12 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix);
  */
 const char **tmp_objdir_env(const struct tmp_objdir *);
 
+/*
+ * Combines all packs in the tmp_objdir into a single pack before migrating.
+ * Removes original pack(s) after installing the combined pack into place.
+ */
+int tmp_objdir_repack(struct tmp_objdir *);
+
 /*
  * Finalize a temporary object directory by migrating its objects into the main
  * object database, removing the temporary directory, and freeing any
-- 
2.42.0.446.g0b9ef90488

