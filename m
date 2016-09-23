Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A57D207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 15:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966854AbcIWPhG (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 11:37:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56057 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966191AbcIWPhF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 11:37:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 553853D5AB;
        Fri, 23 Sep 2016 11:37:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xgE1LXyaiB0KAKe+c4k/j0kVn1g=; b=GzgDvZ
        EF9/KrS50ViTM5NX1/G0wIgblInk82nfXV4K3o2TVETofsE401UdVE4nqNqgy2pF
        HTU4sX5z2DA8vAWTB0DVJZNergKH2iRPy9TxCwOcWUnoOGLAi/bXxnnOM8rSQ+sb
        IqHBz3XiHRGoUEoB8ZRBjntIEDpM/+/WPNMEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YNL++33R749M5w8ViNSyhOyhHzi5nyss
        GuoJRsSCrR71QOHwcnCNsWb3XmcNaGE5OKUsMSgyy93CsLrSn65+p9ihe9bARj2I
        Igw8S71Vdkfzi4FV3tBT8ExQnpCje2ZEIxzd2YsyiHSekuC1qIM1c7/3mdPz6UPV
        v5Rz78dXqR0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 45D3B3D5AA;
        Fri, 23 Sep 2016 11:37:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B43EF3D5A8;
        Fri, 23 Sep 2016 11:37:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     lists@haller-berlin.de (Stefan Haller)
Cc:     anatoly.borodin@gmail.com (Anatoly Borodin), git@vger.kernel.org
Subject: Re: Limitiations of git rebase --preserve-merges --interactive
References: <1mu13z0.1hye7bq1uqj26sM%lists@haller-berlin.de>
Date:   Fri, 23 Sep 2016 08:37:00 -0700
In-Reply-To: <1mu13z0.1hye7bq1uqj26sM%lists@haller-berlin.de> (Stefan Haller's
        message of "Fri, 23 Sep 2016 12:40:29 +0200")
Message-ID: <xmqqvaxm1vc3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 930368EE-81A3-11E6-8842-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

lists@haller-berlin.de (Stefan Haller) writes:

> Thanks, this is interesting; I'm having trouble understanding the tests
> though. Some of them use rebase -p -i, but I don't understand why they
> use -i, or why that even works in a test (i.e. why it doesn't open an
> editor).

Upon starting up, tests dot-source t/test-lib.sh file and it
unsets most of GIT_* environment variables to obtain a stable
testing environment that is not affected by things that testers
may have in their environment.

There is EDITOR=: in t/test-lib.sh, which was added in 2006 before
GIT_EDITOR was invented.  That is the one in effect for git
subcommands that usually interacts with editors during the test,
unless specific tests further override it with test_set_editor
helper.
