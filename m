Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C33B11F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 08:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbeKQSWj (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Nov 2018 13:22:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62440 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeKQSWj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Nov 2018 13:22:39 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E47110D070;
        Sat, 17 Nov 2018 03:06:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5lwEqKzq9TF9HfedM09XquTcCuo=; b=A1hr4d
        Rsjr/6mM+3jYgaT1rW5K7weKE/8BOXzF+Pvj8AU7s7ppzmRoNHalogHO1J6Ghzx1
        IbXkZiHoTff+mwtfnUJUwl86Ad6mx5INFDJ02sGTgxnJrloCGTgOInBygVzapUF+
        dIifiu0Yi/MhHzI6ICqm9RUXo43bEWqV/QErc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q68NXDlHV8otCCSLac38ZJ16fAhcdpyH
        GprwidxC6Mr7FraDc8rUN84hMWIL/aoTy1NavHvRDnGhsGA4+TdFrj3hfoX2mhyK
        DlfUIVdwaIoFUMh54AI6AFy87WInfsqoWiuFS+MbVHPCg5DH5BlMwh5/dYKqf+Es
        UAFfEEp76lE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37BF310D06E;
        Sat, 17 Nov 2018 03:06:45 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A80F610D06D;
        Sat, 17 Nov 2018 03:06:44 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] commit: don't add scissors line if one exists in MERGE_MSG
References: <cover.1542172724.git.liu.denton@gmail.com>
        <cover.1542380865.git.liu.denton@gmail.com>
        <1698fe0d7b7356ea1762f410767dcaf2807ea5c2.1542380865.git.liu.denton@gmail.com>
Date:   Sat, 17 Nov 2018 17:06:43 +0900
In-Reply-To: <1698fe0d7b7356ea1762f410767dcaf2807ea5c2.1542380865.git.liu.denton@gmail.com>
        (Denton Liu's message of "Fri, 16 Nov 2018 10:19:19 -0500")
Message-ID: <xmqq36s0i0vg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B945C478-EA3F-11E8-A09B-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> If commit.cleanup = scissors is specified, don't produce a scissors line
> if one already exists in the MERGE_MSG file.

Are we already sometimes adding a scissors line in that file?  The
impression I was getting was that the change in the step 2/2 is the
only reason why this becomes necessary.  In which case this change
makes no sense as a standalone patch and requires 2/2 to be a
sensible change, no?

> @@ -798,7 +807,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		struct ident_split ci, ai;
>  
>  		if (whence != FROM_COMMIT) {
> -			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
> +			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
> +				!merge_contains_scissors)
>  				wt_status_add_cut_line(s->fp);
>  			status_printf_ln(s, GIT_COLOR_NORMAL,
>  			    whence == FROM_MERGE

This one is done before we show a block of text, which looks correct.

> @@ -824,7 +834,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  				  " Lines starting\nwith '%c' will be ignored, and an empty"
>  				  " message aborts the commit.\n"), comment_line_char);
>  		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
> -			 whence == FROM_COMMIT)
> +			 whence == FROM_COMMIT &&
> +			 !merge_contains_scissors)
>  			wt_status_add_cut_line(s->fp);
>  		else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
>  			status_printf(s, GIT_COLOR_NORMAL,

The correctness of this one in an if/elseif/else cascade is less
clear.  When "contains scissors" logic does not kick in, we just
have a scissors line here (i.e. the original behaviour).  Now when
the new logic kicks in, we not just omit the (extra) scissors line,
but also say "Please enter the commit message..." which is the
message used with the "comment line char" mode of the clean-up.

I wonder if this is what you really meant to have instead:

>  		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
> -			 whence == FROM_COMMIT)
> - 			wt_status_add_cut_line(s->fp);
> +			 whence == FROM_COMMIT) {
> +			 if (!merge_contains_scissors)
> +				wt_status_add_cut_line(s->fp);
> +		}
>  		else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
>  			status_printf(s, GIT_COLOR_NORMAL,

That is, the only behaviour change in "merge contains scissors"
mode is to omit the cut line and nothing else.
