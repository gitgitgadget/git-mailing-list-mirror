Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 178081FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 04:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbdJLEGK (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 00:06:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58540 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750716AbdJLEGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 00:06:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9297E9A565;
        Thu, 12 Oct 2017 00:06:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BoLux277kjoZTxyWj0Nrl5oORLU=; b=K5FBf2
        bTN7mCjqE+otmjA4fTFJEp7EcSdD6+Bfa76KNRWX5DePQaJQo8aFFTcUZFjng34C
        OXcyliJvQNB+aseghL1ZY17jwvBKJopZ2HY37DYKpE7gHVypN7PvMVjBVy5bHqqV
        Bzn59km9qgtUjz/4FJJmECjgHXkJGB7t9MSCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GXzFzUhf5q35qLTWd0SQzUwVMZKbuvgS
        DQnZca77QwyRGpWWqFIfy0IIPAYcyzCzflz3UFCPfY9uOzJ0NK4AJXZxsWr/gOxu
        dVMFhAJ38F54kWjGRUSoKSO7ZsU72OEaxTqFbY3EFnqpcbNLuR4XCsHLp+CBfTxV
        mciXKmmghus=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 894FC9A564;
        Thu, 12 Oct 2017 00:06:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B124A9A560;
        Thu, 12 Oct 2017 00:06:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jameson.miller81@gmail.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jamill@microsoft.com,
        peff@peff.net, sbeller@google.com
Subject: Re: [PATCH v2 5/5] Add tests around status handling of ignored arguments
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
        <20171011133504.15049-1-jamill@microsoft.com>
        <20171011133504.15049-6-jamill@microsoft.com>
Date:   Thu, 12 Oct 2017 13:06:06 +0900
In-Reply-To: <20171011133504.15049-6-jamill@microsoft.com> (Jameson Miller's
        message of "Wed, 11 Oct 2017 09:35:04 -0400")
Message-ID: <xmqqefq91041.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC907328-AF02-11E7-A3A2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jameson.miller81@gmail.com> writes:

> Add tests for status handling of '--ignored=matching` and
> `--untracked-files=normal`.
>
> Signed-off-by: Jameson Miller <jamill@microsoft.com>
> ---

Hmph, having some tests in 3/5, changes in 4/5 and even more tests
in 5/5 makes me as a reader a bit confused, as the description for
these two test patches does not make it clear how they are related
and how they are different.  Is it that changes in 1/5 alone does
not fulfill the promise made by documentation added at 2/5 so 3/5
only has tests for behaviour that works with 1/5 alone but is broken
with respect to what 2/5 claims until 4/5 is applied, and these "not
working with 1/5 alone, but works after 4/5" are added in this step?

>  t/t7519-ignored-mode.sh | 60 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 59 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7519-ignored-mode.sh b/t/t7519-ignored-mode.sh
> index 76e91427b0..6be7701d79 100755
> --- a/t/t7519-ignored-mode.sh
> +++ b/t/t7519-ignored-mode.sh
> @@ -116,10 +116,68 @@ test_expect_success 'Verify status behavior on ignored folder containing tracked
>  		ignored_dir/ignored_1.ign ignored_dir/ignored_2.ign \
>  		ignored_dir/tracked &&
>  	git add -f ignored_dir/tracked &&
> -	test_tick &&
>  	git commit -m "Force add file in ignored directory" &&
>  	git status --porcelain=v2 --ignored=matching --untracked-files=all >output &&
>  	test_i18ncmp expect output
>  '
>  
> +test_expect_success 'Verify matching ignored files with --untracked-files=normal' '
> +	test_when_finished "git clean -fdx" &&
> +	cat >expect <<-\EOF &&
> +	? expect
> +	? output
> +	? untracked_dir/
> +	! ignored_dir/
> +	! ignored_files/ignored_1.ign
> +	! ignored_files/ignored_2.ign
> +	EOF
> +
> +	mkdir ignored_dir ignored_files untracked_dir &&
> +	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
> +		ignored_files/ignored_1.ign ignored_files/ignored_2.ign \
> +		untracked_dir/untracked &&
> +	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
> +	test_i18ncmp expect output
> +'
> +
> +test_expect_success 'Verify matching ignored files with --untracked-files=normal' '
> +	test_when_finished "git clean -fdx" &&
> +	cat >expect <<-\EOF &&
> +	? expect
> +	? output
> +	? untracked_dir/
> +	! ignored_dir/
> +	! ignored_files/ignored_1.ign
> +	! ignored_files/ignored_2.ign
> +	EOF
> +
> +	mkdir ignored_dir ignored_files untracked_dir &&
> +	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
> +		ignored_files/ignored_1.ign ignored_files/ignored_2.ign \
> +		untracked_dir/untracked &&
> +	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
> +	test_i18ncmp expect output
> +'
> +
> +test_expect_success 'Verify status behavior on ignored folder containing tracked file' '
> +	test_when_finished "git clean -fdx && git reset HEAD~1 --hard" &&
> +	cat >expect <<-\EOF &&
> +	? expect
> +	? output
> +	! ignored_dir/ignored_1
> +	! ignored_dir/ignored_1.ign
> +	! ignored_dir/ignored_2
> +	! ignored_dir/ignored_2.ign
> +	EOF
> +
> +	mkdir ignored_dir &&
> +	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
> +		ignored_dir/ignored_1.ign ignored_dir/ignored_2.ign \
> +		ignored_dir/tracked &&
> +	git add -f ignored_dir/tracked &&
> +	git commit -m "Force add file in ignored directory" &&
> +	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
> +	test_i18ncmp expect output
> +'
> +
>  test_done
