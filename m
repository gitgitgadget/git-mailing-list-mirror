Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0402C433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 21:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbiJZVPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 17:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiJZVPN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 17:15:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A26D857F0
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:15:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f23so15443116plr.6
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qFj4GfWPc+Yk5XHwxsP7TdWM+mStCoNNfz0lI2RYPQ=;
        b=J34FWaKPYaLFFjDtot7KgFH0Ew/6mjVtn3sLD7A+ujWrWizrcdtqFpq0dyZYkdicW9
         gUmnnynYwwlC6QQa/8a7xg5pB1La/4OrXnFKf2MwiElk9sK/RX1gsPx2i3c5rPBfsJri
         33Q4Kr1oHAfNsmGMYWKRkSkIQm7nGflDNoi9KtwHKPi5ggBqv332Ja0RJyO53Vy1Th7e
         UFjz1XkXnCj7Y0mdT7rvQ1AqxBaCupgm4gVwQ1imOtuRsPLyZF2+O6nrltjHkr0h6kME
         49qsQTS7bm6kd6pwA/+WeVwVxoDzxcgJsHBhI62odUPAgkPMq5QByVb7GOE5sWehn4BS
         JU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9qFj4GfWPc+Yk5XHwxsP7TdWM+mStCoNNfz0lI2RYPQ=;
        b=rjc5yjmYIne8M5kfzXRBNoq/IlYrnLbNfb/WzfHMpDDbc7MT6KIozpA5pZPSDebHp4
         5vSW8Idn9RxsMwRyFqcSGAdL8+9FnTRIXANOyvGhf3+B09+GnMlLhTZCtPTWfSQOhLWE
         E8VBwmCkwqftUvGm9sZhOAWTHC6dNqEYymS3HzCiIlWqwv8+OQyMBu2JMRadBI+ZeowR
         Ybk0tDdlgghoxUG5SOEHUdZveb0oNTKObjRxKNIj8VAp/XFpFOK4N1slv+WBGLB9nKu7
         XY1le+eJq/9qUixy/q9nmnUMxpn5Ju5GvH7zvkHk1rR2hiB2SMQc7vggOTSuTyK/6Kdk
         63mQ==
X-Gm-Message-State: ACrzQf10WLxH5qmdbEXiD4Z9F7eVmNEts0tTw3YiMOhIlhSSH+r5mhDf
        fxlGXyiFWg+cTh5Ax6N3Juc=
X-Google-Smtp-Source: AMsMyM4/vy4SPX0vmBTsxmoY4tq3Wz/RlKU0BSNdiSzWeRdu7FHedbfobwsebjNkrsxz5HhDlFIh/A==
X-Received: by 2002:a17:90b:1c06:b0:20a:f070:9f3c with SMTP id oc6-20020a17090b1c0600b0020af0709f3cmr6366791pjb.151.1666818911139;
        Wed, 26 Oct 2022 14:15:11 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709027e0b00b00186e34524e3sm1032977plm.136.2022.10.26.14.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:15:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 2/2] config: let feature.experimental imply
 gc.cruftPacks=true
References: <cover.1666815209.git.me@ttaylorr.com>
        <eb151752b8de355ac334507e57dc95aadc9ef2bf.1666815209.git.me@ttaylorr.com>
Date:   Wed, 26 Oct 2022 14:15:10 -0700
In-Reply-To: <eb151752b8de355ac334507e57dc95aadc9ef2bf.1666815209.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 26 Oct 2022 16:13:41 -0400")
Message-ID: <xmqqfsfaffs1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 243ee85d28..5a84f791ef 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -42,7 +42,7 @@ static const char * const builtin_gc_usage[] = {
>  
>  static int pack_refs = 1;
>  static int prune_reflogs = 1;
> -static int cruft_packs = 0;
> +static int cruft_packs = -1;
>  static int aggressive_depth = 50;
>  static int aggressive_window = 250;
>  static int gc_auto_threshold = 6700;
> @@ -593,6 +593,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  	if (prune_expire && parse_expiry_date(prune_expire, &dummy))
>  		die(_("failed to parse prune expiry value %s"), prune_expire);
>  
> +	prepare_repo_settings(the_repository);
> +	if (cruft_packs < 0)
> +		cruft_packs = the_repository->settings.gc_cruft_packs;
> +
>  	if (aggressive) {
>  		strvec_push(&repack, "-f");
>  		if (aggressive_depth > 0)
> @@ -704,7 +708,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  		clean_pack_garbage();
>  	}
>  
> -	prepare_repo_settings(the_repository);

It is curious why we had this call so late in the sequence in the
original.  This is well past what can be reasonably called "start-up".
We have locked the repository, we may have daemonized ourselves, we
may already have packed loose refs and pruned reflogs.  Was that due
to somewhat lazy thinking that the next line is the first one that
requires the repository's settings already prepared, I wonder.

I do not offhand see anything after the location of the new call
above and before this location that may negatively get affected by
making the call to prepare_repo_settings() too early, so this change
should be safe, I guess.

> diff --git a/repo-settings.c b/repo-settings.c
> index e8b58151bc..3021921c53 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -43,6 +43,7 @@ void prepare_repo_settings(struct repository *r)
>  	/* Defaults modified by feature.* */
>  	if (experimental) {
>  		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
> +		r->settings.gc_cruft_packs = 1;
>  	}

OK.

> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index 9110a39088..628dfeb737 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -221,6 +221,11 @@ assert_cruft_pack_exists () {
>  	done <packs
>  }
>  
> +refute_cruft_packs_exist () {
> +	find .git/objects/pack -name "*.mtimes" >mtimes &&
> +	test_must_be_empty mtimes
> +}

Hmph, not "assert_no_cruft_packs"?

>  test_expect_success 'gc --cruft generates a cruft pack' '
>  	test_when_finished "rm -fr crufts" &&
>  	git init crufts &&
> @@ -245,6 +250,42 @@ test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
>  	)
>  '
>  
> +test_expect_success 'feature.experimental=true generates a cruft pack' '
> +	git init crufts &&
> +	test_when_finished "rm -fr crufts" &&
> +	(
> +		cd crufts &&
> +
> +		prepare_cruft_history &&
> +		git -c feature.experimental=true gc &&
> +		assert_cruft_pack_exists
> +	)
> +'

OK.

> +test_expect_success 'feature.experimental=false allows explicit cruft packs' '
> +	git init crufts &&
> +	test_when_finished "rm -fr crufts" &&
> +	(
> +		cd crufts &&
> +
> +		prepare_cruft_history &&
> +		git -c gc.cruftPacks=true -c feature.experimental=false gc &&
> +		assert_cruft_pack_exists
> +	)
> +'

OK.

> +test_expect_success 'feature.experimental=false avoids cruft packs by default' '
> +	git init crufts &&
> +	test_when_finished "rm -fr crufts" &&
> +	(
> +		cd crufts &&
> +
> +		prepare_cruft_history &&
> +		git -c feature.experimental=false gc &&
> +		refute_cruft_packs_exist
> +	)
> +'

OK.

One thing missing is a test for the escape hatch for those who opt
into the experimental world when gc.cruftPacks feature is broken.
IOW,

	git -c feature.experimental=true -c gc.cruftPacks=false

should allow them to opt out of gc.cruftPacks.

Other than that, looking good.

Thanks.

>  run_and_wait_for_auto_gc () {
>  	# We read stdout from gc for the side effect of waiting until the
>  	# background gc process exits, closing its fd 9.  Furthermore, the
