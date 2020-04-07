Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2160C2D0EC
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 21:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8A320748
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 21:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QTXuZNUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDGVz2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:55:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61892 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDGVz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 17:55:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6C39C9E0B;
        Tue,  7 Apr 2020 17:55:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5h6sOrOrILamFwchses82NhD/AM=; b=QTXuZN
        UkzQ+vmEUWBj2lZbcrPwVuV+6cwmSgprUpehj+en6m9Dc26aXgR36Wj1a0OUzN0J
        25Lmtbw1yBtqFjEgiDoF5lWK2DYXxH24fBZ3KtMy+7sYSVrg7WE/GNNonk20xi3z
        cENfQOSpdO1rjFB5kzv94zq0mFU0aDs3Nd9l8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W57JAHTu5jXZcfhLoZM7oNXGeNl42yk0
        s7biRjNe7vXRoQHCRVzDX9lfv+8xjbAWz+q7rf+i6RJSI86rwmIKCLuoIb+613RJ
        ANTPbVS+UGHV92frzZBQstG7/HvJ8cVrnEn+XSci7XBCu7QuW+4IKpKs5+3lDtB/
        G+2kEl7exuk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF237C9E0A;
        Tue,  7 Apr 2020 17:55:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 12C58C9E09;
        Tue,  7 Apr 2020 17:55:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Sami Boukortt <sami@boukortt.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: New git-rebase backend: no way to drop already-empty commits
References: <CAAb+AL8+c6knrQnoi7YOjyM+Wc8-rws-JXVufBc=PciAvPPFJQ@mail.gmail.com>
        <CABPp-BGFinonZJb2u_0-fX3y_UyJ1dY+O40oN0WAzZht0ddJ4w@mail.gmail.com>
        <xmqqh7xvtby2.fsf@gitster.c.googlers.com>
        <CABPp-BF8eokQTVwgo80ffq3tn=NA=mPf7oymce5P4itDyZBiMg@mail.gmail.com>
Date:   Tue, 07 Apr 2020 14:55:21 -0700
In-Reply-To: <CABPp-BF8eokQTVwgo80ffq3tn=NA=mPf7oymce5P4itDyZBiMg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 7 Apr 2020 12:45:55 -0700")
Message-ID: <xmqqd08jrmeu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B2DCB98-791A-11EA-B44F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> As we will be dropping 'apply' that could be used as an escape
>> hatch, before we do so, we should teach the other backends an
>> alternate escape hatch to help those who have been depending on the
>> behaviour of 'apply' that discards the empty ones, whether they
>> become empty, or they are empty from the beginning.  I think the
>> "has contents originally but becomes empty" side is already taken
>> care of, so we'd need to make sure it is easy to optionally discard
>> the ones that are originally empty.
>>
>> Thanks.
>
> I will take a look into it, using (or at least starting with) the
> suggestion Sami provided.

Thanks.
