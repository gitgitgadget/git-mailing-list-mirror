Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1644C43461
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606ED207BB
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vUEF4Q2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgIFV6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:58:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59712 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgIFV6K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 17:58:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E2AAFFC15A;
        Sun,  6 Sep 2020 17:58:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Ci1XXBKRmKBcoYV7RSFIj3BUtF8=; b=vUEF4Q2MxGPR6bXkeTRl
        Bq7VdDR7yl4Xmx4WPfM8C47+1u/9N5CsRN0fIgGFm7Mrg2GG36jo1LdaN05re7e3
        DAYYVr27RTc9BhyNr0gntv65wWWct2QkAsw/CPn1IjWz9fr1tCajyVsdsM4I4S77
        5F6FCTME7tb7GFX0Ou3EOZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=NJZ9PjSLHrtpK9XS8ROElh5fIDsWI5B/5l5+Aqnpi0osnM
        fysTzoOse+s66EopvYRxJlz1gGzGhakjffRm3L0xzo6c/Ro/vHZ6CApncfXepKxg
        ofeDXLzA2UvTmXGYBJDfRZ2kKPfb4M05sOF/IBplOSGJIv251ej1TmCPjSuf4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB18EFC159;
        Sun,  6 Sep 2020 17:58:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2852FFC158;
        Sun,  6 Sep 2020 17:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] builtin/diff: learn --merge-base
References: <cover.1599332861.git.liu.denton@gmail.com>
        <231ba3f661cc4aa7a55c44e339e187c6d70c5507.1599332861.git.liu.denton@gmail.com>
Date:   Sun, 06 Sep 2020 14:58:04 -0700
Message-ID: <xmqqsgbu36vn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B2D0D4C-F08C-11EA-A49B-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +In the case where one commit is given, a diff is displayed between the
> +merge base and the working tree or the index if `--cached` is given.

s/merge base/& between the commit and the HEAD/

As "merge base" in the context of talking about "one commit" does
not make sense, such a clarification would be necessary.

Jonathan suggested "--fork-point A B"; this replaces it with
"--merge-base A B".  Neither is quite satisfying, but other
people might be able to come up with a better names.

In any case, "git diff $(git merge-base MERGE_HEAD HEAD)" while
merging to see how the changes in the working tree look like is
something I've always felt cumbersome to spell, and this is a good
addition.

> +		OPT_BOOL(0, "merge-base", &merge_base,
> +			 N_("use the merge base between the two commits as the diff base"))

Define "diff base".  Eh, that was rhetoric---do not use such an
undefined word.  "compare with the merge base between two commits"
may work better.
