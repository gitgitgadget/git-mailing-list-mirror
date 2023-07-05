Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5837EB64DA
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 17:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjGERYE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 13:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjGERYD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 13:24:03 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF37C173F
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 10:23:59 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 73D2536419;
        Wed,  5 Jul 2023 13:23:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6KUfP+I5s6CzXLhdSA7pj1arGNgP5a2cmb8O0e
        Qq9Nw=; b=Oz+w0WpRnm6OJ4+pSK4+UfdDhuO8eVFFZR3kq78kmAnlxKeKJ3Esiz
        Ji1x1B1KVvf6FYKFGK3lWtyJ/eRduIAnHpLMpjpZQFypwx1W3IwwspmNq/XmH5NL
        NK7m2EtDQ9OVGnVjQS39ZKnfrSs9dYtaBTW5Z44hrpJwe3lZ2an3U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FCE636418;
        Wed,  5 Jul 2023 13:23:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DE16036417;
        Wed,  5 Jul 2023 13:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] imap-send: use server conf argument in setup_curl()
References: <20230703063247.GA3524302@coredump.intra.peff.net>
        <20230703063330.GA3524421@coredump.intra.peff.net>
Date:   Wed, 05 Jul 2023 10:23:54 -0700
In-Reply-To: <20230703063330.GA3524421@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 3 Jul 2023 02:33:30 -0400")
Message-ID: <xmqq35222rx1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B85D018A-1B58-11EE-BE0C-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Our caller passes in an imap_server_conf struct, but we ignore it
> totally, and instead read the config directly from the global "server"
> variable. This works OK, since our sole caller will pass in that same
> global variable.

This obviously is the right thing to do.

A much inferiour alternative would be to drop the srvc parameter to
the callee and that will make it clear that we are only working on
the singleton 'imap_server_conf' all the time (which is not entirely
incorrect), but I do not think there is no point in making any large
change to this program at this point in either direction.

> But the intent seems to have been to use the passed-in
> variable, as otherwise it has no purpose (and many other functions use
> the same pattern).

Yup.  Thanks.
