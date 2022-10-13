Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD93FC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 16:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJMQeZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 12:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJMQeX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 12:34:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6258D144E18
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 09:34:23 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 100D21BAE8D;
        Thu, 13 Oct 2022 12:34:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=hc3uRG/hIC+SEKS24SLp4KRhD6r44mdyfA6P4H1wvWI=; b=yNDO
        sJ1qdjyGv1OouGVK7+bVh9yPgxB8ZtIiaMxUk0kRuiqtdOknP5aVC/mja4o/dilb
        AnOgXxbeqe1cmrxm7cHeWcmoNsCObLjNgFWKUr4IK7jDqjV4GZ0bNOv8fFNyf0o8
        bGNC01tILkB9vl4Uf5g3brub2TBw0Chr+EkexUQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 07C8A1BAE8B;
        Thu, 13 Oct 2022 12:34:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 397081BAE8A;
        Thu, 13 Oct 2022 12:34:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 3/8] rebase: be stricter when reading state files
 containing oids
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
        <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
        <1fd58520253420fbe870a8528540dbc9e2178e3f.1665650564.git.gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 09:34:19 -0700
Message-ID: <xmqqbkqfhed0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E341A032-4B14-11ED-A628-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The state files for 'onto' and 'orig_head' should contain a full hex
> oid, change the reading functions from get_oid() to get_oid_hex() to
> reflect this.

OK.

> -	if (get_oid(buf.buf, &oid))
> +	if (get_oid_hex(buf.buf, &oid))
> ...
>  		return -1;
> -	if (get_oid(buf.buf, &opts->orig_head))
> +	if (get_oid_hex(buf.buf, &opts->orig_head))

