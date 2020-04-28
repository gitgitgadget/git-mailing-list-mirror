Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A183BC83007
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 19:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A2120730
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 19:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cYF/OcRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgD1TRU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:17:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56132 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgD1TRU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 15:17:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD1D964EFF;
        Tue, 28 Apr 2020 15:17:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FYhCYARfOFFK
        wlm29GthCuym7xs=; b=cYF/OcRTy97PQ+vyHJBVUsDNcWIBNBZE29+eUf+26hit
        mNClbgKAmJjXfe6/vEdj3eH7SQZNoAjjm/vtO24VADprZhOJsr8Xx+UO7jjVwNdO
        L+0UFOg0zAswBSfRJmljP2foM5eqUYspTvMCmLoeVRbKHBJKa/ej0CYgGovKIwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WDGHuI
        o3e7t6drMC8JVaBwjEWI2TmjmJme5JuPeI2OBQtmTzeB9G85tqtfp70ME6CaIFt7
        G98QPWrCjaXrFhpN1fxM/H9uwNfuMKp8eQQHB2EmPzXbRXBK/TdqV0FdtugVk6O4
        aFfUUnG1+W+LVxIq7ukTRDjggs/5lCPXR4GBs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C39C764EFE;
        Tue, 28 Apr 2020 15:17:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A21864EF7;
        Tue, 28 Apr 2020 15:17:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fetch-pack: return enum from process_acks()
References: <cover.1587775989.git.jonathantanmy@google.com>
        <cover.1588031728.git.jonathantanmy@google.com>
        <f0cfbc03c27658e54a73c46570c5153961ed85b6.1588031728.git.jonathantanmy@google.com>
        <20200428005333.GE36078@google.com>
        <xmqqftcn4klg.fsf@gitster.c.googlers.com>
        <20200428200056.6fb5dd6b@naga.burning-in.hell>
Date:   Tue, 28 Apr 2020 12:17:16 -0700
In-Reply-To: <20200428200056.6fb5dd6b@naga.burning-in.hell> ("Michal
        =?utf-8?Q?Such=C3=A1nek=22's?= message of "Tue, 28 Apr 2020 20:00:56
 +0200")
Message-ID: <xmqq4kt32zer.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DFD0B252-8984-11EA-A1EB-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> On Tue, 28 Apr 2020 09:54:19 -0700
> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>=20
>> >>  	/* return 0 if no common, 1 if there are common, or 2 if ready */=
 =20
>> >
>> > This comment can be removed now, which is a nice bonus.
> It is still present in the pu branch.
>
> Is there other branch where I should look?

Some branch that is pushed out _after_ I push out, perhaps?
