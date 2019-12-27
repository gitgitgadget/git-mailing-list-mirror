Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A040C2D0C3
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 22:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB77220838
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 22:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KzVLqhjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfL0WtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 17:49:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54933 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfL0WtT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 17:49:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E1492447C;
        Fri, 27 Dec 2019 17:49:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=smamDPuY+pMU7Dx/IcOfs/HG6gw=; b=KzVLqh
        jmP8WxLJQl8n7S/njgXkN/L+dKdDt1EP2XY0lP3YBbwkHiMYrA/bJg2T20aZRffu
        rXWao+kyO/Sm1x8M0jK8yNtwwHEDyvw2ju6T+PkBnokBKeE841XqQL6otMd78P4k
        Bt/FZrHieCRGDhY2m+IJoxHnc+XnzMMGFrqZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=leGHG4Ab3n3rh6AOEguRKYOlWweqgnvN
        EyrFbBOw7Te7Z3oftLjIC8xwRoxSAFCdNCBlR/Er+7VjOek6X5AklhmHktZAX0fe
        UQbFOe4ETJaaCan+r7tn9VfuQ4oKlEZlSouHc+/bcol4UVIDm+HIS8ruDJ6jUAif
        abmzEfu0Jw0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 328382447B;
        Fri, 27 Dec 2019 17:49:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 93C6F2447A;
        Fri, 27 Dec 2019 17:48:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 12/16] t3504: don't use `test_must_fail test_cmp`
References: <cover.1577454401.git.liu.denton@gmail.com>
        <b3e4f1698fd86f75f650c7928f2107ea0edd3600.1577454401.git.liu.denton@gmail.com>
        <41175b96-37d7-f550-b9c2-41d569145b91@kdbg.org>
Date:   Fri, 27 Dec 2019 14:48:58 -0800
In-Reply-To: <41175b96-37d7-f550-b9c2-41d569145b91@kdbg.org> (Johannes Sixt's
        message of "Fri, 27 Dec 2019 21:39:24 +0100")
Message-ID: <xmqqpng9idut.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 123E67D8-28FB-11EA-9C3A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> This is VERY suspicious. It is not reliable to check that something
> is not exactly equal to something else.
>
> Feel free to replace this patch by the following.
>
> ----- 8< -----
> t3504: do check for conflict marker after failed cherry-pick
>
> The test with disabled rerere should make sure that the cherry-picked
> result does not have the conflict replaced with a recorded resolution.
>
> It attempts to do so by ensuring that the file content is _not_ equal
> to some other file. That by itself is a very dubious check because just
> about every random result of an incomplete cherry-pick would satisfy
> the condition.

Good thinking.  Thanks for catching the bogosity of the original
test, which dates back to more than 10 years ago X-<.

> In this case, the intent was to check that the conflicting file does
> _not_ contain the resolved content. But the check actually uses the
> wrong reference file, but not the resolved content. Needless to say
> that the non-equality is satisfied. And, on top of it, it uses a commit
> that does not even touch the file that is checked.
>
> Do check for the expected result, which is content from both sides of
> the merge and merge conflicts. (The latter we check for just the
> middle separator for brevity.)
>
> As a side-effect, this also removes an incorrect use of test_must_fail.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t3504-cherry-pick-rerere.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
> index a267b2d144..80a0d08706 100755
> --- a/t/t3504-cherry-pick-rerere.sh
> +++ b/t/t3504-cherry-pick-rerere.sh
> @@ -94,8 +94,10 @@ test_expect_success 'cherry-pick --rerere-autoupdate more than once' '
>  
>  test_expect_success 'cherry-pick conflict without rerere' '
>  	test_config rerere.enabled false &&
> -	test_must_fail git cherry-pick master &&
> -	test_must_fail test_cmp expect foo
> +	test_must_fail git cherry-pick foo-master &&
> +	grep ===== foo &&
> +	grep foo-dev foo &&
> +	grep foo-master foo
>  '
>  
>  test_done
