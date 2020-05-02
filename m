Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE4AC3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 16:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2516221775
	for <git@archiver.kernel.org>; Sat,  2 May 2020 16:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QOzjJ4Er"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgEBQo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 12:44:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56853 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgEBQo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 12:44:58 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4D4DCAB43;
        Sat,  2 May 2020 12:44:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eU8w1Vl5KVEoJhxbPcjZBj/PRGQ=; b=QOzjJ4
        ErRtA0K4E9x+pR57OMxLuwu9GVLye79Es9CGvNMWJJRywc+/sik7IFCSq7JIgEpU
        2HsZxf6x5TA4+TgkqTmmtiEEC4m1CxT9wgPNQXvY8d/4jp6eodwiWpTyksWZG0Ol
        wgsjuoWdbAbQ4Pj7TU7icPWBft5BJLHCucY1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o2PEhxvaQoBDKKgHzq+9bdcmmCqwsV/e
        1l40h7v3g0cgzy1GMaGYysrtKlwb2rwMsZWFS0JrUsptl7qWZjVfRHKTH58F1jCN
        neNMNaYfGgp9fPIjQtaxvi5++OePdmkhfm3DOyVpbgwKaIOO3fsdEungaK55euAw
        5EpYOxtlIHk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD0EBCAB42;
        Sat,  2 May 2020 12:44:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2BADACAB41;
        Sat,  2 May 2020 12:44:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Erik Huizinga <huizinga.erik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Why are experimental commands git restore and git switch suggested in CLI output?
References: <CADA507xceVtpNkK5hyUrnXM0rPBj=sgpR0eM7b+yybiWT6Cg3w@mail.gmail.com>
Date:   Sat, 02 May 2020 09:44:52 -0700
In-Reply-To: <CADA507xceVtpNkK5hyUrnXM0rPBj=sgpR0eM7b+yybiWT6Cg3w@mail.gmail.com>
        (Erik Huizinga's message of "Sat, 2 May 2020 09:18:26 +0200")
Message-ID: <xmqqtv0yjngb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FD1596A-8C94-11EA-8BAC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Erik Huizinga <huizinga.erik@gmail.com> writes:

> In other words: how can I, an individual end user, know what I can
> safely learn about these commands, and what can not?

The restore/switch commands are thought to be the future, and for a
better future, we still want to polish them further, which means
they may gain new features, their existing behaviour may change, or
some features that are found to be bad for users may be dropped.

And we will know what new features are desirable, which parts of
their existing behaviour should be improved in what way, and which
parts of their existing features cause confusion to users and need
to be dropped, only by listening to those who actually use them in
their daily life.  That is what an experiment is.  By definition,
we won't know what will going to change.

Users who want to help improve future Git are encouraged to use
these experimental commands and complain (especially when they find
that these commands do not work for them in their workflow better
than "git checkout", which these commands are meant to replace).
Their voices will be heard and the commands may gain what they want
and lose what they do not want.

Users who do not care about participating in polishing these two
commands for a better Git in the future can stick to what they
already know, "git checkout".  But eventually these users would have
to learn "switch/restore" and their then-current set of features, as
(hopefully) they would be much better than "git checkout" by then.

Thanks.
