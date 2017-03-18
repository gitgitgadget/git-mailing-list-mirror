Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 492182095B
	for <e@80x24.org>; Sat, 18 Mar 2017 18:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbdCRSfq (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 14:35:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60344 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751449AbdCRSfp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 14:35:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 825DF838CF;
        Sat, 18 Mar 2017 14:35:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mJ8WENkgFLxC
        Nkz8iF449q5Y6RI=; b=f/zBjbta1QrzoEys/tbr5hUdaK6d6GFX29l8wAChmC6W
        Bzo575M7+tseC4tVtU1eZi9pSDvXqRz9d4PVAJ12g+ZWksWUbUM3LIqxFrh2Usoq
        oz/qkGRRvosL8fQZJq4U9CfTt7f+YCpBBg+uPpBtEyfirVMBxc/4mDv3w/6wErI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Z4qhCr
        tcoTxPR4NcyrEKUNjtRDOp4mvtoSEqr/L37ua/8jIDCun9ee8BINmJwfm1G5hHMh
        Ow1P13257HzuG1F19zh6DgYk/DmsY+HjSdIuJHR0KJX/9/Vit/mmb4eto0OCV7Tp
        FEv389leutiBf+oEEjB9Y4e2cdNtKfqpUdeGU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7853A838CE;
        Sat, 18 Mar 2017 14:35:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D740A838CD;
        Sat, 18 Mar 2017 14:35:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH 2/8] tag: Refactor the options handling code to be less bizarro
References: <20170318103256.27141-1-avarab@gmail.com>
        <20170318103256.27141-3-avarab@gmail.com>
Date:   Sat, 18 Mar 2017 11:35:41 -0700
In-Reply-To: <20170318103256.27141-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 18 Mar 2017 10:32:50 +0000")
Message-ID: <xmqqr31u301u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B175C916-0C09-11E7-8D1F-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> diff --git a/builtin/tag.c b/builtin/tag.c
> index ad29be6923..0bba3fd070 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -454,10 +454,10 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
>  	}
>  	create_tag_object =3D (opt.sign || annotate || msg.given || msgfile);
> =20
> -	if (argc =3D=3D 0 && !cmdmode)
> +	if (argc =3D=3D 0 && !cmdmode && !create_tag_object)
>  		cmdmode =3D 'l';

So with this change, if we cannot infer that we are creating a tag
object from other options, we leave cmdmode to its original 0.

> -	if ((create_tag_object || force) && (cmdmode !=3D 0))
> +	if ((create_tag_object || force) && (cmdmode || (!cmdmode && !argc)))
>  		usage_with_options(git_tag_usage, options);

And then immediately after that, we complain by detecting that we
know we are creating a tag and a non-zero cmdmode is in effect
(i.e. 'l', 'd' or 'v', none of which is about creating a tag).  The
way we used to detect that we are doing something other than tag
creation was by seeing cmdmode is set to anything.  Because of your
earlier change, that no longer is true.  You need to separately
check (!cmdmode && !argc).

By following the logic that way, I can see how this change at this
step is a no-op, but I have to say that the code with this patch
looks much more bizarre than the original.

I am not sure why you want to do the first change at this step in
the first place.  Is it because you'd want to take over (!cmdmode &&
!argc) condtion to default to 'list'?  With the change in 4/8 and
5/8, you are ensuring that cmdmode is set to 'l' for these new cases
before the code hits the check to call usage_with_options().  And at
that point, you can use the original "are we creating and !cmdmode
says we are not?  That's contradiction" logic without making it more
bizarre with this patch, no?
