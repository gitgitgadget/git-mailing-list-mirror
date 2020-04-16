Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0E4C38A29
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 01:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA6F214AF
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 01:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xwffyWx4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbgDPB3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:29:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62457 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732147AbgDPB2p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 21:28:45 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DBFF2D5884;
        Wed, 15 Apr 2020 21:28:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NlwIoywo/3wIEtj4VJtai6fLFnc=; b=xwffyW
        x4LL9dGUWsVs183zkLeO87vdhBx92ck7JT8nHNFv6/QK00uur1Mddps2hW6MW4XA
        qMirAtrdXifOjxGumUkNO+6gRArMErefS9rzWxeByiV3Tl0Fi8bfhRqPiE3A7N9s
        sfdMQX12zy6MYXiC3BXMvqPtzQShLC1Fxe27c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cw5DzzjGFaPS4WSmYdUqN/9FuL6Ac/l2
        NJ1b/LVgzWHqtW89UzJHVY0voU7WlkJvVw8Kov/9rhNLmozz4V0Vgkqj+6g9ECU1
        lwC6HpPuWlE/Hm51WQ361k8Fi7W2asjsFTbZpgp1FdcAnfayd+OIdUPxZOavrB7I
        J+ZpFAvQTuE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D3C1FD5883;
        Wed, 15 Apr 2020 21:28:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2B0CCD5882;
        Wed, 15 Apr 2020 21:28:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Danh Doan <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: fixing ci failure of 'pu' with the es/bugreport topic
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com>
        <cover.1586309211.git.congdanhqx@gmail.com>
        <xmqqpncgmk5z.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004101604210.46@tvgsbejvaqbjf.bet>
        <xmqq1rovl54d.fsf@gitster.c.googlers.com>
        <20200410174141.GB27699@danh.dev>
        <xmqqh7xk45l4.fsf@gitster.c.googlers.com>
Date:   Wed, 15 Apr 2020 18:28:38 -0700
In-Reply-To: <xmqqh7xk45l4.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 15 Apr 2020 17:49:59 -0700")
Message-ID: <xmqq1roo43sp.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9A259C7A-7F81-11EA-93FB-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Danh Doan <congdanhqx@gmail.com> writes:
>
>> Excerpt from build log:
>>
>>> fatal error C1083: Cannot open include file: 'config-list.h'
>>
>> It's from bugreport topic.
>> I've seen this failure in the past (when testing with pu),
>> then I saw it disappear.
>>
>> I thought it was fixed during my testing for v4.
>
> Is the issue something similar to 976aaedc (msvc: add a Makefile
> target to pre-generate the Visual Studio solution, 2019-07-29)?
>
> If that is the case, perhaps something like this would help?  I'll
> tentatively queue it on top of es/bugreport and merge the result to
> 'pu' to see what happens.

The build just passed: https://github.com/git/git/runs/590781044

Emily, you may need to squash in something along the line of this
change to the commit in your series that starts building and using
the config-list.h file (was it the first one?).  I've queued mine
as a follow-up "oops, it was wrong" patch, but that would not be
kosher from bisectability's point of view.

But before we see a full reroll of the topic, it would be good to
have a quick "looks OK" from somebody who does Windows (Dscho
CC'ed).

Thanks.

> -- >8 --
> Subject: msvc: the bugreport topic depends on a generated config-list.h file
>
> For reasons explained in 976aaedc (msvc: add a Makefile target to
> pre-generate the Visual Studio solution, 2019-07-29), some build
> artifacts we consider non-source files cannot be generated in the
> Visual Studio environment, and we already have some Makefile tweaks
> to help Visual Studio to use generated command-list.h header file.
>
> As this topic starts to depend on another such generated header file,
> config-list.h, let's do the same to it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  compat/vcbuild/README | 4 ++--
>  config.mak.uname      | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/compat/vcbuild/README b/compat/vcbuild/README
> index 1b6dabf5a2..42292e7c09 100644
> --- a/compat/vcbuild/README
> +++ b/compat/vcbuild/README
> @@ -92,8 +92,8 @@ The Steps of Build Git with VS2008
>     the git operations.
>  
>  3. Inside Git's directory run the command:
> -       make command-list.h
> -   to generate the command-list.h file needed to compile git.
> +       make command-list.h config-list.h
> +   to generate the header file needed to compile git.
>  
>  4. Then either build Git with the GNU Make Makefile in the Git projects
>     root
> diff --git a/config.mak.uname b/config.mak.uname
> index 0ab8e00938..f880cc2792 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -721,9 +721,9 @@ vcxproj:
>  	 echo '</Project>') >git-remote-http/LinkOrCopyRemoteHttp.targets
>  	git add -f git/LinkOrCopyBuiltins.targets git-remote-http/LinkOrCopyRemoteHttp.targets
>  
> -	# Add command-list.h
> -	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 command-list.h
> -	git add -f command-list.h
> +	# Add command-list.h and config-list.h
> +	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 config-list.h command-list.h
> +	git add -f config-list.h command-list.h
>  
>  	# Add scripts
>  	rm -f perl/perl.mak
