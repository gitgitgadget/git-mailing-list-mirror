Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87587C4CECD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56981215A4
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q/f9r3aJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgD0RrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:47:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52064 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgD0RrH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 13:47:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E5DA418F8;
        Mon, 27 Apr 2020 13:47:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CxJ04F7ddltNgdIH3RTfcka+/LQ=; b=Q/f9r3
        aJURLJKWzNvXSVeHqFIgqDrtx7YdeKC9ABmiRgE+6DJr48h3H7chi/mUYvUjAcMe
        WjAKGCoi9l1TTm2JPpOEhAL6DT2MOxKyTWmyQ22BYlrsjAXxthilInsq5qgYAOG4
        +agfRGS9gkyPDkXigbFGQJiwAhBdY3r7ja4N8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SEObhS/f7O7sfpAZ4KvJPDk3j9jbYGoc
        TpS3w1r2MjJkO66ubBmnsx6dZlgVF263t/yFXbNsR3w025XmDTaOgd2zRLkYJrTs
        lv7tRToy0fpWZp6W0nBRh48qmr1mUs3cw7WDq6pyiVqCRI2G4kJ88Re+d8V7R3+g
        zWjhZU4qVVQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 450F3418F6;
        Mon, 27 Apr 2020 13:47:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BDFBA418F5;
        Mon, 27 Apr 2020 13:47:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com
Subject: Re: [PATCH v2] git-credential-store: skip empty lines and comments from store
References: <20200426234750.40418-1-carenas@gmail.com>
        <20200427084235.60798-1-carenas@gmail.com>
        <20200427115223.GA1718141@coredump.intra.peff.net>
Date:   Mon, 27 Apr 2020 10:47:02 -0700
In-Reply-To: <20200427115223.GA1718141@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 27 Apr 2020 07:52:23 -0400")
Message-ID: <xmqqk12095yh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AC8CDD0-88AF-11EA-A5E5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Those were never supposed to work. I'm mildly surprised that they did.

I know that feeling X-<.  It probably was a mistake to pretend that
the file were editable with an editor, but it is too late to fix
that.

The next complainer may say that "; comment" no longer works.  We
probably should draw a line somewhere, but I am not sure where.
