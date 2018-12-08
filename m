Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEE7220A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 06:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeLHGzc (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 01:55:32 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63331 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeLHGzc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 01:55:32 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 57A49272A7;
        Sat,  8 Dec 2018 01:55:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9//HASuNjGmPdPi4T4en+5xd2iE=; b=dh6NS6
        u4+YqarljUcJPHiyP69H7PR1PksBGS7q5++a3qBmOadX/AW7QqC6UeV1USkMhnsp
        A4WbyWvGBSzQxhMHoCRtx9kWBfwY6vc91wy5QhjAF/pK39eMi0xdUM4Fv3M1lw3F
        M7v3sWjEEwMRT/N1KiKPQUiNZi8xOjuZnJvtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f5HvlC8hPqFtl2oCJapYpPtUV/7mDNrd
        RIKoGachu6veVAJq2pJuNGq8Cv0KYBlVgQF/WsV5gvQ47KIr2fafjHg8j7D/lCEk
        aYv7ovD3OT3q7zPane+4Fmv3/VF0dnceR3SymfIt5HHsNvY662BIxXss1HEpWduA
        Ex9lD/0jI8I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FD34272A6;
        Sat,  8 Dec 2018 01:55:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 55016272A2;
        Sat,  8 Dec 2018 01:55:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] submodule--helper: fix BUG message in ensure_core_worktree
References: <20181207235425.128568-1-sbeller@google.com>
        <20181207235425.128568-4-sbeller@google.com>
Date:   Sat, 08 Dec 2018 15:55:22 +0900
In-Reply-To: <20181207235425.128568-4-sbeller@google.com> (Stefan Beller's
        message of "Fri, 7 Dec 2018 15:54:24 -0800")
Message-ID: <xmqqsgz87bj9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3CAAA8B6-FAB6-11E8-B70A-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Shortly after f178c13fda (Revert "Merge branch
> 'sb/submodule-core-worktree'", 2018-09-07), we had another series
> that implemented partially the same, ensuring that core.worktree was
> set in a checked out submodule, namely 74d4731da1 (submodule--helper:
> replace connect-gitdir-workingtree by ensure-core-worktree, 2018-08-13)
>
> As the series 4d6d6ef1fc (Merge branch 'sb/submodule-update-in-c',
> 2018-09-17) has different goals than the reverted series 7e25437d35
> (Merge branch 'sb/submodule-core-worktree', 2018-07-18), I'd wanted to
> replay the series on top of it to reach the goal of having `core.worktree`
> correctly set when the submodules worktree is present, and unset when the
> worktree is not present.
>
> The replay resulted in a strange merge conflict highlighting that
> the BUG message was not changed in 74d4731da1 (submodule--helper:
> replace connect-gitdir-workingtree by ensure-core-worktree, 2018-08-13).
>
> Fix the error message.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Unlike the step 2/4 I commented on, this does explain what this
wants to do and why, at least when looked from sideways.  Is the
above saying the same as the following two-liner?

	An ealier mistake while rebasing to produce 74d4731da1
	failed to update this BUG message.  Fix this.



>  builtin/submodule--helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d38113a31a..31ac30cf2f 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2045,7 +2045,7 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
>  	struct repository subrepo;
>  
>  	if (argc != 2)
> -		BUG("submodule--helper connect-gitdir-workingtree <name> <path>");
> +		BUG("submodule--helper ensure-core-worktree <path>");
>  
>  	path = argv[1];
