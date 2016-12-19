Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11AA5203EA
	for <e@80x24.org>; Mon, 19 Dec 2016 22:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbcLSWyi (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 17:54:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57583 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752337AbcLSWyh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 17:54:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3E7A5AF76;
        Mon, 19 Dec 2016 17:54:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l/XFC7We3vvsdiM9RrgfE4oWlVQ=; b=crFbj7
        Zgm5IpHMBZ2uyNxA0IFvHN3F/EDt/Uf24DY9GQPpoiGiJyN1TC0QCMQRnTNljMEl
        aJeltzz2I7dDnBRYyhjv3S8RicQ+sg2RTCPfj8n7XPSndm7c6cpwMiBvTHAGd0rL
        NlSlGCIrYra/+xusfosWuMVeYPRwxWFnEIYNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A1u41IlTP0KmnY+w6nOHG2+tujTtty2M
        ko8HY/aps/FYaySGvM/HsQiyCsCoBSsnfpIsu+snzIs3Ql8sZjTwpSanh6e9nOyM
        tp67gqz9/PmXETdSXkaFhbnMjnmSG98KZQLyFWIQGJ2Df7XWYI0hhWWonv27i1gs
        PiSmM1JbdpE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0EE25AF75;
        Mon, 19 Dec 2016 17:54:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D29645AF74;
        Mon, 19 Dec 2016 17:54:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     pclouds@gmail.com, bmwill@google.com, git@vger.kernel.org
Subject: Re: [PATCH 0/2] improve relocate_git_dir to fail into a sane state.
References: <20161219215709.24620-1-sbeller@google.com>
Date:   Mon, 19 Dec 2016 14:54:34 -0800
In-Reply-To: <20161219215709.24620-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 19 Dec 2016 13:57:07 -0800")
Message-ID: <xmqqfuljmswl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D09AA9C-C63E-11E6-B733-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This goes on top of sb/submodule-embed-gitdir.
> When the absorbing of a git dir fails, try to recover into a sane state,
> i.e. try to undo the move of the git dir.

Are these unconditionally good improvements?  I ask because the
series is still not in 'next' and it is the last chance to fold
these into existing patches if we wanted to.

>
> Thanks,
> Stefan
>
> Stefan Beller (2):
>   dir.c: split up connect_work_tree_and_git_dir
>   dir.c: add retry logic to relocate_gitdir
>
>  dir.c       | 118 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  dir.h       |   6 ++--
>  submodule.c |   3 +-
>  3 files changed, 110 insertions(+), 17 deletions(-)
