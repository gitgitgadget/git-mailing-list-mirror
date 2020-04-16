Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D922C2BA2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB4A221F9
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 21:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNue9nFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgDPVFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgDPVFa (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 17:05:30 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A119C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 14:05:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so81995plo.7
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 14:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Y6cQ5EMVEN7TVyBA7UOs+RcqG/f7y1+pMS7wro+yUo=;
        b=QNue9nFhc2L6qLq+3m7hkcXJu4cbUZqf8Vjc/2oh50S/kBhic17Xen0JDYB1pDACSZ
         t7Qmw/cJuhbTd7jEpvdKxLqc49WKcpToh3S0f5UvgKCHWqDeCg+myW37wJXiZQQUWSki
         cMcKn2VnNH7KU6UKHkqrG2eU6jp1mttbHxQqIaaZCYoUh27dWWGhCh5pglpumrUM/i3L
         YHfUjso9f2Ok9r2vHqIU41yQqj/n73KXvhcU+VwzNSdP+kTIYyFpKchiUiyhDnGg8SSx
         ACZdMTvM3rM7WVEh3os3LZnuhAZkR3dFIkY11+Ismemk+ES/V1rIDg4AVul1x1N8bvAQ
         5+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Y6cQ5EMVEN7TVyBA7UOs+RcqG/f7y1+pMS7wro+yUo=;
        b=TqHsYc9lXHzcr3945eEa855mv9m78FHhxdu8Zi2aUcX6VTKt2FmEt7QfIMNdgrvXAM
         VTestbk9T0DWx+8D5fHxvfczGJHYXwuWCsDt2er/3x1/R+1yu2t11tmmqW0vamMa7QUy
         F7ExOf33QqFMvET2V3m4N8XBmzmuhssSPGk1n5LWp9c2Dj3fsU/Fm5EVV1UdOJjwu1su
         U1QDyE26aF8zZI9l9UzI835ndtbViYoVJswvFRNimppF+IqevQxISTn5Pth2r8jkrfPj
         o1LiNmdE+xrwj2B+rSnrq9Zosr5aJaIeXFmChgrpN4/w0Tv5loSnvWzTVkaTo6YBQF3I
         /yHw==
X-Gm-Message-State: AGi0PuacqosYSqZKBWbwN/YPzgUqNf1djU/gVV2Xsvpy1LSMoeRp1NkK
        4D8yRc662Y/voTWh4TnpS9z+Eqgw9RIxxw==
X-Google-Smtp-Source: APiQypIIgxpqK/QqxUZgf/xxJKiRx7SYpPDcCERT0Z8v002hBA217w76ZsmrSqmo9gDhXonCRyWU6g==
X-Received: by 2002:a17:90a:fa87:: with SMTP id cu7mr291318pjb.92.1587071129331;
        Thu, 16 Apr 2020 14:05:29 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.171])
        by smtp.gmail.com with ESMTPSA id x18sm10524090pfi.22.2020.04.16.14.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:05:28 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, peff@peff.net, heba.waly@gmail.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH 1/2] submodule.c: update URL in .gitmodules using update_url_in_gitmodules
Date:   Fri, 17 Apr 2020 02:34:55 +0530
Message-Id: <20200416210456.19122-2-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200416210456.19122-1-shouryashukla.oo@gmail.com>
References: <20200416210456.19122-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a helper function update_url_in_gitmodules() to update URL
of an entry in .gitmodules. Later on, we want to use this function
to aid in the conversion of 'set-url' from shell to C.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 submodule.c | 33 +++++++++++++++++++++++++++++++++
 submodule.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/submodule.c b/submodule.c
index c3aadf3fff..0b599dc4e1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -126,6 +126,39 @@ int update_path_in_gitmodules(const char *oldpath, const char *newpath)
 	return ret;
 }
 
+/*
+ * Try to update the "url" entry in the "submodule.<name>" section of the
+ * .gitmodules file. Return 0 only if a .gitmodules file was found, a section
+ * with the correct url=<oldurl> setting was found and we could update it.
+ */
+int update_url_in_gitmodules(const char *path, const char *newurl)
+{
+	struct strbuf entry = STRBUF_INIT;
+	const struct submodule *submodule;
+	int ret;
+
+	/* Do nothing without .gitmodules */
+	if (!file_exists(GITMODULES_FILE))
+		return -1;
+
+	if (is_gitmodules_unmerged(the_repository->index))
+		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
+
+	submodule = submodule_from_path(the_repository, &null_oid, path);
+	if (!submodule || !submodule->name) {
+		warning(_("Could not find section in .gitmodules where path=%s"), path);
+		return -1;
+	}
+	
+	strbuf_addstr(&entry, "submodule.");
+	strbuf_addstr(&entry, submodule->name);
+	strbuf_addstr(&entry, ".url");
+	ret = config_set_in_gitmodules_file_gently(entry.buf, newurl);
+	strbuf_release(&entry);
+	
+	return ret;
+}
+
 /*
  * Try to remove the "submodule.<name>" section from .gitmodules where the given
  * path is configured. Return 0 only if a .gitmodules file was found, a section
diff --git a/submodule.h b/submodule.h
index 4dad649f94..ea09480433 100644
--- a/submodule.h
+++ b/submodule.h
@@ -49,6 +49,8 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *,
 					     const char *path);
 int git_default_submodule_config(const char *var, const char *value, void *cb);
 
+int update_url_in_gitmodules(const char* path, const char *newurl);
+
 struct option;
 int option_parse_recurse_submodules_worktree_updater(const struct option *opt,
 						     const char *arg, int unset);
-- 
2.20.1

