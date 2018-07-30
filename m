Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DC041F597
	for <e@80x24.org>; Mon, 30 Jul 2018 17:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeG3T07 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 15:26:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45651 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeG3T07 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 15:26:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id f12-v6so3901527wrv.12
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 10:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=yy12L5679gDUzKH0CxiZBQLeDbJZpoyob886mKUe5Xk=;
        b=QQALXUn+ShwiQWqS3AAqgGZZ9vGX9/JEN4ZBoD0DcBFSpza7hISGlZ+fUSEXMTQInd
         bou4wNiQ3BbqUlReCeRYyVfsGP2q5inYexhKT5i2/DoPk15VSxM/frg16GYNnmNIJ1wL
         G+ZELUuf/vAjPIu1jeuExX2gYlXCtLQruu4/ZsWKsqPoJreBFvLk+vdO4dxUlL/1ePzv
         uvz5JYVyA8Gu99MLGHYoGXlDAx1SsL3cjExqptapLMUWBOjl26hBEVaFsSp9ep9mC8l4
         +wkmZnPB1f1QNgQocfGgs1sZ4HMxEMpAM/5sbVlJLN5jtD/WkmNLUb0dA5ONbW+bKLoT
         JVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=yy12L5679gDUzKH0CxiZBQLeDbJZpoyob886mKUe5Xk=;
        b=Xpb0WNOKKMbjvtdE1sKOfwecpN+UyR0fMYHM1HnTZ5VnI/JUJ3f3WJg4Ja5ZbdPQ4I
         q1n1J3rYXgsPki/oxfPXqmNAdDm7n0cvdZ5pWG4qWm6k/+gsgDEC6Ylm/hIWZrbDmF+1
         IvF7UuSW6geRd4HT+J4f4EPFpQu923WL7GcywAnTxpHxlMtE1QnNhYAjrgtgO4Pjf0yI
         Uzb5pFIRTed7LEzv5OWsmQWZQT380sR9mn8SUip9Z2GdftlT1rfXPj82mPnfcYURDP6Q
         wzOmMiP/OU5dKhEHuBTxyyqH00QZE0g4PX2ilj1JOwSfAZ8QR+hCDcfnO5oCQi9xEmFh
         rHug==
X-Gm-Message-State: AOUpUlF0PS0PwSgt7S6D09BGg33aNQELrjDUEbTysOax/wxvzOE3UTVx
        V/cPw/y9q3yGxKFYZb+HC2M=
X-Google-Smtp-Source: AAOMgpf1mO/0G5n857zFDcHITN3r1Bvf6kPL8XdjyHIVUG3cbJbW2S2BTPx4T15qW4nVCqHoV6d1fw==
X-Received: by 2002:adf:9954:: with SMTP id x78-v6mr19305071wrb.178.1532973051019;
        Mon, 30 Jul 2018 10:50:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v5-v6sm24891138wrp.87.2018.07.30.10.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:50:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 06/11] rerere: fix crash when conflict goes unresolved
References: <20180605215219.28783-1-t.gummerer@gmail.com>
        <20180714214443.7184-1-t.gummerer@gmail.com>
        <20180714214443.7184-7-t.gummerer@gmail.com>
Date:   Mon, 30 Jul 2018 10:50:50 -0700
Message-ID: <xmqqbmaohath.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Currently when a user doesn't resolve a conflict in a file, but
> commits the file with the conflict markers, and later the file ends up
> in a state in which rerere can't handle it, subsequent rerere
> operations that are interested in that path, such as 'rerere clear' or
> 'rerere forget <path>' will fail, or even worse in the case of 'rerere
> clear' segfault.
>
> Such states include nested conflicts, or an extra conflict marker that
> doesn't have any match.
>
> This is because the first 'git rerere' when there was only one
> conflict in the file leaves an entry in the MERGE_RR file behind.  The

I find this sentence, especially the "only one conflict in the file"
part, a bit unclear.  What does the sentence count as one conflict?
One block of lines enclosed inside "<<<"...">>>" pair?  The command
behaves differently when there are two such blocks instead?

> next 'git rerere' will then pick the rerere ID for that file up, and
> not assign a new ID as it can't successfully calculate one.  It will
> however still try to do the rerere operation, because of the existing
> ID.  As the handle_file function fails, it will remove the 'preimage'
> for the ID in the process, while leaving the ID in the MERGE_RR file.
>
> Now when 'rerere clear' for example is run, it will segfault in
> 'has_rerere_resolution', because status is NULL.

I think this "status" refers to the collection->status[].  How do we
get into that state, though?

new_rerere_id() and new_rerere_id_hex() fills id->collection by
calling find_rerere_dir(), which either finds an existing rerere_dir
instance or manufactures one with .status==NULL.  The .status[]
array is later grown by calling fit_variant as we scan and find the
pre/post images, but because there is no pre/post image for a file
with unparseable conflicts, it is left NULL.

So another possible fix could be to make sure that .status[] is only
read when .status_nr says there is something worth reading.  I am
not saying that would be a better fix---I am just thinking out loud
to make sure I understand the issue correctly.

> To fix this, remove the rerere ID from the MERGE_RR file in the case
> when we can't handle it, and remove the corresponding variant from
> .git/rr-cache/.  Removing it unconditionally is fine here, because if
> the user would have resolved the conflict and ran rerere, the entry
> would no longer be in the MERGE_RR file, so we wouldn't have this
> problem in the first place, while if the conflict was not resolved,
> the only thing that's left in the folder is the 'preimage', which by
> itself will be regenerated by git if necessary, so the user won't
> loose any work.

s/loose/lose/

> Note that other variants that have the same conflict ID will not be
> touched.

Nice.  Thanks for a fix.

>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  rerere.c          | 12 +++++++-----
>  t/t4200-rerere.sh | 22 ++++++++++++++++++++++
>  2 files changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/rerere.c b/rerere.c
> index da1ab54027..895ad80c0c 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -823,10 +823,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
>  		struct rerere_id *id;
>  		unsigned char sha1[20];
>  		const char *path = conflict.items[i].string;
> -		int ret;
> -
> -		if (string_list_has_string(rr, path))
> -			continue;
> +		int ret, has_string;
>  
>  		/*
>  		 * Ask handle_file() to scan and assign a
> @@ -834,7 +831,12 @@ static int do_plain_rerere(struct string_list *rr, int fd)
>  		 * yet.
>  		 */
>  		ret = handle_file(path, sha1, NULL);
> -		if (ret < 1)
> +		has_string = string_list_has_string(rr, path);
> +		if (ret < 0 && has_string) {
> +			remove_variant(string_list_lookup(rr, path)->util);
> +			string_list_remove(rr, path, 1);
> +		}
> +		if (ret < 1 || has_string)
>  			continue;

We used to say "if we know about the path we do not do anything
here, if we do not see any conflict in the file we do nothing,
otherwise we assign a new id"; we now say "see if we can parse
and also see if we have conflict(s); if we know about the path and
we cannot parse, drop it from the rr database (because otherwise the
entry will cause us trouble elsewhere later).  Otherwise, if we do
not have any conflict or we already know about the path, no need to
do anything. Otherwise, i.e. a newly discovered path with conflicts
gets a new id".

Makes sense.  "A known path with unparseable conflict gets dropped"
is the important change in this hunk.

> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index 8417e5a4b1..34f0518a5e 100755
> --- a/t/t4200-rerere.sh
> +++ b/t/t4200-rerere.sh
> @@ -580,4 +580,26 @@ test_expect_success 'multiple identical conflicts' '
>  	count_pre_post 0 0
>  '
>  
> +test_expect_success 'rerere with unexpected conflict markers does not crash' '
> +	git reset --hard &&
> +
> +	git checkout -b branch-1 master &&
> +	echo "bar" >test &&
> +	git add test &&
> +	git commit -q -m two &&
> +
> +	git reset --hard &&
> +	git checkout -b branch-2 master &&
> +	echo "foo" >test &&
> +	git add test &&
> +	git commit -q -a -m one &&
> +
> +	test_must_fail git merge branch-1 &&
> +	sed "s/bar/>>>>>>> a/" >test.tmp <test &&
> +	mv test.tmp test &&

OK, so the "only one conflict" in the log message meant just one
side of the conflict marker.  More generally, the troublesome is
to have "conflict marker(s) that cannot be parsed" in the file.

> +	git rerere &&
> +
> +	git rerere clear
> +'
> +
>  test_done
