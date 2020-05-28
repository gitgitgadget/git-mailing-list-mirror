Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A886C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 03:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606042088E
	for <git@archiver.kernel.org>; Thu, 28 May 2020 03:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpGY7C1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgE1D2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 23:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgE1D2k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 23:28:40 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FC6C05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 20:28:40 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u5so12780301pgn.5
        for <git@vger.kernel.org>; Wed, 27 May 2020 20:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M4j9JXs9DNsqY/YXfIue1xgJt8QFTumLCqRD6OeAbXQ=;
        b=JpGY7C1xbE0orXomrzM6aMuFDoHPhEkfzZB10w7Q8OHoJxT4+ZSa2tbvszLY2ZlgGO
         Z2Jj6HGcXD/KBj1MV9kMWKjCz2oLJfqVoK0z1JRyv4HmRQ5ANxCwVAi/k5mTu0+AjdkA
         L57DFL5Qw+nNemVGMlapDOQsf4BBHUnI15cdiUEvT4X7d+ISLZcWjcWD4IR+Y/zcvJtB
         HETArwf8wKrTGsjAfUqP/e4IZB1bTo8Kn2LRwrU0UUbG5hzkTgWSVVqVgntw4qnZ+IUB
         9Q3ZQDkfsBcev65p6LOjrMUkEf3RkKtJK9yeRs7Vu/vViKqgmswx7pnJrL9bVC992j/e
         29eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M4j9JXs9DNsqY/YXfIue1xgJt8QFTumLCqRD6OeAbXQ=;
        b=VihWTP0pS46bS3nfp3h81v+Ul6DXOAVbY/0UWTIZeVuUW87Mj6uGz9ImP16M/q6QT0
         QNfiVS/EMFaeAzTUguoTR0S1lvsGaPKvCYmYf8no7TbHcySLKzDSSpQEEW+1NkY+mEtf
         52yRvDIwosP4txEdY+VNADDspkV0hGPNjFRw6tdYJs/APNXiZu1cctbA75Zn8aCzTijy
         7QLsLJbjIj6eLEqfpAlZZrfHj7DtDM+1UuPS5bvCd3nLvQmYv4TYjwqpCwMvMGJ4gntt
         QUGITWrzPHZEfmnVdmWd12Nwz60UbrqCsGOjRIDaqcHTOH6/8fpyJItvoo7dWJ440FhK
         hzVA==
X-Gm-Message-State: AOAM5315H3IxWmirZqpjO9mgO4ngvejlPRrBjjpxb9ZjdHUA0U5bH3xA
        JrdYxovA6wbwmlSV8HRTd5Sdj2rJ
X-Google-Smtp-Source: ABdhPJwPH0UheMerxoZxWZCitP5t/a/gUYfdrFR0Up5JHrQLcAV9HbqbhCyogd5yAlQ+yvffjbEXGg==
X-Received: by 2002:a62:6041:: with SMTP id u62mr947140pfb.62.1590636520147;
        Wed, 27 May 2020 20:28:40 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id z138sm93724pfc.70.2020.05.27.20.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 20:28:39 -0700 (PDT)
Date:   Wed, 27 May 2020 20:28:37 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Xin Li <delphij@google.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/1] fetch: allow adding a filter after initial clone.
Message-ID: <20200528032837.GE56118@google.com>
References: <20200513234435.GG6605@camp.crustytoothpaste.net>
 <20200528025359.20931-2-delphij@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528025359.20931-2-delphij@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Xin Li wrote:

> Retroactively adding filter can be useful for existing shallow clones as
> they allow users to see earlier change histories without downloading all
> git objects in a regular --unshallow fetch.
>
> Previously this is possible by manually amending the repository
> configuration to make git think there is an existing promisor. Because
> the code already does most of the hard work, it's safer for git to
> just perform the configuration change automatically instead.
>
> Instead of bailing out immediately when no promisor is available, make
> the code check more specific issue (extension became special in
> repository version 1, while it can have any value in version 0, so
> upgrade should not happen if the repository have an unsupported
> configuration that would render it invalid if we upgraded).
>
> Signed-off-by: Xin Li <delphij@google.com>
> ---

nit: the cover letter contains

> Previously, to retroactively add filter to an existing (shallow) clone
> one would have to manually change the repository configuration to make
> git to believe that there was an existing promisor, like:
>
>   git config core.repositoryFormatVersion 1
>   git config extensions.partialClone origin
>   git fetch --unshallow --filter=blob:none origin
>
> Because the code can already set up promisor, it would be safer and more
> convenient to just do that in git itself.
>
> This version of change will also prevent the code from making damaging
> repository upgrades (when non-standard extensions exists) as pointed out
> by earlier reviewers.

I think that would make a good commit message itself.

[...]
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1790,9 +1790,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	if (depth || deepen_since || deepen_not.nr)
>  		deepen = 1;
>  
> -	if (filter_options.choice && !has_promisor_remote())
> -		die("--filter can only be used when extensions.partialClone is set");
> -

Makes sense.

[...]
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -326,7 +326,8 @@ void partial_clone_register(
>  
>  	/* Check if it is already registered */
>  	if (!promisor_remote_find(remote)) {
> -		git_config_set("core.repositoryformatversion", "1");
> +		if (upgrade_repository_format(the_repository, 1) < 0)
> +			die(_("Unable to upgrade repository format to support partial clone"));

nit: Git's error messages tend to use lowercase (e.g., "fatal: cannot [etc]"
instead of "fatal: Unable [etc]").

>  		/* Add promisor config for the remote */
>  		cfg_name = xstrfmt("remote.%s.promisor", remote);

not about this patch: By the way, the repository format version bump
is not sufficient to achieve its intended aim: we also need to set an
extensions.* setting to ensure Git is new enough to know about partial
clone.  More discussion about this is in [1] (apologies for not having
finished solving that).  This isn't a regression introduced in this
patch, and this patch does the right thing in the context of the
current code.

[...]
> --- a/repository.h
> +++ b/repository.h
> @@ -196,4 +196,10 @@ void repo_update_index_if_able(struct repository *, struct lock_file *);
>  
>  void prepare_repo_settings(struct repository *r);
>  
> +/*
> + * Return 1 if upgrade repository format to target_version succeeded,
> + * 0 if no upgrade is necessary.
> + */

Probably also worth mentioning that this returns -1 on error.

> +int upgrade_repository_format(struct repository *r, int target_version);
> +
>  #endif /* REPOSITORY_H */
[...]
> +++ b/setup.c
> @@ -538,6 +538,36 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
>  	return 0;
>  }
>  
> +int upgrade_repository_format(struct repository *r, int target_version)
> +{
> +	const char *gitdir = get_git_dir();

Unused variable.

> +	struct strbuf sb = STRBUF_INIT;
> +	struct strbuf err = STRBUF_INIT;
> +	struct strbuf repo_version = STRBUF_INIT;
> +	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
> +
> +	strbuf_git_common_path(&sb, r, "/config");

nit: can leave out the '/' to avoid a double-/.

> +	read_repository_format(&repo_fmt, sb.buf);
> +	strbuf_release(&sb);
> +
> +	if (repo_fmt.version >= target_version)
> +		return 0;
> +
> +	repo_fmt.version = target_version;
> +
> +	if (verify_repository_format(&repo_fmt, &err) < 0) {
> +		warning("Unable to upgrade repository format to %d: %s",

Same nit about capitalization.

> +		    target_version, err.buf);

whitespace nit: this would typically use a tab, to line up with the
paren on the previous line.

> +		strbuf_release(&err);
> +		return -1;
> +	}
> +
> +	strbuf_addf(&repo_version, "%d", target_version);
> +	git_config_set("core.repositoryformatversion", repo_version.buf);

Ah, I think I misled you: the config_set API hasn't learned to take a
struct repository yet, so we should hardcode the_repository in this
function instead of taking a "struct repository" parameter.

> +	strbuf_release(&repo_version);
> +	return 1;
> +}
> +
>  static void init_repository_format(struct repository_format *format)
>  {
>  	const struct repository_format fresh = REPOSITORY_FORMAT_INIT;
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index a3988bd4b8..71270d3a53 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -30,6 +30,27 @@ test_expect_success 'extensions.partialclone without filter' '
>  	git -C client fetch origin
>  '
>  
> +test_expect_success 'convert shallow clone to partial clone' '
> +	rm -fr server client &&
> +	test_create_repo server &&
> +	test_commit -C server my_commit 1 &&
> +	test_commit -C server my_commit2 1 &&
> +	git clone --depth=1 "file://$(pwd)/server" client &&
> +	git -C client fetch --unshallow --filter="blob:none" &&
> +	test_cmp_config -C client true remote.origin.promisor &&
> +	test_cmp_config -C client blob:none remote.origin.partialclonefilter &&
> +	test_cmp_config -C client 1 core.repositoryformatversion
> +'

nit: Missing blank line.

Is there a different check this test could perform to check the
user-facing behavior instead of how the configuration is encoded?

> +test_expect_success 'convert shallow clone to partial clone must fail with invalid extension' '
> +	rm -fr server client &&
> +	test_create_repo server &&
> +	test_commit -C server my_commit 1 &&
> +	test_commit -C server my_commit2 1 &&
> +	git clone --depth=1 "file://$(pwd)/server" client &&
> +	git -C client config extensions.sandwidth true &&
> +	test_must_fail git -C client fetch --unshallow --filter="blob:none"
> +'
> +
>  test_expect_success 'missing reflog object, but promised by a commit, passes fsck' '
>  	rm -rf repo &&
>  	test_create_repo repo &&

With whatever subset of the mentioned changes makes sense,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

[1] https://lore.kernel.org/git/20200312230931.GF120942@google.com/.

diff --git i/list-objects-filter-options.c w/list-objects-filter-options.c
index 6d62b60eaca..ce9193c3885 100644
--- i/list-objects-filter-options.c
+++ w/list-objects-filter-options.c
@@ -326,8 +326,8 @@ void partial_clone_register(
 
 	/* Check if it is already registered */
 	if (!promisor_remote_find(remote)) {
-		if (upgrade_repository_format(the_repository, 1) < 0)
-			die(_("Unable to upgrade repository format to support partial clone"));
+		if (upgrade_repository_format(1) < 0)
+			die(_("cannot enable partial clone support"));
 
 		/* Add promisor config for the remote */
 		cfg_name = xstrfmt("remote.%s.promisor", remote);
diff --git i/repository.h w/repository.h
index f301f6f4562..14574c6e627 100644
--- i/repository.h
+++ w/repository.h
@@ -197,9 +197,10 @@ void repo_update_index_if_able(struct repository *, struct lock_file *);
 void prepare_repo_settings(struct repository *r);
 
 /*
- * Return 1 if upgrade repository format to target_version succeeded,
- * 0 if no upgrade is necessary.
+ * Upgrade the repository format to target_version.
+ * Returns 1 on success, 0 if no upgrade was necessary, and -1 after
+ * printing a diagnostic on error.
  */
-int upgrade_repository_format(struct repository *r, int target_version);
+int upgrade_repository_format(int target_version);
 
 #endif /* REPOSITORY_H */
diff --git i/setup.c w/setup.c
index 84da976e077..d1f0aff7d30 100644
--- i/setup.c
+++ w/setup.c
@@ -538,15 +538,14 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	return 0;
 }
 
-int upgrade_repository_format(struct repository *r, int target_version)
+int upgrade_repository_format(int target_version)
 {
-	const char *gitdir = get_git_dir();
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf err = STRBUF_INIT;
 	struct strbuf repo_version = STRBUF_INIT;
 	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
 
-	strbuf_git_common_path(&sb, r, "/config");
+	strbuf_git_common_path(&sb, the_repository, "config");
 	read_repository_format(&repo_fmt, sb.buf);
 	strbuf_release(&sb);
 
@@ -556,8 +555,8 @@ int upgrade_repository_format(struct repository *r, int target_version)
 	repo_fmt.version = target_version;
 
 	if (verify_repository_format(&repo_fmt, &err) < 0) {
-		warning("Unable to upgrade repository format to %d: %s",
-		    target_version, err.buf);
+		warning("cannot upgrade repository format to %d: %s",
+			target_version, err.buf);
 		strbuf_release(&err);
 		return -1;
 	}
diff --git i/t/t0410-partial-clone.sh w/t/t0410-partial-clone.sh
index 71270d3a539..d580488330f 100755
--- i/t/t0410-partial-clone.sh
+++ w/t/t0410-partial-clone.sh
@@ -41,6 +41,7 @@ test_expect_success 'convert shallow clone to partial clone' '
 	test_cmp_config -C client blob:none remote.origin.partialclonefilter &&
 	test_cmp_config -C client 1 core.repositoryformatversion
 '
+
 test_expect_success 'convert shallow clone to partial clone must fail with invalid extension' '
 	rm -fr server client &&
 	test_create_repo server &&
