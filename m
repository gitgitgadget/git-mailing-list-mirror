Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D71FC433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 18:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D2B3610C8
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 18:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242757AbhIWSii (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 14:38:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65288 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242714AbhIWSih (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 14:38:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CAF9FD726E;
        Thu, 23 Sep 2021 14:37:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ino/yv+b2sFn
        epUqrSj8Xf5l+Zl34L+XWB4/NUDLs8Q=; b=Gi9R5fpcwcxEAPHHheXntag96wCB
        RpL1EUVDqDfwEYZeg+ZAg7lzf3FXp2vypo3l/4DaWqdWXjrZU//YPWtOdx6NlSxE
        7gGmwcIpkl+H4bRBfQ3jH3HjEng453hoIg29aN/9FXC3WLExmZuIPCavAnFveV/E
        LYWliBCi1Njrseg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 681BED726D;
        Thu, 23 Sep 2021 14:37:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8DD2D726C;
        Thu, 23 Sep 2021 14:37:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
        <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
        <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com>
        <87r1df497s.fsf@evledraar.gmail.com>
Date:   Thu, 23 Sep 2021 11:37:01 -0700
In-Reply-To: <87r1df497s.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 23 Sep 2021 17:03:56 +0200")
Message-ID: <xmqqczozyw8i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3EAA425A-1C9D-11EC-80A2-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I played with the diff below on top of this, I can't remember if it was
> noted already, but the way you declare function ptrs and use them isn't
> the usual style:
>
> -- >8 --
> diff --git a/run-command.c b/run-command.c
> index 76bbef9d96d..5c831545201 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1903,7 +1903,7 @@ void prepare_other_repo_env(struct strvec *env_ar=
ray, const char *new_git_dir)
>  }
> =20
>  enum start_bg_result start_bg_command(struct child_process *cmd,
> -				      start_bg_wait_cb *wait_cb,
> +				      start_bg_wait_cb wait_cb,
> -typedef int(start_bg_wait_cb)(const struct child_process *cmd, void *c=
b_data);
> +typedef int (*start_bg_wait_cb)(const struct child_process *cmd, void =
*cb_data);

I have no comment on the "default" thing, but I agree that the
preimage does look _unusual_ in our codebase.  You cannot even
declare a "variable" of that type with the typedef, i.e.

	start_bg_wait_cb an_instance_of_that;

If there is a good reason behind choosing the unusual "the type of
the function is...", that is OK, but otherwise...
