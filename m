Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC74C433DF
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C7AA20758
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 19:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="0GIECuMj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgGMTIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgGMTIn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 15:08:43 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72CDC061755
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 12:08:42 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id di5so6290610qvb.11
        for <git@vger.kernel.org>; Mon, 13 Jul 2020 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YYSKDJRzc9ePHUby/ufQAENfNT9eDr/XWbOiVL3LetQ=;
        b=0GIECuMjt1NpjHmY295HGIJVE4E/4ZNnm0mqTQXNO/4h3BlQMO4Vf16emptP0dSHfG
         6DVnyS2qXmnAMjljIu2xvIsn3N6pFclRkZNUYLKWfsWCtnvjH9haupDTfdlDraaSV8aC
         6RrBnCJpIgyctkkSO27vlSsAxWUnvpEBKmYkQMADWImnYCERW8QsWpcfrRXkUOB2JpjE
         JmAiOM4Ev9BoVV5s9gwStc6i9dJoc4C2hSukfF7BFK86l4Q7r127fzwF8J/23t8o81+3
         0qAwy3eBxdg+Q9vHaFxvn//4U6az3n6iyvWzxcRJsU12xkMvxTuAUOcN3Tcog1cWX43c
         78xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YYSKDJRzc9ePHUby/ufQAENfNT9eDr/XWbOiVL3LetQ=;
        b=YvSr4QjQY0etx9ufo4tbBqkcKsyZS2uGAmXqe+FX4vjwAGKPm21TnFvPNxceBdXh2d
         KLCvfn2nK8kzrQvETMK6/0aj7NiSTEN7w+FwQ94/RRYXr/3o+K9P+uHg3NVb8uKs4F66
         OXr/6ZkDRIDXoCLWPb1/3JO6JdbcAnlOufhy4NRKLWeW+gkSal6xhScwo2ojmAKYVupW
         HCUQ9kNq3rkVoMinNiDnTFTR1GtWTo8bC4Kup5e/ZiP3kkgEbIoCnc99fqHrEr2YIeKH
         Ae6N9JjgjxnI6SRhFzkqghZzjxz9yC5Aon05Jtl3y6VFZGpJXA6sSUg/9vAvSR9cYdL7
         9KSA==
X-Gm-Message-State: AOAM532uXFDhneL3W2il8SF10U5gBMvTVCchsPhQwY2Nvda0F2fvJvkN
        GXpn37rq7SlWLK0IP4ESfsFMlA==
X-Google-Smtp-Source: ABdhPJwYm63kxVVG3Sq7H+TqsKU7URgVaDXj8OvllYOfJ9csk3QyYUgHDb4QfPY0lU5LcjgM9YUtgg==
X-Received: by 2002:ad4:54af:: with SMTP id r15mr978121qvy.162.1594667321874;
        Mon, 13 Jul 2020 12:08:41 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:7dfb:38dc:7c85:86a3])
        by smtp.gmail.com with ESMTPSA id v62sm20812541qkb.81.2020.07.13.12.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:08:41 -0700 (PDT)
Date:   Mon, 13 Jul 2020 15:08:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git@vger.kernel.org
Subject: Re: [PATCH] fetch: optionally allow disabling FETCH_HEAD update
Message-ID: <20200713190834.GA77607@syl.lan>
References: <20200711204849.khfbyundun7ujqzw@chatter.i7.local>
 <xmqqimetrcay.fsf@gitster.c.googlers.com>
 <20200711211915.h5bdgmbkisyc23m3@chatter.i7.local>
 <xmqqblkkr63u.fsf@gitster.c.googlers.com>
 <20200712202502.x4p2c7rf6ctflt5g@chatter.i7.local>
 <xmqqr1tgpibi.fsf@gitster.c.googlers.com>
 <79a56e7b-3c31-80c0-6a8b-807dcb4d5af3@kdbg.org>
 <xmqqk0z7nxs7.fsf@gitster.c.googlers.com>
 <xmqqft9vnvce.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqft9vnvce.fsf_-_@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 13, 2020 at 11:06:09AM -0700, Junio C Hamano wrote:
> If you run fetch but record the result in remote-tracking branches,
> and either if you do nothing with the fetched refs (e.g. you are
> merely mirroring) or if you always work from the remote-tracking
> refs (e.g. you fetch and then merge origin/branchname separately),
> you can get away without having FETCH_HEAD at all.
>
> Teach "git fetch" a command line option "--[no-]write-fetch-head"
> and "fetch.writeFetchHEAD" configuration variable.  Without either,
> the default is to write FETCH_HEAD, and the usual rule that the
> command line option defeats configured default applies.
>
> Note that under "--dry-run" mode, FETCH_HEAD is never written;
> otherwise you'd see list of objects in the file that you do not
> actually have.
>
> Also note that this option is explicitly passed when "git pull"
> internally invokes "git fetch", so that those who configured their
> "git fetch" not to write FETCH_HEAD would not be able to break the
> cooperation between these two commands.  "git pull" must see what
> "git fetch" got recorded in FETCH_HEAD to work correctly.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>     Junio C Hamano <gitster@pobox.com> writes:
>
>     > Johannes Sixt <j6t@kdbg.org> writes:
>     >
>     >> Nah, really??? It's one of the benefits of git-fetch that it writes
>     >> FETCH_HEAD and the primary reason in many cases where I use the command!
>     >> So, either I don't care that FETCH_HEAD is written, or I do use it. IMO,
>     >> not wanting to write FETCH_HEAD is the odd case and would need a
>     >> configuration tweak, not the other way round.
>     >
>     > Yeah, that's even easier to arrange.
>     >
>     > Just the "--[no-]write-fetch-head" command line option and the
>     > fetch.writeFetchHEAD configuration variable are introduced and left
>     > off by default forever.
>
>     Something like this, perhaps.  Obviously I won't be pushing this
>     topic further while in prerelase freeze, but Konstantin or
>     anybody else interested can locally apply the patch to their own
>     copy of Git to test it out.
>
>     Thanks.
>
>  builtin/fetch.c  | 19 ++++++++++++++++---
>  builtin/pull.c   |  3 ++-
>  t/t5510-fetch.sh | 39 +++++++++++++++++++++++++++++++++++++--
>  3 files changed, 55 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 82ac4be8a5..3ccf69753f 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -56,6 +56,7 @@ static int prune_tags = -1; /* unspecified */
>  #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
>
>  static int all, append, dry_run, force, keep, multiple, update_head_ok;
> +static int write_fetch_head = 1;
>  static int verbosity, deepen_relative, set_upstream;
>  static int progress = -1;
>  static int enable_auto_gc = 1;
> @@ -118,6 +119,10 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
>  		return 0;
>  	}
>
> +	if (!strcmp(k, "fetch.writefetchhead")) {
> +		write_fetch_head = git_config_bool(k, v);
> +		return 0;
> +	}
>  	return git_default_config(k, v, cb);
>  }
>
> @@ -162,6 +167,8 @@ static struct option builtin_fetch_options[] = {
>  		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
>  	OPT_BOOL(0, "dry-run", &dry_run,
>  		 N_("dry run")),
> +	OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
> +		 N_("write fetched references to the FETCH_HEAD file")),
>  	OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
>  	OPT_BOOL('u', "update-head-ok", &update_head_ok,
>  		    N_("allow updating of HEAD ref")),
> @@ -893,7 +900,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  	const char *what, *kind;
>  	struct ref *rm;
>  	char *url;
> -	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head(the_repository);
> +	const char *filename = (!write_fetch_head
> +				? "/dev/null"
> +				: git_path_fetch_head(the_repository));

Ah, because dry_run ==> !write_fetch_head, so this is an equivalent
translation. Makes sense.

>  	int want_status;
>  	int summary_width = transport_summary_width(ref_map);
>
> @@ -1327,7 +1336,7 @@ static int do_fetch(struct transport *transport,
>  	}
>
>  	/* if not appending, truncate FETCH_HEAD */
> -	if (!append && !dry_run) {
> +	if (!append && write_fetch_head) {
>  		retcode = truncate_fetch_head();
>  		if (retcode)
>  			goto cleanup;
> @@ -1594,7 +1603,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
>  	int i, result = 0;
>  	struct argv_array argv = ARGV_ARRAY_INIT;
>
> -	if (!append && !dry_run) {
> +	if (!append && write_fetch_head) {
>  		int errcode = truncate_fetch_head();
>  		if (errcode)
>  			return errcode;
> @@ -1795,6 +1804,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	if (depth || deepen_since || deepen_not.nr)
>  		deepen = 1;
>
> +	/* FETCH_HEAD never gets updated in --dry-run mode */
> +	if (dry_run)
> +		write_fetch_head = 0;
> +
>  	if (all) {
>  		if (argc == 1)
>  			die(_("fetch --all does not take a repository argument"));
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 8159c5d7c9..e988d92b53 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -527,7 +527,8 @@ static int run_fetch(const char *repo, const char **refspecs)
>  	struct argv_array args = ARGV_ARRAY_INIT;
>  	int ret;
>
> -	argv_array_pushl(&args, "fetch", "--update-head-ok", NULL);
> +	argv_array_pushl(&args, "fetch", "--update-head-ok",
> +			 "--write-fetch-head", NULL);

...and here we pass '--write-fetch-head' explicitly, because we don't
want a user who has set 'fetch.writeFetchHead' to 'false' to suddenly
have their 'git pull's stop working. Makes sense.

>
>  	/* Shared options */
>  	argv_push_verbosity(&args);
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index a66dbe0bde..3052c2d8d5 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -539,13 +539,48 @@ test_expect_success 'fetch into the current branch with --update-head-ok' '
>
>  '
>
> -test_expect_success 'fetch --dry-run' '
> -
> +test_expect_success 'fetch --dry-run does not touch FETCH_HEAD' '
>  	rm -f .git/FETCH_HEAD &&
>  	git fetch --dry-run . &&
>  	! test -f .git/FETCH_HEAD
>  '
>
> +test_expect_success '--no-write-fetch-head does not touch FETCH_HEAD' '
> +	rm -f .git/FETCH_HEAD &&
> +	git fetch --no-write-fetch-head . &&
> +	! test -f .git/FETCH_HEAD
> +'
> +
> +test_expect_success '--write-fetch-head gets defeated by --dry-run' '
> +	rm -f .git/FETCH_HEAD &&
> +	git fetch --dry-run --write-fetch-head . &&
> +	! test -f .git/FETCH_HEAD
> +'
> +
> +test_expect_success 'fetch.writeFetchHEAD and FETCH_HEAD' '
> +	rm -f .git/FETCH_HEAD &&
> +	git -c fetch.writeFetchHEAD=no fetch . &&
> +	! test -f .git/FETCH_HEAD
> +'
> +
> +test_expect_success 'fetch.writeFetchHEAD gets defeated by --dry-run' '
> +	rm -f .git/FETCH_HEAD &&
> +	git -c fetch.writeFetchHEAD=yes fetch --dry-run . &&
> +	! test -f .git/FETCH_HEAD
> +'
> +
> +test_expect_success 'fetch.writeFetchHEAD and --no-write-fetch-head' '
> +	rm -f .git/FETCH_HEAD &&
> +	git -c fetch.writeFetchHEAD=yes fetch --no-write-fetch-head . &&
> +	! test -f .git/FETCH_HEAD
> +'
> +
> +test_expect_success 'fetch.writeFetchHEAD and --write-fetch-head' '
> +	rm -f .git/FETCH_HEAD &&
> +	git -c fetch.writeFetchHEAD=no fetch --write-fetch-head . &&
> +	test -f .git/FETCH_HEAD
> +'
> +
>  test_expect_success "should be able to fetch with duplicate refspecs" '
>  	mkdir dups &&
>  	(

Test coverage all looks good, thanks for working on this. I don't think
there's anything left, so this would be great after 2.28 is released.

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

> --
> 2.28.0-rc0
>

Thanks,
Taylor
