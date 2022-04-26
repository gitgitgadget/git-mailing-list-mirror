Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2CAC433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 16:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352976AbiDZQ20 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 12:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352977AbiDZQ2W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 12:28:22 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF0B3884
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 09:25:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF605184115;
        Tue, 26 Apr 2022 12:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7S8mE+AwuSTcA1tQz4WsoY11entgt97Cel03rp
        hUBGc=; b=I/Tuu3tLlZW0cfCfPLPvS5Xa6odi4QLjNZwMXngcp+cjEX+1vTevO5
        NV1vQInkCQ3FGMcamwKe9S3/Yb1apCawsiqcrcTN9n/iCs42mixC2dxdNYlWRVLU
        vJ51N1qOHj62qiAswDxxW8o9gNxGMNOzVuZhqWl3ylfEyyNN3AMOI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C7BB5184114;
        Tue, 26 Apr 2022 12:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 64115184112;
        Tue, 26 Apr 2022 12:25:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git describe
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
        <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email>
        <xmqqczh73hns.fsf@gitster.g> <xmqqk0bf1i12.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2204261743590.355@tvgsbejvaqbjf.bet>
Date:   Tue, 26 Apr 2022 09:25:08 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2204261743590.355@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 26 Apr 2022 17:45:37 +0200 (CEST)")
Message-ID: <xmqqtuafrevv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70B6D6A8-C57D-11EC-AAC5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Actually, not quite.  when "git" runs in "sudo git", the real
>> identity has long lost, so the below would not help.  Sigh.
>
> Could you help me understand what is going on exactly? How/when is `git`
> running `sudo git`? I thought the problem was that `sudo make install`
> transitively runs `git describe` with euid 0, but `getuid()` should still
> return the non-admin user's ID, no?

The first "git" is literal English meaning, refers to a person ;-)

Anybody building and installing git would do

	$ sudo make
	$ sudo make install

and no, sudo does not leave a clue in getuid() from whom it came from.

