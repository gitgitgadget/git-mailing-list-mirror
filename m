Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1676A1F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 04:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeK1PqY (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 10:46:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59769 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbeK1PqX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 10:46:23 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 60A7B320CC;
        Tue, 27 Nov 2018 23:46:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Fa8/mfvaC6sz
        7Jy13e8Zx8i/Eu0=; b=SxXDfHWavw30HfSttRAG+NoKoTZyWYTP8GAtS7bN59yu
        LPHwfWWyAB6xwVmaRm0e5iA3Jx3hXQ8VvPEcTzfJCiU0geeLEJ2/TPkENV0B278a
        4nyIyU6RhTJfIebXHXjPCOCtLLcyZC8ZQShjs+jeifpRuvYycz4S/2APTDA07nU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JaOIjf
        yIzx5JFWeNVf4MrkPfuwFYRhcuYSoEF4nH5eUID8YVzqJMDEyPUYUe4QHzXvkWLZ
        o94NL501S/VBsj/Wg6U0weuz7ie6jB2pj1gSLeg+gn7+uZ4UGnEE48UD7iFe/quC
        tJ1oh7OquNPTaAwaHxZT5OkmPI3yeRXLJK91s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 59103320CB;
        Tue, 27 Nov 2018 23:46:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6E923320C8;
        Tue, 27 Nov 2018 23:46:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, hsed@unimetic.com
Subject: Re: [PATCH] tests: avoid syntax triggering old dash bug
References: <20181127164253.9832-1-avarab@gmail.com>
        <CAPig+cS-_m8RBsCME_Gj15EEs1tcFcGn0Acfvq4HgxKiL9PaHg@mail.gmail.com>
Date:   Wed, 28 Nov 2018 13:45:59 +0900
In-Reply-To: <CAPig+cS-_m8RBsCME_Gj15EEs1tcFcGn0Acfvq4HgxKiL9PaHg@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 27 Nov 2018 14:16:55 -0500")
Message-ID: <xmqqo9a9stbs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 817D7CF2-F2C8-11E8-B0A6-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Nov 27, 2018 at 11:43 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Avoid a bug in dash that's been fixed ever since its
>> ec2c84d ("[PARSER] Fix clobbering of checkkwd", 2011-03-15)[1] first
>> released with dash v0.5.7 in July 2011.
>
> Perhaps enhance the commit message to explain the nature of the bug
> itself. It is not at all obvious from reading the above or from
> looking at the diff itself what the actual problem is that the patch
> is fixing. (And it wasn't even immediately obvious by looking at the
> commit message of ec2c84d in the dash repository.) To help readers of
> this patch avoid re-introducing this problem or diagnose such a
> failure, it might be a good idea to give an example of the syntax
> which trips up old dash (i.e. a here-doc followed immediately by a
> {...} expression) and the actual error message 'Syntax error: "}"
> unexpected'.

Indeed.  From the patch text, I would not have even guessed.  I was
wondering if there were interactions with "" and $() inside it.

If having {...} immediately after a here-doc is a problem, then the
patch should not touch existing code at all, but instead insert a
new line, perhaps like

	: avoid open brace immediately after here-doc for old dash

immediately before {...}; that would have made it easier to grok.

>@@ -892,8 +892,9 @@ test_expect_success 'get --expiry-date' '
> 	1510348087
> 	0
> 	EOF
>+	date_valid1=3D$(git config --expiry-date date.valid1) &&
> 	{
>-		echo "$rel_out $(git config --expiry-date date.valid1)"
>+		echo "$rel_out $date_valid1"
> 		git config --expiry-date date.valid2 &&
> 		git config --expiry-date date.valid3 &&
> 		git config --expiry-date date.valid4 &&
