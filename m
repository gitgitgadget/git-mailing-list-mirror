Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50D3C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4959E22459
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bj6Zw+nK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfKTAjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:39:47 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52534 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfKTAjr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:39:47 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AC9028E19;
        Tue, 19 Nov 2019 19:39:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=st6X7j8Qw/EEIIkYFjRoS9+pdVc=; b=bj6Zw+
        nKsuG0WeEVKXk6AjOMDDtU09LEVs++tOXLfxyXHtDIuoHIqVH8Yav8W4teuDCpnX
        R+VQIOeC3iRE55VlTI+lRgn+jB6BXpZMxNsSTaaxHZ4VP+bZlk2Peabj3NAbItag
        y3K/uL+wD5+25Hbiu6b9L1Rv2IO5H+t7W+6lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JfuxTqDepsH3/ev7F7fPeqkF/Lleg5d0
        FmJ6/3a+dmliV79zvyyoUGp6Y1Dt/YNhWoj8jcEE+kiIZyJO3Tobv2WnVwgOtuLp
        kz0ty/8qJ6oIPXt8e1UJrsuvJ4ExjxuzdXMfegxpGfkHnfGKK+b5/xGwk9S+nfde
        5bqchwd4StI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 135B628E18;
        Tue, 19 Nov 2019 19:39:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7387328E17;
        Tue, 19 Nov 2019 19:39:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 1/9] bugreport: add tool to generate debugging info
References: <20191025025129.250049-1-emilyshaffer@google.com>
        <20191025025129.250049-2-emilyshaffer@google.com>
        <xmqqr2284is5.fsf@gitster-ct.c.googlers.com>
        <20191119202542.GB36377@google.com>
        <nycvar.QRO.7.76.6.1911200027460.15956@tvgsbejvaqbjf.bet>
Date:   Wed, 20 Nov 2019 09:39:43 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911200027460.15956@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 20 Nov 2019 00:31:42 +0100
        (CET)")
Message-ID: <xmqqzhgre5yo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F329F06-0B2E-11EA-BB4E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I did suggest on IRC to teach `git-remote-https` an option where it prints
> the cURL version (and build options) and exits.

I like that.  You ask the exact binary what (it thinks) it uses, so
that there won't be skew between the view by "git remote-http" and
"git bugreport" on the world.
