Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PLING_QUERY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923F0C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 04:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5701322AAC
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 04:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbhAQEdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 23:33:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62035 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbhAQEdv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 23:33:51 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 581531036E4;
        Sat, 16 Jan 2021 23:33:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Uv/C9nltDG25YAQrwIiZSRet8c=; b=Hdi6QA
        eKYDnrXGOj29XLZUNQkFN1rk62InR3dgZ3RVQ9UPs0wth7b3Tbn11xdv/roRiIh0
        4gfVjB4lDEQabk5eEVQQuh/98cwfR0PWp2lYgmVR63zJbNNR0QnMlYutqwhbxcLU
        ZfZ5SWaCmmww8/UPjrvO9I1Ib8Fm/XWTuO9vM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G7oGGKK73CKoFliyKLwZv9vzcsAl6u6I
        7dJ/kA1KAgBfi6oAlbZcjW8wGkeIzQUAD8jqIPt3B1vwTbsSJKJUi5ZUE6fw1sdB
        LHFmsDT7JtXM+dXdlm9RncYpYP2AZQCvxWmpqIabhJc0hok8+5z04y9KDZWy5NZt
        kCtLEmB21z8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 501711036E3;
        Sat, 16 Jan 2021 23:33:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 972D31036E1;
        Sat, 16 Jan 2021 23:33:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: How to implement the "amend!" commit ?
References: <CAPSFM5c2iqBn8_Dih2id7q6RRp0q=vfCSVUHDE5AOXZ8z3Ko9w@mail.gmail.com>
        <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com>
        <99b40665-45dd-6c4d-d46a-56c7dbf89568@gmail.com>
        <xmqq7dofxnru.fsf@gitster.c.googlers.com>
        <CAPSFM5cEnex1xaBy5ia_xNFDNzt5_Y=W-6TB9d9yW_AiPAKxDg@mail.gmail.com>
Date:   Sat, 16 Jan 2021 20:33:00 -0800
In-Reply-To: <CAPSFM5cEnex1xaBy5ia_xNFDNzt5_Y=W-6TB9d9yW_AiPAKxDg@mail.gmail.com>
        (Charvi Mendiratta's message of "Sun, 17 Jan 2021 09:13:07 +0530")
Message-ID: <xmqq4kjgnpxf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15E3F7B0-587D-11EB-A9FA-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> Earlier, I thought to implement the UI of amend! commit as :
> "git commit --fixup=a/amend:<commit>"
>
> So users can either use 'a' as abbreviation or 'amend'. But I want to once
> confirm if I got this right ? As I am doubtful about, what does allowing to
> accept any prefix of "amend" and "reword" means ?

It means that all of these do the same thing ...

	git commit --fixup=amend:<commit>
	git commit --fixup=amen:<commit>
	git commit --fixup=ame:<commit>
	git commit --fixup=am:<commit>
	git commit --fixup=a:<commit>

... until somebody more brilliant than either of us comes along and
invents another operation that sits next to 'amend' and 'reword',
say, 'annoy'.  At that point,

	git commit --fixup=a:<commit>

no longer uniquely identifies a choice among three ('amend',
'annoy', or 'reword') and you'd give an error message, but

	git commit --fixup=am:<commit>

will keep working as an abbreviation for "amend".
