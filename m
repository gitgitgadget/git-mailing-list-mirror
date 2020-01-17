Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ED3C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 17:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83E52073A
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 17:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N4Z2ILo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgAQRfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:35:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52442 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgAQRfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 12:35:16 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BC904B336;
        Fri, 17 Jan 2020 12:35:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qtzu0aHBzLhTsEgXV1yBK060KdQ=; b=N4Z2IL
        o16yFBBnuD3xK71DGsENyiai6C0+pUUrBWeqX3apZgBvjqkbiG6xSB7XtCS3UPsv
        nnNjibZ0HK9lUJ2UthmSYUa1+yRAi2CXQjXOxkWn65D1TpJMAvt5rGIH3vpHRQMZ
        v2NCAlYsodcQq/acOl4xKyaTJxpwtuRBGU6pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C0QKIuAwFz7ZsgOz0KWPWSS/vBeIhiJY
        lnR6yEdOJMyLhu8T3m9k01G4m+pjxIFGGYRfpP7m2UPPmDiefaQDp2UsoYgSdz04
        OrG0SoPldYcbItiaN3+MGw2TGUMeIMx6VWps6DbGOiKa5iz0avpE9KWN4vdhoQju
        fpKh+XMhrtE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34C024B335;
        Fri, 17 Jan 2020 12:35:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F18B4B334;
        Fri, 17 Jan 2020 12:35:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] built-in add -i: accept open-ended ranges again
References: <pull.528.git.1579163587.gitgitgadget@gmail.com>
        <7e4bf4bbbcd8c81a19d690aee379042e47246947.1579163587.git.gitgitgadget@gmail.com>
        <xmqqv9pbf3mu.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2001171100030.46@tvgsbejvaqbjf.bet>
Date:   Fri, 17 Jan 2020 09:35:12 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2001171100030.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 17 Jan 2020 11:01:00 +0100 (CET)")
Message-ID: <xmqqv9padm0f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7B311A0-394F-11EA-A72F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Good.  We do not allow "everything up to N" with "-N", so covering
>> "N and everything after" with "N-" is sufficient.
>
> Even worse, `-N` means "toggle N off". But that can't be fixed easily as
> it has been part of the UI for ages.

There is no loss.  "N-" is useful because you do not necessarily
know what the maximum is, but "everything up to N" will always be
"1-N" and you do not know what the minimum is.

So, there is not even worse there at all ;-)

