Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83D20203C1
	for <e@80x24.org>; Mon, 12 Dec 2016 22:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbcLLWhM (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 17:37:12 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63100 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751613AbcLLWhL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 17:37:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B07E6583A6;
        Mon, 12 Dec 2016 17:37:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xMc2z9gd71b4nvXLHjtd8ZVNTEA=; b=lYmXue
        +3yctG70z35ItQwFoOApyJx6iFyYoI2KX7IcWTtdsc6r8oktZ+2LxSvzr2bBPm9S
        kDwjVZUAGNDb6epZktskUeeJN1jGEEM+iz7xf/7sMlFh5zsOiWTx1bZ85Qo684BA
        oxMFbJR7TtaddTse4G3H3LZ40+pYEsiULAyXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S5q4R4+/1obzevTIreTitQaVqq1XKlbA
        h8VLSZG8sKg3lvWGM5AlHXE+AEGl+nL9Xp3CrgkTXxakXu9S61JGkf0XeenJ3hVg
        yVHgWpXBR8beoNWj5xhYUfrQFbSqLKVdGJz4NC52ABxrPcPq4MTjEAdGaPF3Vcih
        tOfYWucZK/s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8CE3583A5;
        Mon, 12 Dec 2016 17:37:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25403583A4;
        Mon, 12 Dec 2016 17:37:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] handling alternates paths with colons
References: <20161209140215.qlam6bexm5irpro2@ikki.ethgen.ch>
        <20161209152219.ehfk475vdg4levop@sigill.intra.peff.net>
        <xmqqwpf8rkeq.fsf@gitster.mtv.corp.google.com>
        <20161210085133.2pnkz6eqlxoxdckg@sigill.intra.peff.net>
        <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
Date:   Mon, 12 Dec 2016 14:37:08 -0800
In-Reply-To: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 12 Dec 2016 14:49:29 -0500")
Message-ID: <xmqqvauo7p0r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84DA3C3C-C0BB-11E6-A5CE-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So here are patches that do that. It kicks in only when the first
> character of a path is a double-quote, and then expects the usual
> C-style quoting.

The quote being per delimited component is what makes this fifth
approach a huge win.  

All sane components on a list-valued environment are still honored
and an insane component that has either a colon in the middle or
begins with a double-quote gets quoted.  As long as nobody used a
path that begins with a double-quote as an element in such a
list-valued environment (and they cannot be, as using a non-absolute
path as an element does not make much sense), this will be safe, and
a path with a colon didn't work with Git unaware of the new quoting
rule anyway.  Nice.



