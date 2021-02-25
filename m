Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E24C43381
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 19:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870B864F2C
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 19:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhBYTI1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 14:08:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57660 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhBYTH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 14:07:59 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9C729F7BD;
        Thu, 25 Feb 2021 14:06:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zZWn7t736POk
        KJw9BPVczSB4C9I=; b=xjcsQ1miN/Q8j5hzTasYlwSONa6sAsaAs4uVQfNKTb52
        vxlXvrh4jbD8Bzhp1CypxM8UQsvnbKN8kOiAD5BsRZglpzDEi7/9jNfgRdUBuFOy
        JC2avfP/MyqkamrJub+nVbNaDR56t9dxtjsRg+TicrmTmp6Tg9uy42kG58myjgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nuNpM/
        pv+KcjeKLAaVjo4/zv2FgVWrqqU98Je1AmIxi7WuzoI1IfF03P0lK+WNrSYzspgE
        6Dofug5WQnwp/Z/YHBCZ6Dz7ozHuz4wJCI8eBwxODK3m6qSP801Hg8xZhvFnmglA
        +EibK2UyMiC+PkkkZb2cHfgDcOuAjgvDjMOiM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0A8F9F7BC;
        Thu, 25 Feb 2021 14:06:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 585439F7BB;
        Thu, 25 Feb 2021 14:06:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v3 12/35] userdiff tests: change setup loop to
 individual test setup
References: <20210215154427.32693-1-avarab@gmail.com>
        <20210224195129.4004-13-avarab@gmail.com> <xmqqa6rsyi2u.fsf@gitster.g>
        <5fb2fd5c-7c69-a6fe-566d-227ed09946e4@kdbg.org>
Date:   Thu, 25 Feb 2021 11:06:52 -0800
In-Reply-To: <5fb2fd5c-7c69-a6fe-566d-227ed09946e4@kdbg.org> (Johannes Sixt's
        message of "Thu, 25 Feb 2021 19:28:35 +0100")
Message-ID: <xmqqlfbcufub.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F299136-779C-11EB-ABD4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 25.02.21 um 03:52 schrieb Junio C Hamano:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>=20
>>> +# check each individual file
>>> +for i in $(git -C t4018 ls-files)
>>> +do
>>> +	test_expect_success "setup hunk header: $i" "
>>> +		grep -v '^t4018' \"t4018/$i\" >\"t4018/$i.content\" &&
>>> +		sed -n -e 's/^t4018 header: //p' <\"t4018/$i\" >\"t4018/$i.header\=
" &&
>>> +		cp \"t4018/$i.content\" \"$i\" &&
>>> =20
>>>  		# add test file to the index
>>> -		git add "$i" &&
>>> +		git add \"$i\" &&
>>>  		# place modified file in the worktree
>>> -		sed -e "s/ChangeMe/IWasChanged/" <"t4018/$i.content" >"$i" || retu=
rn 1
>>> -	done
>>> -'
>>> +		sed -e 's/ChangeMe/IWasChanged/' <\"t4018/$i.content\" >\"$i\"
>>> +	"
>>=20
>> Please use '' around the second argument (i.e. test body) of the
>> test_expect_success, and use "" inside it.  "$i" that is used in the
>> loop is visible perfectly fine inside the test body when it is
>> eval'ed, and we won't have to count ugly backslashes that way.
>
> If we do that, then we better be sure that the implementation of
> test_expect_success does not clobber $i. Looks like we are OK at this t=
ime.

That's a good point.  Often we use more specific variable name than
$i to take advantage of the 'eval'-ed nature of the test body, and
it may probably be wise to do so here, too.
