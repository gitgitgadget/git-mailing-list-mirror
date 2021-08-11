Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC96C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 17:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A823860720
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 17:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhHKRRP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 13:17:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56808 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhHKRRO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 13:17:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 21F51D2565;
        Wed, 11 Aug 2021 13:16:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U1FnH8nfsUT3TKwNNj9JyvnE8anlGsgwFDU4ih
        PXMJ4=; b=OU1k0VzlW3pl7Y38k0PByvA7WDPXU9kF/3lxNz3nIUz0T1M29No4qo
        r5AxtDyXdWNIf2S6CN6vG/7jKsA4fF3vuhQ/QdU64bVc7bzGKR333fuilr7ci1rE
        eTikzKpJ3mtzFL/UN5JZIGm+gOlMgmhM3nl0A0cHe+4+5j5I3PoOo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1933FD2564;
        Wed, 11 Aug 2021 13:16:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 93F41D2563;
        Wed, 11 Aug 2021 13:16:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tassilo Horn <tsdh@gnu.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5] userdiff: improve java hunk header regex
References: <20210811145341.43429-1-tsdh@gnu.org>
Date:   Wed, 11 Aug 2021 10:16:49 -0700
In-Reply-To: <20210811145341.43429-1-tsdh@gnu.org> (Tassilo Horn's message of
        "Wed, 11 Aug 2021 16:53:41 +0200")
Message-ID: <xmqqa6lnaola.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9FF94FE-FAC7-11EB-82E4-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just a few whitespace nits that "git am" noticed for me.

Tassilo Horn <tsdh@gnu.org> writes:

> diff --git a/t/t4018/java-class-member-function b/t/t4018/java-class-member-function
> index 298bc7a71b..a8d7850412 100644
> --- a/t/t4018/java-class-member-function
> +++ b/t/t4018/java-class-member-function
> @@ -3,6 +3,10 @@ public class Beer
>  	int special;
>  	public static void main(String RIGHT[])
>  	{
> -		System.out.print("ChangeMe");
> +            someMethodCall();
> +            someOtherMethod("17")
> +                .doThat();
> +            // Whatever
> +            System.out.print("ChangeMe");

I notice that the original used HT (horizontal tab) to indent, but
the new one uses runs of SP (space).  This project has no written
preference for coding style for Java, which means it would have been
more appreciated if the original style were kept.

> diff --git a/t/t4018/java-enum-constant b/t/t4018/java-enum-constant
> new file mode 100644
> index 0000000000..a1931c8379
> --- /dev/null
> +++ b/t/t4018/java-enum-constant
> @@ -0,0 +1,6 @@
> +private enum RIGHT {
> +    ONE,
> +    TWO,
> +    THREE,
> +    ChangeMe
> +}

For these new tests, you'd be the one setting what styles to use ;-)
After all, we serve users from projects with different style, and
having variety in our test patterns is not bad.

> diff --git a/userdiff.c b/userdiff.c
> index 3c3bbe38b0..6644931ce1 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -142,7 +142,11 @@ PATTERNS("html",
>  	 "[^<>= \t]+"),
>  PATTERNS("java",
>  	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
> -	 "^[ \t]*(([A-Za-z_][A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
> +         /* Class, enum, and interface declarations */
> +         "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*[ \t]+.*)$\n"
> +         /* Method definitions; note that constructor signatures are not */
> +         /* matched because they are indistinguishable from method calls. */
> +         "^[ \t]*(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
>  	 /* -- */
>  	 "[a-zA-Z_][a-zA-Z0-9_]*"
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"

This hunk does violate project convention that our codebase uses
leading HT to indent (and align with extra SPs if needed).

