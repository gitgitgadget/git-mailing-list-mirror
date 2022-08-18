Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5383C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 16:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344448AbiHRQ21 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 12:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245538AbiHRQ2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 12:28:25 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BE113DC2
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 09:28:20 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A36701BE89C;
        Thu, 18 Aug 2022 12:28:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lkaTLiRb4ldzBrUsYUpDyR/qj+Q5PZhj0/DlzA
        w6L4U=; b=WCThxPstfHWCHIuKhN1+5pvszftht/gA3spe4NKqltfC7F9kzgwquY
        GOkjLWpXCoB/v1HuxeLPeVOVMspQl8Ot6XidI3w0r6FeawtYSyIqYeCpoWOIhA45
        Y19TSjvU3AAKUvEbPYt1DwvLkwmjWPHwB8c2LQUSti9tclkso2rvI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9AB041BE89B;
        Thu, 18 Aug 2022 12:28:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1FB1C1BE899;
        Thu, 18 Aug 2022 12:28:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jinwook Jeong <vustthat@gmail.com>, git@vger.kernel.org
Subject: Re: bugreport: "git config --global" fails if an invalid .git file
 present
References: <CAA3Q-aYfn0om2tXjwH-9ayaX57Yj6xkKw1hpi2asthgHvWovsw@mail.gmail.com>
        <Yv3ZKcD0L0dSIavr@coredump.intra.peff.net>
Date:   Thu, 18 Aug 2022 09:28:14 -0700
In-Reply-To: <Yv3ZKcD0L0dSIavr@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 18 Aug 2022 02:16:09 -0400")
Message-ID: <xmqq35dtseht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C31931AE-1F12-11ED-9A5C-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And that would make your case Just Work. But it's also more dangerous;
> if a misconfiguration or transient error caused us to set up an
> unexpected environment, then the results could be quite wrong and
> confusing. Maybe less so for "git config", but for destructive
> operations it's a scarier concept.

That is a good point, especially if destructive command is run in a
repository the user didn't mean to run it in, it would not be
pretty.

> In your case, the right resolution is probably to delete the bogus .git
> file.

Yup, that was what I said in a draft I wrote a few days ago and
still in my outbox ;-)
