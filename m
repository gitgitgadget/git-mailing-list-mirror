Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6734BC433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 16:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242807AbiEEQO2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 12:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382134AbiEEQOA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 12:14:00 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD09D5D1AF
        for <git@vger.kernel.org>; Thu,  5 May 2022 09:09:50 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C1DDC17911D;
        Thu,  5 May 2022 12:09:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KXPX4YFJfprX5rW6P48y4xMfpB9r3IgiXoBCNj
        /xFJ4=; b=svm5tMjvJt/d1qOTjdzS59oupANRn9NfwKOaOpDyEpdqCZdLW5o+aN
        y58P4MVbBtcoGmun0m51RNByDG+GW1nHrOx935GyLog/SmQZIulBImKComQVKKvF
        IHJ9kCXiS/4xoEAIaZOITgqHAdAxO53WUxS84Znos9WVLySLiUTMk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B9DD517911C;
        Thu,  5 May 2022 12:09:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 275C117911A;
        Thu,  5 May 2022 12:09:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Guy Maurel <guy.j@maurel.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [PATCH v3 2/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
References: <20220428105852.94449-1-carenas@gmail.com>
        <20220503065442.95699-1-carenas@gmail.com>
        <20220503065442.95699-3-carenas@gmail.com>
        <nycvar.QRO.7.76.6.2205051545370.355@tvgsbejvaqbjf.bet>
Date:   Thu, 05 May 2022 09:09:44 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2205051545370.355@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 5 May 2022 16:01:21 +0200 (CEST)")
Message-ID: <xmqqilqkezav.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8222A98-CC8D-11EC-B113-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> We could side-step all of this, of course, if we simply did this:
>
> 	euid = getuid();
> 	if (euid == ROOT_UID)
> 		euid = git_env_ulong("SUDO_UID", euid);

Yes, that is not "side-stepping" at all.  It is "we already have a
function that knows how to use strto*l() correctly" ;-)

Very good suggestion.  Thanks.
