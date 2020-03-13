Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531D0C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 00:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3925206EB
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 00:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V5+BPCFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCMALw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:11:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50340 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgCMALv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 20:11:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CDB94CF8CA;
        Thu, 12 Mar 2020 20:11:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WCwIodKjMWVxLecaKKxxcQ94Evo=; b=V5+BPC
        FD5w2MU27RSP9rxSxQKNdug4G8I2vT/ZLI3P9nizO+7k33krQURLvYy1Xj2D3Eih
        L0rlKho48Af6UoCR69cpeFvL0MhLLKY4pGG4kEE+pVfPvJGdNgc2jfjYxtypKnqw
        rH5XHg1/C678NfEgvFrBewd81iAPLgxywVLqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JvcmezPpyTMxmGnfCidx7yO/Xp6kqZa5
        cdoYQXrKbXsPEHjfUr/OjLogvAPsoLqV7Odp6bUiISQrgYvvun/eaiKzTVNJg31U
        qRNVR05PuV8GB80rI5wnskxOMFTbkcg8Wd7JaOxFWFWeBbpQG+xo8JFbUhCFDM9K
        Nb1Am9Y9iFc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C463ECF8C9;
        Thu, 12 Mar 2020 20:11:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 17DF2CF8C8;
        Thu, 12 Mar 2020 20:11:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Luke Bonanomi <lbonanomi@gmail.com>
Subject: Re: [PATCH v2] git-gui--askpass: coerce answers to UTF-8 on Windows
References: <pull.578.git.1583954676691.gitgitgadget@gmail.com>
        <pull.578.v2.git.1584048710895.gitgitgadget@gmail.com>
Date:   Thu, 12 Mar 2020 17:11:45 -0700
In-Reply-To: <pull.578.v2.git.1584048710895.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 12 Mar 2020 21:31:50
        +0000")
Message-ID: <xmqq7dzpdsfy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A7F19C2-64BF-11EA-AB74-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Luke Bonanomi <lbonanomi@gmail.com>
>
> This addresses the issue where Git for Windows asks the user for a
> password, no credential helper is available, and then Git fails to pick
> up non-ASCII characters from the Git GUI helper.
>
> This can be verified e.g. via
>
> 	echo host=http://abc.com |
> 	git -c credential.helper= credential fill
>
> and then pasting some umlauts.
>
> The underlying reason is that Git for Windows tries to communicate using
> the UTF-8 encoding no matter what the actual current code page is. So
> let's indulge Git for Windows and do use that encoding.
>
> This fixes https://github.com/git-for-windows/git/issues/2215
>
> Signed-off-by: Luke Bonanomi <lbonanomi@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Heh, that is over-crediting me.  I didn't do anything other than
just scan the code once.

>     Fix git-gui--askpass on Windows
>     
>     Windows has this odd thing where there is an active code page (somewhat
>     like LC_CTYPE) and there is no real UTF-8 code page. So we need to help 
>     git-gui--askpass along a bit to be of use when asking for credentials.
>     
>     Changes since v1:
>     
>      * Fixed indentation
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-578%2Fdscho%2Fgit-gui--askpass-utf-8-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-578/dscho/git-gui--askpass-utf-8-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/578
>
> Range-diff vs v1:
>
>  1:  3beec773772 ! 1:  7891941486d git-gui--askpass: coerce answers to UTF-8 on Windows
>      @@ -20,6 +20,7 @@
>           This fixes https://github.com/git-for-windows/git/issues/2215
>       
>           Signed-off-by: Luke Bonanomi <lbonanomi@gmail.com>
>      +    Helped-by: Junio C Hamano <gitster@pobox.com>
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>       
>        diff --git a/git-gui--askpass b/git-gui--askpass
>      @@ -30,7 +31,7 @@
>        	}
>        
>       +	# On Windows, force the encoding to UTF-8: it is what `git.exe` expects
>      -+		if {$::tcl_platform(platform) eq {windows}} {
>      ++	if {$::tcl_platform(platform) eq {windows}} {
>       +		set ::answer [encoding convertto utf-8 $::answer]
>       +	}
>       +
>
>
>  git-gui--askpass | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/git-gui--askpass b/git-gui--askpass
> index 4277f30c411..1c99ee8ca20 100755
> --- a/git-gui--askpass
> +++ b/git-gui--askpass
> @@ -56,6 +56,11 @@ proc finish {} {
>  		}
>  	}
>  
> +	# On Windows, force the encoding to UTF-8: it is what `git.exe` expects
> +	if {$::tcl_platform(platform) eq {windows}} {
> +		set ::answer [encoding convertto utf-8 $::answer]
> +	}
> +
>  	puts $::answer
>  	set ::rc 0
>  }
>
> base-commit: 63a58457e094c9c9bbf562b872009d32f1f88133
