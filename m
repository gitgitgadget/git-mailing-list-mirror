Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAB201F461
	for <e@80x24.org>; Tue,  2 Jul 2019 19:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfGBT5N (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 15:57:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63950 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfGBT5N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 15:57:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F93E14B421;
        Tue,  2 Jul 2019 15:57:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UT+ZWYnMmxrlj7UT0Vn2VyFNAsc=; b=blHSNV
        8ZYRm/bq0Yp74RGMii8b4Th0Qg078AhpQEn5iu1bSN01hi9r8FAEHU8cAejWGK/+
        zczhm/OOz72v7A70A9GecCeyOa0AJOnK9F8syd92eh0Er1IcdEtFZpB/BtbzDwR8
        kDe4W8UQOTiT9XDEwCkjRWe9IS+4HvQkceikY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hf5ACNuFYpeThKS3/pSboOeT8+YH7b7R
        u048zyaX8TVitkBqwXwyX9U0SLEL7YY5E/B/Hmc70Tk8o24MkToTNpSIvs9ON0SX
        coGXwkiDVF6j2HTm8TNMPI3eikTZQOZMGwb6oPjfJw0jOS7+UR47T4BQS9cZrl4g
        mlAa/uRQ96M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66C9114B41E;
        Tue,  2 Jul 2019 15:57:11 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C0B6214B41D;
        Tue,  2 Jul 2019 15:57:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, git-packagers@googlegroups.com,
        gitgitgadget@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Subject: Re: [PATCH v3 00/10] grep: move from kwset to optional PCRE v2
References: <20190627233912.7117-1-avarab@gmail.com>
        <20190701212100.27850-1-avarab@gmail.com>
        <nycvar.QRO.7.76.6.1907021417050.48@tvgsbejvaqbjf.bet>
Date:   Tue, 02 Jul 2019 12:57:09 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907021417050.48@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 2 Jul 2019 14:32:56 +0200 (CEST)")
Message-ID: <xmqqo92c2oru.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 942EEA26-9D03-11E9-B851-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Please note that the problem is _not_ MinGW! The problem is that the
> non-JIT'ted code path is a lot more stringent than the JIT'ted one. So
> what you'd need is a prerequisite that tests whether the PCREv2 in use
> supports JIT'ted code or not, and skip the test case in the latter one.

Hmph, so additional prereq !MINGW may happen to match "do we use
pcre sans jit?" but not a right thing to use here?

