Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56A2203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 17:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbcGVRUH (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 13:20:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751605AbcGVRUF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 13:20:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C19AE2CD28;
	Fri, 22 Jul 2016 13:20:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X3qOSM9jvFYIns67GJzaqxUkqX4=; b=VBA+kY
	gyc8uhtO++l/UYes4UekKulx/z090CgQCVcr3u2cAuVLZEDmFtgmsN0OTYBmeTV8
	maqa+w3gMjnhujsJgxYmZZlLIGDaAlr1fZmcKfB1HCXYOdv4SoIkOiLKnOaLXtTl
	whgVaJIWz1L4Ki4USHPadXW8muAffAXZFZByI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bvr+Na42sAuk19/dvnpxmldTY8oWsr7y
	ANutHuHSC4M2AxIZidaLzqj+oxkY0YTYqqhG91zRj0y5tpKeyOi2x/RjYqP8I0ac
	N8pCZz6SsyyjgXuxesiWbomK4UJVntOoI7Nf/n+Y0CfAE93bif5U2OK7gUC/+k46
	qOZ3U6w6occ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B4E842CD27;
	Fri, 22 Jul 2016 13:20:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D115B2CD25;
	Fri, 22 Jul 2016 13:20:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Matthieu Moy <Matthieu.Moy@imag.fr>
Cc:	git@vger.kernel.org, Thibault Durand <thibault.durand.28@gmail.com>
Subject: Re: [RFC/PATCH] status: suggest 'git merge --abort' when appropriate
References: <20160721125837.3127-1-Matthieu.Moy@imag.fr>
Date:	Fri, 22 Jul 2016 10:19:59 -0700
In-Reply-To: <20160721125837.3127-1-Matthieu.Moy@imag.fr> (Matthieu Moy's
	message of "Thu, 21 Jul 2016 14:58:37 +0200")
Message-ID: <xmqqa8h9bneo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86A06EA2-5030-11E6-9BD9-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> We already suggest 'git rebase --abort' during a conflicted rebase.
> Similarly, suggest 'git merge --abort' during conflict resolution on
> 'git merge'.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

It wasn't immediately obvious without the context that the changed
code will trigger only during a merge, and not just any other case
where we have unmerged index entries.  show_merge_in_progress() is
only called when s.merge_in_progress is set, which in turn is set
only when MERGE_HEAD is there, so we are good here.

Will apply; thanks.

>  t/t7060-wtstatus.sh    | 4 ++++
>  t/t7512-status-help.sh | 1 +
>  wt-status.c            | 7 +++++--
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
> index 44bf1d8..4d17363 100755
> --- a/t/t7060-wtstatus.sh
> +++ b/t/t7060-wtstatus.sh
> @@ -34,6 +34,7 @@ test_expect_success 'M/D conflict does not segfault' '
>  On branch side
>  You have unmerged paths.
>    (fix conflicts and run "git commit")
> +  (use "git merge --abort" to abort the merge)
>  
>  Unmerged paths:
>    (use "git add/rm <file>..." as appropriate to mark resolution)
> @@ -138,6 +139,7 @@ test_expect_success 'status when conflicts with add and rm advice (deleted by th
>  On branch master
>  You have unmerged paths.
>    (fix conflicts and run "git commit")
> +  (use "git merge --abort" to abort the merge)
>  
>  Unmerged paths:
>    (use "git add/rm <file>..." as appropriate to mark resolution)
> @@ -171,6 +173,7 @@ test_expect_success 'status when conflicts with add and rm advice (both deleted)
>  On branch conflict_second
>  You have unmerged paths.
>    (fix conflicts and run "git commit")
> +  (use "git merge --abort" to abort the merge)
>  
>  Unmerged paths:
>    (use "git add/rm <file>..." as appropriate to mark resolution)
> @@ -195,6 +198,7 @@ test_expect_success 'status when conflicts with only rm advice (both deleted)' '
>  On branch conflict_second
>  You have unmerged paths.
>    (fix conflicts and run "git commit")
> +  (use "git merge --abort" to abort the merge)
>  
>  Changes to be committed:
>  
> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index 49d19a3..5c3db65 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -29,6 +29,7 @@ test_expect_success 'status when conflicts unresolved' '
>  On branch conflicts
>  You have unmerged paths.
>    (fix conflicts and run "git commit")
> +  (use "git merge --abort" to abort the merge)
>  
>  Unmerged paths:
>    (use "git add <file>..." to mark resolution)
> diff --git a/wt-status.c b/wt-status.c
> index de62ab2..1f21b6a 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -948,9 +948,12 @@ static void show_merge_in_progress(struct wt_status *s,
>  {
>  	if (has_unmerged(s)) {
>  		status_printf_ln(s, color, _("You have unmerged paths."));
> -		if (s->hints)
> +		if (s->hints) {
>  			status_printf_ln(s, color,
> -				_("  (fix conflicts and run \"git commit\")"));
> +					 _("  (fix conflicts and run \"git commit\")"));
> +			status_printf_ln(s, color,
> +					 _("  (use \"git merge --abort\" to abort the merge)"));
> +		}
>  	} else {
>  		s-> commitable = 1;
>  		status_printf_ln(s, color,
