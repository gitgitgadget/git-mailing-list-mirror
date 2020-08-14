Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C18C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 01:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 472A820675
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 01:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nxL93dJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHNBcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 21:32:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54508 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHNBcs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 21:32:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0331FE0089;
        Thu, 13 Aug 2020 21:32:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s89r4kscn9SFS5mb2Jrm5M7Ivls=; b=nxL93d
        JTdIaKU4983qD+Hvd7rxk6GvP862rAMs4iZFXs8XMZClsRi7Z4WWEFfkupB7P5GF
        yybKXsDuS7Zq7nyeL7qs+hT4dj74hX8LXChbY/QZZneWM3f0yjrxDX+5lLhDbHW1
        bYZ5rP4OxAdq1ic67GyYEMV0ABjzKi/UxigVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Eik//7eaMzs0++mP8FWtQjOr8QOGTMRd
        is4bU8qRdnGkWyIzLCS81paMxE9FjOtIZbhZUy85ziyi9PJU6LjpyrrKV88a72BF
        W6uFNJGiyYuZGa6KwkNrfN9a6FJz3doxUJsy8gp9y9CeWdWjCmsnNiQgUE20/Lag
        WFJraDzU0gw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F02B6E0087;
        Thu, 13 Aug 2020 21:32:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3E2F0E0086;
        Thu, 13 Aug 2020 21:32:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3] fetch: optionally allow disabling FETCH_HEAD update
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
        <83401c52002716084b9c53a77c9d57b6009f84e2.1596731424.git.gitgitgadget@gmail.com>
        <20200812231021.GG2965447@google.com>
        <xmqqo8nf4dkb.fsf@gitster.c.googlers.com>
        <xmqqh7t740vu.fsf_-_@gitster.c.googlers.com>
        <8acc67e5-4b17-7fdc-0685-b5113e819010@gmail.com>
Date:   Thu, 13 Aug 2020 18:32:40 -0700
In-Reply-To: <8acc67e5-4b17-7fdc-0685-b5113e819010@gmail.com> (Derrick
        Stolee's message of "Thu, 13 Aug 2020 21:13:14 -0400")
Message-ID: <xmqqtux6yptz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C026BB6-DDCE-11EA-A83C-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>  * So, it becomes much smaller by punting the whole configuration
>>    thing, as we do not need the extra code for config parsing and
>>    there is no need for code to override the user configuration when
>>    driving "git fetch" from "git pull".
>
> Sounds good. I'll incorporate this patch into my next version,
> except it seems you dropped this test:

Yup.  

As we are not touching "pull" at all, the test I removed would make
as much sense as a hypothetical one where its "git pull" is replaced
with "git cat-file" or any other unrelated subcommand, and that is
why I removed it.  But I am OK if you resurrect it---everybody thinks
"fetch" and "pull" are closely related after all.

Thanks.



> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> index 159afa7ac8..db1a381cd9 100755
> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -85,6 +85,13 @@ test_expect_success 'git pull --cleanup errors early on invalid argument' '
>         test -s err)
>  '
>  
> +test_expect_success 'git pull --no-write-fetch-head fails' '
> +       mkdir clonedwfh &&
> +       (cd clonedwfh && git init &&
> +       test_expect_code 129 git pull --no-write-fetch-head "../parent" >out 2>err &&
> +       test_must_be_empty out &&
> +       test_i18ngrep "no-write-fetch-head" err)
> +'
>  
>  test_expect_success 'git pull --force' '
>         mkdir clonedoldstyle &&
>
> which I changed "test_must_fail" to "test_expect_code 129" to
> demonstrate that this is a usage error, not just any error.
>
> Thanks,
> -Stolee
