Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_C,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BB5C433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 00:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCB12086A
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 00:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XbrCQFcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgGXA6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 20:58:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64605 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728394AbgGXA6j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 20:58:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8389C80B08;
        Thu, 23 Jul 2020 20:58:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=qquFlAIeOLvqUGrx6NdCKmG0x
        EA=; b=XbrCQFcrDvRGnc6wc5blTpT9RSutqkmGP50qRTaOzrecK/msHanUiqJND
        WVc/IvHyq9+i0xPVzW+cxXNFrZH1ZamWjXFGikBnBNM72oxRlBmjmllUp6mh3aqP
        LrqL4L7Y6jZdH2C+ceUh/SOOI+YMzMK83eP4CUm2k6Qh0tBxeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=vTNh6rkGouxzDKrMP4J
        ulNi3oCe5zazkLpWt3LizVNh0/PJWa1G+3xBQlIA0PzJH5WxwRyt6fyV2ebQunBh
        nOwPy4jxeuqFFu6TR0JzlqcA2Gd3SP+kVLRcGlORfDq7qEGWm7DcWTqwWIUJv04S
        f32pyHs8LT4moBJtHDBhqeZ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79EC380B07;
        Thu, 23 Jul 2020 20:58:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F18C180B06;
        Thu, 23 Jul 2020 20:58:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        Lin Sun <lin.sun@zoom.us>
Subject: Re: [PATCH v17] Support auto-merge for meld to follow the vim-diff behavior
References: <pull.781.v16.git.git.1594544903477.gitgitgadget@gmail.com>
        <pull.781.v17.git.git.1594596738929.gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 17:58:36 -0700
Message-ID: <xmqqv9idn2yr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CE42DFE4-CD48-11EA-A0EC-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"sunlin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lin Sun <lin.sun@zoom.us>
>
> Make the mergetool used with "meld" backend behave similarly to "vimdif=
f" by
> telling it to auto-merge non-conflicting parts and highlight the confli=
cting
> parts when `mergetool.meld.useAutoMerge` is configured with `true`, or =
`auto`
> for detecting the `--auto-merge` option automatically.
>
> Helped-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail=
.com>
> Helped-by: David Aguilar <davvid@gmail.com>
> Signed-off-by: Lin Sun <lin.sun@zoom.us>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>     Enable auto-merge for meld to follow the vimdiff beharior
>    =20
>     Hi, the mergetool "meld" does NOT merge the no-conflict changes, wh=
ile
>     the mergetool "vimdiff" will merge the no-conflict changes and high=
light
>     the conflict parts. This patch will make the mergetool "meld" simil=
ar to
>     "vimdiff", auto-merge the no-conflict changes, highlight conflict p=
arts.

This version seems to revert the bool-or-str change that would
become useful with a bit more polishing, with docs and tests.

Intended?

It also seems to repeat many issues that have been pointed out
during the reviews of previous revisions.  I'd rather not have to
repeat pointing them out all over again, obviously.

I have queued v16 (the one with the beginning of bool-or-str) with
minimum fixups for issues I pointed out in the review of that
revision queued on top of it as SQUASH??? commit.  Please find it in
the 'seen' branch.

Also,

    Subject: Support auto-merge for meld to follow the vim-diff behavior

needs fixing.

cf. https://git-scm.com/docs/SubmittingPatches#describe-changes

Two tricks to pick a good title are:

 - Read a pageful or two of "git shortlog --no-merges" output to get
   accustomed to the general pattern in the entire project.  It
   would become clear why titles with "area:" prefix help the
   patches with them easier to locate.

 - Read a pageful of "git shortlog --no-merges -- mergetools"
   (i.e. the same but limited to the files you are touching) to see
   how the changes that contributed over time to build the subsystem
   are called, so that the new patches can fit in the pattern.

I think something along the lines of

    Subject: [PATCH] mergetool/meld: optionally allow --auto-merge behavi=
our

or something would fit well.

Thanks.
