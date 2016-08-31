Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 723291F859
	for <e@80x24.org>; Wed, 31 Aug 2016 20:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753820AbcHaUMe (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 16:12:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58023 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753356AbcHaUMd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 16:12:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D71537FAE;
        Wed, 31 Aug 2016 16:12:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NdMUMj52K+Do
        1EfUYXFyXgaGAKw=; b=r74A3QbBBFreoga7M64xzLFQSpxD8YUmx24OiL7/8LeZ
        Jkr+KOA/eJpCGm7ZYzb1GxOOAaQeMBUpbusqGXOD/eoR1f19qEdsJaqNsgxOmnmx
        Q0ODoiO5+u7QqBcs0iJpk5UPu5FTh4yzxRi5CebQ75I7G6/aXwv0XnhyA5lYNpw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NhEj4w
        4qgq2gij3gXvOuTq8kTgb40hiJ+q5pm7oIONTX8eRm0dn9HdNJI/UL1554HEngs4
        yl00qCWMlcXysZDYqKpTWNCv8OHYLpbcoKDIu61Vt+M6hkLL/K7APwtVrLBLomPP
        tf0t1WXkQ/baT3XuIVN5OdkIF3EkHGvXw1v2Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6588537FAD;
        Wed, 31 Aug 2016 16:12:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E637D37FAB;
        Wed, 31 Aug 2016 16:12:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 16/22] sequencer: prepare for rebase -i's GPG settings
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <c6a37af958f59390c00429a5b38b34d34c9a5b95.1472457609.git.johannes.schindelin@gmx.de>
        <104de15c-77e8-9474-9579-4934ca8a4323@gmail.com>
Date:   Wed, 31 Aug 2016 13:12:29 -0700
In-Reply-To: <104de15c-77e8-9474-9579-4934ca8a4323@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Wed, 31 Aug 2016 22:10:38
 +0200")
Message-ID: <xmqqmvjszoia.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3FB04A52-6FB7-11E6-B1E8-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>> +			else {
>> +				opts->gpg_sign =3D buf.buf + 2;
>> +				strbuf_detach(&buf, NULL);
>
> Wouldn't we leak 2 characters that got skipped?  Maybe xstrdup would
> be better (if it is leaked, and not reattached)?

An attempt to avoid leaking by calling free(opts->gpg_sign) would
make it crash, which would be even worse ;-).
