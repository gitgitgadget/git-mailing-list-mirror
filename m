Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FEFC7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 19:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjEIT2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 15:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjEIT2U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 15:28:20 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE40448F
        for <git@vger.kernel.org>; Tue,  9 May 2023 12:28:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-643bb9cdd6eso3860858b3a.1
        for <git@vger.kernel.org>; Tue, 09 May 2023 12:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683660497; x=1686252497;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2cMxwE4KTfhi2Fofux5FYX6wBgF25o241RpJQiKFsc=;
        b=aI7Ta8hCzjAtxC7a7R7njPqZrk4MX1E1Hi9cUC2AxSXB2Op/T/+XU8LNMZ09T1/oW2
         pMJZMFWLPfBuNrq8Ng4vB50Z6x3+Rm5BWomABp7q7e+OFQk4w8wIf0VH2ipUfwT0cZhp
         r6K5s/iWG59TLJwrdN05TwustxAS6MS10OTjIxWXJx+h5HzjrZ9Jr19BtW7GbZC8XwOO
         1BJ2s0fIkB97K/233vOWb/yCus8D9TYIIJtzGHCnObnavEyMcFYdoK9hmcDfTNNXXfvB
         QqveusAvIp0JDEg/n0FTRdxg0TIZy8iTt87U54tl6yo3lOumSTupvRZo7DgIL1Ak33lm
         lQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683660497; x=1686252497;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C2cMxwE4KTfhi2Fofux5FYX6wBgF25o241RpJQiKFsc=;
        b=VtgBn7zAXfPCH8AigwtYmVgYwXa1W70qn+ulPnoIoGYaRXk/+LEcat0E+nah1XTrfb
         Cfr1tglCZgPeGOHDu5l1nW9ZdHbD86atvsJE7if8ou2JCpg+f/NrB++6543EKm4ll11A
         8BxmGFCN7wpAAhXoJLoxjfR8G1or6axtoJIW+UNeYlkeloFT7j2GGNdHge/snCqqgIu2
         dIyuqKo0fjcL0EevEKk981huwOwtaVRg4JQDl2pjjTJMirsdSbq6rgrHT2RRpYNgBtS2
         V9f5qC3zibFrH3sG/5W+fuxtlIjAggzLe1DrrOIqV7410vHjTxfCq4DDv8rN+CfZwKpy
         RfRw==
X-Gm-Message-State: AC+VfDzkJf65D7rIJtQD2Fmox1h9D2+zSEmGsU2K9D7ZP/jSE1fGFgPW
        AnjJPkhhQue0cJ37KyCH3Vc=
X-Google-Smtp-Source: ACHHUZ5BAyjzqONhIVzqRMv468xzra9Wvd8BYnxTR8fyTN/852NLMf8cFEjJvCuIL1BmP9Zxit1ezw==
X-Received: by 2002:a05:6a00:14c8:b0:63d:2d8c:7fd5 with SMTP id w8-20020a056a0014c800b0063d2d8c7fd5mr20537202pfu.12.1683660497072;
        Tue, 09 May 2023 12:28:17 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id c8-20020a62e808000000b0063b1b84d54csm2060266pfi.213.2023.05.09.12.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:28:16 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v4 4/8] fetch: fix missing from-reference when fetching
 HEAD:foo
References: <cover.1681906948.git.ps@pks.im> <cover.1683636885.git.ps@pks.im>
        <e599ea6d335d16b45fa75b223ea8db93e46c627d.1683636885.git.ps@pks.im>
Date:   Tue, 09 May 2023 12:28:16 -0700
In-Reply-To: <e599ea6d335d16b45fa75b223ea8db93e46c627d.1683636885.git.ps@pks.im>
        (Patrick Steinhardt's message of "Tue, 9 May 2023 15:02:15 +0200")
Message-ID: <xmqqednpxq27.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> But it is not intended when displaying the updated references and would
> cause us to miss the left-hand side of the displayed reference update:
>
> ```
> $ git fetch origin HEAD:foo
> From https://github.com/git/git
>  * [new ref]                          -> foo
> ```
> The HEAD string is clearly missing from the left-hand side of the arrow,
> which is further stressed by the point that the following commands show
> the left-hand side as expected:
>
> ```
> $ git fetch origin HEAD
> From https://github.com/git/git
>  * branch                  HEAD       -> FETCH_HEAD

I do not mind being explicit and showing HEAD in this case for the
sake of consistency.

But speaking for the past developers, it was deliberate to omit what
is common from the output to make it more terse, IIRC, and I think
it is unfair to call it a "BUG".

Back when we wrote git-fetch-script, the output was a lot more
verbose, and through efforts like 165f3902 (git-fetch: more terse
fetch output, 2007-11-03) and numerous others over time, we got to
the current output.

> Note that this patch also changes formatting of the block that computes
> the "kind" and "what" variables. This is done on purpose so that it is
> part of the diff, hopefully making the change easier to comprehend.

Just to help readers, "kind" is the category like branch, tag,
etc. and "what" is the concrete name like 'master' and 'foo'.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 08d7fc7233..6aecf549e8 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -918,12 +918,14 @@ static void display_ref_update(struct display_state *display_state, char code,
>  	}
>  
>  	width = (summary_width + strlen(summary) - gettext_width(summary));
> +	remote = prettify_refname(remote);
> +	local = prettify_refname(local);
>  
>  	strbuf_addf(&display_state->buf, " %c %-*s ", code, width, summary);
>  	if (!display_state->compact_format)
> -		print_remote_to_local(display_state, remote, prettify_refname(local));
> +		print_remote_to_local(display_state, remote, local);
>  	else
> -		print_compact(display_state, remote, prettify_refname(local));
> +		print_compact(display_state, remote, local);
>  	if (error)
>  		strbuf_addf(&display_state->buf, "  (%s)", error);
>  	strbuf_addch(&display_state->buf, '\n');
> @@ -934,7 +936,7 @@ static void display_ref_update(struct display_state *display_state, char code,
>  static int update_local_ref(struct ref *ref,
>  			    struct ref_transaction *transaction,
>  			    struct display_state *display_state,
> -			    const char *remote, const struct ref *remote_ref,
> +			    const struct ref *remote_ref,
>  			    int summary_width)
>  {
>  	struct commit *current = NULL, *updated;
> @@ -946,7 +948,7 @@ static int update_local_ref(struct ref *ref,
>  	if (oideq(&ref->old_oid, &ref->new_oid)) {
>  		if (verbosity > 0)
>  			display_ref_update(display_state, '=', _("[up to date]"), NULL,
> -					   remote, ref->name, summary_width);
> +					   remote_ref->name, ref->name, summary_width);

Makes sense.  The variable "remote" (now removed) holds what to
write to FETCH_HEAD to be used to formulate a merge message by the
caller, but this function is purely to report the ref updates and
has no need to have access to that information.

> @@ -1252,14 +1254,13 @@ static int store_updated_refs(struct display_state *display_state,
>  			if (!strcmp(rm->name, "HEAD")) {
>  				kind = "";
>  				what = "";
> -			}
> -			else if (skip_prefix(rm->name, "refs/heads/", &what))
> +			} else if (skip_prefix(rm->name, "refs/heads/", &what)) {
>  				kind = "branch";
> -			else if (skip_prefix(rm->name, "refs/tags/", &what))
> +			} else if (skip_prefix(rm->name, "refs/tags/", &what)) {
>  				kind = "tag";
> -			else if (skip_prefix(rm->name, "refs/remotes/", &what))
> +			} else if (skip_prefix(rm->name, "refs/remotes/", &what)) {
>  				kind = "remote-tracking branch";
> -			else {
> +			} else {
>  				kind = "";
>  				what = rm->name;
>  			}

This is a bit noisier than necessary.  It took me a while until I
realized that this hunk is a no-op.

> @@ -1277,7 +1278,7 @@ static int store_updated_refs(struct display_state *display_state,
>  					  display_state->url_len);
>  
>  			if (ref) {
> -				rc |= update_local_ref(ref, transaction, display_state, what,
> +				rc |= update_local_ref(ref, transaction, display_state,
>  						       rm, summary_width);
>  				free(ref);

Good.

> @@ -1288,7 +1289,7 @@ static int store_updated_refs(struct display_state *display_state,
>  				 */
>  				display_ref_update(display_state, '*',
>  						   *kind ? kind : "branch", NULL,
> -						   *what ? what : "HEAD",
> +						   rm->name,
>  						   "FETCH_HEAD", summary_width);

Good, too.  The original cleared "what" and then to compensate for
that had a logic to turn it back to "HEAD", but that is all gone by
passing rm->name down.  

I think we could pass "rm" and leave it to display_ref_update() what
string to use, if we wanted to further refine the output later.

Then somebody in the future may even want to see "HEAD" to be shown
as an empty string and that can all be done in display_ref_update().
It would fix the inconsistency that "git fetch origin HEAD" reports
"HEAD -> FETCH_HEAD" by hiding "HEAD" just like the case where
fetching "HEAD:foo" does, going in the other direction, I would
think.

Thanks.
