Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5E6520A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 07:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbeLHHEI (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 02:04:08 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64139 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeLHHEH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 02:04:07 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7ACD219CE8;
        Sat,  8 Dec 2018 02:04:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KkLuZFy0x+BCqF1vHFp1/ALPmIQ=; b=dhX4CO
        meaZmIkFTDqY0FAFYyiZlj52kgvS1a+cdK5CpMoqHLG29C6fcSyFJPjpfG9n5AFl
        3I8nTw1mjcUKzf4esSUTfAs7lxQDKgu7s5xDqVvsjA1hnDQHeApawi/wmQFVWakk
        Q9brn7e1boJ98aMnk2ChBLny81Njg+YDa4Su0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XjkOcj/yDzplt9e9WyhgYGYFThcX/yzA
        AlPKuQIQhssOGwwTlt/hkyXqHOonYFiQ6TSvOI3B7L1yb+uOWcQZ/3cjqYcLlqf9
        wvRITCWGfZtruaEXLLRlKoZkwifRjnYzxSwGx4RBZgVsP1ysrvBCwRua56Uzjgxj
        J5Q2yAdwUcE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 740A319CE7;
        Sat,  8 Dec 2018 02:04:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7EBF219CE0;
        Sat,  8 Dec 2018 02:03:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] submodule deinit: unset core.worktree
References: <20181207235425.128568-1-sbeller@google.com>
        <20181207235425.128568-5-sbeller@google.com>
Date:   Sat, 08 Dec 2018 16:03:56 +0900
In-Reply-To: <20181207235425.128568-5-sbeller@google.com> (Stefan Beller's
        message of "Fri, 7 Dec 2018 15:54:25 -0800")
Message-ID: <xmqqo99w7b4z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F22ADCE-FAB7-11E8-AB32-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This re-introduces 984cd77ddb (submodule deinit: unset core.worktree,
> 2018-06-18), which was reverted as part of f178c13fda (Revert "Merge
> branch 'sb/submodule-core-worktree'", 2018-09-07)
>
> The whole series was reverted as the offending commit e98317508c
> (submodule: ensure core.worktree is set after update, 2018-06-18)
> was relied on by other commits such as 984cd77ddb.
>
> Keep the offending commit reverted, but its functionality came back via
> 4d6d6ef1fc (Merge branch 'sb/submodule-update-in-c', 2018-09-17), such
> that we can reintroduce 984cd77ddb now.

None of the above three explains the most important thing directly,
so readers fail to grasp what the main theme of the three-patch
series is, without looking at the commits that were reverted
already.

Is the theme of the overall series to make sure core.worktree is set
to point at the working tree when submodule's working tree is
instantiated, and unset it when it is not?

2/4 was also explained (in the original) that it wants to unset and
did so when "move_head" gets called.  This one does the unset when a
submodule is deinited.  Are these the only two cases a submodule
loses its working tree?  If so, the log message for this step should
declare victory by ending with something like

	... as we covered the only other case in which a submodule
	loses its working tree in the earlier step (i.e. switching
	branches of top-level project to move to a commit that did
	not have the submodule), this makes the code always maintain
	core.worktree correctly unset when there is no working tree
	for a submodule.

Thanks.  I think I agree with what the series wants to do (if I read
what it wants to do correctly, that is).

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 2 ++
>  t/lib-submodule-update.sh   | 2 +-
>  t/t7400-submodule-basic.sh  | 5 +++++
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 31ac30cf2f..672b74db89 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1131,6 +1131,8 @@ static void deinit_submodule(const char *path, const char *prefix,
>  		if (!(flags & OPT_QUIET))
>  			printf(format, displaypath);
>  
> +		submodule_unset_core_worktree(sub);
> +
>  		strbuf_release(&sb_rm);
>  	}
>  
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 51d4555549..5b56b23166 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -235,7 +235,7 @@ reset_work_tree_to_interested () {
>  	then
>  		mkdir -p submodule_update/.git/modules/sub1/modules &&
>  		cp -r submodule_update_repo/.git/modules/sub1/modules/sub2 submodule_update/.git/modules/sub1/modules/sub2
> -		GIT_WORK_TREE=. git -C submodule_update/.git/modules/sub1/modules/sub2 config --unset core.worktree
> +		# core.worktree is unset for sub2 as it is not checked out
>  	fi &&
>  	# indicate we are interested in the submodule:
>  	git -C submodule_update config submodule.sub1.url "bogus" &&
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 76a7cb0af7..aba2d4d6ee 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -984,6 +984,11 @@ test_expect_success 'submodule deinit should remove the whole submodule section
>  	rmdir init
>  '
>  
> +test_expect_success 'submodule deinit should unset core.worktree' '
> +	test_path_is_file .git/modules/example/config &&
> +	test_must_fail git config -f .git/modules/example/config core.worktree
> +'
> +
>  test_expect_success 'submodule deinit from subdirectory' '
>  	git submodule update --init &&
>  	git config submodule.example.foo bar &&
