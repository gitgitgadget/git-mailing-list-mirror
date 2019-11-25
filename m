Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7E1C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 03:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20B520674
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 03:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j5tZ7DRl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfKYDA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 22:00:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61792 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfKYDA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 22:00:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 577BA2BCFF;
        Sun, 24 Nov 2019 22:00:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TMH2ypfwp+lqPJh6iI3QBcgb2PQ=; b=j5tZ7D
        Rl8lzLlBfahvEDEZSDbsLomi9iN2BLPnVvVf+I9Ef07ZGojTLl8eWIbzxm5iyj6p
        F6ZgYEpkI/IKQ+gl6epNuHPTbZ7vSgnJVvGXWOUwUwsqZdKdHyrzQTeNRGzXc2Uj
        +xtqyDS9D4Y3Hue6T3tJZvFld3FV0ANeLgr3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F84W8Uy9G/5UH9laJKedf3ynwuTClUPx
        3/QYGJ/P68WtG6nTrKhYTnfcdaSecMd5qcnwjmq/bQrXMK7FRK7gVn4h+RW3ivjC
        icwBSBWNdUz4PLHM4JD36O5NbPVdarn1i2TMZ8ooujCv5I4Sjx5MPYJ3YNszMlbe
        AFeGS5CI2Hc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D7D82BCFE;
        Sun, 24 Nov 2019 22:00:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AE0BF2BCFD;
        Sun, 24 Nov 2019 22:00:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 1/1] sequencer: fix empty commit check when amending
References: <pull.467.git.1574345181.gitgitgadget@gmail.com>
        <pull.467.v2.git.1574451783.gitgitgadget@gmail.com>
        <037f2b2975e06847443aef46939e3c712053dedf.1574451783.git.gitgitgadget@gmail.com>
        <xmqq5zjb2vsx.fsf@gitster-ct.c.googlers.com>
        <340859a7-5cc4-f641-818d-fcedbf29a2a6@gmail.com>
        <94573071-556b-caae-b159-40c168a08f44@gmail.com>
Date:   Mon, 25 Nov 2019 12:00:55 +0900
In-Reply-To: <94573071-556b-caae-b159-40c168a08f44@gmail.com> (Phillip Wood's
        message of "Sun, 24 Nov 2019 10:52:01 +0000")
Message-ID: <xmqqr21wy80o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CD1CB054-0F2F-11EA-97B6-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> We do actually check that there is a valid HEAD before we try to fixup
> a commit. Though perhaps we should still change this patch as HEAD may
> be changed by another process between that check and re-reading it
> here. If you try to fixup a commit without a valid HEAD you get
>
> error: need a HEAD to fixup
> hint: Could not execute the todo command
> hint:
> hint:     fixup faef1a5a7637ff91b3611aabd1b96541da5f5536 P
> hint:
> hint: It has been rescheduled; To edit the command before continuing, please
> hint: edit the todo list first:
> hint:
> hint:     git rebase --edit-todo
> hint:     git rebase --continue
> error: could not copy '.git/rebase-merge/message-squash' to
> '.git/rebase-merge/message'
>
> The last error message is unfortunate but we do exit in an orderly
> manner rather than segfaulting.

Thanks for thinking about the issue further.

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index d2f1d5bd23..4f55f0cd1c 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -67,6 +67,21 @@ test_expect_success 'setup' '
>  SHELL=
>  export SHELL
>
> +test_expect_success 'fixup on orphan branch errors out' '
> +
> +       test_when_finished "git switch master" &&
> +       write_script switch-branch.sh <<-\EOF &&
> +       git symbolic-ref HEAD refs/heads/does-not-exist &&
> +       git rm -rf .

That "git rm -rf ." scares me, though.

> +       EOF
> +       (
> +               set_fake_editor &&
> +               FAKE_LINES="exec_./switch-branch.sh \
> +                           fixup 1" git rebase -i HEAD^
> +       ) &&
> +       test_pause
> +'
> +
>
> I think it would be useful to add something like this to the test
> suite (changed to check the error message, with a better name for the
> script and modified to expect failure) What do you think?

So, we try an interactive rebase, try to apply a fix-up on an unborn
branch and expect it to fail in a controlled way, something like

	(
		# we are in subshell so freely export
		set_fake_editor &&
		export FAKE_LINES="exec_./switch-branch.sh fixup 1" &&
		test_must_fail git rebase -i HEAD^ 2>error &&
		test_i18ngrep "... what we expect ..." error
	)

Perhaps.  I do not think of a good reason why we should allow
switching to another branch when "rebase -i" gives control back to
the user, so in the longer run, the checked condition may not stay
the same (I suspect you would catch "does-not-exist is unborn and
there is nothing to 'fixup'" right now---I am envisioning that the
condition that is checked and the message we would issue would be
"we gave you a detached HEAD for a good reason---stay there and do
not switch to any other branch") and the message expected by this
test would have to be updated.

Thanks.



