Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5041C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 05:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FAA0207F9
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 05:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HVl2MI1x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgFIFS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:18:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57560 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgFIFSX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 01:18:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F05866D6B5;
        Tue,  9 Jun 2020 01:18:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s7WaedF2vPcvLneS3twSYqyxC6I=; b=HVl2MI
        1xeilx+KFMrEEGdwW6QV5pMi6LOHTqGAu6LXACI+30FuoieMEXG1mm46FECTjHZz
        6IMlzDgQcf/dTDNtyiIenmn1mZnE+NMBgxxIDlpDlyfUUYezXyeukXjUf76AN18D
        YwZNkpSuqqEAt9wt2AQUlnpl1pvlHyd3ZYbuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qH9kJEoA6UnWeBMRiAF+PL8khxFdNaks
        J7YgcfpTzj90HOQh5ndrE9BCknST9b2dgqY2upbSxcpAVdNTdKZwrkpJxTxJ+iqS
        cRQ6QrpUnWsEKZdX8MSv3gJAsTclzWZ4fu2v7ys+syzgACUsZjdl1oBnLSBRCdZ4
        Cj/AHQVvCQc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8FC06D6B4;
        Tue,  9 Jun 2020 01:18:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B8096D6B3;
        Tue,  9 Jun 2020 01:18:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Chris Torek via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH 1/3] t/t3430: avoid undocumented git diff behavior
References: <pull.804.git.git.1591661021.gitgitgadget@gmail.com>
        <414163bbc3cbdda241bedc7bc4dfb8b493071dcb.1591661021.git.gitgitgadget@gmail.com>
Date:   Mon, 08 Jun 2020 22:18:19 -0700
In-Reply-To: <414163bbc3cbdda241bedc7bc4dfb8b493071dcb.1591661021.git.gitgitgadget@gmail.com>
        (Chris Torek via GitGitGadget's message of "Tue, 09 Jun 2020 00:03:39
        +0000")
Message-ID: <xmqqr1uoizqc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A189B366-AA10-11EA-ABC3-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Chris Torek via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Chris Torek <chris.torek@gmail.com>
>
> According to the documentation, "git diff" takes at most two commit-ish,
> or an A..B style range, or an A...B style symmetric difference range.
> The autosquash-and-exec test relied on "git diff HEAD^!", which works
> fine for ordinary commits as the revision parse produces two commit-ish,
> namely ^HEAD^ and HEAD.
>
> For merge commits, however, this test makes use of an undocumented
> feature:

s/undocumented feature/undefined behaviour/;

The show.sh scripts wants to compute the diff against first parent,
and it uses a range notation HEAD^! which happens to mean
HEAD^..HEAD for a single parent commit, but it forgets that the
commit it may get fed could be a merge.  What the code happens to do
when given "git diff ^HEAD^2 HEAD^..HEAD" is undefined behaviour and
does not even ...

> the resulting revision parse has all the parents as UNINTERESTING
> followed by the HEAD commit.  This looks identical to a symmetric
> diff parse, which lists the merge bases as UNINTERESTING, followed by
> the A (UNINTERESTING) and B revs.  So the diff winds up treating it
> as one, using the first oid (i.e., HEAD^) and the last (i.e., HEAD).
> The documentation, however, says nothing about this usage.

...deserve to be explained in a paragraph like this, I would think.

> Since diff actually just uses HEAD^ and HEAD, call for these directly
> here.  That makes it possible to improve the diff code's handling of
> symmetric difference arguments.

Yes, the resulting code expresses the intent much better.


>
> Signed-off-by: Chris Torek <chris.torek@gmail.com>
> ---
>  t/t3430-rebase-merges.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index a1bc3e20016..b454f400ebd 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -420,7 +420,7 @@ test_expect_success 'with --autosquash and --exec' '
>  	git commit --fixup B B.t &&
>  	write_script show.sh <<-\EOF &&
>  	subject="$(git show -s --format=%s HEAD)"
> -	content="$(git diff HEAD^! | tail -n 1)"
> +	content="$(git diff HEAD^ HEAD | tail -n 1)"
>  	echo "$subject: $content"
>  	EOF
>  	test_tick &&
