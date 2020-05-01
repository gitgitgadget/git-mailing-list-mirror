Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E041CC4724C
	for <git@archiver.kernel.org>; Fri,  1 May 2020 18:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7BC216FD
	for <git@archiver.kernel.org>; Fri,  1 May 2020 18:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fr6pex9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgEAS7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 14:59:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65257 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbgEAS7g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 14:59:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BA6EC35B7;
        Fri,  1 May 2020 14:59:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OSXzHZJijEUj
        J+9loSuwdLhgINk=; b=Fr6pex9GkGJtZxCRbYopGVZdc28iBX4L2sgYTgzTIYtt
        jgQoDDTjD7dZdKH9JKZGQEnWrit7yRgDGqPzxaFEeT6pqtHoI2c+l8rFZs1AJyWo
        AGuuve1Jgrmr5Zrk0BJ97mvN2HKM4QwHhn+ePsC5i76Und+kCQ0WrlQzkrudwz8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KjGlN5
        uhSrwSMyn76KcBO/pL5uyqBmRVcqihSa6gBz7Id052EtG8OuCSs94dDUCGRdZsmT
        mjKfDCb9SGdaoLmxj3flG+RH+4oZajgPBaBQP4TjgUWk13X44XL93HfsrVqB9JM/
        AWO8HMVVu/IsqZBgTcEQy2GBCMuQ5R/wg78VY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 929BFC35B6;
        Fri,  1 May 2020 14:59:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C8A6CC35B4;
        Fri,  1 May 2020 14:59:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v9] credential-store: warn instead of fatal for bogus lines from store
References: <20200430011959.70597-1-carenas@gmail.com>
        <20200430160642.90096-1-carenas@gmail.com>
        <xmqq1ro4sp1p.fsf@gitster.c.googlers.com>
        <20200501003041.GD33264@Carlos-MBP>
        <xmqqimhgph3z.fsf@gitster.c.googlers.com>
        <CAPUEspiD10bYsCDoHM6PJdidyofNadJL0bexjiNNZCXNU+Ay_Q@mail.gmail.com>
        <xmqqees4p6mb.fsf@gitster.c.googlers.com>
        <20200501135757.GF33264@Carlos-MBP>
Date:   Fri, 01 May 2020 11:59:30 -0700
In-Reply-To: <20200501135757.GF33264@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 1 May 2020 06:57:57 -0700")
Message-ID: <xmqqsggjlbvx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E40DC444-8BDD-11EA-AE09-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> attempt to save everyone's time with the v4 series[2], and that was mad=
e
> obsolete by Junio's creation of jc/credential-store-file-format-doc.

I actually discarded that "file format only" patch after you
included in your series.  One fewer patch I have to keep track of is
always better ;-)

Thanks.
