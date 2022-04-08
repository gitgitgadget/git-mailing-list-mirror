Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66B1C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 18:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiDHTAe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 15:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiDHTAc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 15:00:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D162A3F40
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 11:58:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 53EE118CA84;
        Fri,  8 Apr 2022 14:58:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yNSSkidOcnVCtytVdjUFr1Pv7h2yLtd0lSxhRJ
        8gc8s=; b=jZcw6yuteZTxmLoXqp24WgiyIPU3qLQjBo6QfGBFsTRNsAWR7phWDo
        ZHBxssjXoKyC0TTljZtccOnVM1e1N2eZpCoRFSUI5BeT5ui7KaL8br1+TPfAuvzY
        4ftNa1ZFtnsJo/o/Ppfm3jubfscOd8/bXJ6e++C0ojNnFt84/tYHI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4CD6418CA83;
        Fri,  8 Apr 2022 14:58:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A9DA318CA82;
        Fri,  8 Apr 2022 14:58:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: add help target
References: <20220408074524.156165-1-gitter.spiros@gmail.com>
        <YlBVBlwNVc8mEjn5@nand.local>
Date:   Fri, 08 Apr 2022 11:58:24 -0700
In-Reply-To: <YlBVBlwNVc8mEjn5@nand.local> (Taylor Blau's message of "Fri, 8
        Apr 2022 11:30:14 -0400")
Message-ID: <xmqq1qy7mmgf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEB1125E-B76D-11EC-B9DE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I could definitely see something like "make help" being helpful, since
> make itself doesn't have a convenient way to list all of a Makefile's
> targets.

But is listing all useful to begin with?  I doubt it.

Most useful targets are all .PHONYs, so a possible approach is to
make them double-colon rules, and have a section at the top, next to
where we explain "# The default target of this Makefile is...", that
lists all of them there, and have a rule

	# The default target of this Makefile is...
	all::
	+# Common targets
	+test::
	+doc::
	+...
        +help::
        +        sed -e '/help::/q' Makefile
        # Import tree-wide shared Makefile behavior and libraries
        include shared.mak

perhaps?

> I worry about this list getting stale, though.

Absolutely.

A well-curated list of common targets, maybe, but I find nothing
interesting in the posted patch that lists way too many.

I also suspect that a well-curated list at the top would eliminate
the need for the "help" target in the first place.  Between "make
help" and "less Makefile", the latter is much more intuitive.

Thanks.

