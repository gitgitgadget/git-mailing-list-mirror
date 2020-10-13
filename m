Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DEEC433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 15:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B0E425200
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 15:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jPLkTcSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbgJMPrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 11:47:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51867 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731233AbgJMPrN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 11:47:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 134FB7163E;
        Tue, 13 Oct 2020 11:47:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2ivnMGScZhs7DYaDnP+TgI0j6A0=; b=jPLkTc
        SIoA3dL1FNBSAJYmfD0j/nCdqcDwRxfp257qYZDSb2usxP3p8hfzeBkINbv/a/vg
        3UQGGLofntTrSAyeftb4mmyl/rRXuWunKeKmDIzgyCKEcH0r8FN8waPBoV3omYzQ
        dYEGaLnySX1WvNo2E3dHNyIHeuYT98zoVrS7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VSzr6NLzKxH9xWR1SXtDfcNECWS9JMfV
        dkeaYz52M1vOwfeUoRmcMyRiRsq4XpWQ1trAdfoqYfGL7thja2S2f0yitPy8CTK9
        OA3Z6GhNiUbg+P83FLTQErlF2+15h7Tso1k3UM1PU8WCkswXF/R0HmcnQXfdOXy5
        bkOO9zoknh0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09D587163D;
        Tue, 13 Oct 2020 11:47:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8E6AE7163A;
        Tue, 13 Oct 2020 11:47:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Patrick Steinhardt <ps@pks.im>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
        <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
        <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
        <20201002041214.GE3252492@google.com>
        <CAFQ2z_NL1UrmonMH3qLKrEkjsPjm9qTbtoeY0OHQZzkVW2t3-w@mail.gmail.com>
        <20201012152505.GB3740546@google.com> <20201012170527.GA21606@xps>
        <nycvar.QRO.7.76.6.2010131405380.50@tvgsbejvaqbjf.bet>
Date:   Tue, 13 Oct 2020 08:47:09 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2010131405380.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 13 Oct 2020 14:12:05 +0200 (CEST)")
Message-ID: <xmqqo8l6ku0y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B19F4A4-0D6B-11EB-93E4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Somewhat related: I was wondering whether it would make sense for git.git
> to rename `strbuf` to `git_buf`? Would that make it easier to exchange
> code between the two projects? Or would it just be unnecessary churn?

To us, "git_buf" is just as descriptive as "buf" and does not say
anything about the nature of 'buf' (other than apparently it was
invented and widely used here).  "git_strbuf" I can understand, but
why should we?

