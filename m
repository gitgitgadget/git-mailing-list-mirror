Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE45C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 16:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbiCAQ6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 11:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiCAQ6s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 11:58:48 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3225B4F457
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 08:58:02 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE47118C441;
        Tue,  1 Mar 2022 11:58:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0VSmdQlYJ3fnJIyJbk8BYjU+ZzLg5FCdgYBX0m
        Wqp/g=; b=FJB3C+HVO8AAYg60h0CySw/US+VMbHrTTeS1mzA7YgzfSOltrSkmMN
        +ekB0r1mS690HxOX0rmO45UIuhtpeESJ9qlJAsf91+oJ0Y9Cfuxut5vBKAOYaJxZ
        TUqQcS52HM3Kx6Hh++ZU3OIkIPjxjVUalbP2DhJkNln/Is2yCMs34=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C6FA118C440;
        Tue,  1 Mar 2022 11:58:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0698218C43E;
        Tue,  1 Mar 2022 11:57:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
        <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
        <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
        <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
        <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
        <xmqqv8x2dd7j.fsf@gitster.g> <xmqqzgmd5uzu.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2203011109050.11118@tvgsbejvaqbjf.bet>
Date:   Tue, 01 Mar 2022 08:57:57 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2203011109050.11118@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 1 Mar 2022 11:10:19 +0100
        (CET)")
Message-ID: <xmqqee3lsj8q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEF797F4-9980-11EC-BB66-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Yes, that's because line 5520 is the header of that group. If you direct
> the reader to
> https://github.com/git/git/runs/5343133021?check_suite_focus=true#step:4:5674
> instead, it will get expanded.

Ah, that's a good trick to know.  I presume 5674 can be any random
line in the block that is hidden by default that I want the viewer
to expand, right?

> If it would not get expanded, that would be a bug, but obviously not in my
> patch series.

Well, the choice to use a mechanism that has such a bug is made by
this patch series.  If "allowing users to easily exchange a URL that
points the exact place that the tests broke" were one of the goals,
it does not matter whose fault it is---the aggregate result is that
the new UI would have failed that goal.

Thankfully there does not seem to be such a bug in the UI mechanism
used by this series, so we are in good shape.

Thanks.
