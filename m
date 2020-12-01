Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A16C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDB220870
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XAJJMWTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404374AbgLAUE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 15:04:28 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57337 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392317AbgLAUE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 15:04:27 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3ED310DDE2;
        Tue,  1 Dec 2020 15:03:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=B3Ng4ujMro5JfE0gbdiQz0yfL1c=; b=XAJJMW
        TBpu5/J/p5h4VjvFO7C8Mq7Zud5SPczQtpgcISuyhsXBH1T8d8M/E4SVhgzrI06S
        VHMsJLqfMBiCJ40fdOpuUAriA599VxgSGurk6gZkUSZkPtbGToZYyeIJLnylZaYT
        Be0be7rOlpmJObdOGmiHxHzxTSJj9H9rdwBWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h3uahcpXyFixyErGGCyKoZkUxhvSZ/hr
        20FsjT1NP6Hgrw/kEmMG6cU0q2MzBi+2M3sQ2I/ewLFuWTClWLIRoxtK1EGkcy+X
        GZxMi9t4ReX45nH2yuu3qSMKHqXiphjty5q1YSR0UlAvNvotr/uGXonwbnclCoiJ
        AUlXTuN+lgQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CCA4A10DDE1;
        Tue,  1 Dec 2020 15:03:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 12CF210DDE0;
        Tue,  1 Dec 2020 15:03:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ernst Reissner <rei3ner@arcor.de>
Cc:     git@vger.kernel.org
Subject: Re: bug report/feature request: git describe: what is 'clean'
References: <ed404c7e-d098-348d-d8fe-dae8aa5a5fda@arcor.de>
Date:   Tue, 01 Dec 2020 12:03:41 -0800
In-Reply-To: <ed404c7e-d098-348d-d8fe-dae8aa5a5fda@arcor.de> (Ernst Reissner's
        message of "Tue, 1 Dec 2020 11:46:35 +0100")
Message-ID: <xmqqh7p5pa3m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4FFB5A42-3410-11EB-B671-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ernst Reissner <rei3ner@arcor.de> writes:

> To keep backward compatibility,
> maybe it is a good idea to add a second suffix, maybe 'untracked' to
> display in addition.

It won't work for folks who have used output from "describe --dirty"
as the base of their version number, as their procedure do not know
they need to strip "-untracked" at the end.  

A new option, "describe --dirty --untracked", is possible, though.
