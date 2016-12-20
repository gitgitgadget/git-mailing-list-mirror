Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71CCA1FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 16:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934216AbcLTQ7W (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 11:59:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54172 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932357AbcLTQ7V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 11:59:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4111658FD4;
        Tue, 20 Dec 2016 11:59:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=30gbZJAKhfxMwBgm8r1u9T9gbBc=; b=fj74FK
        Zxl7tT9TqE9gyNkCkQV7qjjxa9Oh91Mo6QFrR60dpDR48Bngf0AUMjaxKS5pAAIv
        YJ15uR0Y9UUcQisMR/PWuNV5XCQICl3oAbDYLGBA8f/CWinqMWAL5RJGs3vJn7Yq
        GxQTVttaa1Oilj/5rYhcmE92D6bQxwWA6rgmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z4K40qZFE04X9J+OcUBqVPeKrhrJMI5M
        PYJSXwu3O98kd7y0NFp8dB4q1IH6JMKFzOFBco8GaTXkIB+q63SjTYBmjmQyKXJE
        gU1ppYNeEv0SbyfLpIbcBrgn/rz+RVVoSAJqihA3VzJjrnZmMGi5mwIDjT2k4Wy9
        XU1uaXULb6w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 351FA58FD3;
        Tue, 20 Dec 2016 11:59:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 84B4658FD1;
        Tue, 20 Dec 2016 11:59:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] winansi_isatty(): fix when Git is used from CMD
References: <cover.1481454992.git.johannes.schindelin@gmx.de>
        <42ddc270ea04e01e899cc479063e5d602e4a4448.1481454992.git.johannes.schindelin@gmx.de>
        <129f000c-49c1-0e75-26b3-c96e9b442443@kdbg.org>
        <xmqqy3zfsq4q.fsf@gitster.mtv.corp.google.com>
        <5977e71d-da58-7cb0-bc69-343bb3a1341d@kdbg.org>
        <ffc6a7a0-4ae4-b755-0b09-5bcd7114a2e6@kdbg.org>
        <alpine.DEB.2.20.1612201732160.54750@virtualbox>
Date:   Tue, 20 Dec 2016 08:59:18 -0800
In-Reply-To: <alpine.DEB.2.20.1612201732160.54750@virtualbox> (Johannes
        Schindelin's message of "Tue, 20 Dec 2016 17:50:04 +0100 (CET)")
Message-ID: <xmqqtw9yleop.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5EF9A00-C6D5-11E6-A2B6-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> That code works because winansi_get_osfhandle() is in winansi.c, where its
> call to isatty() is *not* redirected to winansi_isatty(). Good.
> ...
> My plan was actually ...
> ...
> Let's just clean up all of this in one go.

I take this to mean that I should hold off applying/merging j6t's
one liner and wait for your counterproposal tested by j6t.  If I
misread you please let me know.

Thanks for working well together, as always.
