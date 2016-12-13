Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66BE9203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 18:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941046AbcLMSC7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 13:02:59 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50935 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941017AbcLMSCy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 13:02:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A314D54CB7;
        Tue, 13 Dec 2016 13:02:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0oTZ8Dw5USdMf+r7A0M3J4P2SAo=; b=qp4JT6
        9uBX9pwzsDFZLrWdDrI0DWSdjrF7nU2J1KHfr7butR2x2ve2CFCb3h4kX4wsWWv0
        1K/NfboSh0HzBnKO9rCdKnXauAq7GNeTWxd4jXHQbr36cwFHJ+bB9+rJlGXlcMrf
        PqOILuPKZKo0ivCYjVNpRoUqLs+2mBdmis7ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kWM7s297JZUX0IB5HUa0flMyod8AU8fG
        S5Wi65u2Zj3uLFRoDmkXK62xBIdbD9fYX5EV76PDNHP2FCBSYBL63UPeH5z/eTqs
        35QAaSTVnpKhBJnRqhcWLmTz7tLn5b/O/SYipZEhiwALUvsX+pWfIPQyC9zzHOHI
        P6STM6YOEq8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A3BC54CB5;
        Tue, 13 Dec 2016 13:02:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 006AB54CB3;
        Tue, 13 Dec 2016 13:02:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Packham <judge.packham@gmail.com>
Cc:     git@vger.kernel.org, mah@jump-ing.de, peff@peff.net,
        jacob.keller@gmail.com
Subject: Re: [PATCHv2 1/2] merge: Add '--continue' option as a synonym for 'git commit'
References: <20161212083413.7334-1-judge.packham@gmail.com>
        <20161213084859.13426-1-judge.packham@gmail.com>
Date:   Tue, 13 Dec 2016 10:02:50 -0800
In-Reply-To: <20161213084859.13426-1-judge.packham@gmail.com> (Chris Packham's
        message of "Tue, 13 Dec 2016 21:48:58 +1300")
Message-ID: <xmqq60mn671x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D71ECB4-C15E-11E6-9EE1-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Packham <judge.packham@gmail.com> writes:

> +'git merge' --continue
>  
>  DESCRIPTION
>  -----------
> @@ -61,6 +62,9 @@ reconstruct the original (pre-merge) changes. Therefore:
>  discouraged: while possible, it may leave you in a state that is hard to
>  back out of in the case of a conflict.
>  
> +The fourth syntax ("`git merge --continue`") can only be run after the
> +merge has resulted in conflicts.

OK.  I can see that the code refuses if there is no MERGE_HEAD, so
"can only be run" is ensured correctly.

> 'git merge --continue' will take the
> +currently staged changes and complete the merge.

For Git-savvy folks, this may be sufficient to tell that they are
expected to resolve conflicts in the working tree and register the
resolusion by doing "git add" before running "git merge --continue",
but I wonder if that is clear enough for new readers.

The same comment applies to the option description below.  I suspect
that it is better to remove the last sentence above, leaving "4th
one can be run only with MERGE_HEAD" here, and enhance the
explanation in the option description (see below).

>  OPTIONS
>  -------
> @@ -99,6 +103,12 @@ commit or stash your changes before running 'git merge'.
>  'git merge --abort' is equivalent to 'git reset --merge' when
>  `MERGE_HEAD` is present.
>  
> +--continue::
> +	Take the currently staged changes and complete the merge.
> ++
> +'git merge --continue' is equivalent to 'git commit' when
> +`MERGE_HEAD` is present.
> +

These two sentences are even more technical and unfriendly to new
readers, I am afraid.  How about giving a hint by referring to an
existing section, like this?

    --continue::
        After a "git merge" stops due to conflicts you can conclude
        the merge by running "git merge --continue" (see "How to
        resolve conflicts" section below).

> @@ -277,7 +287,8 @@ After seeing a conflict, you can do two things:
>  
>   * Resolve the conflicts.  Git will mark the conflicts in
>     the working tree.  Edit the files into shape and
> -   'git add' them to the index.  Use 'git commit' to seal the deal.
> +   'git add' them to the index.  Use 'git merge --continue' to seal the
> +   deal.

Why do we want to make it harder to discover "git commit" here?
I would understand:

	... Use 'git commit' to conclude (you can also say 'git
	merge --continue').

though.  After all, we are merely introducing a synonym for those
who want to type more.  There is no plan to deprecate the use of
'git commit', which is a perfectly reasonable way to conclude an
interrupted merge, that has worked well for us for the past 10 years
and still works.

> @@ -65,6 +66,7 @@ static int option_renormalize;
>  static int verbosity;
>  static int allow_rerere_auto;
>  static int abort_current_merge;
> +static int continue_current_merge;
>  static int allow_unrelated_histories;
>  static int show_progress = -1;
>  static int default_to_upstream = 1;
> @@ -223,6 +225,8 @@ static struct option builtin_merge_options[] = {
>  	OPT__VERBOSITY(&verbosity),
>  	OPT_BOOL(0, "abort", &abort_current_merge,
>  		N_("abort the current in-progress merge")),
> +	OPT_BOOL(0, "continue", &continue_current_merge,
> +		N_("continue the current in-progress merge")),
>  	OPT_BOOL(0, "allow-unrelated-histories", &allow_unrelated_histories,
>  		 N_("allow merging unrelated histories")),
>  	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
> @@ -739,7 +743,7 @@ static void abort_commit(struct commit_list *remoteheads, const char *err_msg)
>  	if (err_msg)
>  		error("%s", err_msg);
>  	fprintf(stderr,
> -		_("Not committing merge; use 'git commit' to complete the merge.\n"));
> +		_("Not committing merge; use 'git merge --continue' to complete the merge.\n"));

Likewise.  I do not see a need to change this one at all.

> @@ -1166,6 +1170,22 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		goto done;
>  	}
>  
> +	if (continue_current_merge) {
> +		int nargc = 1;
> +		const char *nargv[] = {"commit", NULL};
> +
> +		if (argc)
> +			usage_msg_opt("--continue expects no arguments",
> +			      builtin_merge_usage, builtin_merge_options);

Peff already commented on "what about other options?", and I think
his "check the number of args before parse-options ran to ensure
that the '--abort' or '--continue' was the only thing" is probably
a workable hack.

The "right" way to fix it would be way too involved to be worth for
just this single change (and also fixing "--abort").  Just thinking
aloud:

 * Update parse-options API to:

   - extend "struct option" with one field that holds what "command
     modes" the option the "struct option" describes is incompatible
     with.

   - make parse_options() to keep track of the set of command modes
     that are compatible with the options seen so far, and complain
     if an option that is not compatible with the command mode is
     given.

 * Use the above facility to update "git merge" so that --abort and
   --continue becomes OPT_CMDMODE.

Then, the updated parse_options() would:

 - start by making the "incompatible command modes" an empty set.

 - while it processes each option on the command line:

   - if it is not an OPTION_CMDMODE, add the set of command modes
     that are incompatible with the option to the "incompatible
     command modes".

   - if it is an OPTION_CMDMODE and we already saw another
     OPTION_CMDMODE, error out (we already do this).

 - after all options are read, check the final command mode and see
   if that is in "incompatible command modes".

You can mark almost all options "git merge" takes except a selected
few like "--quiet" as incompatible with "--abort" and "--continue"
and let parse_options() catch incompatible options.  Of course you
still need to check argc for non-option here.

