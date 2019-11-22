Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA53C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 02:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10682067D
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 02:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B2882Max"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfKVCj2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 21:39:28 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59368 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfKVCj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 21:39:27 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B94588BC26;
        Thu, 21 Nov 2019 21:39:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=emwCRWYRuns4VjQEvoud6fSH3sA=; b=B2882M
        axnA/gnkMmjzXW9x6aANeZClXfSABTR6nY5hoqJvwgluTkUDPqLICj65gMrBX1Rb
        aXAwxLaG9sxfxEZOpOJ2LeuF/odJk/xeZv20ueZDv+FUEXOy3Fbq/7i6cKoC32JN
        znTTzbbvhOvvGWZOU+G/3PY6BoixkFMVtNBiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Pvsr5TGEhw8gAAopAcrk6vXujdX2cb0r
        oiKApQtF5NAYxNuKkyme9xTqWRMEbvsElv3kBxxsTrSvT4DmjZTTWCMseO8Xrcmy
        FG1azkhYm8ORepPwYtR8nspX426WVBW9PVn0VoTqBNtTS3zD3eTVSElpVT7/qkF6
        oLCE8l+9hoo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1E828BC25;
        Thu, 21 Nov 2019 21:39:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E47A08BC24;
        Thu, 21 Nov 2019 21:39:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hans Jerry Illikainen <hji@dyntopia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] gpg-interface: limit search for primary key fingerprint
References: <20191116180655.10988-1-hji@dyntopia.com>
        <20191116180655.10988-2-hji@dyntopia.com>
        <xmqqtv712145.fsf@gitster-ct.c.googlers.com>
        <87d0dkbyxb.hji@dyntopia.com>
Date:   Fri, 22 Nov 2019 11:39:20 +0900
In-Reply-To: <87d0dkbyxb.hji@dyntopia.com> (Hans Jerry Illikainen's message of
        "Thu, 21 Nov 2019 23:19:12 +0000")
Message-ID: <xmqqsgmg7hyf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4AB8561E-0CD1-11EA-860E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hans Jerry Illikainen <hji@dyntopia.com> writes:

> On Mon, Nov 18 2019, Junio C Hamano wrote:
> ...
>> A short helper
>>
>> 	static void replace_cstring(const char **field,
>> 				    const char *line, const char *next)
>> 	{
>> 		free(*field);
>> 		if (line && next)
>> 			*field = xmemdupz(line, next - line);
>> 		else
>> 			*field = NULL;
>> 	}
>>
>> may have quite a lot of uses in this function, not only for this
>> field.
>
> Implemented.  I wasn't sure whether to do it in a separate commit or
> not, but #git-devel suggested that I do; so that's what I did.

If such a refactoring helped the readability of _existing_ code that
can also use this helper, then I agree it is the right approach to
make that into a separate prelimimary commit.

Thanks for working on this.

