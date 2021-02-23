Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3CBC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 07:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B378864DDC
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 07:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhBWHtU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 02:49:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51044 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhBWHtS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 02:49:18 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9494E108A1B;
        Tue, 23 Feb 2021 02:48:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bAKEl6Fy1ZE3FFZZj1NKdVaRtYk=; b=mWKORy
        lnpRCPm1+Z0Kkv9hTscx3eGjA1UxsQbzicAMkYh4KWR/cQzbzfr4SgTL72h+617u
        MC2E+NuH7bdKJATyuaKHSpZVcwIu1UIFFvEtMzXXZiGgFU/qj2yNJUqRHWbXN5a8
        TLzkuWq9BYNc5Cd6enbpV4Jh0JfiaV1hJIQXw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YWuUQWs8xxrXApOOypz+8WcscqPYB2in
        X69KbZGnc29qwlX565Gc02xr6RsAURVhhZ7WAf9jDpOqHtowWC2D6pSFSUyl1WQE
        Nk+XPQvC2fc0rUkuPBICwFqx+KsVvzugQngJ2s9Zfsvt+ixaX6I0/nEP4LgVN8Hr
        DrBL7YmqW4M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C56C108A1A;
        Tue, 23 Feb 2021 02:48:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CA200108A19;
        Tue, 23 Feb 2021 02:48:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] git-cat-file.txt: remove references to "sha1"
References: <a24cbbe955f45072ffa88ca16f84e2443720a38f.1614062288.git.liu.denton@gmail.com>
        <4030a678b923ca6a49b4e5bc6f0cdf4cf6ae7037.1614064618.git.liu.denton@gmail.com>
Date:   Mon, 22 Feb 2021 23:48:32 -0800
In-Reply-To: <4030a678b923ca6a49b4e5bc6f0cdf4cf6ae7037.1614064618.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 22 Feb 2021 23:17:33 -0800")
Message-ID: <xmqqzgzv4433.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8784AA9A-75AB-11EB-979E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>  `objectname`::
> -	The 40-hex object name of the object.
> +	The full hex representation of the object ID of the object.

While I agree that it is a good idea to move away from an explicit
mention of "40", I do not see why we would want to explain "object
name" not as "object name" but as "object ID".  IOW, s/ID/name/.

> @@ -215,8 +215,9 @@ newline. The available atoms are:
>  
>  `deltabase`::
>  	If the object is stored as a delta on-disk, this expands to the
> -	40-hex sha1 of the delta base object. Otherwise, expands to the
> -	null sha1 (40 zeroes). See `CAVEATS` below.
> +	full hex representation of the object ID of the delta base
> +	object. Otherwise, expands to the null OID (all zeroes). See
> +	`CAVEATS` below.

Likewise.  Documentation/glossary-content.txt says "object name" is
the canonical term, with "object identifier", "hash" etc. as its
synonyms.

> @@ -235,14 +236,14 @@ newline.
>  For example, `--batch` without a custom format would produce:
>  
>  ------------
> -<sha1> SP <type> SP <size> LF
> +<oid> SP <type> SP <size> LF
>  <contents> LF
>  ------------
>  
>  Whereas `--batch-check='%(objectname) %(objecttype)'` would produce:
>  
>  ------------
> -<sha1> SP <type> LF
> +<oid> SP <type> LF
>  ------------

These look good.

Thanks.
