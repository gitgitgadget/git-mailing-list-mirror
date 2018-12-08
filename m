Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SUBJ_ALL_CAPS shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC59A20A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 05:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeLHF5i (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 00:57:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50127 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeLHF5i (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 00:57:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E5F010BB30;
        Sat,  8 Dec 2018 00:57:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8O7pyluB0TOYreJ1tnXmjiLB+d0=; b=SLnXnV
        VpYupYBmHy0svR0C1GRViXWcLAQOPyw9YsTbvo+tysCjGD2PqjRAquh0PJMR6HYH
        UJyYjtPOQclzRawiLCqr/vifoN2GSbqUIrmeV+oL4+Rk5X/EdlSD5ScxUxzu3H+U
        DNhDrg+ywdAt/jB0ILk0k6/GSQdlWOFmKuWmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KGssOJWHrPPj7RehEkxrbazA1zK5APbp
        1LbaoPUM0wY30H3vBg5Oz981OWXb1hfxXRvXy322z7kry5OrJwPsqGDTVpIJ3cwU
        lpir+GlBri19C6gcLemlHTJe34ftSBxr1JgxggzDeOOCeBkGazsewaxpx0aBNTYQ
        BOK8UDWU91Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77A6310BB2F;
        Sat,  8 Dec 2018 00:57:33 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2FF710BB2E;
        Sat,  8 Dec 2018 00:57:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/4]
References: <20181207235425.128568-1-sbeller@google.com>
Date:   Sat, 08 Dec 2018 14:57:31 +0900
In-Reply-To: <20181207235425.128568-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 7 Dec 2018 15:54:21 -0800")
Message-ID: <xmqqefas8ss4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2789D91E-FAAE-11E8-85AB-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> A couple days before the 2.19 release we had a bug report about
> broken submodules[1] and reverted[2] the commits leading up to them.
>
> The behavior of said bug fixed itself by taking a different approach[3],
> specifically by a weaker enforcement of having `core.worktree` set in a
> submodule [4].
>
> The revert [2] was overly broad as we neared the release, such that we wanted
> to rather keep the known buggy behavior of always having `core.worktree` set,
> rather than figuring out how to fix the new bug of having 'git submodule update'
> not working in old style repository setups.
>
> This series re-introduces those reverted patches, with no changes in code,
> but with drastically changed commit messages, as those focus on why it is safe
> to re-introduce them instead of explaining the desire for the change.

The above was a bit too cryptic for me to grok, so let me try
rephrasing to see if I got them all correctly.

 - three-patch series leading to 984cd77ddb were meant to fix some
   bug, but the series itself was buggy and caused problems; we got
   rid of them

 - the problem 984cd77ddb wanted to fix was fixed differently
   without reintroducing the problem three-patch series introduced.
   That fix is already with us since 4d6d6ef1fc.

 - now these three changes that were problematic in the past is
   resent without any update (other than that it has one preparatory
   patch to add tests).

Is that what is going on?  Obviously I am not getting "the other"
benefit we wanted to gain out of these three patches (because the
above description fails to explain what that is), other than to fix
the issue that was fixed by 4d6d6ef1fc.

Sorry for being puzzled...

> [1] https://public-inbox.org/git/2659750.rG6xLiZASK@twilight
> [2] f178c13fda (Revert "Merge branch 'sb/submodule-core-worktree'", 2018-09-07)
> [3] 4d6d6ef1fc (Merge branch 'sb/submodule-update-in-c', 2018-09-17)
> [4] 74d4731da1 (submodule--helper: replace connect-gitdir-workingtree by ensure-core-worktree, 2018-08-13)
>
> Stefan Beller (4):
>   submodule update: add regression test with old style setups
>   submodule: unset core.worktree if no working tree is present
>   submodule--helper: fix BUG message in ensure_core_worktree
>   submodule deinit: unset core.worktree
>
>  builtin/submodule--helper.c        |  4 +++-
>  submodule.c                        | 14 ++++++++++++++
>  submodule.h                        |  2 ++
>  t/lib-submodule-update.sh          |  5 +++--
>  t/t7400-submodule-basic.sh         |  5 +++++
>  t/t7412-submodule-absorbgitdirs.sh |  7 ++++++-
>  6 files changed, 33 insertions(+), 4 deletions(-)
