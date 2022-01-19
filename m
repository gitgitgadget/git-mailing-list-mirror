Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE36C433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 16:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355844AbiASQGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 11:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbiASQGR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 11:06:17 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC61C061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 08:06:17 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id u18so103935edt.6
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 08:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=fSwK7+POy93Al5+4qWaYAeesdRHNJyJ6SabJMS0dxt0=;
        b=IqVGmkxuggVWwcdYsDe3l71pPMCCdrvUFALdtj66Dx7oZB4gVqc6IZVtX1YL9NE2s4
         /Ajdyg+doE/1GtKAjD8PU8imvwHY+JT9mWkbu4oSRIrMFAzMEc3lyf76gQYcBygt592k
         HpUsCC6OH3M8FCdjJxtduOeBIfnuqZ46CGz/jzNu56F6skeUQb6pCr9LYeCoj0b7lS0+
         HmuOBrQIEuKW7gglAC3Y7OJXfQ11JkGOaq5nIL+fXC5jXx2wLCyTZRL2avyXEScxDL2q
         9YFL4vtnqjfqIcIUPbgU3fDwRRhV6M61DcMKVt7uhu55dzAbcaRvQrKWYIN5Ua1YfPt1
         zfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=fSwK7+POy93Al5+4qWaYAeesdRHNJyJ6SabJMS0dxt0=;
        b=o4tewcI+igja524PWfME4FLPrQOhGAcdYWjlY7xDrIknEbeyARGAy972R+dq0/eMPw
         rSKPNXDQyUp/etbd7tuCKT4vYL4oBqs8lzkCVkKMlmMKcjLkIZIiL0c3l/o+e0HAVpqX
         Rt6UNDkD8Nj51c7g9lM0z/FnseSUtAQvQLNHlKgNwv8UtDiVOs++U3luftX08ELzR0+S
         Gs9yLMkgBex+Bj1djCxYiPiGMrlgLsoSkHLqn4XfG5+l3X0AO/zHp9I6hv8f7EefCV4u
         I7EfWNjTc6SDOXIqotQ+N4cTolTzsL1MZgawsXwSdKkNlB46snXzubzk26ByUJbhn0CN
         v72g==
X-Gm-Message-State: AOAM530V0HV3K5EtyuOTcaiHfeKNbxSXqXJlCF94qjmEJe0WS73IAJvB
        e8WQf5c81wDLhun6B9i5tcIM7XvrdvPb1g==
X-Google-Smtp-Source: ABdhPJywOZkEtwVz8a6/V82DBeABRue+wy34EVvkH/nC5qKs9LHa9GoDclJG2F1zP3AVsN7zrjkjzg==
X-Received: by 2002:a17:906:dc92:: with SMTP id cs18mr13819479ejc.236.1642608370259;
        Wed, 19 Jan 2022 08:06:10 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 5sm79747edx.32.2022.01.19.08.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 08:06:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nADTN-001nx4-0Y;
        Wed, 19 Jan 2022 17:06:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 1/9] show, log: provide a --remerge-diff capability
Date:   Wed, 19 Jan 2022 17:01:12 +0100
References: <pull.1103.v2.git.1640419159.gitgitgadget@gmail.com>
 <pull.1103.v3.git.1640907369.gitgitgadget@gmail.com>
 <d57ae218cf9eaee0b66db299ee1bba9b488b69b1.1640907369.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <d57ae218cf9eaee0b66db299ee1bba9b488b69b1.1640907369.git.gitgitgadget@gmail.com>
Message-ID: <220119.86lezbn21b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 30 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> +	struct tmp_objdir *remerge_objdir = NULL;
> +
> +	if (rev->remerge_diff) {
> +		remerge_objdir = tmp_objdir_create("remerge-diff");
> +		if (!remerge_objdir)
> +			die_errno(_("unable to create temporary object directory"));
> +		tmp_objdir_replace_primary_odb(remerge_objdir, 1);
> +	}

Re the errno feedback on v1
https://lore.kernel.org/git/211221.864k71r6kz.gmgdl@evledraar.gmail.com/
the API might lose the "errno" due to e.g. the remove_dir_recurse()
codepath. This seems like it would take care of that:

diff --git a/builtin/log.c b/builtin/log.c
index 944d9c0d9b5..d4b8b1aa4b6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -424,9 +424,9 @@ static int cmd_log_walk(struct rev_info *rev)
 	int saved_dcctc = 0;
 
 	if (rev->remerge_diff) {
-		rev->remerge_objdir = tmp_objdir_create("remerge-diff");
+		rev->remerge_objdir = tmp_objdir_create_gently("remerge-diff", 0);
 		if (!rev->remerge_objdir)
-			die_errno(_("unable to create temporary object directory"));
+			exit(128);
 		tmp_objdir_replace_primary_odb(rev->remerge_objdir, 1);
 	}
 
diff --git a/tmp-objdir.c b/tmp-objdir.c
index adf6033549e..3c656120003 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -121,19 +121,21 @@ static void env_replace(struct strvec *env, const char *key, const char *val)
 	strvec_pushf(env, "%s=%s", key, val);
 }
 
-static int setup_tmp_objdir(const char *root)
+static int setup_tmp_objdir(const char *root, int quiet)
 {
 	char *path;
 	int ret = 0;
 
 	path = xstrfmt("%s/pack", root);
 	ret = mkdir(path, 0777);
+	if (!quiet && ret < 0)
+		die_errno(_("unable to create temporary object directory '%s'"), path);
 	free(path);
 
 	return ret;
 }
 
-struct tmp_objdir *tmp_objdir_create(const char *prefix)
+struct tmp_objdir *tmp_objdir_create_gently(const char *prefix, int quiet)
 {
 	static int installed_handlers;
 	struct tmp_objdir *t;
@@ -161,6 +163,8 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix)
 	strbuf_grow(&t->path, 1024);
 
 	if (!mkdtemp(t->path.buf)) {
+		if (!quiet)
+			error_errno(_("unable to create temporary directory '%s'"), t->path.buf);
 		/* free, not destroy, as we never touched the filesystem */
 		tmp_objdir_free(t);
 		return NULL;
@@ -173,7 +177,7 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix)
 		installed_handlers++;
 	}
 
-	if (setup_tmp_objdir(t->path.buf)) {
+	if (setup_tmp_objdir(t->path.buf, quiet)) {
 		tmp_objdir_destroy(t);
 		return NULL;
 	}
diff --git a/tmp-objdir.h b/tmp-objdir.h
index 76efc7edee5..5072fb860d9 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -24,8 +24,15 @@ struct tmp_objdir;
 /*
  * Create a new temporary object directory with the specified prefix;
  * returns NULL on failure.
+ *
+ * The tmp_objdir_create() is an a wrapper for
+ * tmp_objdir_create_gently(..., 1).
  */
-struct tmp_objdir *tmp_objdir_create(const char *prefix);
+struct tmp_objdir *tmp_objdir_create_gently(const char *prefix, int quiet);
+static inline struct tmp_objdir *tmp_objdir_create(const char *prefix)
+{
+	return tmp_objdir_create_gently(prefix, 1);
+}
 
 /*
  * Return a list of environment strings, suitable for use with
