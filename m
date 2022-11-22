Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F43AC433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 01:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiKVB2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 20:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKVB2g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 20:28:36 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D238C8FB2C
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 17:28:35 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id ci10so5767665pjb.1
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 17:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+FXPVeHsjGEHVEA/Ie7+T/rFXcoTODPUI9oentJnbtw=;
        b=CIuIzgt3YMKor0NG2N7kIEO/gvAyjMrm5YOBrha1V6YIskzOpUi/tBI1PKWZ6rmyau
         HH5GUpW1Wi6m37kprFKZzuhkl+fNkqzFyHAfNtuGO2crVwniVHZbGnHBh3W3a0qi/k/n
         mS59NFi0Oe8NaAeHh5yVU6GBQeQShx8QkmDJzMJjnfZzHsfu9IOAz2Ut/XqgvTkXaLU0
         ui+XFv5HzbRLN/nHRoaYG72twxzo7i0VtduZ6ybninR1Z0MjKqMaTMN2W5ZzFmiKMaB8
         UskX1kKcFo2VgsehMz7wrzsc2o4qc3mgnT+LsR+PLaDKKC28iP48QS0YZWLTaetD9m65
         h52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+FXPVeHsjGEHVEA/Ie7+T/rFXcoTODPUI9oentJnbtw=;
        b=nhyZJbfTuR4iri/otgg3OLHncQ+UKcnlmmbsWlABThrhSS6mgxjJhb/dhSgWeOOOxc
         Yl75jxJveGi3OyJ7BZgisvD8ZD6v1kdiN7/5ipKtobZKAXvQ3akI8kvR6z+y0YOh4MKs
         KtiKVsD3HVkKkriGk/Wy9+Uup29WqeinNcyzKjBWkw6eXSt3jJBSGrIm8/yrQ/LjfIJd
         MFEydroVP1OwMRXuU+1a6GP2OgXub4Dl8UTkLOg6C2QW4l+rtO7YKVPNbRN3tNylHutZ
         xrtXoEe0G7cPgoklQ/paWLe7iv8HDWvwkVcPAOOuAMz7avIM9LsTONDd0sFn2B1RJUto
         JVIw==
X-Gm-Message-State: ANoB5pmTVX0ozcoInsCNtA1FrAAjG/SXQ+Uhvrb2/EG80BBtz2IP4Wpb
        atciizEPQ49rx6NPdCRxs3DezXy4ibzbiA==
X-Google-Smtp-Source: AA0mqf6dzCtgJi4SmnRItga8FFiXo2/bexCWmpoRFZefr3GF8YgyTurshGMGATucAacrudk4iiHYpg==
X-Received: by 2002:a17:903:1314:b0:178:2eca:9e1d with SMTP id iy20-20020a170903131400b001782eca9e1dmr14625017plb.43.1669080515166;
        Mon, 21 Nov 2022 17:28:35 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id g16-20020a1709029f9000b00186da904da0sm10422142plq.154.2022.11.21.17.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 17:28:34 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] prune: recursively prune objects directory
References: <20221119201213.2398081-1-e@80x24.org>
        <xmqq5yf8yhe0.fsf@gitster.g> <20221121104427.M268307@dcvr>
        <xmqqpmdgv4it.fsf@gitster.g> <xmqqleo3vraj.fsf@gitster.g>
        <20221122000927.M873500@dcvr>
Date:   Tue, 22 Nov 2022 10:28:34 +0900
In-Reply-To: <20221122000927.M873500@dcvr> (Eric Wong's message of "Tue, 22
        Nov 2022 00:09:27 +0000")
Message-ID: <xmqq7cznu69p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> I am unsure about duplicating ishex() from name-rev.c, however...

Yeah, I wonder why name-rev.c does not use isxdigit() in the first
place.

> ------8<-----
> Subject: [PATCH] prune: recursively prune objects directory
>
> $GIT_DIR/objects/pack may be removed to save inodes in shared
> repositories, so avoid scanning it if it does not exist.  Loose
> object directories ($GIT_DIR/objects/??) may have old temporary
> files, so we now prune those, too.
>
> Recursion is limited to a single level since git doesn't use
> deeper levels.  This avoids the risk of stack overflows via
> infinite recursion when pruning untrusted repos.
>
> We'll also emit the system error in case a directory cannot be
> opened to help users diagnose permissions problems or resource
> constraints.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  builtin/prune.c  | 28 ++++++++++++++++++++--------
>  t/t5304-prune.sh | 16 ++++++++++++++++
>  2 files changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/prune.c b/builtin/prune.c
> index df376b2ed1..0f6a33690a 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -114,25 +114,41 @@ static int prune_subdir(unsigned int nr, const char *path, void *data)
>  	return 0;
>  }
>  
> +/*
> + * XXX ishex is duplicated in builtin/name-rev.c, perhaps git-compat-util.h
> + * is a better home for it
> + */
> +#define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
> +static int is_loose_prefix(const char *d_name)
> +{
> +	return strlen(d_name) == 2 && ishex(d_name[0]) && ishex(d_name[1]);
> +}
> +
>  /*
>   * Write errors (particularly out of space) can result in
>   * failed temporary packs (and more rarely indexes and other
>   * files beginning with "tmp_") accumulating in the object
>   * and the pack directories.
>   */
> -static void remove_temporary_files(const char *path)
> +static void remove_temporary_files(const char *path, int recurse)
>  {
>  	DIR *dir;
>  	struct dirent *de;
>  
>  	dir = opendir(path);
>  	if (!dir) {
> -		fprintf(stderr, "Unable to open directory %s\n", path);
> +		warning_errno(_("unable to open directory %s"), path);
>  		return;
>  	}
>  	while ((de = readdir(dir)) != NULL)
> -		if (starts_with(de->d_name, "tmp_"))
> +		if (starts_with(de->d_name, "tmp_")) {
>  			prune_tmp_file(mkpath("%s/%s", path, de->d_name));
> +		} else if (recurse && (strcmp(de->d_name, "packs") == 0 ||
> +					is_loose_prefix(de->d_name))) {

OK, the intent is to be careful and deal only with the fan-out
directories objects/[0-9a-f]{2}/ and objects/pack/ and leave crufts
in objects/info and any other unknown subdirectories, which makes
sense.

Two nits are:

 - "packs" wants to be "pack".
 - "strcmp() == 0" wants to be "!strcmp()".

> +			char *s = mkpathdup("%s/%s", path, de->d_name);
> +			remove_temporary_files(s, 0);
> +			free(s);
> +		}
>  	closedir(dir);
>  }
>  
> @@ -150,7 +166,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>  			 N_("limit traversal to objects outside promisor packfiles")),
>  		OPT_END()
>  	};
> -	char *s;
>  
>  	expire = TIME_MAX;
>  	save_commit_buffer = 0;
> @@ -186,10 +201,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>  				      prune_cruft, prune_subdir, &revs);
>  
>  	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
> -	remove_temporary_files(get_object_directory());
> -	s = mkpathdup("%s/pack", get_object_directory());
> -	remove_temporary_files(s);
> -	free(s);
> +	remove_temporary_files(get_object_directory(), 1);
>  
>  	if (is_repository_shallow(the_repository)) {
>  		perform_reachability_traversal(&revs);
> diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
> index 8ae314af58..8c2278035e 100755
> --- a/t/t5304-prune.sh
> +++ b/t/t5304-prune.sh
> @@ -29,6 +29,22 @@ test_expect_success setup '
>  	git gc
>  '
>  
> +test_expect_success 'prune stale loose objects' '
> +	mkdir .git/objects/aa &&
> +	>.git/objects/aa/tmp_foo &&
> +	test-tool chmtime =-86501 .git/objects/aa/tmp_foo &&
> +	git prune --expire 1.day &&
> +	test_path_is_missing .git/objects/aa/tmp_foo
> +'
> +
> +test_expect_success 'bare repo prune is quiet without $GIT_DIR/objects/pack' '
> +	git clone -q --shared --template= --bare . bare.git &&
> +	rmdir bare.git/objects/pack &&
> +	git --git-dir=bare.git prune --no-progress 2>prune.err &&
> +	test_must_be_empty prune.err &&
> +	rm -r bare.git prune.err
> +'

Is the last "clean-up" step necessary?

> +
>  test_expect_success 'prune stale packs' '
>  	orig_pack=$(echo .git/objects/pack/*.pack) &&
>  	>.git/objects/tmp_1.pack &&

Other than that, looks like a good idea.

Thanks.
