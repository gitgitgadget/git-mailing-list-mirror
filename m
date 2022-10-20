Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1891C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 17:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiJTRtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 13:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJTRtF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 13:49:05 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D941A2E03
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 10:49:05 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 42D541C9EBF;
        Thu, 20 Oct 2022 13:49:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ysy3DnnzUnZ3MzEAEwv76QcXt+WOkUGVrgsv4L
        i83xQ=; b=rDJJksxoiy060IT0ULn7Rd1X8eqf22txlkNoPCEIV68krmy4ngA6wJ
        iXnu0I9XFiInQ/sgVOdqHa8WeL8FDmpSZ6eTaOOo04V+wvEpN8ErU/YjqnZYLOD8
        KJAzt1yI4wqXaKC99dcDGP6BpWk5GL76tnXNCLPpnXiWtT4PvthMA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3BC6C1C9EBD;
        Thu, 20 Oct 2022 13:49:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 69F351C9EBA;
        Thu, 20 Oct 2022 13:49:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Mat=C4=9Bj?= Cepl <mcepl@cepl.eu>, git@vger.kernel.org
Subject: Re: git-send-email with GPG signed commits?
References: <4eb8707f-4686-e304-2aab-a6afee11abc9@cepl.eu>
        <Y1GJAart+/yFc5MR@coredump.intra.peff.net>
Date:   Thu, 20 Oct 2022 10:48:59 -0700
In-Reply-To: <Y1GJAart+/yFc5MR@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 20 Oct 2022 13:44:33 -0400")
Message-ID: <xmqqr0z2s7w4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A8DB842-509F-11ED-969F-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So commit signatures are generally an attestation by the committer, not
> by the author. It's just that the two are usually the same when you are
> committing locally.
>
> I think you would need some kind of "author-sig" header that signs the
> commit object bytes _without_ the commit header at all. And that assumes
> the maintainer's workflow is to never modify a patch in transit, and to
> apply it at the exact same spot that you wrote it (so that the parent
> and tree ids remain the same).

Doesn't it immediately break down once you send a 2-patch series?
You may be able to get the bottom one right, but the top one needs
to depend on the commit object name of the result of applying the
bottom one.

It depends on what they are trying to achieve by transferrring with
existing signature intact.  If they truly want to preserve the
validity of the signatures on commits, they are better off
exchanging bundles over e-mail, as reviewers and integrators are not
even allowed to touch anything.
