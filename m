Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF6961FBEC
	for <e@80x24.org>; Wed,  8 Mar 2017 00:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933360AbdCHAos (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 19:44:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55206 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751217AbdCHAop (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 19:44:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 078667F1F0;
        Tue,  7 Mar 2017 17:49:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AUYfpz7Qpp+0y+zbeAszI8ENwlo=; b=tH488a
        VK3Swcb9AeBN4qMOChsgl1N6mIx8iVecmxKQy2HkD9jdTxUd+4ZMgHazSZk7KYsC
        81PjHeaNJTlagaujRib+pRVSQxjop4AmDzJhNvXjpJj5YMckpQqRzqeyGz5H8z8O
        jFp2dQSRUByAWK5zpLhhN+c43t7dj3PKmPElE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oM6DEADO+r23UlfyD9NBFc96yHpVEBSj
        CG5FJoTAoD2ftBDvtKvVbhy61CdT9dZ0AednMyIv+mGKwxPCuXSJL3lLry6ORT/6
        En3Iv3XF3HkjBku1RAQ8CkNX3m7kBZkChJrnhIBtXAwI/LqppUHMbgmOpM+9l+2S
        5MkS5/2xD8M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00F197F1EF;
        Tue,  7 Mar 2017 17:49:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 645CE7F1EE;
        Tue,  7 Mar 2017 17:49:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Benjamin Fuchs <email@benjaminfuchs.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        ville.skytta@iki.fi
Subject: Re: [RFC PATCH] rev-parse: add --show-superproject-working-tree
References: <CAGZ79kZv=LoP+nG0GVtU_Zi+_SX8_98AXFqzXNh=xM6ASy+=Gw@mail.gmail.com>
        <20170307034553.10770-1-sbeller@google.com>
        <xmqq8toh7wqu.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYMZk3sNNjWgp9acQG6z5Q5CnsJi+n7Bvr3EkfbSHasMA@mail.gmail.com>
Date:   Tue, 07 Mar 2017 14:49:38 -0800
In-Reply-To: <CAGZ79kYMZk3sNNjWgp9acQG6z5Q5CnsJi+n7Bvr3EkfbSHasMA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 7 Mar 2017 12:40:54 -0800")
Message-ID: <xmqq7f4066t9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58985B58-0388-11E7-8A3E-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Mar 7, 2017 at 10:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> So perhaps your superproject_exists() helper can be eliminated
>
> That is what I had originally, but I assumed a strict helper function
> for "existence of the superproject" would be interesting in the future,
> e.g. for get_superproject_git_dir, or on its own. There was an attempt
> to have the shell prompt indicate if you are in a submodule,
> which would not need to know the worktree or git dir of the
> superproject, but only its existence.
>
>> instead coded in get_superproject_working_tree() in place to do:
>>
>>         - xgetcwd() to get "/local/repo/super/sub/dir".
>
> Did you mean .../super/dir/sub ?

I meant "/local/repo/super/sub/dir".  I am using this case to
illustrate: the root of the superproject is at /local/repo/super,
its submodule we are interested in is at sub/dir, and the function
is working inside the submodule--after the repository discovery
moves the cwd, xgetcwd() would give the root of the working tree of
the submodule, which is at "/local/repo/super/sub/dir".

And that would give us "dir" by taking that as relative to its "../"

>>         - relative_path() to get "dir".
>
> ok.

indeed.

>>         - ask "ls-{tree,files} --full-name HEAD dir" to get "160000"
>>           and "sub/dir".
>
> "ls-files --stage --full-name" to get
> 160000 ... dir/sub

Yeah, also when usihng ls-files you obviously do not give HEAD but
you do give "dir" as the pathspec.  And you get "sub/dir" as the
result.
