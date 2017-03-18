Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BAA82095B
	for <e@80x24.org>; Sat, 18 Mar 2017 18:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdCRS6r (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 14:58:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57511 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751406AbdCRS6r (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 14:58:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC09C83BB2;
        Sat, 18 Mar 2017 14:58:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XZS4M63KvB5IGEZGpagcgGS0tK8=; b=BRNXOd
        6S43c2cKB29uQbVxXcTcMIe7gJOEFUVhtmfSEgnyhXhf4dyXBW630/bbOoshlcgh
        y6u7BbUjpzu1pdofwCVWzftvzPomxMIgAMv5ZgtBtGhxCqE9oNf6orkG9FjeKVNi
        gyWLytW5R2U+OIeDmxpcet5rZ6AJEwOjR1IVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g7v5pTw/KMd0czvE4IuL+/WUu57m9/oW
        pUIfP/oAwQGNBwFCvq+j5LiForWkmqwXx23QeKZOflkqCtVwDIkOLSu/hxnWM/OY
        nDCBc9JMi+VPPAZ97/KrosGfY+0QY3R3y4Arme1Bnwg8RgLOVIUDdNrNFbJi9V+F
        Atab8/p1yeY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B304483BB1;
        Sat, 18 Mar 2017 14:58:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2BB0883BB0;
        Sat, 18 Mar 2017 14:58:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] pickaxe: fix segfault with '-S<...> --pickaxe-regex'
References: <20170318151239.17196-1-szeder.dev@gmail.com>
Date:   Sat, 18 Mar 2017 11:58:43 -0700
In-Reply-To: <20170318151239.17196-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Sat, 18 Mar 2017 16:12:39 +0100")
Message-ID: <xmqqefxu2yzg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9555466-0C0C-11E7-AB5E-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Interestingly, the new test fails (with the patch) under prove but
not when run from the shell (i.e. "cd t && sh t4062-diff-pickaxe.sh").

