Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BAE11F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 07:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbeKNReZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 12:34:25 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55893 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeKNReZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 12:34:25 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2F6E52A2BF;
        Wed, 14 Nov 2018 02:32:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+FiBVL9YniVY
        0KWRjNTUSyfXFgQ=; b=oioYg+9I8vnKr+GEYwtOl5MdmrlDjGSh2CvdaqCs7vgF
        FlPQjBr04Uq0K/mr25Q2yLu3YPdcVcjjnt0AcyPbnpISTe/Y89mzx/QeRqTxkclP
        C7lhZW/FhfoqUQgyggU60x0B6fb9t7tilj1AvPt7K/PK8aUhZaNf562IZFiJJgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SmccQJ
        +w7AKe8CZ1s1tS64oW73yV7vr414wKJQQKr9e/CFnlyt076Gzie0xaGJz6qGchW6
        JIzc0+duHHhPZlLiDlFF7LaWG8XHExZUznuLwlCgRLE9/uprrxusXsR3oIVOi+YC
        eqKlM3yWAvdDeHNNDR3VOzJDYa2sxumzJ0AQA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 282512A2BE;
        Wed, 14 Nov 2018 02:32:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 37CBC2A2BB;
        Wed, 14 Nov 2018 02:32:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, mduft@gentoo.org, stefano.lattarini@gmail.com,
        kusmabite@gmail.com
Subject: Re: [PATCH] git-compat-util: prefer poll.h to sys/poll.h
References: <20181114011043.27419-1-congdanhqx@gmail.com>
Date:   Wed, 14 Nov 2018 16:32:16 +0900
In-Reply-To: <20181114011043.27419-1-congdanhqx@gmail.com> (=?utf-8?B?IsSQ?=
 =?utf-8?B?b8OgbiBUcuG6p24gQ8O0bmc=?=
        Danh"'s message of "Wed, 14 Nov 2018 08:10:43 +0700")
Message-ID: <xmqq5zx0nmgv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6AECC3EC-E7DF-11E8-8324-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> -#ifndef NO_SYS_POLL_H
> +#if !defined(NO_POLL_H)
> +#include <poll.h>
> +#elif !defined(NO_SYS_POLL_H)
>  #include <sys/poll.h>
>  #else
> +/* Pull the compat stuff */
>  #include <poll.h>
>  #endif

The last comment would help readers who got "Huh?  When NO_POLL_H
and NO_SYS_POLL_H is given, we still include <poll.h>" without it.

Looks good.  Thanks.
