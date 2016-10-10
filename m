Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA02B20989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753186AbcJJRxV (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:53:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62613 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752879AbcJJRxS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:53:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B68C43834;
        Mon, 10 Oct 2016 13:52:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=79TGRYakImqSGeARFXeOqg5COew=; b=X1+tK9
        ko7nC4F5RLoTgykUDp42skJc32xYuN/RlTewjrJkeXFGLJj1PXujKvUR8xJKnbG6
        ngxAAXjuDNmF19yf5vzuGgLu9nl77iErzRd2V5ivigWPe0W24rnsIUdCBhzAxOkc
        YaS7+7DvRAONtBQ0yLHkcKNK3wxwabVewbKnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T2cPpvD1r+BdGvdCOz1pdij72AwOHY97
        MDt7mWb0qKdumeLtlLHlUughKW53en5CZTJlsn2uNg3Jv1knNOirDtuiv5CM9qpN
        yFPe+E5Kaeofm0bXlLRw4SW58YYZZSW0T5rhgHYHa+vpAyQmQVIw3TBLHvtdCPfz
        x0inuNJ4oPQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2381E43833;
        Mon, 10 Oct 2016 13:52:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8436A43832;
        Mon, 10 Oct 2016 13:52:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
References: <20161006114124.4966-1-pclouds@gmail.com>
        <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610071319520.35196@virtualbox>
        <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
        <0347de20-72a7-b384-389f-4b2ad5789973@kdbg.org>
        <20161007175052.sxyk7y2ytjh36phr@sigill.intra.peff.net>
        <alpine.DEB.2.20.1610081034430.35196@virtualbox>
        <20161009060149.voqjoiltqi6jub7g@sigill.intra.peff.net>
        <CACsJy8BpYYJmBm32YsQyuP58uhLE+sn8WdhiHyY6xzcqPVjMVQ@mail.gmail.com>
        <20161009205854.byq2wqgemtmwudfb@sigill.intra.peff.net>
Date:   Mon, 10 Oct 2016 10:52:26 -0700
In-Reply-To: <20161009205854.byq2wqgemtmwudfb@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 9 Oct 2016 16:58:54 -0400")
Message-ID: <xmqqzimcf5wl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F646260-8F12-11E6-B976-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Having separate exec/shell boolean options just punts the overlap from
> the command key to those keys. If you have two mutually exclusive
> options, I think the best thing is a single option, like:
>
>   type = <shell | exec | whatever>
>
> and then it is obvious that a second appearance of "type" overrides an
> earlier one, by our usual "last one wins" convention. As opposed to:
>
>   shell = true
>   exec = true
>
> where you have to understand the meaning of each option to know that
> "exec" overrides "shell".

Good.  

Duy's "do we want to chdir or stay?" would be an orthogonal axis to
"what does the command line look like?" and "how is the command line
run?" so it adds one member to the "alias.<string>.*" family of
variables, I guess.
