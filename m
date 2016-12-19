Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56E371FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 19:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755633AbcLSTSG (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 14:18:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58718 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753719AbcLSTSE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 14:18:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 05626588A3;
        Mon, 19 Dec 2016 14:18:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S4tLAR2y2wdCtRjvUghjrGJGr0E=; b=s/jP3b
        Xq8oikF5cDt3XIli38oMV3AGWk9eFznn0nWbvB0SuRZy2tROHtWbJH+5SSliIdrR
        FyAUAG4tfms72G3zAjkT8J/nYylB7hB34J33S+s5bGYdC+DyDIVIzMNhYFz6jJc3
        2k0ZvJVpCSx4svnSASR2gRsGYu8nJM7ZtawDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vPsp1t0rj2rtggmkTxn4WowVxui+eYlU
        GXz2ulSKzbBgzY5hruuT2Q1JfaxRoIof97iGFgm5Kkqow7dlke+Zv2sky7qtD3Gk
        0g2W6KEFr9aOYxUnUiFqldHXtND2ynQP1sjJ8rbruGpXkydsQmgTT3Zi2ZlDWpl2
        HZPAKTBDy0A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F083E588A2;
        Mon, 19 Dec 2016 14:18:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06E88588A0;
        Mon, 19 Dec 2016 14:18:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 32/34] sequencer (rebase -i): show the progress
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
        <cover.1481642927.git.johannes.schindelin@gmx.de>
        <9e48dffa8e58183debb79f29413afa81af174475.1481642927.git.johannes.schindelin@gmx.de>
Date:   Mon, 19 Dec 2016 11:18:01 -0800
In-Reply-To: <9e48dffa8e58183debb79f29413afa81af174475.1481642927.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 13 Dec 2016 16:32:44 +0100
        (CET)")
Message-ID: <xmqqr353ohhy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DCB44344-C61F-11E6-959E-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The interactive rebase keeps the user informed about its progress.
> If the sequencer wants to do the grunt work of the interactive
> rebase, it also needs to show that progress.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Sensible.  This further adds two comparisons with TODO_COMMENT and
makes need for is_counted() or something like that felt more.

    $ git grep TODO_COMMENT pu sequencer.c

shows that some places "x < TODO_COMMENT" is used while some other
places "y != TODO_COMMENT" is used, both for the same purpose, and
"z >= TODO_COMMENT" is also seen for the negation of the same.

I think all of them except for one can become is_counted() or
!is_counted() to convey what they want to check better while the one
used in the loop control:

	for (i = 0; i < TODO_COMMENT; i++)

should probably become:

	for (i = 0; i < ARRAY_SIZE(todo_command_info); i++)

as the parsing loop wants to check the input against all known
commands and there is no strong reason for that layer to know how
the insns are numbered.  is_xxx() implementation can take advantage
of the way the insns are numbered, but there is no point spreading
the knowledge to higher layer in the callchain.

Other than that, all 34 patches looked sensible steps explained as a
coherent story that unfolds bit by bit, which was mostly a pleasant
read.

Thanks.
