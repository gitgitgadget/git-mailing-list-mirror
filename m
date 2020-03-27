Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2E9C43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9388320737
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 18:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g2XpQ1LQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgC0S3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:29:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65290 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0S3q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 14:29:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB2846195C;
        Fri, 27 Mar 2020 14:29:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=CKoJXHiP3dLw
        NY0yRCZ7FF2Xeeo=; b=g2XpQ1LQnGS/pTewM1AVUPcGQxe0llp+rL456bLbe8CM
        wKUmSDRjZklPFkGNmFuPBmmk8EeISMbBFjGtnv4Cq/M9eWOg5THCpSS9MJpX/Mj3
        poLbmYEJ2cHz7/aQo3w9yaffYDoV/Tt10PR/VJvFudjbG3Dh2T/54kJsBG8ETW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vcLA+K
        QCOj4GwcCIhJtOLIsXA6n8aggwwgIj2t2oFWhePDUystO3w6AHinWvJv9ibjyB1l
        VAmZLHT3N8O7TPJbXNuqOrnUEVDS/GrYyypVwbE5EGMnSBh6mhuni1x/C9ziGlY+
        cXGOXsyzwHXdkzNP4IDJo5T3TtW60uTRB/tD4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1FEE6195B;
        Fri, 27 Mar 2020 14:29:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37EDC6195A;
        Fri, 27 Mar 2020 14:29:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] configure: respect --without-<package> flags
References: <cover.1584516715.git.congdanhqx@gmail.com>
        <cover.1584589859.git.congdanhqx@gmail.com>
        <20200326122314.GA19102@danh.dev>
Date:   Fri, 27 Mar 2020 11:29:43 -0700
In-Reply-To: <20200326122314.GA19102@danh.dev> (Danh Doan's message of "Thu,
        26 Mar 2020 19:23:14 +0700")
Message-ID: <xmqqa741hcrs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EE1BEFF6-7058-11EA-9D1C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> On 2020-03-19 10:58:54+0700, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh=
 <congdanhqx@gmail.com> wrote:
>> Current git's configure script allow --without-<package>,
>> it rightfully set NO_<PACKAGE> in the beginning of the configure scrip=
t,
>> but overwrite them with autodetect later.
>>=20
>> Respect them now.
>
> Hi Junio,
>
> Can I get your opinion on this serie?

I do not have opinion on everything ;-)  If you sent it during the
pre-release freeze, it is very possible that I totally ignored it,
especially if nobody showed interest in the topic.

Not limited to this topic, but I'd prefer to see leftover topics
reappear after the tip of 'next' gets rewind.

Thanks.

