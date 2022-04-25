Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090CBC433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 06:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbiDYGmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 02:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbiDYGmj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 02:42:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DEA3AF
        for <git@vger.kernel.org>; Sun, 24 Apr 2022 23:39:36 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3A2BD1A0CBD;
        Mon, 25 Apr 2022 02:39:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=YLA+eBrWteRVUX/dZn8SYiKJ6
        QNyOjKWmlH9kU8mdNg=; b=HG0+lE3QK6Aj2ha7dYg5iy8TF+e6bbviWk3D9CTFs
        JXhinPD7M+Nq6qz+LO2BBUytgG6s0gv+7Kh7ucY4FnFtG4W5G+SQK4KPnM9C1AK3
        ZT/ObV9DDE/xdzJrngKNkNBqwM398lkjOy67sb3i16QpPzZJ98nsvjRWtojqSszu
        JM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2627B1A0CBC;
        Mon, 25 Apr 2022 02:39:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A35861A0CBB;
        Mon, 25 Apr 2022 02:39:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git describe
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
        <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email>
        <xmqqczh73hns.fsf@gitster.g> <xmqqk0bf1i12.fsf@gitster.g>
        <20220425020108.5agdq6bdg6umrtbt@carlos-mbp.lan>
Date:   Sun, 24 Apr 2022 23:39:27 -0700
Message-ID: <xmqqy1zty8dc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 756255E0-C462-11EC-909C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com> writes:

> At that point, though you might as well excempt root from this check

But "root" or any higher-valued account is what needs this kind of
protection the most, no?  The protection is *not* about people
knowingly accessing their own repository via "root", but those who
are in a directory without being aware of its repository-ness.  You
prepare /var/tmp/.git/ and let others do things that they would do
in /var/tmp/ throw-away directories normally and get affected by
what you leave in /var/tmp/.git/config file.  If "root" is among
these "others", that sounds like you caught a bigger fish X-<.
