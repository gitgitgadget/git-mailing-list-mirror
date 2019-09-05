Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BE9B1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 19:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403980AbfIETuf (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 15:50:35 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54750 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403969AbfIETub (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 15:50:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D14F7487F;
        Thu,  5 Sep 2019 15:50:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=p7nNCSBxnTsl
        +osIezNX9ziVQmE=; b=cXBHTN1XnLDgbADAXR22XUqixDjra6IQ4ksz/xfbHPPZ
        tnY1iwLQQRg2xQbOAvqS2+7hfDfM2irqB4jzEtlA9T1C8wu12vY4CXAeaymGgHTn
        vZKI3f4cYKmwpud6UyltMzgyR0JWuNn+p2M2MS8I8YDp0FSiIPMA0dtc7poe0J8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dkjACY
        D42cxSHvpuySIGLNRGXvlYxlv69nfQnkueu8rxwbcyK/WaWNHEjHJQZUW3YwwjVW
        JSEGJcS8axhbVGLTKSV4OPnQvFCWTXtQ6c4Jgy3LlAezUjw7koiYy9jo2UX6fow8
        Tg17e0hrFawljypel1+NRLvZnOxWqYrbDgz2A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 046757487E;
        Thu,  5 Sep 2019 15:50:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D74B674875;
        Thu,  5 Sep 2019 15:50:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, Stephan Beyer <s-beyer@gmx.net>,
        Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Fix maybe-uninitialized warnings found by gcc 9 -flto
References: <20190905082459.26816-1-s-beyer@gmx.net>
        <6c6c4e71-d9e5-1ad4-74db-12c323da42f7@web.de>
        <20190905175304.GA23663@sigill.intra.peff.net>
        <b4f53049-ff50-8143-1653-d321cce6421c@web.de>
        <xmqqr24upmtm.fsf@gitster-ct.c.googlers.com>
        <8d90d803-8a4b-2656-550d-ccee5156b643@web.de>
Date:   Thu, 05 Sep 2019 12:50:24 -0700
In-Reply-To: <8d90d803-8a4b-2656-550d-ccee5156b643@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 5 Sep 2019 21:39:38 +0200")
Message-ID: <xmqqimq6plof.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6848B810-D016-11E9-BE26-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The loop count is either 1 or argv[1] interpreted as a number, i.e. it =
could
> be very high.  Its body consists of an index load and writing a number =
to a
> file, though -- a strlen() call on the name of that file should go unno=
ticed
> amid that activity.  (I didn't measure it, though.)

Yup, I didn't either but we reasoned along the same line.
