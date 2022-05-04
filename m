Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5AEC43217
	for <git@archiver.kernel.org>; Wed,  4 May 2022 15:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352786AbiEDPyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 11:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352838AbiEDPyB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 11:54:01 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D080711E
        for <git@vger.kernel.org>; Wed,  4 May 2022 08:50:24 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BAC2719780B;
        Wed,  4 May 2022 11:50:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R3a1Vc/s4miy49Y+P9AY+4NsyWSE5nq8LHhXnd
        BO1tY=; b=kD3gjqAtkaVmAIo/HK+FgDQqxujUT5qWUjZFf4Poid9PKMKK00ZpnM
        myB2NODJtczCu2ituAgB0on84xAAEA97qy1GF18vXPgCrpTUagXsVZhflwlaFPW2
        lNkM4iF9LxcPsaX2iME9yxwYO3PkBbBup+GfcT3KCqhOflKXcTVrA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B32AD19780A;
        Wed,  4 May 2022 11:50:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8E9DC197808;
        Wed,  4 May 2022 11:50:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4 5/8] transport: add client side capability to request
 object-info
References: <20220503231558.4172288-1-jonathantanmy@google.com>
Date:   Wed, 04 May 2022 08:50:18 -0700
In-Reply-To: <20220503231558.4172288-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 3 May 2022 16:15:58 -0700")
Message-ID: <xmqq8rrhnvph.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E662C5D4-CBC1-11EC-8189-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> RTT more than necessary. We could just determine if the server supports
> the attributes we want by using capabilities (without needing to send
> the request to check).

Hmph.  capabilities may cut in both ways, though.

Those clients that are not interested in object-info at all (which
are the majority of case where people clone, fetch or ls-remote),
they do not even need to know what kind of object attributes the
object-info command is prepared to report, and they would appreciate
not having to spend any extra byte in the capability-advertisement.

Of course, for object-info clients, having it upfront does make
things simpler.

So...


