Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D2E7207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 19:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbcILTs3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 15:48:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55821 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751400AbcILTs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 15:48:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B1AD3D048;
        Mon, 12 Sep 2016 15:48:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eP7TgmKHZr+dNKZBEAaI5zDRHE0=; b=p2ONFS
        vkHUSF8OKlerCP7s9i2jKAt2RkWcJ3J5YHw+ybAZTh2P/QATGSG9UHuSfhy9S1Nd
        ismrhuB4WevGmKkVnAihHfMo/xghjXl/GD1UAbXD4HAr3m1avAM/yj2UhL48F+fW
        m+Zi+aUxmPbuf7xpTwlM+D1vEQF6ChhDQ4ZDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V1VBZEi1Xwd9hcMxIWHRFoLtQovNFPbP
        JpbW988AzwCC9XMQjRdOsH+yxpp2qiiSnG/KUx6rDg1KgHm0Uz9Ut/4bwLWVtKFj
        AXIjj/K9X6e7JhqmLwrkMFH4dk9lNlYuT/DUj72q5v1b+fIl2/jdeXtkkBpMMPnr
        x5n/MbWVB4o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2334F3D046;
        Mon, 12 Sep 2016 15:48:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A301F3D045;
        Mon, 12 Sep 2016 15:48:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 02/25] sequencer: use memoized sequencer directory path
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <5c52dcbff8b21b24a360d6f5bd2710fe1139eb4a.1473590966.git.johannes.schindelin@gmx.de>
Date:   Mon, 12 Sep 2016 12:48:24 -0700
In-Reply-To: <5c52dcbff8b21b24a360d6f5bd2710fe1139eb4a.1473590966.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 11 Sep 2016 12:52:37 +0200
        (CEST)")
Message-ID: <xmqqr38o292v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF318EB0-7921-11E6-9319-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/commit.c |  2 +-
>  sequencer.c      | 11 ++++++-----
>  sequencer.h      |  5 +----
>  3 files changed, 8 insertions(+), 10 deletions(-)

OK.  It's nice to see code reduction.

> -#define SEQ_DIR		"sequencer"
> -#define SEQ_HEAD_FILE	"sequencer/head"
> -#define SEQ_TODO_FILE	"sequencer/todo"
> -#define SEQ_OPTS_FILE	"sequencer/opts"
> +const char *git_path_seq_dir(void);

