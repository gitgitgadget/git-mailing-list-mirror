Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736EFC2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 12:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51565613EF
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 12:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhFNM41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 08:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbhFNM4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 08:56:25 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FEBC061574
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 05:54:23 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so10006950pjs.2
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 05:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gEd4LDoOEZO/KgwnbaxLFki+yGaphBvkUBiW4Xg0YZY=;
        b=EKqKxXOJzUYF39oVJgebBTqxReCWC3kdE/c5dARsWcBG4H5jD4IgpFfUC60NNGU9xP
         G0Ufz2ZGhyc5y+AodUd0HqnenBdQ+Dvm6RD0eODTmiX0nMba+rb0oDhjQHZW1Epd0sdo
         EAqLaagI+wbbpuXMQNtKUXnhPoERV7hzBK2JLXlTIFDH5r6TgsyDS/Nl8cT35hHK/xMc
         1W7pLoEv0wATKwGFY8oHJgdfZl5dbCGmYKniKdxa/a7UkxU9gweQSPXDo0gAbd1ldUYt
         0o4z4BUQk8wDdq7qdBOHopjrMHWBUmvdKmQRp/P67zvRf+JADZ0uC/lnrz1Dc/mTDAfb
         MCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gEd4LDoOEZO/KgwnbaxLFki+yGaphBvkUBiW4Xg0YZY=;
        b=l3CeBlMECtGslQhWoTBg76HlzZm+ImoJZFgXcPZaaNnGJ58ZVK7mcwiL1HRvc7ZBPk
         fZcMKNasHGUvfz09MucfguKfKEmcZemm8ZKO6Z3ZKd10jUOd/7/2iuzWG2JDt6YD8Vy8
         RoHwmLi7agNuMAQHHtqFssKBC0y91m1M9JRxRuE/OsGJjEbFQhbP4FRbJOYq1YV17Xdb
         horLuA5ngPt23gCNlQWq78+cNjlVmF73vgoPw2CWoMuAbX7uzjmD0l7bVZXAphntKhwq
         wk0f6SKn0qfQEqPyXns0rbowc+9ozNiU96VU5MSOd/6EE8iu/vxTWQ54ke9xDKE0QODE
         3EHg==
X-Gm-Message-State: AOAM5311QZ7Sg4mbW9XzJavNlfagvIuShwHN+Qz/zi0Tc5qveHbUNsGD
        ZJGQ54zUdqML+9Riy7RdUlgY+laIykkxpkzJqtU=
X-Google-Smtp-Source: ABdhPJytYfaqjsjBZNpa8pkw/52A6GTZAbjaAk6L4VI+OK4hK1Yxmn23X2fAd1PS685HOLegTfd7UA==
X-Received: by 2002:a17:90a:f0d5:: with SMTP id fa21mr19182945pjb.4.1623675262391;
        Mon, 14 Jun 2021 05:54:22 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id k9sm12907085pgq.27.2021.06.14.05.54.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jun 2021 05:54:21 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC] [PATCH v4 0/3] submodule--helper: introduce subcommands for sh to C conversion
Date:   Mon, 14 Jun 2021 18:21:54 +0530
Message-Id: <20210614125157.99426-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610083916.96243-1-raykar.ath@gmail.com>
References: <20210610083916.96243-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version modifies 'module_clone()' and separates the flag parsing from the
actual cloning logic. This allows us to use the functionality of
'submodule--helper clone' without needing to push arguments to a strvec from
'add_submodule'. We use a new struct called `module_clone_data` instead.

Because this change involves moving the contents of 'module_clone()' to
'clone_submodule()', the whole function had to be relocated further down so that
all the helpers it calls are available to it.

Other changes include making error output match more closely to the shell
version, and better usage of the C API
('is_directory()' -> 'is_nonbare_repo_dir()')

Atharva Raykar (3):
  submodule--helper: refactor module_clone()
  submodule--helper: introduce add-clone subcommand
  submodule--helper: introduce add-config subcommand

 builtin/submodule--helper.c | 536 ++++++++++++++++++++++++++++--------
 git-submodule.sh            |  66 +----
 2 files changed, 425 insertions(+), 177 deletions(-)

Range-diff against v3:
-:  ---------- > 1:  11d035ce75 submodule--helper: refactor module_clone()
1:  3b5f7bec7c ! 2:  c85701b79a submodule--helper: introduce add-clone subcommand
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +static int add_submodule(const struct add_data *add_data)
     +{
     +	char *submod_gitdir_path;
    ++	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
     +
     +	/* perhaps the path already exists and is already a git repo, else clone it */
     +	if (is_directory(add_data->sm_path)) {
    ++		struct strbuf sm_path = STRBUF_INIT;
    ++		strbuf_addstr(&sm_path, add_data->sm_path);
     +		submod_gitdir_path = xstrfmt("%s/.git", add_data->sm_path);
    -+		if (is_directory(submod_gitdir_path) || file_exists(submod_gitdir_path))
    -+			printf(_("Adding existing path at '%s' to index\n"),
    ++		if (is_nonbare_repository_dir(&sm_path))
    ++			printf(_("Adding existing repo at '%s' to the index\n"),
     +			       add_data->sm_path);
     +		else
     +			die(_("'%s' already exists and is not a valid git repo"),
     +			    add_data->sm_path);
    ++		strbuf_release(&sm_path);
     +		free(submod_gitdir_path);
     +	} else {
    -+		struct strvec clone_args = STRVEC_INIT;
     +		struct child_process cp = CHILD_PROCESS_INIT;
     +		submod_gitdir_path = xstrfmt(".git/modules/%s", add_data->sm_name);
     +
     +		if (is_directory(submod_gitdir_path)) {
     +			if (!add_data->force) {
    -+				error(_("a git directory for '%s' is found "
    -+					"locally with remote(s):"), add_data->sm_name);
    ++				fprintf(stderr, _("A git directory for '%s' is found "
    ++						  "locally with remote(s):"),
    ++					add_data->sm_name);
     +				show_fetch_remotes(stderr, add_data->sm_name,
     +						   submod_gitdir_path);
    -+				fprintf(stderr,
    -+					_("If you want to reuse this local git "
    -+					  "directory instead of cloning again from\n"
    -+					  "  %s\n"
    -+					  "use the '--force' option. If the local git "
    -+					  "directory is not the correct repo\n"
    -+					  "or if you are unsure what this means, choose "
    -+					  "another name with the '--name' option.\n"),
    -+					add_data->realrepo);
     +				free(submod_gitdir_path);
    -+				return 1;
    ++				die(_("If you want to reuse this local git "
    ++				      "directory instead of cloning again from\n"
    ++				      "  %s\n"
    ++				      "use the '--force' option. If the local git "
    ++				      "directory is not the correct repo\n"
    ++				      "or if you are unsure what this means, choose "
    ++				      "another name with the '--name' option.\n"),
    ++				    add_data->realrepo);
     +			} else {
     +				printf(_("Reactivating local git directory for "
     +					 "submodule '%s'\n"), add_data->sm_name);
    @@ builtin/submodule--helper.c: static int module_set_branch(int argc, const char *
     +		}
     +		free(submod_gitdir_path);
     +
    -+		strvec_pushl(&clone_args, "clone", "--path", add_data->sm_path, "--name",
    -+			     add_data->sm_name, "--url", add_data->realrepo, NULL);
    -+		if (add_data->quiet)
    -+			strvec_push(&clone_args, "--quiet");
    -+		if (add_data->progress)
    -+			strvec_push(&clone_args, "--progress");
    -+		if (add_data->prefix)
    -+			strvec_pushl(&clone_args, "--prefix", add_data->prefix, NULL);
    ++		clone_data.prefix = add_data->prefix;
    ++		clone_data.path = add_data->sm_path;
    ++		clone_data.name = add_data->sm_name;
    ++		clone_data.url = add_data->realrepo;
    ++		clone_data.quiet = add_data->quiet;
    ++		clone_data.progress = add_data->progress;
     +		if (add_data->reference_path)
    -+			strvec_pushl(&clone_args, "--reference",
    -+				     add_data->reference_path, NULL);
    -+		if (add_data->dissociate)
    -+			strvec_push(&clone_args, "--dissociate");
    ++			string_list_append(&clone_data.reference,
    ++					   xstrdup(add_data->reference_path));
    ++		clone_data.dissociate = add_data->dissociate;
     +		if (add_data->depth >= 0)
    -+			strvec_pushf(&clone_args, "--depth=%d", add_data->depth);
    ++			clone_data.depth = xstrfmt("%d", add_data->depth);
     +
    -+		if (module_clone(clone_args.nr, clone_args.v, add_data->prefix)) {
    -+			strvec_clear(&clone_args);
    ++		if (clone_submodule(&clone_data))
     +			return -1;
    -+		}
    -+		strvec_clear(&clone_args);
     +
     +		prepare_submodule_repo_env(&cp.env_array);
     +		cp.git_cmd = 1;
2:  a2a6b4d74c = 3:  6532b4ae11 submodule--helper: introduce add-config subcommand
-- 
2.31.1

