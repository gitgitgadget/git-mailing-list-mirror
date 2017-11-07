Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D221720A30
	for <e@80x24.org>; Tue,  7 Nov 2017 03:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbdKGDDj (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Nov 2017 22:03:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50047 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752093AbdKGDDi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Nov 2017 22:03:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E90F19C5AC;
        Mon,  6 Nov 2017 22:03:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=d0GFpSLprbc5YXtnfs1qaXzIw+s=; b=hFmLNF
        xNbQjfHkGHZHhUpIbSw2m++d1PzYGCJlzdRuhmTnTkdI4hpWiVgdZUj0E2nkRmIj
        oYAcmmZNy5j/iC18zEvnkF0pAGZww2Lf2L+EDW+tBVEDBDst4Wfh6xcj4kZRwXpk
        J/62EcdvY0uPGRPDXJ8xxKDH0+2PjB9niN/9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZHyW86h2HUP+YfnggZstTuhwbLxkmkC5
        TKKS8eU83+izgLqUBIVJmxewpSkpDFcnfnr8OYMWi3AgJGxaaW3o4xngCML/S5Oc
        KIu3J903Rx8CXAvgg5A/hSNPjBIq9rSK46uLPRa3dFnmdAjhhG1eHf851wV9rz3r
        FRmW8ISXLes=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D619C9C5AA;
        Mon,  6 Nov 2017 22:03:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 532EF9C5A5;
        Mon,  6 Nov 2017 22:03:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v1 3/8] commit: move post-rewrite code to libgit
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
        <20171106112709.2121-1-phillip.wood@talktalk.net>
        <20171106112709.2121-4-phillip.wood@talktalk.net>
Date:   Tue, 07 Nov 2017 12:03:36 +0900
In-Reply-To: <20171106112709.2121-4-phillip.wood@talktalk.net> (Phillip Wood's
        message of "Mon, 6 Nov 2017 11:27:04 +0000")
Message-ID: <xmqqpo8ug587.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FDCFC9A-C368-11E7-993D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Move run_rewrite_hook() from bulitin/commit.c to sequencer.c so it can
> be shared with other commands and add a new function
> commit_post_rewrite() based on the code in builtin/commit.c that
> encapsulates rewriting notes and running the post-rewrite hook.

This, especially the part that rips out the notes rewriting from
builtin/commit.c and moves it to elsewhere, is a bit curious
separation of labor.  I guess we'll see why in later steps in the
series.

The change itself looks like a regression-free no-op, which is good.
