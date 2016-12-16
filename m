Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A69FE1FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 19:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759248AbcLPT0u (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 14:26:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59392 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752203AbcLPT0t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 14:26:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20DC857E0C;
        Fri, 16 Dec 2016 14:13:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1nGShB9EXWY/QPVWOpMABIRwza0=; b=dgQg1a
        5Guwhor0XhZgTsQsoR2RnFklPLsBAlXFxLpUW16WYRgvac7FAFx0UslaTiApS7IY
        58K6tFiiGV2NPQoQMc4AMzU6GsXNGPqoB/ZV+7Nrjn1dvNZtNJ6irc5soT0eIZ4x
        VzhwqCUzzCXH+FUFCy/laCGHLO5EZ04wbMdeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RidFje+Nebp2zq0m3V8zzbqaVCvCbDXm
        GnjNA3R1EBuB1RLoPFVN7qLhPCMYmiFRKdKF2v+7cVSgeyewciSp4ijFTiLYQkIi
        JmOswjPoTsb4Bn9a9wL6eKJ05iSfyZUmC/WgLzVNGeLowugg6SkRn+LMKz4qb3e9
        e9odS8PqSco=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17B3557E0B;
        Fri, 16 Dec 2016 14:13:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7E42257E0A;
        Fri, 16 Dec 2016 14:13:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 11/34] sequencer (rebase -i): remove CHERRY_PICK_HEAD when no longer needed
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <81ba5f7ddb3a1a66e878b955094b7ae00f2cd781.1481642927.git.johannes.schindelin@gmx.de>
Date:   Fri, 16 Dec 2016 11:13:28 -0800
In-Reply-To: <81ba5f7ddb3a1a66e878b955094b7ae00f2cd781.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:30:38 +0100
        (CET)")
Message-ID: <xmqqd1grsn53.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA798E82-C3C3-11E6-808D-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The scripted version of the interactive rebase already does that.

Sensible.  I was wondering why this wasn't there while reviewing
10/34, comparing the two (this is not a suggestion to squash this
into the previous step).

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 855d3ba503..abffaf3b40 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1835,8 +1835,13 @@ static int commit_staged_changes(struct replay_opts *opts)
>  
>  	if (has_unstaged_changes(1))
>  		return error(_("cannot rebase: You have unstaged changes."));
> -	if (!has_uncommitted_changes(0))
> +	if (!has_uncommitted_changes(0)) {
> +		const char *cherry_pick_head = git_path("CHERRY_PICK_HEAD");
> +
> +		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
> +			return error(_("could not remove CHERRY_PICK_HEAD"));
>  		return 0;
> +	}
>  
>  	if (file_exists(rebase_path_amend())) {
>  		struct strbuf rev = STRBUF_INIT;
