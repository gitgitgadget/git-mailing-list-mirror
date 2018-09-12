Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285D91F404
	for <e@80x24.org>; Wed, 12 Sep 2018 19:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeIMA0w (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 20:26:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46432 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbeIMA0w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 20:26:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id a108-v6so3188422wrc.13
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 12:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mfA/04izd/ZyEgHMNOCP+HvbzhR6t4VgZvVtIrvz5qs=;
        b=IAeRsdDppC3CdLhoMy6bZzLK/62Mv4vazsUfabU6HgWE+aqgG8RGDm21Z+/vslSjUh
         /Gekt9h558XpHVOmubkXu3kinW0Ok3d9qJrCBozViVAIMNbYbor5rGK3iR38J9GMPEV9
         ZjP43DRolKWUOJpBvlgRDNxMY6zCz7JQAGj44JXMMloQjaurRigcX/U7ZBR281zdTN5g
         hdAToo8iXTdSbjPdLw6GfNez3CHwQCx/5K77ZtrTkn9PUkoM5EHlJj0tGMSqo839OS1Y
         60TaXxzPOxWD0/H7WmlFrpPkfLSmbrUgx/bP1NoV3sHSAqMiVnpcxywkImOaiGRVpL0Q
         Oz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mfA/04izd/ZyEgHMNOCP+HvbzhR6t4VgZvVtIrvz5qs=;
        b=aHO7472EBPJARATrEFf4pYTn5xCcH8+N69ZVWPsN2+JcKpEvb4st3trIcwbDw/SDuz
         JtPNqI0xQogctg6LLhWagCQJcSYQco37FVf2ZJgUCehQfIObLvPBnSkss2rYFnRG4Ydi
         DVb3Hpx21sNXv9tLyM2daqkBxI/BQVzx+BFGSZW4puoniTVFj7+TzsYKnEByJKhsoQHH
         OTApqPVnWITRIZ+z2sD0lSFsAS5P9bMlqLCW0NAc+KO03yxCSANRVDJFqDV9sul9Zi5F
         S3KgzBuAXkAUmFccUR1u95XT5hcrfr2v3GfxW+x2NBJyKpSUWLzx7TqZEAGCg93aWwQ2
         2D2g==
X-Gm-Message-State: APzg51Ax62HX5ThxDM+1VgeA0qYSr1iAZj/26dMzebec9WN4N8fQW9Hz
        ao5hmJRcC0U/HZEIUFZsh/4=
X-Google-Smtp-Source: ANB0VdbfZSQiw33LAKqC2bLSIpXUdpizQMTC/0x+TQVJKym0TiQYWjVLVhZ0ZeXmrDU9AmJePhVlRw==
X-Received: by 2002:adf:c109:: with SMTP id r9-v6mr2707341wre.233.1536780054345;
        Wed, 12 Sep 2018 12:20:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s205-v6sm2420962wmf.42.2018.09.12.12.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 12:20:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 9/9] builtin/fetch: check for submodule updates for non branch fetches
References: <20180911234951.14129-1-sbeller@google.com>
        <20180911234951.14129-10-sbeller@google.com>
Date:   Wed, 12 Sep 2018 12:20:53 -0700
In-Reply-To: <20180911234951.14129-10-sbeller@google.com> (Stefan Beller's
        message of "Tue, 11 Sep 2018 16:49:51 -0700")
Message-ID: <xmqqbm92ldyi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> For Gerrit users that use submodules the invocation of fetch without a
> branch is their main use case.

That's way under explains this commit.  It is totally unclear how
that statement of fact relates to the problem this patch is trying
to address; it does not even make it clear what problem is being
addressed by the patch.

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/fetch.c             | 5 ++++-
>  t/t5526-fetch-submodules.sh | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 95c44bf6ffa..ea6ecd123e7 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -887,11 +887,14 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  				rc |= update_local_ref(ref, what, rm, &note,
>  						       summary_width);
>  				free(ref);
> -			} else
> +			} else {
> +				check_for_new_submodule_commits(&rm->old_oid);

This happens when there is no "ref", which is set only when
rm->peer_ref exists, which is set only when we are using remote
tracking branch (or more generally storing the fetched rev somewhere
in our refs/ hierarchy), e.g. the rev is recorded only in FETCH_HEAD.

What does rm->old_oid have in such a case?  Is this the tip of the
superproject history we just fetched?

When we keep record of what we saw in the previous attempt to fetch,
we can tell "we have seen their history up to this old commit
before, and now we fetched their history up to this new commit" and
the question "during that time, which submodules have been modified
in the history of the superproject" becomes answerable.  When we are
not keeping the record of previous fetch, how would we answer that
question without going through the whole history?

	The answer is that check-for-new does not even do the "old
	branch tip was X and new branch tip is Y, so we can look
	only at X..Y"; it only cares about the new branch tip of the
	superproject, and excludes the existing tips of all branches
	in the superproject (i.e. computing something akin to "Y
	--not --all" instead of "X..Y").

So, I guess this is probably reasonable.  But does the call to
"check-for-new submodule" need to be unconditional?  In this
codepath, do we know when we are not doing a recursive fetch in a
superproject?  If so, perhaps we can omit the cost of going through
all the refs to populate ref_tips_before_fetch array in such a case.

>  				format_display(&note, '*',
>  					       *kind ? kind : "branch", NULL,
>  					       *what ? what : "HEAD",
>  					       "FETCH_HEAD", summary_width);
> +			}
> +
>  			if (note.len) {
>  				if (verbosity >= 0 && !shown_url) {
>  					fprintf(stderr, _("From %.*s\n"),
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index af12c50e7dd..a509eabb044 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -615,7 +615,7 @@ test_expect_success "fetch new commits on-demand when they are not reachable" '
>  	git update-ref refs/changes/2 $D &&
>  	(
>  		cd downstream &&
> -		git fetch --recurse-submodules --recurse-submodules-default on-demand origin refs/changes/2:refs/heads/my_branch &&
> +		git fetch --recurse-submodules origin refs/changes/2 &&
>  		git -C submodule cat-file -t $C &&
>  		git checkout --recurse-submodules FETCH_HEAD
>  	)
