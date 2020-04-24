Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62686C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F39C5215A4
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 21:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="haaUsiH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgDXVWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 17:22:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61903 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgDXVWj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 17:22:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D1F6478A4;
        Fri, 24 Apr 2020 17:22:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K2xbPKwSckYafiHG6OilkW/KdzM=; b=haaUsi
        H8+syD7bf86lopaDN/E82JMNvsc3lbptzFoW9LVPbRDmvRkyqALCeB2lCQkKeI0I
        FjgToMtDb2TZhoXjQZaZRo7d3NKXsl+ck/MGLDYAuL+EMvHJPWr859Pe23taev0h
        kulcnVxLZTZ763N4oHQk/FSe56riZ8qINlSBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ENLpPh7+j5Qcqp+TA3XuFSCmeL9GvNlU
        nxyGaeic/jPMvoFydz59xeApcsU76UT/6v+mwSvjWTPpWXvIDhnS+0I/avJMxdOT
        vfVvPw/3Omsmv6lb6iH6Ih6DKrbN0/InWh7coYGd9WuAbvkqXPvdTcVKu3Ub4k5H
        VYcOb0ZzKQc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63A94478A3;
        Fri, 24 Apr 2020 17:22:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E4810478A2;
        Fri, 24 Apr 2020 17:22:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] push: anonymize URLs in error messages and warnings
References: <pull.618.git.1587738008248.gitgitgadget@gmail.com>
        <xmqqtv18bov7.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2004242259520.18039@tvgsbejvaqbjf.bet>
Date:   Fri, 24 Apr 2020 14:22:36 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2004242259520.18039@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 24 Apr 2020 23:04:38 +0200
        (CEST)")
Message-ID: <xmqqh7x8bmub.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B849E8CC-8671-11EA-B357-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>  	if (verbosity > 0)
> -		fprintf(stderr, _("Pushing to %s\n"), transport->url);
> +		fprintf(stderr, _("Pushing to %s\n"), anon_url);

Heh, both of us did not see this?  We must be tired.

Will replace the squash one with this one liner and wait until dust
settles.

Thanks for a quick turnaround.
