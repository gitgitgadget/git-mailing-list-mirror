Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9F2C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 22:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BDC21582
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 22:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wxkty7qw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfLQWl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 17:41:59 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50331 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfLQWl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 17:41:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 281819CABF;
        Tue, 17 Dec 2019 17:41:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hQXozdLO36Fv5jRFHqHxKFjypMw=; b=wxkty7
        qwODUOQ3DNQAJqHdaba2MrW8ej3tRAIPNkdgVsmuxDUQt4gb7c6pJfsTC+KUbifY
        7r/BzdnisrwbiB67qoT5gOYhJ1QeteCZa75cdDNKsYiKm+BNyuStDMTdWNAmdkpD
        BQ8h0LxR+GjMBChK6KVUS8DAtvXK6Os7b25NE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jsa7BTrgbhlqMWlCO5vyMfzcH1pp2J5f
        ftrmohn7bttgcChEHIAH5vSMzJow22JJocXcIkCdldJGwN/fEpvLZ/kY35sV3v5/
        UNubFBp6AiN8HdF9UMmRH7vxi+HY2BkOnPMeaTW2GjgABBKYLRCCIdg1yx+MMPWS
        /KlibBwjuAk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 219AD9CABE;
        Tue, 17 Dec 2019 17:41:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4A8889CABC;
        Tue, 17 Dec 2019 17:41:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH 1/1] commit: display advice hints when commit fails
References: <pull.495.git.1576574242.gitgitgadget@gmail.com>
        <f23477c5a32e5d638310024194040146026972b8.1576574242.git.gitgitgadget@gmail.com>
Date:   Tue, 17 Dec 2019 14:41:53 -0800
In-Reply-To: <f23477c5a32e5d638310024194040146026972b8.1576574242.git.gitgitgadget@gmail.com>
        (Heba Waly via GitGitGadget's message of "Tue, 17 Dec 2019 09:17:22
        +0000")
Message-ID: <xmqq5ziefuby.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D35F0D2-211E-11EA-82DB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 2db2ad0de4..4439666465 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -961,6 +961,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	 */
>  	if (!committable && whence != FROM_MERGE && !allow_empty &&
>  	    !(amend && is_a_merge(current_head))) {
> +		s->hints = advice_status_hints;
>  		s->display_comment_prefix = old_display_comment_prefix;
>  		run_status(stdout, index_file, prefix, 0, s);
>  		if (amend)

It almost tempts me to say why this is not done inside run_status(),
which has other callers, but I think the answer is because we do not
want these hints when we are actually committing (iow, the ongoing
commit must be aborted before the user can actually say "git add"
etc. that are suggested).  

So the change makes sense to me.

Will queue.

> diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> index 46a5cd4b73..3d76e8ebbd 100755
> --- a/t/t7500-commit-template-squash-signoff.sh
> +++ b/t/t7500-commit-template-squash-signoff.sh
> @@ -382,4 +382,13 @@ test_expect_success 'check commit with unstaged rename and copy' '
>  	)
>  '
>  
> +test_expect_success 'commit without staging files fails and displays hints' '
> +	echo "initial" >>file &&
> +	git add file &&
> +	git commit -m initial &&
> +	echo "changes" >>file &&
> +	test_must_fail git commit -m initial >actual &&
> +	test_i18ngrep "no changes added to commit (use \"git add\" and/or \"git commit -a\")" actual
> +'
> +
>  test_done
