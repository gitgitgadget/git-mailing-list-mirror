Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC536C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6959610FE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238633AbhIMTap (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240740AbhIMTan (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:30:43 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AEFC061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:29:27 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id q14so11325172ils.5
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JxtQN0C3fp1fJVAPZaFKkpq8UYXyfl+A2p+H5pfWsko=;
        b=M4xUWTCv/rY5w7mTO53+CB8c7JNQ/po7Y6R2ecux66ld52M8a+3/UTJkbJYcA/geQJ
         wlAwLV4O8x5+0Pi7XQn1OlDMhsC33GNiKzCc8sJYzG60WhzXS0fmHFX8bavWjSJVDrPd
         IDY7XhF4zFPGplTDDiSHQkHz/62LjExiS6qXQcFZah0ijc0fIQ8rvsY07w+RD8iZRbUg
         AhadN8VkyjpM99lvUdmU9qV9gwTWVLimDIie/c5qVP8v65rivFcM9EjQPdme3hJsGzo8
         O8DGkUrAT4xagpk7vWyvkQaUMTJBjcX/ri3+7cpxvbt1CpnrEt22WHan38G99+PFsfPr
         +zJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JxtQN0C3fp1fJVAPZaFKkpq8UYXyfl+A2p+H5pfWsko=;
        b=1gtTkUNCbMTzh7qBEokYxU9pdz1Toa5fA4WwN/klQSXrVPbZQ1pZKYu+7RboI4Hq7x
         vQKJWSDDvsOLI0C4YoOKp+yp+j/WtphMdpG7mkJABCfpB05NtXGw82oprOZlOlts5vSX
         kclCOql0IDUueHpuG/DHMv1HAkSoNsnKvT4dfJAxc537PBQfW1hVM7V3kyWptsxeNw7f
         tKB6OwxTd8ktkNGpiBvz/j1o3hwlksUdpltKVWWb2b5OWP0ozj+UmyKcygrsnIqRCLUT
         T/CS30zvY+QWV5S0RxVv2wM0XGwcMIHcEF4+kwzvyMIwFVIvgqKi4BxiORqdwhCGbEvY
         TGCg==
X-Gm-Message-State: AOAM531rA8WEDTI0+dgjGECJReiKxKm/f3nawSE0wR2IH85p5jNP/lr7
        tlzUUp9a8o4KlAYcEgYukhrFmg==
X-Google-Smtp-Source: ABdhPJwKdI4BYniDHegOqGyLJD7jwxx+fB0edEK8+rYF69U1KJgAy44OUi9l1ZCFZsLKbEfXMlbP6w==
X-Received: by 2002:a05:6e02:1546:: with SMTP id j6mr9259316ilu.154.1631561366464;
        Mon, 13 Sep 2021 12:29:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c11sm4633861ile.22.2021.09.13.12.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 12:29:26 -0700 (PDT)
Date:   Mon, 13 Sep 2021 15:29:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
Subject: Re: [PATCH 1/3] fsck: verify commit graph when implicitly enabled
Message-ID: <YT+mlW851sRyt842@nand.local>
References: <20210913181221.42635-1-chooglen@google.com>
 <20210913181221.42635-2-chooglen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210913181221.42635-2-chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 11:12:19AM -0700, Glen Choo wrote:
> the_repository->settings() is the preferred way to get certain
> settings (such as "core.commitGraph") because it gets default values
> from prepare_repo_settings(). However, cmd_fsck() reads the config
> directly via git_config_get_bool(), which bypasses these default values.
> This causes fsck to ignore the commit graph if "core.commitgraph" is not
> explicitly set in the config, even though commit graph is enabled by
> default.

Small nit; "the_repository->settings()" should be spelled as
"the_repository->settings", since "settings" is not a function.

It may be worth noting that this was totally fine before
core.commitGraph's default changed to true. That happened in 31b1de6a09
(commit-graph: turn on commit-graph by default, 2019-08-13), which is
the first time this sort of regression would have appeared.

>  	if (connectivity_only) {
>  		for_each_loose_object(mark_loose_for_connectivity, NULL, 0);
> @@ -908,7 +909,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>
>  	check_connectivity();
>
> -	if (!git_config_get_bool("core.commitgraph", &i) && i) {
> +	if (the_repository->settings.core_commit_graph) {
>  		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
>  		const char *verify_argv[] = { "commit-graph", "verify", NULL, NULL, NULL };

Here's the main part of your change, which is obviously correct (I'm
glossing over the earlier part where you call prepare_repo_settings();
also required and obviously correct).

> +test_expect_success 'git fsck (ignores commit-graph when config set to false)' '
> +	cd "$TRASH_DIRECTORY/full" &&
> +	git fsck &&
> +	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
> +		"incorrect checksum" &&
> +	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
> +	git -c core.commitGraph=false fsck

Nit; I recommend replacing the `-c` style configuration with
`test_config`, which modifies `$GIT_DIR/config` but only for the
duration of the sub-shell.

> +'
> +
> +test_expect_success 'git fsck (checks commit-graph when config unset)' '
> +	test_when_finished "git config core.commitGraph true" &&

... which would allow you to get rid of something like this (since you
can avoid modifying the state visible outside of this test).

> +	cd "$TRASH_DIRECTORY/full" &&
> +	git fsck &&
> +	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
> +		"incorrect checksum" &&
> +        git config --unset core.commitGraph &&

But I'm not aware of a way to temporarily unset a configuration variable
for the duration of a test, so here I would probably write:

    test_must_fail git -c core.commitGraph= fsck

which Git interprets as "pretend this variable is unset in-core".

Thanks,
Taylor
