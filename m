Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AADCC433FE
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 13:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346106AbiC3Njs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 09:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbiC3Njq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 09:39:46 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0534726564
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 06:38:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4160175ACE;
        Wed, 30 Mar 2022 09:37:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=u/Qd7m+sGcBeEfqVN1BmbNji9xx8KZhvoan3YH16Vzg=; b=w14L
        H/bk0fywrg1DAc+MQ97nTYUq0areywXaXY948P+FPSzgI9JAGegQnaUAipx/zgJl
        aP19s3peuVXS6vPq0h7bQEdk11Qf8ye8KZInUDPzdCs6Z/fbro4rm/3tPfvJ9/Ky
        RdCKC5xM4hX8EIwPqXPEKaOJhaLzy6k0wjOMzfQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DC040175ACD;
        Wed, 30 Mar 2022 09:37:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA0B9175ACC;
        Wed, 30 Mar 2022 09:37:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        tytso@mit.edu, derrickstolee@github.com, larsxschneider@gmail.com
Subject: Re: [PATCH v3 01/17] Documentation/technical: add cruft-packs.txt
References: <YiZI99yeijQe5Jaq@google.com> <YjkjaH61dMLHXr0d@nand.local>
        <YjpDbHmKY9XA2p0K@google.com> <YjpHbaBspUasDdEy@nand.local>
        <YjpWFZ95OL7joFa4@google.com> <Yjpxd8qhwnAIJJma@nand.local>
        <YkICkpttOujOKeT3@nand.local> <xmqq8rst23w0.fsf@gitster.g>
        <YkIm7lnQsUT0JnvS@nand.local> <xmqqa6d8yckj.fsf@gitster.g>
        <YkO/P3xgGYmhAz2O@nand.local>
Date:   Wed, 30 Mar 2022 06:37:54 -0700
Message-ID: <xmqq1qyjblxp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B285C7C-B02E-11EC-8E9B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> The thing I think Jonathan seeks to prevent is older versions of Git
> gc'ing a repo that has cruft packs. I think I may need you to clarify a
> little, sorry :-(.

By making controlled rollout of the use of "--cruft" option (and the
assumption here is that a large organization setting people do not
manually say "gc --cruft", and they can ship their maintenance
scripts that may be run via cron or whatever with and without
"--cruft"), you can control the number of repositories that can
potentially see older versions of Git running gc on with cruft
packs.  Those users, for whom it is not their turn to start using
"--cruft" enabled version of the script, will not have cruft packs,
so it does not matter if they keep an older version of Git somewhere
hidden in a hermetic build of an IDE that bundles Git and gc kicks
in for them.

