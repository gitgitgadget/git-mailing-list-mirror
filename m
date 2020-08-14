Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351EBC433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F399020768
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hAwZYEeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgHNUWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:22:35 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61291 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHNUWe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:22:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C1F9E6D63;
        Fri, 14 Aug 2020 16:22:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JI0d1DuhI0s9RMDZJzSonHsy1Uw=; b=hAwZYE
        eNQ6bKhAJAL3tHmZKPaK0X+2TLGdM2aGnrdmpWU3/dG1Jo5bIiFISTIgLRlCyGkG
        j21epMV0KPh4blV/WeRrKjWRyMvc2bTgKTt4mFnIyA8MgOeBKme3tr56DcfGnJUG
        v+UifO3REv4WPZff3YOKaJB4h/KSmX3HOIGZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ly8AWckOBDUXnyUrEehUai9RCje2nrw3
        BmWFXDTuWkmmjScENzCzcone3PP2cBASB0qqZcf1dhEbZW2jqeZNlP35Li7OBwhq
        T4Jss0iAeAUZDEf6AaaEauGWmbgeeLQG8C8BjvP5a3kMzeA5mOkPfG7ZsmwitGuS
        xSwi+reHdsQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 24A99E6D62;
        Fri, 14 Aug 2020 16:22:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6856CE6D61;
        Fri, 14 Aug 2020 16:22:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, martin.agren@gmail.com, me@ttaylorr.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/3] commit-graph: use the hash version byte
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
        <4bbfd345d16da4604dd20decda8ecb12372e4223.1597428440.git.gitgitgadget@gmail.com>
        <20200814201153.GK8085@camp.crustytoothpaste.net>
Date:   Fri, 14 Aug 2020 13:22:29 -0700
In-Reply-To: <20200814201153.GK8085@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 14 Aug 2020 20:11:53 +0000")
Message-ID: <xmqqy2mhuge2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1814DE6-DE6B-11EA-842D-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Can we maybe say something like this?
>
>   switch (hash_algo_by_ptr(the_hash_algo)) {
>     case GIT_HASH_SHA1:
>       return 1;
>     case GIT_HASH_SHA256:
>       return 2;
>     default:
>       die(_("invalid hash version"));
>   }
>
> That way if SHA-256 gets broken and we switch to another 256-bit hash
> (SHA-3-256?), we'll be forced to update this properly.

Excellent.
