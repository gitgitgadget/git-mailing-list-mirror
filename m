Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CCDC433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 00:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44DD613F9
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 00:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhD2AgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 20:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbhD2AgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 20:36:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F314AC06138B
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 17:35:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l4so97204648ejc.10
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 17:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=z1wAYxrd4/6iEEbHL+LId7QejR8wCbKh3ShaDwSGO3I=;
        b=j5mFeuVPkZ5fD11DkpAOkXrmcicbCv2oKXDS1VF24RE0wP3iQ2HjY8sMJqX05L2fRg
         xh4MGSIwVDkdEE8yDLBVO26MWIaT+eWW4KOujyAQyMQRjPXZ4Hx6Jpaw446xuXMkj++P
         4vn11gWeVur+naTgFMivYsbA9kNaaRJq5WbCb+c/5rcf5vnDJXxHi8MqzWVZjsLmiWUV
         OcJ75hMBeEie4shaUsb+rl2mu11uw2tAb4TtCFPzH38WiHkrfc1FNVUuRd4bzlgYNluG
         x5N5bmRiCmix2pFAum1+2pkT0qJf9B2aCtTzAfRsWrnQFjofiNrbJ/ND/IO4zEZYJadB
         vOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=z1wAYxrd4/6iEEbHL+LId7QejR8wCbKh3ShaDwSGO3I=;
        b=GB1qxK0IZs1zrca1Vqwa4Ga3G4VIh1flWo1HRMxDhQ21Q7bK6Q0qeYWt0cIJOrGaeb
         z3ypomNSCppuhZy41BhiojWCXHEFAN7HXXqk54/hQMFC9RoZgolD6xgAkdIppcCISUFQ
         R538YDWDePQUsLphXbz0MNvvVyd/qlBECqaC6Yvkark/7iifARVE+xqjeOKGJjsWHnVC
         FON6eKlx0v+auCzjQFrNtm3yLHbImhdo62gwdmJBh8iBm1m8ezAL28EE+d3JJXxH5KOs
         P+xuVs6zmIl9eq5W5LX2mlV79rNtan26PPIhXfC0GTT4qSs2TeHDjpYYJj48TrLngG9k
         9Nmg==
X-Gm-Message-State: AOAM532DyxvX5zbBJbPUk3vU8brXdzQkGLZeiOqYAVimTr2qfiMLmiwE
        yAzxNmyMSYOTOV8mEEwJZ/wwwoYQcaLcSw==
X-Google-Smtp-Source: ABdhPJxitiWbgrm71YFzYw3WIv0bLDIR2M1oHjlfSQ1HYaDfP41Krfb0yJ8W8+IRaxCZ/DvmGxQUeQ==
X-Received: by 2002:a17:906:f8d9:: with SMTP id lh25mr13437223ejb.88.1619656520350;
        Wed, 28 Apr 2021 17:35:20 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id rs8sm810868ejb.17.2021.04.28.17.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 17:35:19 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, ross@skydio.com,
        abe@skydio.com, brian.kubisiak@skydio.com
Subject: Re: [PATCH V2] git-apply: add --allow-empty flag
Date:   Thu, 29 Apr 2021 02:32:53 +0200
References: <20210427011246.28054-1-jerry@skydio.com>
 <20210427194049.14399-1-jerry@skydio.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210427194049.14399-1-jerry@skydio.com>
Message-ID: <878s52ylko.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Jerry Zhang wrote:

> Some users or scripts will pipe "git diff"
> output to "git apply" when replaying diffs
> or commits. In these cases, they will rely
> on the return value of "git apply" to know
> whether the diff was applied successfully.
>
> However, for empty commits, "git apply" will
> fail. This complicates scripts since they
> have to either buffer the diff and check
> its length, or run diff again with "exit-code",
> essentially doing the diff twice.
>
> Add the "--allow-empty" flag to "git apply"
> which allows it to handle both empty diffs
> and empty commits created by "git format-patch
> --always" by doing nothing and returning 0.
>
> Add tests for both with and without --allow-empty.
>
> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> ---
> This patch applies on top of "git-apply: add --quiet flag".
> The conflict is in Documentation -> Synopsis and is
> trivial to solve.
>
> V1 -> V2:
> - Moved behavior under a flag
> - Added tests for both cases
>
>  Documentation/git-apply.txt |  6 +++++-
>  apply.c                     |  8 ++++++--
>  apply.h                     |  1 +
>  t/t4126-apply-empty.sh      | 16 ++++++++++++++++
>  4 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index a32ad64718..b6d77f4206 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -16,7 +16,7 @@ SYNOPSIS
>  	  [--ignore-space-change | --ignore-whitespace]
>  	  [--whitespace=(nowarn|warn|fix|error|error-all)]
>  	  [--exclude=<path>] [--include=<path>] [--directory=<root>]
> -	  [--verbose | --quiet] [--unsafe-paths] [<patch>...]
> +	  [--verbose | --quiet] [--unsafe-paths] [--allow-empty] [<patch>...]
>  
>  DESCRIPTION
>  -----------
> @@ -256,6 +256,10 @@ When `git apply` is used as a "better GNU patch", the user can pass
>  the `--unsafe-paths` option to override this safety check.  This option
>  has no effect when `--index` or `--cached` is in use.
>  
> +--allow-empty::
> +	Don't return error for patches containing no diff. This includes
> +	empty patches and patches with commit text only.
> +
>  CONFIGURATION
>  -------------
>  
> diff --git a/apply.c b/apply.c
> index 918e0988bb..0ddde5e8a8 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4732,8 +4732,10 @@ static int apply_patch(struct apply_state *state,
>  	}
>  
>  	if (!list && !skipped_patch) {
> -		error(_("unrecognized input"));
> -		res = -128;
> +		if (!state->allow_empty) {
> +			error(_("unrecognized input"));
> +			res = -128;
> +		}
>  		goto end;
>  	}
>  
> @@ -5061,6 +5063,8 @@ int apply_parse_options(int argc, const char **argv,
>  		OPT_CALLBACK(0, "directory", state, N_("root"),
>  			N_("prepend <root> to all filenames"),
>  			apply_option_parse_directory),
> +		OPT_BOOL(0, "allow-empty", &state->allow_empty,
> +			N_("don't return error for empty patches")),
>  		OPT_END()
>  	};
>  
> diff --git a/apply.h b/apply.h
> index da3d95fa50..16202da160 100644
> --- a/apply.h
> +++ b/apply.h
> @@ -66,6 +66,7 @@ struct apply_state {
>  	int threeway;
>  	int unidiff_zero;
>  	int unsafe_paths;
> +	int allow_empty;
>  
>  	/* Other non boolean parameters */
>  	struct repository *repo;
> diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
> index ceb6a79fe0..f89c53c5f6 100755
> --- a/t/t4126-apply-empty.sh
> +++ b/t/t4126-apply-empty.sh
> @@ -31,6 +31,22 @@ test_expect_success 'apply empty' '
>  	test_cmp expect empty
>  '
>  
> +test_expect_success 'apply empty patch fails' '
> +	git reset --hard &&
> +	git commit --allow-empty -m "empty commit" &&
> +	git format-patch --always HEAD~ >empty.patch &&
> +	test_must_fail git apply empty.patch &&
> +	test_must_fail git apply - </dev/null
> +'
> +
> +test_expect_success 'apply with --allow-empty succeeds' '
> +	git reset --hard &&
> +	git commit --allow-empty -m "empty commit" &&

Rather than making two --allow-empty commits, shouldn't this be added to
the earlier "setup" routine, so both of these tests can use the same
empty commit?

The setup routine sets up a patch0 and patch1, just add an empty-patch ?

And for the "git reset --hard" I see you're copy/pasting the existing
convention in that file, but FWIW it's better to use 'test_when_finished
"git reset --hard"' in the appropriate spot in the test (i.e. just
before we'd need the reset if we fail), so a test cleans up after
itself. As opposed to "I'm cleaning in case an earlier test didn't clean
up".

> +	git format-patch --always HEAD~ >empty.patch &&
> +	git apply --allow-empty empty.patch &&
> +	git apply --allow-empty - </dev/null
> +'
> +
>  test_expect_success 'apply --index empty' '
>  	git reset --hard &&
>  	rm -f missing &&

