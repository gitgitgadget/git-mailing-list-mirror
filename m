Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E99C433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 21:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355263AbiDZVNq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 17:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355212AbiDZVNp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 17:13:45 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3E41C121
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 14:10:34 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7869918790D;
        Tue, 26 Apr 2022 17:10:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wkfWlM6yxG74yTXH5uC9tsi83fzN4kiCI2Fb6+
        Aeu7A=; b=PacjEH1HnwL4H0q5xFB9sTr0kTZSvcBBvrgkEZ1ehmDUr0I6bAlAPG
        0l5FGmNDeL4uWDqTmILOKXgp/0hqMB1oo/Y0mD1Rc+z6kvfOj5f21YiIaRiAn0Ic
        T8SqCqq+ng0/drhGqYX7kF4WUzC2TJ8Nly0OSYTqIq4Gu27Q99QmE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 701EF18790C;
        Tue, 26 Apr 2022 17:10:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E62A4187909;
        Tue, 26 Apr 2022 17:10:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     rsbecker@nexbridge.com, Derrick Stolee <derrickstolee@github.com>,
        git@vger.kernel.org, philipoakley@iee.email, me@ttaylorr.com,
        Guy Maurel <guy.j@maurel.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH] git-compat-util: avoid failing dir ownership checks
 if running priviledged
References: <20220426183105.99779-1-carenas@gmail.com>
        <9658dea7-d421-b238-113d-c7b83eca4569@github.com>
        <xmqqlevrr53n.fsf@gitster.g>
        <04bb01d859a9$b759cb50$260d61f0$@nexbridge.com>
        <CAPUEspi_mX1xj1Nu2DuE83U9jB6oeRd=8FDPgGXbSC76mGHroQ@mail.gmail.com>
Date:   Tue, 26 Apr 2022 14:10:29 -0700
In-Reply-To: <CAPUEspi_mX1xj1Nu2DuE83U9jB6oeRd=8FDPgGXbSC76mGHroQ@mail.gmail.com>
        (Carlo Arenas's message of "Tue, 26 Apr 2022 13:45:16 -0700")
Message-ID: <xmqqilqvpn3u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4DF1943C-C5A5-11EC-A38D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> Agree with you that using strtol is better, but the added checks
> and logic make it more complicated and go against the assumption
> made in the commit message that the environment CAN'T be tampered
> with.

I think we require strto*l() here, to relieve us from worrying about
"is int large enough?" question.

