Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URIBL_SBL,URIBL_SBL_A shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 590ED20A26
	for <e@80x24.org>; Thu, 28 Sep 2017 06:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750946AbdI1GCn (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 02:02:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58061 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750775AbdI1GCm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 02:02:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54FBB9E0C9;
        Thu, 28 Sep 2017 02:02:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2z65LUiZYISlfSQOTMZE5rMHNPM=; b=ZGtQDb
        cCeKkoufJfoFXsYVzLrGSN9+Wt+8Hn5sbpAv8RCOqWiDItdXsAt8Xz/AXud79Y05
        ZksMk8P0hxcJgLIFMKd8zUhZh0W1spJ2s5CHro3ijr7oimOJDPxv3xoFTzYz4TCi
        QsYXzsOXVHSp4EEg1qBx/gNJMsH/ISkY6Q/nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tGjOT+RVRsKLk7p68vGnUK5lEJ+1P7oM
        /viXrfCrKIs04BG+V0PVKlqduoLUAvEdIpwlqSsojesaEV5VoB+yPKufi3ji3zN2
        qV8ZnqJrXgmv6+3n5zJLg44muGmpjFT+fxSF6PK7e6cj6X9E36R2Csb2Le7tw2VT
        qgT3ytNkTME=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D8C79E0C7;
        Thu, 28 Sep 2017 02:02:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB3019E0C6;
        Thu, 28 Sep 2017 02:02:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Rannaud <e@nanocritical.com>
Cc:     git@vger.kernel.org, Jeremy SERROR <jeremy.serror@gmail.com>,
        "Shawn O . Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
References: <xmqqefqs7qx8.fsf@gitster.mtv.corp.google.com>
        <cccb06b75df3cad9f013d5a9ab0371f0a2d9c2ce.1506541322.git.e@nanocritical.com>
        <xmqqh8vn32mn.fsf@gitster.mtv.corp.google.com>
        <CAH_=xoZfuJDE515zZbry1DdGV+YeySy+5T9QOBefO-MMTSvXSA@mail.gmail.com>
Date:   Thu, 28 Sep 2017 15:02:39 +0900
In-Reply-To: <CAH_=xoZfuJDE515zZbry1DdGV+YeySy+5T9QOBefO-MMTSvXSA@mail.gmail.com>
        (Eric Rannaud's message of "Wed, 27 Sep 2017 21:56:14 -0700")
Message-ID: <xmqqvak31hts.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2EB8876-A412-11E7-8CCA-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Rannaud <e@nanocritical.com> writes:

> Doesn't fast-import get a copy of 8 (open for both reading and
> writing), as a child process, and exec 8>&- only closes the copy of
> the file descriptor in the parent shell, so the named pipe remains
> open for writing somewhere (in the fast-import process itself, in
> fact), therefore fast-import will not find EOF on its stdin?

AHHHHhhhh.  If that was done intentionally, well, I really have to
marvel at the cleverness of the solution!  It makes sense now to me.
