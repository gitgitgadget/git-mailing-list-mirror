Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC1DC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 21:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2102520692
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 21:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XnOEUNxb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgAHVln (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:41:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34357 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgAHVlm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 16:41:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id x17so1661176pln.1
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 13:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YsMcegGespJJrynsEsX3L080+XDifIF+XmK1yz3rRzo=;
        b=XnOEUNxb7WlfRqeihoE4aEz/sWXmhd2k5HmK3EliulcRlOmjCo5qxhKgZ2sVC2JcMJ
         x54KBlk4dVguh/AKXAVB4YWwUIrsNYviAby1rNM+sx168C8KrPrBV7Z5nxqsRtordp5n
         6EoFdjTTuY5rf2XMbgIbrhfmVTztw4/Hvp8gaggUYOZX5Toe9dch44DJIMLl7Ppk3P04
         nnOBDR4r/OF9AOeW+X87Hlu7//EE8mrrRAxnYCWcv6JuE36dgnC3JkaGVpUcng0JiGxP
         mnd4Mc5EjBT9+teqckSrJC/cU3WL+pfFAnrKjzeTBbuq3a7qqV4YqB3Lpu2mcH6eezXe
         szpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=YsMcegGespJJrynsEsX3L080+XDifIF+XmK1yz3rRzo=;
        b=FrCGWq8kqIU7B/6ZRGr1nhwQDLOlB/mLiwJRJHeDDYhDd/SHDYAb+4W2pvtuuS94uu
         5rnCE6X5QrctJS3O3YO/giuuaoR0MVbMN288DG7Ix70XOPmdop3abUwNrpZcFdP/xuP9
         TpSaLje60ZcYRfiUt0jAsY73smOkwJ2vzDXlMzuw2sx6qhuXA/lFeWi9t8lexjnq7j7D
         0hUgR7VTvqr98cPVhfdgQlB3DEIR2YNc3wA26s5juhSbmyqkwQbiQAqpDlc2Hk2TPUoJ
         rovPPgtctmzpOiUPiZukv8LRPYqCOLBGc3I3ZIFpqJTz6T5EfrvWx7GcgzNMkcBA9RT+
         Qdig==
X-Gm-Message-State: APjAAAUq9JdW4f6SnXLbBOdEcVhDzHlKWRjUezaVk5+R76Wr4sLvMjWj
        Vom/Tzgr5YQ75GofwyicA40u+yJ/Nh5eOg==
X-Google-Smtp-Source: APXvYqy7gXKbKn41mBbqVEYmT27+JMkW5tOOQZbcKQSExp3Z6EKtN9uxO1raAa5hRSnHA1W+aPUInQ==
X-Received: by 2002:a17:90a:26ab:: with SMTP id m40mr933009pje.42.1578519701574;
        Wed, 08 Jan 2020 13:41:41 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:ece8:7fe:c1f1:a20f])
        by smtp.gmail.com with ESMTPSA id r3sm4916511pfg.145.2020.01.08.13.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 13:41:40 -0800 (PST)
Date:   Wed, 8 Jan 2020 13:41:36 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org, Yaroslav O Halchenko <debian@onerussian.com>
Subject: Re: [PATCH] submodule add: show 'add --dry-run' stderr when aborting
Message-ID: <20200108214136.GB63040@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Yaroslav O Halchenko <debian@onerussian.com>
References: <20200108003121.28034-1-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108003121.28034-1-kyle@kyleam.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.01.07 19:31, Kyle Meyer wrote:
> Unless --force is specified, 'submodule add' checks if the destination
> path is ignored by calling 'git add --dry-run --ignore-missing', and,
> if that call fails, aborts with a custom "path is ignored" message (a
> slight variant of what 'git add' shows).  Aborting early rather than
> letting the downstream 'git add' call fail is done so that the command
> exits before cloning into the destination path.  However, in rare
> cases where the dry-run call fails for a reason other than the path
> being ignored---for example, due to a preexisting index.lock
> file---displaying the "ignored path" error message hides the real
> source of the failure.
> 
> Instead of displaying the tailored "ignored path" message, let's
> report the standard error from the dry run to give the caller more
> accurate information about failures that are not due to an ignored
> path.
> 
> For the ignored path case, this leads to the following change in the
> error message:
> 
>   The following [-path is-]{+paths are+} ignored by one of your .gitignore files:
>   <destination path>
>   Use -f if you really want to add [-it.-]{+them.+}
> 
> The new phrasing is a bit awkward, because 'submodule add' is only
> dealing with one destination path.  Alternatively, we could continue
> to use the tailored message when the exit code is 1 (the expected
> status for a failure due to an ignored path) and relay the standard
> error for all other non-zero exits.  That, however, risks hiding the
> message of unrelated failures that share an exit code of 1, so it
> doesn't seem worth doing just to avoid a clunkier, but still clear,
> error message.
> 
> Signed-off-by: Kyle Meyer <kyle@kyleam.com>
> ---
>  git-submodule.sh           | 14 ++++++++------
>  t/t7400-submodule-basic.sh | 15 +++++++++++++--
>  2 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/git-submodule.sh b/git-submodule.sh
> index aaa1809d24..afcb4c0948 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -241,13 +241,15 @@ cmd_add()
>  	    die "$(eval_gettext "'\$sm_path' does not have a commit checked out")"
>  	fi
>  
> -	if test -z "$force" &&
> -		! git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm_path" > /dev/null 2>&1
> +	if test -z "$force"
>  	then
> -		eval_gettextln "The following path is ignored by one of your .gitignore files:
> -\$sm_path
> -Use -f if you really want to add it." >&2
> -		exit 1
> +	    dryerr=$(git add --dry-run --ignore-missing --no-warn-embedded-repo "$sm_path" 2>&1 >/dev/null)
> +	    res=$?
> +	    if test $res -ne 0
> +	    then
> +		 echo >&2 "$dryerr"
> +		 exit $res
> +	    fi
>  	fi
>  
>  	if test -n "$custom_name"

Seems reasonable: we move the dry-run add inside the if block, and
capture its stderr, then display the message only if the return code is
non-zero.


> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 7f75bb1be6..42a00f95b9 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -156,9 +156,9 @@ test_expect_success 'submodule add to .gitignored path fails' '
>  	(
>  		cd addtest-ignore &&
>  		cat <<-\EOF >expect &&
> -		The following path is ignored by one of your .gitignore files:
> +		The following paths are ignored by one of your .gitignore files:
>  		submod
> -		Use -f if you really want to add it.
> +		Use -f if you really want to add them.
>  		EOF
>  		# Does not use test_commit due to the ignore
>  		echo "*" > .gitignore &&
> @@ -191,6 +191,17 @@ test_expect_success 'submodule add to reconfigure existing submodule with --forc
>  	)
>  '
>  
> +test_expect_success 'submodule add relays add --dry-run stderr' '
> +	test_when_finished "rm -rf addtest/.git/index.lock" &&
> +	(
> +		cd addtest &&
> +		: >.git/index.lock &&
> +		! git submodule add "$submodurl" sub-while-locked 2>output.err &&
> +		test_i18ngrep "^fatal: .*index\.lock" output.err &&
> +		test_path_is_missing sub-while-locked
> +	)
> +'
> +
>  test_expect_success 'submodule add --branch' '
>  	echo "refs/heads/initial" >expect-head &&
>  	cat <<-\EOF >expect-heads &&

I had to look up what ":" does, but it looks like it's reasonably widely
used in other tests so that seems fine. However, it looks like you don't
even need the : command and can just ">.git/index.lock" by itself (see
the "setup - initial commit" test case in this file for an example).

> base-commit: 042ed3e048af08014487d19196984347e3be7d1c
> -- 
> 2.24.1
> 


Looks good to me. Thanks for the patch!
