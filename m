Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DFF3207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 19:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbcILTqi (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 15:46:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53581 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751260AbcILTqh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 15:46:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CAE03D012;
        Mon, 12 Sep 2016 15:46:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tk0xxGw55ZGBU9+N7dWtmk0EKYU=; b=XiDQJT
        f4ESRQADJBY6c9LOYYNQQprYvrDAqebmaoGz/QC/FJcohEzuVg/WcWIwWoHzCXMu
        iTWSTNNs1WNshhszPHCZpt4bijkfkgj6pdKlOovGK44vJtRY+qLZu6n12zKL0r4A
        uyLG+lfXHNbOe9zieBc/WfQpt/MqkDKJaFKV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kLLTgtyebLOyfqNu+PMqBxDHsK93wjaH
        CYnnbiJ0CoTgQnjwW90gJYbr+44HBFpX/L6JCzJt6NyrCK2To3QG5hB0LsNGuPfk
        XiwVnNnW3ZjLJ6cgZXq62NZWrAFs036TPxnyvB8AOibPkOJgrow2mG3h9jC7ABhC
        NfWewL7x0K0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 260293D010;
        Mon, 12 Sep 2016 15:46:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8A4713D00E;
        Mon, 12 Sep 2016 15:46:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 05/25] sequencer: allow the sequencer to take custody of malloc()ed data
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <942aa559a0af9b52e079c5c78fa313f49b87d50d.1473590966.git.johannes.schindelin@gmx.de>
Date:   Mon, 12 Sep 2016 12:46:33 -0700
In-Reply-To: <942aa559a0af9b52e079c5c78fa313f49b87d50d.1473590966.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 11 Sep 2016 12:53:07 +0200
        (CEST)")
Message-ID: <xmqqzinc295y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D02A5F6-7921-11E6-BEEC-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The sequencer is our attempt to lib-ify cherry-pick. Yet it behaves
> like a one-shot command when it reads its configuration: memory is
> allocated and released only when the command exits.
>
> This is kind of okay for git-cherry-pick, which *is* a one-shot
> command. All the work to make the sequencer its work horse was
> done to allow using the functionality as a library function, though,
> including proper clean-up after use.
>
> This patch introduces an API to pass the responsibility of releasing
> certain memory to the sequencer. Example:
>
> 	const char *label =
> 		sequencer_entrust(opts, xstrfmt("From: %s", email));

I thought we (not just me) were already pretty clear during the last
round of review that we will not want this entrust() thing.



