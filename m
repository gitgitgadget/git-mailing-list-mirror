Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B89C433F5
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 22:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbiAaWmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 17:42:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64315 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiAaWmD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 17:42:03 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B2ECA165A75;
        Mon, 31 Jan 2022 17:42:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0EdLtNjvVyzU
        wralPpyzA5xxiXlTxUEmebMrsQUmvQs=; b=M6XMvaDCY5niKZWDejzvR0rK66Oj
        yXMQJuYe8lOIAorysyuI2954yY3UWvvYHwEyJhOhXWpA2obcKOjW3kJpYKc+zuzJ
        GGAqN4HKKNQYk2wsWwPNsV6M94k/83zYoV8inQJEDfOeOOPGAME2JxN2mpXnrQFz
        MfbO/DVxrYEReYk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AB49A165A74;
        Mon, 31 Jan 2022 17:42:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1D0EC165A6F;
        Mon, 31 Jan 2022 17:42:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v4 1/4] i18n: factorize more 'incompatible options'
 messages
References: <pull.1123.v3.git.1643580113.gitgitgadget@gmail.com>
        <pull.1123.v4.git.1643666870.gitgitgadget@gmail.com>
        <2eac2ef502b86d0c15513c8d0e69928ce2140b1f.1643666870.git.gitgitgadget@gmail.com>
Date:   Mon, 31 Jan 2022 14:41:59 -0800
In-Reply-To: <2eac2ef502b86d0c15513c8d0e69928ce2140b1f.1643666870.git.gitgitgadget@gmail.com>
        (=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Mon,
 31 Jan 2022
        22:07:46 +0000")
Message-ID: <xmqqv8xzh6iw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 013AFDFA-82E7-11EC-BF27-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jean-No=C3=ABl Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> +inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
> +				      int opt2, const char *opt2_name,
> +				      int opt3, const char *opt3_name)
> +{
> +	die_for_incompatible_opt4(opt1, opt1_name,
> +				  opt2, opt2_name,
> +				  opt3, opt3_name,
> +				  0, "");
> +}

I haven't seen a non-static inline function defined in a common
header files.  Does this actually work?  In my build, ld choked on
this one.

Otherwise make it "static inline"?  Or just

#define die_for_incompatible_opt3(o1,n1,o2,n2,o3,n3) \
	die_for_incompatible_opt4((o1), (n1), \
				  (o2), (n2), \
				  (o3), (n3), \
				  0, "")

perhaps?
