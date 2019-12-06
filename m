Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5CFC43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 18:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83ECC24673
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 18:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gn+lYmSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfLFSNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 13:13:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57878 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfLFSNg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 13:13:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D4B5F1E42B;
        Fri,  6 Dec 2019 13:13:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IG7kX/Hodmr3VOwmWzx6aKFwVJs=; b=Gn+lYm
        Slmp73PeUJjjWXcezb5Tre5IqqxG782RvVTDkOi39YLHn6tXX51ihQjHaFty17GP
        f+w5dbbgOSKj4PF5/o0tFZjGcWds+CkIi21sSY9iB4QkettUaUG1IXNgFefFjtgj
        2hTY+qXisJjQkpr2JiKr7R8vadPvVtFK8cZl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PaPzLyCXS0hSVfS/uvyYmPsdOlSnN3iT
        ti1FXt/CxrIsSKtQpBMzQbnBNBXr9M3noXRJfdZET0I33zCQ1SU/HUdvPJT3t34+
        yytGooul7Ea/7wIVdjtgweDkY17UjphfIQaDT4gllw4gnOzG4NEKO/KJ+PEXq5LF
        N83q1/tlWKk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB4581E42A;
        Fri,  6 Dec 2019 13:13:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07B1E1E429;
        Fri,  6 Dec 2019 13:13:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 5/9] commit: use enum value for multiple cherry-picks
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
        <20191206160614.631724-1-phillip.wood123@gmail.com>
        <20191206160614.631724-6-phillip.wood123@gmail.com>
Date:   Fri, 06 Dec 2019 10:13:31 -0800
In-Reply-To: <20191206160614.631724-6-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Fri, 6 Dec 2019 16:06:10 +0000")
Message-ID: <xmqq1rthxqyc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CF6CE66-1854-11EA-B3C9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Add FROM_CHERRY_PICK_MULTI for a sequence of cherry-picks rather than
> using a separate variable.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/commit.c | 25 +++++++++++--------------
>  wt-status.h      |  9 ++++++++-
>  2 files changed, 19 insertions(+), 15 deletions(-)

Makes sense.  The checks have become quite pleasant to read, thanks
to the new helper function.

> ...
> -	if (whence == FROM_CHERRY_PICK && !renew_authorship) {
> +	if (is_from_cherry_pick(whence) && !renew_authorship) {
>  		author_message = "CHERRY_PICK_HEAD";
>  		author_message_buffer = read_commit_message(author_message);
>  	}
> diff --git a/wt-status.h b/wt-status.h
> index 64f1ddc9fd..0098fdb0b5 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -39,9 +39,16 @@ enum show_ignored_type {
>  enum commit_whence {
>  	FROM_COMMIT,     /* normal */
>  	FROM_MERGE,      /* commit came from merge */
> -	FROM_CHERRY_PICK /* commit came from cherry-pick */
> +	FROM_CHERRY_PICK_SINGLE, /* commit came from cherry-pick */
> +	FROM_CHERRY_PICK_MULTI /* commit came from a sequence of cherry-picks */
>  };

It might be worth to end PICK_MULTI with a trailing comma to
future-proof, but not worth a reroll for this alone.

