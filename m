Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A042EC10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 23:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3335120724
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 23:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O2SEgZ8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCXXhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 19:37:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63693 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgCXXhs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 19:37:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A2DB24D1EE;
        Tue, 24 Mar 2020 19:37:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HEw0ntwbh+nQHW5GhGXQQmB8rgI=; b=O2SEgZ
        8zTxlrT/W96ck314C6iNZV8jxHl+cYbtGpp/sG027HGIwDJUMVoGeFV3AhER9EIW
        hEgccq1X2oKKbUDbJP3WlwXRognhmPXJi3epqvznF0tlhGCnRVFlGubGSQNsQqEe
        /++T8hJaEWR2jagpgy46OG/GUr9PT7Ow9gBcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YxmR6pkGM/a6BKT4zFgkH1fG/XHSFaii
        PU7zfsM/pvRc8J9vXoZ07i1SXzkVkkq0atSt7b2EdtSrJWRMs/Tx0+F/gH/oP/XB
        Aur4Reno/NjXVSsoBD1FjxhpPGJG6k5quOusun1I7HUkDU9kYq5cJpsuwbbzUhb2
        hQv4F3Najtk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C7AA4D1ED;
        Tue, 24 Mar 2020 19:37:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 186D54D1EA;
        Tue, 24 Mar 2020 19:37:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 7/8] t4124: fix test for non-compliant diff(1)
References: <cover.1584838148.git.congdanhqx@gmail.com>
        <10f39c3d30d13e9141f081f985a0620954cc7493.1584838148.git.congdanhqx@gmail.com>
        <nycvar.QRO.7.76.6.2003231456200.46@tvgsbejvaqbjf.bet>
        <20200323150449.GC11801@danh.dev>
        <xmqq8sjq4wyf.fsf@gitster.c.googlers.com>
        <20200324034025.GE11801@danh.dev>
        <nycvar.QRO.7.76.6.2003242328380.46@tvgsbejvaqbjf.bet>
Date:   Tue, 24 Mar 2020 16:37:44 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2003242328380.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 24 Mar 2020 23:29:02 +0100 (CET)")
Message-ID: <xmqqtv2dz5mf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7654C8D0-6E28-11EA-B37A-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> With this explanation, I totally agree that your patch is better than
> mine.

Meaning that we'd have a fallback checker that understands "diff -u"
output, because the presense of "diff -u" cannot be relied upon and
we'd need to keep the original that understands "diff -c" anyway?

If that is what you meant, I am 100% fine with that.

