Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466D6C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 17:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjDLRxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 13:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDLRxe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 13:53:34 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C79EE45
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 10:53:33 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i8so3215244plt.10
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681322012; x=1683914012;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqXiXZwX1CqbZJ1LroRhPZakkQSORNis26HxYyUULcY=;
        b=bdIPy2MD6yRHt1peYBOjW34wZUV4WdZGJ0HUizOUbcf0yVbfhFhcOX++dHRXrRa6nB
         5fauEIrdguSDEOCgYv599eBZy3JnS29kqfnEy53vB829IUp3yf6dYOxw32acgbaeMiVL
         VlqOlJzxoblp8yOJHQQB8Vymw7RyntkVW2mS4hnpdIUzR24MbUFZSeg8YbW7QBcGF85T
         GZxnzJ3FJIRpcOMEMCPD1PQ6A0DNWaQyMIv4opjMzDFSBcMerNLYeSZ6wL4DoA4gigHb
         EYT1OryXWKLpT6S93lsXg6O5Sc9/IQsEdQU/aVxhjFYZcbq6oSiDEq5fz2cJ14aVn8zd
         pLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681322012; x=1683914012;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NqXiXZwX1CqbZJ1LroRhPZakkQSORNis26HxYyUULcY=;
        b=NwGbYptQKxqvqGsQRvyPWCp7qUkUfvrKHwnt3FHlxYm9ZXNI7c3TZWKqeeSWz577a2
         wGhx4D84qP5K6FLC4mIUIEpjwKvKYk1KFmV3YQGhzuRYbOwYh7M+ISjR+9b6ibu3ySoh
         UgFdeV2WXHB4huCnNhCNziDmkWqukJErKpLseCN/F03Mro7Fk3MqBg7YH8pZlKYnai+s
         12WEpMwRK8IN/fFrTGOS1ObUaL5taVpBU6fzXzpiNkCfVjc/eoIlYGWMdacbgPwq9CxA
         9SVCudXHxP/2oKDX5idFsgkkLzaK9jKLI7altNpW1Noz6B66pzAqyRJol8uLz07rSe/1
         oe9w==
X-Gm-Message-State: AAQBX9di/vHBQ8BbGJUVb7rnKZxn48zPIrHxHZxAZneGrMoZCKExbDcM
        HWjhwGv3AtCkPrkMc/Nea14=
X-Google-Smtp-Source: AKy350ar9cy4DtrQcl1cPB9TDWll5u8SRbr5yX2oqUMSL/FEN4dgwrFhx1g6vHfTyQ0iWEQpKvUdOA==
X-Received: by 2002:a05:6a20:c530:b0:eb:b8:bdc8 with SMTP id gm48-20020a056a20c53000b000eb00b8bdc8mr6788452pzb.57.1681322012086;
        Wed, 12 Apr 2023 10:53:32 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id s11-20020a62e70b000000b0063af7d177aesm2379560pfh.195.2023.04.12.10.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 10:53:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Robin Jarry <robin@jarry.cc>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
Subject: Re: [PATCH v2] send-email: export patch counters in validate
 environment
References: <20230411114723.89029-1-robin@jarry.cc>
        <20230412095434.140754-1-robin@jarry.cc>
Date:   Wed, 12 Apr 2023 10:53:31 -0700
In-Reply-To: <20230412095434.140754-1-robin@jarry.cc> (Robin Jarry's message
        of "Wed, 12 Apr 2023 11:54:34 +0200")
Message-ID: <xmqqfs957zs4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robin Jarry <robin@jarry.cc> writes:

>  if ($validate) {
> +	# FIFOs can only be read once, exclude them from validation.

It is very good to see this comment here, as it may not be obvious
to everybody why we exclude them.

> +validate_cover_letter()
> +{

See Documentation/CodingGuidelines, look for "For shell scripts
specifically" and follow what is in the section.  There may be style
violations of other kinds in the file.

> +validate_patch()
> +{
> +	file="$1"
> +	# Ensure that the patch applies without conflicts to the latest
> +	# upstream version.

That comment is true only for the first one.  The second patch needs
to apply to the upstream plus the first patch, and so on.

> +	git am -3 "$file" || die "failed to apply patch on upstream repo"
> +	# XXX: Add appropriate checks here (e.g. checkpatch.pl).
> +}
> +
> +validate_series()
> +{
> +	# XXX: Add appropriate checks here (e.g. quick build, etc.).
> +}
> +
> +die()
> +{
> +	echo "sendemail-validate: error: $*" >&2
> +	exit 1
> +}
> +
> +get_work_dir()
> +{
> +	git config --get sendemail.validateWorkdir || {
> +		# Initialize it to a temp dir, if unset.
> +		git config --add sendemail.validateWorkdir "$(mktemp -d)"
> +		git config --get sendemail.validateWorkdir
> +	}
> +}
> +
> +get_upstream_url()
> +{
> +	git config --get remote.origin.url ||
> +		die "cannot get remote.origin.url"
> +}
> +
> +clone_upstream()
> +{
> +	workdir="$1"
> +	url="$(get_upstream_url)"
> +	rm -rf -- "$workdir"
> +	git clone --depth=1 "$url" "$workdir" ||
> +		die "failed to clone upstream repository"
> +}

Style-wise, it is better to get rid of get_upstream_url and write
the above more like

	workdir=$1 &&
	url=$(git config remote.originurl) &&
	rm -r -- "$workdir" &&
	git clone ... ||
	die "failed to ..."

and that would be less error prone (e.g. you will catch failure from
"rm" yourself, instead of relying on "git clone" to catch it for
you).

In any case, I would avoid network traffic and extra disk usage if I
were showing an example for readers to follow, and would not
recommend you to use "clone" here, even if it were a shallow one.

It would make much more sense to create a secondary worktree based
on this repository, with its HEAD detached at the copy of the target
branch (e.g. refs/remotes/origin/HEAD), and use that secondary
worktree, as the necessary objects for "am -3" to fall back on are
more likely to be found in such a setting, compared to a shallow
clone that only can have the blobs at the tip.

> +
> +# main -------------------------------------------------------------------------

> +workdir=$(get_work_dir)
> +if [ "$GIT_SENDEMAIL_FILE_COUNTER" = 1 ]; then
> +	clone_upstream "$workdir"
> +fi
> +cd "$workdir"
> +export GIT_DIR="$workdir/.git"

It is a good discipline to always set GIT_DIR and GIT_WORK_TREE as a
pair.  Working in a subdirectory of a working tree becomes awkward,
because the presence of the former without the latter signals that
your $(cwd) is at the top of the working tree.

But that is more or less moot, because I am suggesting not to use
"git clone" to prepare the playground and instead use a secondary
worktree that is attached to the same current repository, so GIT_DIR
would be the same as the current one.

And because you are "cd"ing there anyway, it probably is much
simpler to just 

    unset GIT_DIR GIT_WORK_TREE

to let the repository discovery mechanism take care of it.

> +if grep -q "^diff --git " "$1"; then
> +	validate_patch "$1"
> +else
> +	validate_cover_letter "$1"
> +fi
> +
> +if [ "$GIT_SENDEMAIL_FILE_COUNTER" = "$GIT_SENDEMAIL_FILE_TOTAL" ]; then
> +	validate_series || die "patch series was rejected"
> +fi

It is uneven that validate_patch and validate_cover_letter are
responsible for dying when problem is found, but validate_series is
not and the caller is made responsible for that.

I would make the caller responsible for dying with message for all
three by removing the calls to "die" or "exit" from the former two,
if I were showing an example for readers to follow.

Overall, a very well crafted patch, even though little details and
some design choices can be improved.

Thanks.

