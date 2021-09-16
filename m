Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E64C433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 12:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23C960E90
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 12:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbhIPMUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 08:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbhIPMUM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 08:20:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCCBC061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 05:18:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h17so16036467edj.6
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 05:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=rMv1F66KS4YHBfAZ9KCC2HrTufNEJkbP7+Hse1qjgTo=;
        b=jDL6JvE7ABdW63tDkpqdbIPlxU5Cttr8GsEKB7tVaocHZ+1AaBU5VmTs4/tHe2DaOk
         FGY28A0Sqew4sBOIZdJzCIv6AQQsffHOdePG81E9AAMQZOiQjf8Ym+lBmoQH4a3czt0S
         gRGzZeBb2SXzaK3rGQ4xtOI2w23sZxm9/KBcUyrYpARLbk/H4exAVQkTqW2cv2+utTuF
         OQcexG0LzhQSsQs+BtQqMHqsAzSiNqmP6X2Rzt0LwCo7C2zp7gwiCOODQBeiFnQjd8nt
         DssL2mL7iXiXRlrPhrnyxyPj6qeqRWBCN6edvCuhk35RAXJ4eEwcwv9DlCw+L2QWSX58
         ze/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=rMv1F66KS4YHBfAZ9KCC2HrTufNEJkbP7+Hse1qjgTo=;
        b=lUIvW6zOSPKOXGvNIdYe7eJk7V9bJDC6WQ2/X8IOaOWYI/GVgS8XgAVBb/EbGvl9NR
         jpQvJxd93fv9E3rmnDrhAyquj43p9xlBs2YPPygexR31dsSUmGWGwb70fD75L5EfdOOh
         MNfDuHWh1s/MLB9mkL4AHEzYFqCVybGdeLt7XvftYFKxDs9KZxidBp9/i9cw/DEivqCA
         2Y8RvkQPBKxXK2OebR48XpTyQHEVsuXhZRpuAiQ6d7MdozTPliTAreEfV9nJHkiobTC3
         +99m5V9Xi5Il7DEnjIVo3vVs6nKE7PlQdgojpZeh8DiEP11W9NDTkg6P1fr3ueQm07cn
         cHvg==
X-Gm-Message-State: AOAM531MBEK1RCc49LordtJbKMhHaBVqRLt/rFlsOcNDoV+GYWUio469
        ZXOh+k9KIOfQSk53zzeB0UA=
X-Google-Smtp-Source: ABdhPJzvAmqLxlJBtL3szKSsCJv/sEkb4IYJLEYpkyQf5B6D0uAd4jm+O/HxY0n6eda0/+jGYlTHvQ==
X-Received: by 2002:a17:906:a018:: with SMTP id p24mr5821886ejy.349.1631794730262;
        Thu, 16 Sep 2021 05:18:50 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ay3sm1129660ejb.0.2021.09.16.05.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 05:18:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ryan Anderson <ryan@michonline.com>, vmiklos@frugalware.org,
        bedhanger@gmx.de
Subject: Re: [PATCH 2/2] request-pull: mark translatable strings
Date:   Thu, 16 Sep 2021 14:15:15 +0200
References: <20210916113516.76445-1-bagasdotme@gmail.com>
 <20210916113516.76445-3-bagasdotme@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210916113516.76445-3-bagasdotme@gmail.com>
Message-ID: <87sfy4g1cm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 16 2021, Bagas Sanjaya wrote:

> Mark user-faced strings as translatable (including PR message output).
>
> Cc: Ryan Anderson <ryan@michonline.com>
> Cc: vmiklos@frugalware.org 
> Cc: bedhanger@gmx.de
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  git-request-pull.sh | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/git-request-pull.sh b/git-request-pull.sh
> index 9e1d2be9eb..8aa3a3f342 100755
> --- a/git-request-pull.sh
> +++ b/git-request-pull.sh
> @@ -40,7 +40,7 @@ test -n "$base" && test -n "$url" || usage
>  baserev=$(git rev-parse --verify --quiet "$base"^0)
>  if test -z "$baserev"
>  then
> -    die "fatal: Not a valid revision: $base"
> +    die "$(eval_gettext "fatal: Not a valid revision: \$base")"
>  fi
>  
>  #
> @@ -58,12 +58,12 @@ head=${head:-$(git show-ref --heads --tags "$local" | cut -d' ' -f2)}
>  head=${head:-$(git rev-parse --quiet --verify "$local")}
>  
>  # None of the above? Bad.
> -test -z "$head" && die "fatal: Not a valid revision: $local"
> +test -z "$head" && die "$(eval_gettext "fatal: Not a valid revision: \$local")"
>  
>  # This also verifies that the resulting head is unique:
>  # "git show-ref" could have shown multiple matching refs..
>  headrev=$(git rev-parse --verify --quiet "$head"^0)
> -test -z "$headrev" && die "fatal: Ambiguous revision: $local"
> +test -z "$headrev" && die "$(eval_gettext "fatal: Ambiguous revision: \$local")"
>  
>  local_sha1=$(git rev-parse --verify --quiet "$head")
>  
> @@ -76,7 +76,7 @@ then
>  fi
>  
>  merge_base=$(git merge-base $baserev $headrev) ||
> -die "fatal: No commits in common between $base and $head"
> +die "$(eval_gettext "fatal: No commits in common between \$base and \$head")"

Looks good.

>  # $head is the refname from the command line.
>  # Find a ref with the same name as $head that exists at the remote
> @@ -120,13 +120,13 @@ remote_or_head=${remote:-HEAD}
>  
>  if test -z "$ref"
>  then
> -	echo "warn: No match for commit $headrev found at $url" >&2
> -	echo "warn: Are you sure you pushed '$remote_or_head' there?" >&2
> +	echo "$(eval_gettext "warn: No match for commit \$headrev found at \$url")" >&2
> +	echo "$(eval_gettext "warn: Are you sure you pushed '\$remote_or_head' there?")" >&2
>  	status=1
>  elif test "$local_sha1" != "$remote_sha1"
>  then
> -	echo "warn: $head found at $url but points to a different object" >&2
> -	echo "warn: Are you sure you pushed '$remote_or_head' there?" >&2
> +	echo "$(eval_gettext "warn: \$head found at \$url but points to a different object")" >&2
> +	echo "$(eval_gettext "warn: Are you sure you pushed '\$remote_or_head' there?")" >&2
>  	status=1
>  fi

Messages like these should probably be combined into one this one's
mostly on the edge, but the "are you sure" reads like a continuation of
the "no match for" or "$head found at" sentence, so translators may want
to re-orderthat wording...

> @@ -138,19 +138,22 @@ fi
>  
>  url=$(git ls-remote --get-url "$url")
>  
> -git show -s --format='The following changes since commit %H:
> +git show -s --format="
> +$(gettext 'The following changes since commit %H:
>  

The newline added at the start here looks like a bug or unrelated
change.

>    %s (%ci)
>  
>  are available in the Git repository at:
> -' $merge_base &&
> +')
> +" $merge_base &&

And this likewise looks like an unrelated formatting change.

>  echo "  $url $pretty_remote" &&
> -git show -s --format='
> +git show -s --format="
> +$(gettext '

And likewise here maybe we want to include the first \n?

>  for you to fetch changes up to %H:
>  
>    %s (%ci)
>  
> -----------------------------------------------------------------' $headrev &&
> +----------------------------------------------------------------')" $headrev &&
>  
>  if test $(git cat-file -t "$head") = tag
>  then
> @@ -162,7 +165,7 @@ fi &&
>  
>  if test -n "$branch_name"
>  then
> -	echo "(from the branch description for $branch_name local branch)"
> +	echo "$(eval_gettext "(from the branch description for \$branch_name local branch)")"
>  	echo
>  	git config "branch.$branch_name.description"
>  	echo "----------------------------------------------------------------"

The rest looks good/correct,
