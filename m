Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E5EC4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 21:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A9F622C7C
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 21:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgLGVpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 16:45:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52807 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgLGVpT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 16:45:19 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC65D8BE78;
        Mon,  7 Dec 2020 16:44:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ml1qOvGIB5gg
        tsLSTn/zBC3NjFU=; b=RTobMXCjEENbTF4WCTDLUw0zzKY9dxIzN3oAWyqY2LUy
        5HHXJCMdfT0kC7LQhSBMY+b46hZMb+C5GFWnWzKmF9fLJ4qO8DVqWCzFN0StAH6/
        9K6G6VcSGWUXGwmaJ9srE4CyVNz542ZWx2N5MM6kapcmVVcI9Ei4ju02/3er/yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uPqES+
        b2LwNo6z3W5wq/EuhlSVRpWaBcHLSieI94oy2bg3NjbX7TnrwrwJXpJ21jeZiys6
        JDLRYWRzRge1EoVNJZDeUHEH/KouVJahcjLQAWIPdiZhbaGlGuY5GQc9v+HbBxAX
        rv5Iw7RsqsTZB+PcqIxYrKGDfEVACIiv8bmko=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E34478BE77;
        Mon,  7 Dec 2020 16:44:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73EFB8BE76;
        Mon,  7 Dec 2020 16:44:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: bash: fix gitk alias regression
References: <20201205071023.1270390-1-felipe.contreras@gmail.com>
        <CAMP44s0xdkG5P_QHasQZbM3wNf3H99ZWCKB4qgP0Xdigpo7aoQ@mail.gmail.com>
Date:   Mon, 07 Dec 2020 13:44:35 -0800
In-Reply-To: <CAMP44s0xdkG5P_QHasQZbM3wNf3H99ZWCKB4qgP0Xdigpo7aoQ@mail.gmail.com>
        (Felipe Contreras's message of "Sat, 5 Dec 2020 01:12:42 -0600")
Message-ID: <xmqqk0tt8f5o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 66916732-38D5-11EB-98DF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sat, Dec 5, 2020 at 1:10 AM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>>
>> Long time ago when the _git_complete helper was introduced, _gitk was
>> replaced with __gitk_main, and a placeholder for backwards compatibili=
ty
>> pointing to __git_wrap_main_gitk was left in place.
>>
>> When "__git_complete gitk __gitk_main" was called, that created the
>> __git_wrap__gitk_main helper, which is just basically "__git_func_wrap
>> __gitk_main" plus `complete` options.
>>
>> Unfortunately the commit b0a4b2d257 (completion: add support for
>> backwards compatibility, 2012-05-19) missed a previous instance of a
>> call to _gitk in _git_gitk
>>
>> So, basically we had __git_wrap__git_main -> __git_func_wrap __git_mai=
n ->
>> __git_complete_command gitk -> _git_gitk -> _gitk ->
>> __git_wrap__gitk_main -> __git_func_wrap __gitk_main -> __gitk_main.
>>
>> There was never any need to call __git_func_wrap twice. Since _git_git=
k
>> is always called inside the wrapper, it can call __gitk_main directly.
>>
>> And then, in commit 441ecdab37 (completion: bash: remove old compat
>> wrappers, 2020-10-27) _gitk was removed, which triggers the following
>> error:
>>
>>   _git_gitk:9: command not found: _gitk
>>
>> Let's call the correct function: __gitk_main.
>>
>> Cc: SZEDER G=C3=A1bor <szeder@ira.uka.de>
>
> Hmmm. SZEDER G=C3=A1bor <szeder.dev@gmail.com>

Thanks.

We've seen two hotfixes including this one on the fc/zsh-completion
topic since it has been pushed down to 'master' for a month or so.
Can somebody give the entire topic a quick eyeballing again (the
range is 1d1c4a8759..af806a2c24) just to be sure?




