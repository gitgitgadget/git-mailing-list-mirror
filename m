Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9A6C001DF
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 23:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjHGXxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 19:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHGXxb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 19:53:31 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E85099
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 16:53:30 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E23E2256B9;
        Mon,  7 Aug 2023 19:53:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kmOMqInk5WWruuCKWPMn3SOPwZlhcxuoQWAEhv
        qHQOA=; b=ephA8g3eDxjNTei2WcxQUN/a8nrqn1AfoEHJ60yCEAqONuwbcweNn+
        DI0P3q/MMnzFNp7wrQJuabBQTtHQ72x7rFDc1PG85WMr3ONv44ftnwsyhmCs857Q
        zhoOFQs/BInavudJKCdCdBP3wfvEZhPhQpEODwYXJp2jlRRTPvPs4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DA4CA256B8;
        Mon,  7 Aug 2023 19:53:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 061EE256B7;
        Mon,  7 Aug 2023 19:53:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        lenaic@lhuard.fr, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/6] maintenance: add get_random_minute()
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
        <fefdaa9457948ee5302e7cbfaae250e0b589d752.1691434300.git.gitgitgadget@gmail.com>
        <ZNFgIyuhlNd8I9Y2@nand.local>
Date:   Mon, 07 Aug 2023 16:53:24 -0700
In-Reply-To: <ZNFgIyuhlNd8I9Y2@nand.local> (Taylor Blau's message of "Mon, 7
        Aug 2023 17:20:35 -0400")
Message-ID: <xmqq4jlabea3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99ABB6D4-357D-11EE-8800-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I was wondering where else we call srand() within Git, and it looks like
> the only other spot is in `lock_file_timeout()`.

lock_file_timeout() should be updated to match git_mkstemps_mode(),
which was taught to use the csprng_bytes() function with 47efda96
(wrapper: use a CSPRNG to generate random file names, 2022-01-17),
and this new caller may want to do so as well, perhaps?  I dunno,
but the caller then does not have to worry about "initializing it
just once".
