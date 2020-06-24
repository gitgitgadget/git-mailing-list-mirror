Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71D9C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 00:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9F320C09
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 00:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h+1fioTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbgFXAgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:36:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51200 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388073AbgFXAgu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 20:36:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C1307D3E17;
        Tue, 23 Jun 2020 20:36:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wku3uh+5uYUpFZywUNMOkETMNgU=; b=h+1fio
        TZWc8qWb1PLNCEnfAwIpp0ONYo1Ef9d1MaxIvBvEnYsz0As7Xbi4RmjnlrcIdkQ9
        dUa+V7AQVQln90l//rshNOnry215IDoR8lp0OMoW3Pc8JnxEYVZJBvVAJxozW1EW
        AjeZu7MZA0cGCOTg+IoL1r7PQzjmZUyXH6d2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qEfcPkbqIdgOMQvrE0Hm8S0DNsZjbVBA
        J/HjyD20hDa2BOss4PSzBxgmRrcPAR2XHHmXYUnelsX3dCSCPAbSwz4MDpxH2+30
        tzBELGu6o+iqsvn3X3RQzA0CNB+/HAmBi+4hjgGnvhGVXeTKATihSdHzGVMzGTVz
        AD8AMtYVQf8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8BA8D3E16;
        Tue, 23 Jun 2020 20:36:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 11D25D3E15;
        Tue, 23 Jun 2020 20:36:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/8] send-pack/transport-helper: avoid mentioning a particular branch
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <a29943d7bbc11a524089348a4abbd33c7514eee9.1592951611.git.gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 17:36:44 -0700
In-Reply-To: <a29943d7bbc11a524089348a4abbd33c7514eee9.1592951611.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 23 Jun 2020
        22:33:24 +0000")
Message-ID: <xmqqr1u59u5f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C880F2D8-B5B2-11EA-BCAE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -1046,7 +1046,7 @@ static int push_refs(struct transport *transport,
>  	if (!remote_refs) {
>  		fprintf(stderr,
>  			_("No refs in common and none specified; doing nothing.\n"
> -			  "Perhaps you should specify a branch such as 'master'.\n"));
> +			  "Perhaps you should specify a specific branch.\n"));

Hmph, not just "specify a branch."?  Maybe it is just me, but
"specify a specific branch" did not roll well on my tongue.
