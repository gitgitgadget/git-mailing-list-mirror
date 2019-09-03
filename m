Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5568C1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 19:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfICTvJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 15:51:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50288 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfICTvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 15:51:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C38918658;
        Tue,  3 Sep 2019 15:51:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uGJHoIFBVEvB6vAg8kPqnpxVCX0=; b=VSf/uC
        EV42NprSJDCwYGJQeDt2cn0wY7RCBmmaErUM62SZP9mmddBWDnY+Bi1hs4TiTeWn
        sIiJRSAh4Vw2cVmapkyrrBmT1XQfjl7ncra7T91q5UJzBfL+KilkWLFfWqBFWHL0
        QHjkC00n37eST+u6OLlN3S59ZuDdjAMM7J3Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kF37GnILldFGcH8HmevjYaeGmZXBYKBo
        dsjre1u2ny5D0ZnigKtlqSJOH0wCrmPTg34KcExd0/SRahXGIqfwz7PpTv55/6ZV
        4xrJWS9XELBbeB8yrqIFtR/CpDgtEqVMt427nX2FExWiuEK6nO6x/DEBYXAw5QNS
        Cu+RhLY7jsU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2299A18657;
        Tue,  3 Sep 2019 15:51:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F68918656;
        Tue,  3 Sep 2019 15:51:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Matt R via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Matt Rogers <mattr94@gmail.com>
Subject: Re: [PATCH 1/1] rebase -r: let `label` generate safer labels
References: <pull.327.git.gitgitgadget@gmail.com>
        <4a02c38442dd8a4c0381adc8db0dce81c253da09.1567432900.git.gitgitgadget@gmail.com>
        <444f3ec4-abdf-1aa9-e8a8-8b5346b939e8@gmail.com>
        <xmqq5zmav9ej.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1909031256290.46@tvgsbejvaqbjf.bet>
Date:   Tue, 03 Sep 2019 12:51:05 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1909031256290.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 3 Sep 2019 13:19:59 +0200 (CEST)")
Message-ID: <xmqq5zm9taza.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B1FAC3E-CE84-11E9-92E7-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If you care deeply about double dashes and leading dashes, how about
> this instead?
>
> 		char *from, *to;
>
>    		for (from = to = label.buf; *from; from++)
> 			if ((*from & 0x80) || isalnum(*from))
> 				*(to++) = *from;
> 			/* avoid leading dash and double-dashes */
> 			else if (to != label.buf && to[-1] != '-')
>    				*(to++) = '-';
> 		strbuf_setlen(&label, to - label.buf);

Simple enough and is a good change when judged locally.

It still would cause readers to wonder if label_oid() later append
'-%d' to end up with double-dash near the end, etc., which made me
wonder if the resulting code becomes better if sanitization and
uniquefying are done at the same single place in the other message.
