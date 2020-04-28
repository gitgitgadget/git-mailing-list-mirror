Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA7DC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75A120730
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 21:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="B+Avk9+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgD1VRY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:17:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57936 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgD1VRX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 17:17:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCD2A4D61E;
        Tue, 28 Apr 2020 17:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=fE7FIlVno/l3
        aGJiJQVvjkXk3Jc=; b=B+Avk9+5pnS39OqZBn6IlHTjx9U0GP0/HWnK/CtaWZ2Y
        ATYaVh+TI/8PdvN3yk/S9PJnidTPo/Q980QTsy/NLvT4WIMbi2VUY0RmcsuSO/bF
        NRHBBGvdiWCEZeBtTm1bg1y7wf+p3tcDGNQHHeTknnEg310M5yjoV9ZqDd7/vF0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=BKduPk
        3s/12qxvso5W3iP72jLNBz1zyZXnPbeA6Di6aLmq2KzWBAw+xKFdm5t1W9cTHFp8
        AHK9vOx6lTDiRf39jvr5DVYk7SRg50AJucVua7pJ95MtpMuP+gZbMrBpit+zNq4o
        0X0+wNjn6iytG5AKpGcAKcvseAQj4pUWY1yFw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D22EE4D61D;
        Tue, 28 Apr 2020 17:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 607614D61C;
        Tue, 28 Apr 2020 17:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        Stefan Tauner <stefan.tauner@gmx.at>
Subject: Re: [PATCH v3] git-credential-store: skip empty lines and comments from store
References: <20200427084235.60798-1-carenas@gmail.com>
        <20200427125915.88667-1-carenas@gmail.com>
        <xmqqftco94wx.fsf@gitster.c.googlers.com>
        <20200427191858.GB1728884@coredump.intra.peff.net>
        <xmqqv9lk7j7p.fsf@gitster.c.googlers.com>
        <20200428052510.GA201501@google.com>
        <xmqqsggn4mxz.fsf@gitster.c.googlers.com>
        <20200428211407.GC56126@Carlos-MBP>
Date:   Tue, 28 Apr 2020 14:17:19 -0700
In-Reply-To: <20200428211407.GC56126@Carlos-MBP> ("Carlo Marcelo Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 28 Apr 2020 14:14:07 -0700")
Message-ID: <xmqq4kt31fa8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A54502D0-8995-11EA-8BF2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

>> > +		if (!credential_from_url_gently(&entry, line.buf, 1) &&
>> > +		    entry.username && entry.password &&
>> >  		    credential_match(c, &entry)) {
>> >  			found_credential =3D 1;
>> >  			if (match_cb) {
>>=20
>> Hmph, so the idea is, instead of ignoring the potential error
>> detected by credential_from_url() and using credential when it is
>> available, we loudly attempt to parse and give warning on malformed
>> entries when we discard a line?
>
> the idea was to silently ignore the line (notice quiet =3D 1), which

Ah, sorry, I apparently did not read the patch carefully enough.

Thanks for a correction.
