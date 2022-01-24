Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E73BC433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 15:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240790AbiAXP3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 10:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiAXP3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 10:29:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCC1C06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 07:29:45 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id p12so57269653edq.9
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 07:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=UcltebWCA/I3OqwLUU8Pab2EClA2+6XVAoQNVRCZcuE=;
        b=jSI19bslfKAb4gQztPuFayAW7rwhiL7Q8aer0kIRfobk0hG9qBB3bDY8fHp6GJraPC
         GOW1mebsDbMDUATpofwiysLEJaNakXBfayMj5UQK3k/EiMuctDBcmY+LNkJO7U0s/fB9
         yMLT39FxcmFCrardQaLF8DpNVhQjuSmuivmvrrZycB6Z1pZACjpSkSIiTj51sB2eyRvY
         pWDkFcuUYUbCj28T7mMO3cseJnvVytiHZcbZNOtPKaog4DO+NUO8eayFT2zGoCo0A+/E
         x93tn88aA//Lv7+VXH+16A5mfkfi/bRWmTtZKzPqfUqp78hoUmlTZpR+hfGNnpK5uo43
         0SEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=UcltebWCA/I3OqwLUU8Pab2EClA2+6XVAoQNVRCZcuE=;
        b=FR1i9r228jGDlBODs+FhppBl3+kkKgzOnn4D7wivz/kkyEl0+UD7EEsQvVyS9JS1T0
         Xp1rF1P8qFag7x5ym4S7K8yShn+4saL6iir37ec0ebR784bpPjUYyjNmOV8FGKrgFHbn
         x4Z3AXqqMUo8/l1MTdmeQ9FSNygoc6Or7/LSnmlqglSpmgie0dX+i3bxD17T9ghfP6fS
         8q4R4DGVOh5JTcBA1KNDhkqXd8eBNfZxZ9iwaQp3ZefCZWyCFpkK41yAoYCLv/iIWju5
         9AB/KqVmG7Odq5/kSZTOGUYSQFGeoirvuR1zQ73/JjwvSvisUxjOnv7N1awP4SIsIWQ9
         cZSw==
X-Gm-Message-State: AOAM532tF0TFLX7aLC3Pzx488QHjas4JbMMSPXCktQeSynbBz0402zAF
        GegcHmdtCEP9pa6QfEdfJJoJrwp2I+k=
X-Google-Smtp-Source: ABdhPJxZT9MVo2MghaoVcmZDQuzGJL8e9RA335UyR/We9/s3+y+LPAd5jPuqB0Jy5YrNXZrVrteU3Q==
X-Received: by 2002:aa7:cd17:: with SMTP id b23mr12467370edw.141.1643038183997;
        Mon, 24 Jan 2022 07:29:43 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y17sm5001630ejw.165.2022.01.24.07.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 07:29:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nC1Hr-002XLm-21;
        Mon, 24 Jan 2022 16:29:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     BoJun via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, BoJun <bojun.cbj@gmail.com>,
        Chen Bojun <bojun.cbj@alibaba-inc.com>
Subject: Re: [PATCH] receive-pack: purge temporary data if no command is
 ready to run
Date:   Mon, 24 Jan 2022 16:17:26 +0100
References: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1124.git.1642987616372.gitgitgadget@gmail.com>
Message-ID: <220124.86v8y9gniw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 24 2022, BoJun via GitGitGadget wrote:

> From: Chen Bojun <bojun.cbj@alibaba-inc.com>
>
> When pushing a hidden ref, e.g.:
>
>     $ git push origin HEAD:refs/hidden/foo
>
> "receive-pack" will reject our request with an error message like this:
>
>     ! [remote rejected] HEAD -> refs/hidden/foo (deny updating a hidden ref)
>
> The remote side ("git-receive-pack") will not create the hidden ref as
> expected, but the pack file sent by "git-send-pack" is left inside the
> remote repository. I.e. the quarantine directory is not purged as it
> should be.

Hrm, shouldn't the tmp-objdir.[ch]'s atexit() make sure that won't
happen (but maybe it's buggy/not acting as I thought...)?

> Add a checkpoint before calling "tmp_objdir_migrate()" and after calling
> the "pre-receive" hook to purge that temporary data in the quarantine
> area when there is no command ready to run.

But we're not purging anything, just returning early?

If we'll always refuse this update, why do we need to run the
pre-receive hook at all, isn't that another bug?....

> The reason we do not add the checkpoint before the "pre-receive" hook,
> but after it, is that the "pre-receive" hook is called with a switch-off
> "skip_broken" flag, and all commands, even broken ones, should be fed
> by calling "feed_receive_hook()".

...but I see it's intentional, but does this make sense per the
rationale of 160b81ed819 (receive-pack: don't pass non-existent refs to
post-{receive,update} hooks, 2011-09-28)? Maybe, but the reason we have
these for "non-existent refs" != this categorical denial of a hidden
ref.

> Add a new test case and fix some formatting issues in t5516 as well.
>
> Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Helped-by: Teng Long <dyroneteng@gmail.com>
> Signed-off-by: Chen Bojun <bojun.cbj@alibaba-inc.com>
> ---
>     receive-pack: purge temporary data if no command is ready to run

[...odd duplication of mostly the same commit message from GGG
(presumably...]

> -mk_empty () {
> +mk_empty() {

This patch includes a lot of line-re-wrapping, shell formatting changes
etc. You should really submit this without any of those & just have the
meaningful changes here.

> [...]
> -for head in HEAD @
> -do
> +for head in HEAD @; do

e.g. this, indentation changes earlier, and most of the changes here...

>  
>  	test_expect_success "push with $head" '
>  		mk_test testrepo heads/main &&
> @@ -1020,7 +1011,7 @@ test_expect_success 'push into aliased refs (inconsistent)' '
>  	)
>  '
>  
> -test_force_push_tag () {
> +test_force_push_tag() {
>  	tag_type_description=$1
>  	tag_args=$2
>  
> @@ -1066,7 +1057,7 @@ test_force_push_tag () {
>  test_force_push_tag "lightweight tag" "-f"
>  test_force_push_tag "annotated tag" "-f -a -m'tag message'"
>  
> -test_force_fetch_tag () {
> +test_force_fetch_tag() {
>  	tag_type_description=$1
>  	tag_args=$2
>  
> @@ -1158,8 +1149,7 @@ test_expect_success 'push --prune refspec' '
>  	! check_push_result testrepo $the_first_commit tmp/foo tmp/bar
>  '
>  
> -for configsection in transfer receive
> -do
> +for configsection in transfer receive; do
>  	test_expect_success "push to update a ref hidden by $configsection.hiderefs" '
>  		mk_test testrepo heads/main hidden/one hidden/two hidden/three &&
>  		(
> @@ -1250,8 +1240,7 @@ test_expect_success 'fetch exact SHA1 in protocol v2' '
>  	git -C child fetch -v ../testrepo $the_commit:refs/heads/copy
>  '
>  
> -for configallowtipsha1inwant in true false
> -do
> +for configallowtipsha1inwant in true false; do
>  	test_expect_success "shallow fetch reachable SHA1 (but not a ref), allowtipsha1inwant=$configallowtipsha1inwant" '
>  		mk_empty testrepo &&
>  		(
> @@ -1809,4 +1798,12 @@ test_expect_success 'refuse fetch to current branch of bare repository worktree'
>  	git -C bare.git fetch -u .. HEAD:wt
>  '
>  
> +test_expect_success 'refuse to push a hidden ref, and make sure do not pollute the repository' '
> +	mk_empty testrepo &&
> +	git -C testrepo config receive.hiderefs refs/hidden &&
> +	git -C testrepo config receive.unpackLimit 1 &&
> +	test_must_fail git push testrepo HEAD:refs/hidden/foo &&
> +	test_dir_is_empty testrepo/.git/objects/pack
> +'
> +
>  test_done
>
> base-commit: 297ca895a27a6bbdb7906371d533f72a12ad25b2


...until we get to this, this mostly OK, but maybe test the case for
what the hook does here (depending on what we want to do).

If the quarantine directory was not purged as before how does checking
whether testrepo/.git/objects/pack is empty help? We place those in
.git/objects/tmp_objdir-* don't we?
