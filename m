Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 145BE20A40
	for <e@80x24.org>; Mon, 27 Nov 2017 05:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750932AbdK0F2c (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 00:28:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57123 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750773AbdK0F2b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 00:28:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C52ABC666;
        Mon, 27 Nov 2017 00:28:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L/sRVLY4BojNTSDqwDm/kPSRKz0=; b=eHO2Rj
        Pq9fMZ35ROKUqGWnlhlbxJMO8JAZF7gv0Rd1kMNZAnuFzK2BzfPeAfbqXeV+uuXl
        1OCFnIVtHoNUBE0IkdCgbc1wYKhObFZ41mkqtlUM05jy4BNHlwoTcfzg8hCifO19
        hfTLm+5qNC8eUCK0+jsjHysNxYpHk8R6ZN8C4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=imqIS6j0C3UcQj6wi/k2z1fZZLEMoVTC
        h0d7dQKDeDYXWij8a+U0M8nRx+oDcS+RcTgaRS8RBHTlAaggQla3rbk//h3fAye6
        nMlURaWEGECDZkvd8kzLbzLNa8ujoe1WzvobfTkn1lsEqDxUsCQCZE5NiODUtLzE
        04aL0llS4iA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03B60BC665;
        Mon, 27 Nov 2017 00:28:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7BC54BC664;
        Mon, 27 Nov 2017 00:28:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, avarab@gmail.com
Subject: Re: [PATCH 5/5] t3404: add test case for abbreviated commands
References: <20171127045514.25647-1-liambeguin@gmail.com>
        <20171127045514.25647-6-liambeguin@gmail.com>
Date:   Mon, 27 Nov 2017 14:28:29 +0900
In-Reply-To: <20171127045514.25647-6-liambeguin@gmail.com> (Liam Beguin's
        message of "Sun, 26 Nov 2017 23:55:14 -0500")
Message-ID: <xmqqr2skcmte.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDA7CB9C-D333-11E7-BD03-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Liam Beguin <liambeguin@gmail.com> writes:

> Make sure the todo list ends up using single-letter command
> abbreviations when the rebase.abbreviateCommands is enabled.
> This configuration options should not change anything else.
>
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> ---
>  t/t3404-rebase-interactive.sh | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 6a82d1ed876d..e460ebde3393 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1260,6 +1260,38 @@ test_expect_success 'rebase -i respects rebase.missingCommitsCheck = error' '
>  	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
>  '
>  
> +test_expect_success 'prepare rebase.abbreviateCommands' '
> +	reset_rebase &&
> +	git checkout -b abbrevcmd master &&
> +	test_commit "first" file1.txt "first line" first &&
> +	test_commit "second" file1.txt "another line" second &&
> +	test_commit "fixup! first" file2.txt "first line again" first_fixup &&
> +	test_commit "squash! second" file1.txt "another line here" second_squash
> +'
> +
> +cat >expected <<EOF &&
> +p $(git rev-list --abbrev-commit -1 first) first
> +f $(git rev-list --abbrev-commit -1 first_fixup) fixup! first
> +x git show HEAD
> +p $(git rev-list --abbrev-commit -1 second) second
> +s $(git rev-list --abbrev-commit -1 second_squash) squash! second
> +x git show HEAD
> +EOF

Please have this cat inside and at the beginning of the next
test_expect_success, preferably indented with HT to align with other
commands (adding '-' to the opening of your here-document makes the
shell strip all leading HTs from the here-document), like this:

	test_expect_success 'respects rebase....' '
		cat expect <<-EOF &&
		p $(git rev-list ...)
		f $(git rev-list ...)
		...
		EOF
		test_when_finished "
                	...
		" &&
		...
		test_cmp expect actual
	'

