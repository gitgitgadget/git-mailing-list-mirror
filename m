Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0727C207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 18:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbcIPS3i (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 14:29:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61547 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751704AbcIPS3h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 14:29:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92D323F7C2;
        Fri, 16 Sep 2016 14:29:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bqIj3P/4QNyGVjb8oHTaS/dFiLs=; b=XS2UXu
        7YKzYPzBhb3cV9POlxXYs/b7x+CgJ0NEjguMB3G6ffpEIvUFhze4KasAtaM3KxhF
        PaEHBox7ieZPf+Om+QkkuGUFwddsJrMZ80Q3f6aTDSlLvAxfjjLENFBkS4yX75S6
        /Lps5JUZ0gH3B6rues3uagJ+dSl2jbLli6Wj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CadCke39oEp3jDr9wFIk9ARQH5vHKw3i
        8EZ/BKGgmpzA/IwjwuqFqUEutU2DigPXbdRhL/nSX1ePDFGT59U5pUjzcoxu3BeG
        6ISHgzT5YB/aDi3h292rCr1I84a/SGFOkBy38I4e7tQ1zY31QZAY2Qbnw/131JOm
        9FIVz9ce56o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B7403F7C1;
        Fri, 16 Sep 2016 14:29:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0738E3F7C0;
        Fri, 16 Sep 2016 14:29:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC/PATCH 0/3] handle multiline in-body headers
References: <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
        <cover.1474047135.git.jonathantanmy@google.com>
Date:   Fri, 16 Sep 2016 11:29:27 -0700
In-Reply-To: <cover.1474047135.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Fri, 16 Sep 2016 10:37:21 -0700")
Message-ID: <xmqqshszk8ag.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80FE241C-7C3B-11E6-B5DC-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks, Peff, for the explanation and the method to reproduce the issue.
>
> The issue seems to be in mailinfo.c - this patch set addresses that, and I have
> also included a test for "git am" in t/t4150-am.sh to show the effect of this
> patch set on that command.

Thanks, will take a look.

> Jonathan Tan (3):
>   mailinfo: refactor commit message processing
>   mailinfo: correct malformed test example
>   mailinfo: handle in-body header continuations
>
>  mailinfo.c                           | 165 ++++++++++++++++++++++++++++-------
>  mailinfo.h                           |   1 +
>  t/t4150-am.sh                        |  23 +++++
>  t/t5100-mailinfo.sh                  |   4 +-
>  t/t5100/info0008--no-inbody-headers  |   5 ++
>  t/t5100/info0018                     |   5 ++
>  t/t5100/msg0008--no-inbody-headers   |   6 ++
>  t/t5100/msg0015--no-inbody-headers   |   1 +
>  t/t5100/msg0018                      |   2 +
>  t/t5100/patch0008--no-inbody-headers |   0
>  t/t5100/patch0018                    |   6 ++
>  t/t5100/sample.mbox                  |  20 +++++
>  12 files changed, 206 insertions(+), 32 deletions(-)
>  create mode 100644 t/t5100/info0008--no-inbody-headers
>  create mode 100644 t/t5100/info0018
>  create mode 100644 t/t5100/msg0008--no-inbody-headers
>  create mode 100644 t/t5100/msg0018
>  create mode 100644 t/t5100/patch0008--no-inbody-headers
>  create mode 100644 t/t5100/patch0018
