Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09683C433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 14:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB15E2075F
	for <git@archiver.kernel.org>; Thu, 28 May 2020 14:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Py+DkcqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403925AbgE1O6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 10:58:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50958 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403787AbgE1O57 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 10:57:59 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77B427C484;
        Thu, 28 May 2020 10:57:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FL5CuOF159XZ/zqq+RIffxl91Us=; b=Py+Dkc
        qZARKnjUPHWCOKkKNHRll8pQe9J6NnlCeqLlbGGfvytB3YaiptxmIBFeRVFkqN8n
        luwHUSo1O0PisAWiZVaHXJTaUAwa4h9vwPx30pcs9uXe2DiEGVW+xHo+3Y0NqxdB
        P1H6fNwQxgk6EmUDSU4S8YDxLsK0/MvOKWOzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QavV3rJ26PsWSpY2MQtp1/xmrr4fU9Oi
        Vq1b7oJlUft787To0Yes/TCrDtSPoa9ONmxEKjDpsgaWfa2BZgsv/bmBuVeJ9BhI
        YiQhlXgCuIpUbSVBBvoqvYOPbLMkgRCCQLkhKon/SEcAK/KGEenJ77z66HzRNiQo
        VoEO4DN8d1c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E9337C483;
        Thu, 28 May 2020 10:57:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E80CC7C482;
        Thu, 28 May 2020 10:57:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Steadmon <steadmon@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
        <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>
        <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>
        <20200407014829.GL6369@camp.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2004072355100.46@tvgsbejvaqbjf.bet>
        <20200408000149.GN6369@camp.crustytoothpaste.net>
        <20200527223907.GB65111@google.com>
        <xmqqa71s6g1w.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2005272334560.56@tvgsbejvaqbjf.bet>
        <20200528145018.GA58643@google.com>
Date:   Thu, 28 May 2020 07:57:55 -0700
In-Reply-To: <20200528145018.GA58643@google.com> (Jonathan Nieder's message of
        "Thu, 28 May 2020 07:50:18 -0700")
Message-ID: <xmqqwo4w3y4s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CFFEA34-A0F3-11EA-9503-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I think it's worth discussing naming, but it's kind of a distraction
> from what Brian brought up.  The real question is, do we consider the
> existing "git gc" infrastructure such a lost cause that we should
> touch it as little as possible?

I am fine with that, as long as the "new" thing will take over what
"git gc" currently does.  It has always been bothering me that the
maintenance pieces for features added in the past few years like
midx were deliberately let outside the scope of "one entry point for
housekeeping".
