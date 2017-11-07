Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2DC620A10
	for <e@80x24.org>; Tue,  7 Nov 2017 03:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933213AbdKGDij (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 22:38:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52634 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933031AbdKGDii (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 22:38:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D05EA9CCDD;
        Mon,  6 Nov 2017 22:38:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kWMGJJB1dZCaR6Yn+f5GyIMdUe4=; b=VjOzy0
        tT2sdsvM6f+53GbEt1O3elsuj1uwrpeFFbr/YjS44BHVKs8TAzGlZsG3gbdZHW9Z
        9RTSR24qmWdMIKRSfO49aBkjEf0GipeEbC6381UAt/+kcfbaFUYR3sGDFa3iM9xY
        PrZgFQCxfuW7v4s16tgXCRMXoX4ZeM5xDMQ3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o3Z++rfe69i9/y56NIuhK4XhIoAfWyI+
        YZGkPU6/0u7qPkXuMN9L9IvTKvFFFm4JLVUAf/AFznribWz6en2ysJLrKT4h3iB4
        qFVvBmdmp6t1k3G7wxVpf9mLvWFIFNCektck3pgyLFJpePLS9MziJZ48Q/JRwAN0
        Srs+bsSyke8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C90269CCDB;
        Mon,  6 Nov 2017 22:38:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 419FB9CCD9;
        Mon,  6 Nov 2017 22:38:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 4/8] commit: move print_commit_summary() to libgit
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20171106112709.2121-1-phillip.wood@talktalk.net>
        <20171106112709.2121-5-phillip.wood@talktalk.net>
Date:   Tue, 07 Nov 2017 12:38:36 +0900
In-Reply-To: <20171106112709.2121-5-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Mon, 6 Nov 2017 11:27:05 +0000")
Message-ID: <xmqqlgjig3lv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23849A26-C36D-11E7-87FE-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Move print_commit_summary() from builtin/commit.c to sequencer.c so it
> can be shared with other commands. The function is modified by
> changing the last argument to a flag so callers can specify whether
> they want to show the author date in addition to specifying if this is
> an initial commit.

A movement of a long function like this one really is easier if you
did not make any other unnecessary change in the same patch and then
made the change as a follow-up.

The end result seemed sane.  

Do not use signed int as a collection of bits "flags", as it makes
readers wonder if you are going to do some clever thing by treating
the topmost bit somewhat special (e.g. "if (flags < 0)").  Unless
you are indeed doing something clever like that, use "unsigned int"
instead.

