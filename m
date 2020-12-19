Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33210C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 00:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10E923BA7
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 00:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgLSAr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 19:47:59 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53536 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgLSAr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 19:47:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9728711102A;
        Fri, 18 Dec 2020 19:47:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YztTZcuWkYa2XYHEIRXZfecL+vE=; b=AJe0C9
        vfU5ajgGK701qqSfN3sVMrByYucZWH2VDcfWzrKPFRxHxV/1ZYjVlzDYv427tOQx
        fGXCTe1/msc/C6DQoJ6i1AhzxLTTy4wKl6CYrhQagDNMjpbKXozrll4YdUI+dsqE
        jM5gCd4F6kPHIHlxf1eXuvfqaPs2jQveOu2VY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YisUAUG4b2nGClbUDFw1tqNlZh1mTG7A
        0VqEoLfDmcE5A/reMmH3sai8ueJ18BunByGvvqVkV2+jERjQ93WXui1Ju0fnwMp5
        1LwjrJENIi4/jHr044TW8d8MLCa8ZB+s3/V+UXqcs2ZxbL6DJMgQzWovaSrH35Lz
        o/+HCC/HoMc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FBB6111029;
        Fri, 18 Dec 2020 19:47:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 121ED111028;
        Fri, 18 Dec 2020 19:47:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Shourya Shukla <periperidip@gmail.com>, git@vger.kernel.org,
        liu.denton@gmail.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v3 1/3] dir: change the scope of function
 'directory_exists_in_index()'
References: <20201214231939.644175-1-periperidip@gmail.com>
        <20201214231939.644175-2-periperidip@gmail.com>
        <nycvar.QRO.7.76.6.2012190104140.56@tvgsbejvaqbjf.bet>
Date:   Fri, 18 Dec 2020 16:47:11 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2012190104140.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 19 Dec 2020 01:08:11 +0100 (CET)")
Message-ID: <xmqqsg82tyeo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BBC09716-4193-11EB-9666-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Shourya,
>
> On Tue, 15 Dec 2020, Shourya Shukla wrote:
>
>> Change the scope of the function 'directory_exists_in_index()' as well
>> as declare it in 'dir.h'.
>>
>> Since the return type of the function is the enumerator 'exist_status',
>> change its scope as well and declare it in 'dir.h'. While at it, rename
>> the members of the aforementioned enum so as to avoid any naming clashes
>> or confusions later on.
>
> This makes it sound as if only existing code was adjusted, in a minimal
> way, but no new code was introduced. But that's not true:

I noticed it last night, too---I suspect it was a mistake made while
shuffling changes across steps with rebase -i.

>> Helped-by: Christian Couder <christian.couder@gmail.com>
>> Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
>> Signed-off-by: Shourya Shukla <periperidip@gmail.com>
>> ---
>>  builtin/submodule--helper.c | 408 ++++++++++++++++++++++++++++++++++++
>>  dir.c                       |  30 ++-
>>  dir.h                       |   9 +
>>  3 files changed, 429 insertions(+), 18 deletions(-)
>
> Tons of new code there. And unfortunately...

>> +static const char *parse_token(const char *cp, int *len)
>> +{
>> +	const char *p = cp, *start, *end;
>> +	char *str;
>> +
>> +	start = p;
>> +	while (*p != ' ')
>> +		p++;
>> +	end = p;
>> +	str = xstrndup(start, end - start);
>> +
>> +	while(*p == ' ')
>> +		p++;
>> +
>> +	return str;
>> +}
>
> This function is not careful enough to avoid buffer overruns. It even
> triggers a segmentation fault in our test suite:
> https://github.com/gitgitgadget/git/runs/1574891976?check_suite_focus=true#step:6:3152

I notice that len is not used at all ;-)

> I need this to make it pass (only tested locally so far, but I trust you
> to take the baton from here):
>
> -- snipsnap --
> From c28c0cd3ac21d546394335957fbaa350ab287c3f Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Sat, 19 Dec 2020 01:02:04 +0100
> Subject: [PATCH] fixup??? dir: change the scope of function
>  'directory_exists_in_index()'
>
> This fixes the segmentation fault reported in the linux-musl job of our
> CI builds. Valgrind has this to say about it:
>
> ==32354==
> ==32354== Process terminating with default action of signal 11 (SIGSEGV)
> ==32354==  Access not within mapped region at address 0x5C73000
> ==32354==    at 0x202F5A: parse_token (submodule--helper.c:2837)
> ==32354==    by 0x20319B: report_fetch_remotes (submodule--helper.c:2871)
> ==32354==    by 0x2033FD: add_submodule (submodule--helper.c:2898)
> ==32354==    by 0x204612: module_add (submodule--helper.c:3146)
> ==32354==    by 0x20478A: cmd_submodule__helper (submodule--helper.c:3202)
> ==32354==    by 0x12655E: run_builtin (git.c:458)
> ==32354==    by 0x1269B4: handle_builtin (git.c:712)
> ==32354==    by 0x126C79: run_argv (git.c:779)
> ==32354==    by 0x12715C: cmd_main (git.c:913)
> ==32354==    by 0x2149A2: main (common-main.c:52)
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/submodule--helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 4f1d892b9a9..29a6f80b937 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2834,12 +2834,12 @@ static const char *parse_token(const char *cp, int *len)
>  	char *str;
>
>  	start = p;
> -	while (*p != ' ')
> +	while (*p && *p != ' ')
>  		p++;
>  	end = p;
>  	str = xstrndup(start, end - start);
>
> -	while(*p == ' ')
> +	while(*p && *p == ' ')
>  		p++;
>
>  	return str;
> --
> 2.29.2.windows.1.1.g3464b98ce68
