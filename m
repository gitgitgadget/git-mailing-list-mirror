Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DE001F404
	for <e@80x24.org>; Tue,  4 Sep 2018 16:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeIDVOP (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 17:14:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33175 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeIDVOP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 17:14:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id r1-v6so9637461wmh.0
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 09:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=Z8zIxw6nZXFDsuyBcL9Nw9kCccixjeZn56xV2ugaMco=;
        b=NmqrYByz7SuNAISQZ4Vp0eoqRqOX7lfIX78ro4J8KIIaz04XYCoFK3cHJHzn82UQD4
         iwAHD2Nv7Teq1I4odmzgn+uKTaV3LGvSnRDFWA2d/gDaEotLLdK4WOjagRnBF/t/YVAp
         CepmB+Q67uKb1YOWN5UyruggzxPE1miu+rvsnxdmjClA0U7U4BMDy/tJE9ETWnV1UHfH
         1frNGUi5Tt/xbyY1EOfPUxjqbQ3Jg/4fRSJh+rfiY0lpfYGMPpUH706Rs6FZxHo6jzhk
         fzVlLlhY2W7f6iVNGwkIoZpIJ6s8/w0v6LgFW5aZJRxf6XGTlTQxY03hjjwSunQ8axmy
         F8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=Z8zIxw6nZXFDsuyBcL9Nw9kCccixjeZn56xV2ugaMco=;
        b=AAxTxKGRN+uwrWXjX69eqsTX9OhkTYJzb8NY26jjgxh0aqeSg5cEO6RATG2uSNxfuU
         JwQQdH4r33RK4c8hLarHObZ5qpjGoTQISXG2YofIpvvdd5qXkwNOpX9LTKEk4Dm2ddHU
         zvzDfJWIWTtg6iAzVn1rv7MjX0IMGVK6LTBfvt3Gf4ptYoCAwgNU61rQAZZxO/rgAKAD
         mxmDWEDumVvoq+VqGSsGRDixP95IMuGWwnuVGlm498SqOWLaW/snKZ/oaHNGpvdfFF11
         gizcVIWcsJAMDDpSv7ft/TD7d4OXfQ6KTHPItQ+OxSi5N+xcKfiOIr03LKojLTauNssL
         Fsqg==
X-Gm-Message-State: APzg51CQJUeQi/ls6DZrZwkQnLDAE1h6xMHmy75ESp0hSaH+5vJbqZzh
        udt6FrARPHfugPG/2IFLBYyN+3iN
X-Google-Smtp-Source: ANB0VdYh3u2cDKOP6Cfi1BQgBg9xFhRU+X1hAPlGL2jR26XGMGf0eE6qxALxVbvq8548mab6wgQxMA==
X-Received: by 2002:a1c:e904:: with SMTP id q4-v6mr3020558wmc.154.1536079697455;
        Tue, 04 Sep 2018 09:48:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y10-v6sm16050145wrl.87.2018.09.04.09.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 09:48:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] rebase -i: be careful to wrap up fixup/squash chains
References: <pull.30.git.gitgitgadget@gmail.com>
        <0c9d0f75fc0dd28d55d4ed41d008182746fc86cd.1535759099.git.gitgitgadget@gmail.com>
Date:   Tue, 04 Sep 2018 09:48:16 -0700
Message-ID: <xmqqftypb44v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/sequencer.c b/sequencer.c
> index 84bf598c3e..ac5c805c14 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3578,9 +3578,20 @@ static int commit_staged_changes(struct replay_opts *opts,
>  		 * the commit message and if there was a squash, let the user
>  		 * edit it.
>  		 */
> -		if (is_clean && !oidcmp(&head, &to_amend) &&
> -		    opts->current_fixup_count > 0 &&
> -		    file_exists(rebase_path_stopped_sha())) {
> +		if (!is_clean || !opts->current_fixup_count)
> +			; /* this is not the final fixup */
> +		else if (oidcmp(&head, &to_amend) ||
> +			 !file_exists(rebase_path_stopped_sha())) {
> +			/* was a final fixup or squash done manually? */
> +			if (!is_fixup(peek_command(todo_list, 0))) {
> +				unlink(rebase_path_fixup_msg());
> +				unlink(rebase_path_squash_msg());
> +				unlink(rebase_path_current_fixups());
> +				strbuf_reset(&opts->current_fixups);
> +				opts->current_fixup_count = 0;
> +			}

Let me see if the code is easily grokkable by (trying to) follow
aloud.

    We used to refrain from going into this big else clause that
    does the fixup-squash handling when is_clean is false,
    current-count is not yet zero, head and to-amend are different
    commits or stopped-sha file is missing.  The updated code still
    refrains from going into the big else clause under exactly the
    same condition, but it learned to clean up the state, when the
    _next_ one is not a fix-up, i.e. when we are looking at the last
    fixup/squash in the current chain.  And the lack of clean-up
    would have resulted in the next step misbehaving.

I see a few calls to is_fixup(peek_command()) and a local boolean
variable final_fixup used in this function.  I have to wonder if it
makes the resulting code, especially the above part, easier to
follow and understand, if the function peeked todo-list to check if
we are dealing with the final fix-up in a chain very early just
once, and used it to see "are we doing the final fixup/squash in the
current chain?" throughout the rest of the function.

	Side note: I actually think that the existing final_fixup
	boolean means something different (iow, final_fixup is not
	set inside the new "clean-up" code above, even though we
	dealt with the last one in the fix-up chain, and that is not
	a bug---which means that "final_fixup" does not mean "we are
	dealing with the last one in the fix-up chain"), which may
	want to be clarified a bit with in-code comment near where
	the variable is defined for the function to be readable.

In any case, thanks for fixing this, which seems to have appeared in
Git 2.18.  Let's fork a topic from maint, cook it in 'next' and aim
for eventually merging it down for both 2.19 and 2.18 tracks.

> +		} else {
> +			/* we are in a fixup/squash chain */
>  			const char *p = opts->current_fixups.buf;
>  			int len = opts->current_fixups.len;
>  
> diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
> index 7d5ea340b3..13f5688135 100755
> --- a/t/t3415-rebase-autosquash.sh
> +++ b/t/t3415-rebase-autosquash.sh
> @@ -330,7 +330,7 @@ test_expect_success 'wrapped original subject' '
>  	test $base = $parent
>  '
>  
> -test_expect_failure 'abort last squash' '
> +test_expect_success 'abort last squash' '
>  	test_when_finished "test_might_fail git rebase --abort" &&
>  	test_when_finished "git checkout master" &&
