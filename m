Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E26F8202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 15:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933842AbdKGPNk (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 10:13:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65220 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751844AbdKGPNj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 10:13:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8B68A70D9;
        Tue,  7 Nov 2017 10:13:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vb4O3H68YL4BGlvI6lUIc9DFCII=; b=jqHV26
        +q1F7VYipLfjbBF2ab7OlmO+WbyLOdsCiAoghZRkwxr1V64pNJzdlfFMazUoK6+x
        8mW61boHaQavYMqS19zAQ0Pev8Dsola3L6hWp7vMnpjBDDSSlFQf24Le1Pl5GIUw
        IcHbMtQ7ILO28CBFb46T4ntt2a3Ig4Ml7JmiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nNtjfHTre4sE7u53QPv4HDPkwUFMHGMo
        8w4w/nlKKTe5LzFlII9ZS05WKJXCdAL7ue0sZRnUhMoJbUsyacUf6IaVTpxMDG7Q
        5XbobL7CmriPQ3USvXe20JkkmHQgQ+9hd4Fg+fnvDCVmyqW3iblBcuUK6cPqLS6l
        eDKUPHS20jw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF53DA70D7;
        Tue,  7 Nov 2017 10:13:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1FCAEA70D3;
        Tue,  7 Nov 2017 10:13:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 5/8] sequencer: don't die in print_commit_summary()
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20171106112709.2121-1-phillip.wood@talktalk.net>
        <20171106112709.2121-6-phillip.wood@talktalk.net>
        <xmqq8tfig1rr.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 08 Nov 2017 00:13:37 +0900
In-Reply-To: <xmqq8tfig1rr.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 07 Nov 2017 13:18:16 +0900")
Message-ID: <xmqq7ev2dsv2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B2B5E24-C3CE-11E7-A582-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> And this step is going in the right direction, but I am not sure if
> this made the function safe enough to be called repeatedly from the
> rebase machinery and we are ready to unleash this to the end users
> and tell them it is safe to use it.

Another possibility perhaps is that the function is safe to reuse
already even without this patch, of course ;-).
