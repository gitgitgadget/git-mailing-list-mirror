Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00355C433E1
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 16:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA7420739
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 16:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F42m14nx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgGPQKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:10:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61186 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbgGPQKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 12:10:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD457E6CBA;
        Thu, 16 Jul 2020 12:10:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xqKyQUwp0hDSFVskaG4wVoSueSk=; b=F42m14
        nx49K/kKB3oEhdFJ3KA5P83qQx1sPLz4QiUS4VvkCa/q7+LL8BS0YxiR4Gfxwuel
        BJ0u0RGiTqPD7CxT0ybYGEgaTz2fKIoo5kdLogDrpqd+do4nXvjfQP9XNxARyim8
        gY/dkVe+Oypng0oaregiO+tdT+5U4Koap0apk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cyLkMbWvJifEeJErLPQHIwLrBfjS8JT9
        D4cmwC0QJvkPP/t6m/CJG9Hoo62FiCdxdldzphNtPoF1xb0DMZEHB0B0bylt7O4y
        8VAxeF0TeedBZZ31KfFQlMXxAT27HOzbut+bAUpqSWMGl6MfzAjT/LXcg3LDPzGM
        QfGaTpu1OpQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B5681E6CB9;
        Thu, 16 Jul 2020 12:10:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9A040E6CB3;
        Thu, 16 Jul 2020 12:10:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] repository: allow repository format upgrade with extensions
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
        <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
        <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
        <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
        <xmqqpn8wkben.fsf@gitster.c.googlers.com>
        <20200716062054.GA3242764@google.com>
        <20200716062818.GC3242764@google.com>
        <xmqqh7u8hrka.fsf@gitster.c.googlers.com>
        <20200716110007.GD376357@coredump.intra.peff.net>
Date:   Thu, 16 Jul 2020 09:10:01 -0700
In-Reply-To: <20200716110007.GD376357@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 16 Jul 2020 07:00:07 -0400")
Message-ID: <xmqqd04vigpy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEBC1B68-C77E-11EA-8D39-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I agree with this line of reasoning. I'd prefer to see it
> addressed now, so that we don't have to remember to do anything later.

Very true.  Also the documentation may need some updating,
e.g. "These 4 extensions are honored without adding
repositoryFormatVersion to your repository (as special cases)" to
avoid further confusion e.g. "why doesn't my objectFormat=SHA-3 does
not take effect by itself?".

> I.e., for this patch to put the existing known extensions into the
> "good" list for v0, locking it into place forever, and leaving the
> objectformat topic with nothing particular it needs to do.
>
> But in the name of -rc1 expediency, I'm also OK moving forward with this
> for now.

I'm OK, too, as I said.

I'd need to kick out bc/sha-2-part-3 topic out of my tree while that
infrastructure is in place on top of these two patches, though.

Thanks.
