Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C91A81F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 12:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733180AbeKMWyk (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 17:54:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55720 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732728AbeKMWyk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 17:54:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E6121161DA;
        Tue, 13 Nov 2018 07:56:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7VoRr6z6P7FS/HatxboHyF1hx6E=; b=bOqEGM
        ztMlkeN8eHR2qvvYgfcMFic86yvRI8lodvize1+n9Zv2v1GK1d76Tep4JLWw5wyU
        qBqBpmxnr5Kt++GIAVhgN6a/cbKwIi5XVYsV7/A8BAUcQ/06oPrVl6Vm27OEGf8q
        6qqyACJt8orAxgHHyaYrOr+FP0LzTjhpKJA38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k8NkaCbZKFL7k+Feis0/HAqlTxnzlih4
        MCWvgCvcy9sLxMoHWecgcpIEQvPqrM/5W7pTMwfo7u6D1qSZDMpVGTFxRPYElWUK
        aDZppCziKx4l6jeoPjXpxbQnBgOjMhVM0ddwoMePqVQCcXC/MT1ed68Y/nukboIc
        ZxdaoYu8p1s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36EAF1161D9;
        Tue, 13 Nov 2018 07:56:37 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D4A21161D8;
        Tue, 13 Nov 2018 07:56:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] rebase -r: demonstrate bug with conflicting merges
References: <pull.75.git.gitgitgadget@gmail.com>
        <efdd3736a96f90a4ab52acaf2e5efbe3435bcb89.1542065154.git.gitgitgadget@gmail.com>
        <xmqqh8glyajx.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811131109360.39@tvgsbejvaqbjf.bet>
        <xmqqtvkluqpb.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811131345080.39@tvgsbejvaqbjf.bet>
Date:   Tue, 13 Nov 2018 21:56:35 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1811131345080.39@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 13 Nov 2018 13:47:34 +0100 (STD)")
Message-ID: <xmqqpnv9uoe4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E091598-E743-11E8-92AE-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> You misunderstand. In this case it is crucial to read the regression test
> first. The fix does not make much sense before one understands the
> condition under which the order of the code statements matters.

I am not sure what you mean.  It sounds as if you want to use
diff-orderfile to present change for t/ before changes to other
files are presented in format-patch output to help readers, and I
think that may make sense for certain cases.  It may even include
this case.

But that is not incompatible with "avoid showing the patch that
updates the code to fix breakages separately, ending up with showing
the changes to t/ that are mostly about s/_failure/_success/ and
readers are forced to go back to the previous patch to remind
themselves what the broken scenario was about; by keeping it in a
single patch, the readers can get the tests in one piece".
