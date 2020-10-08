Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEE2C433DF
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 17:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4114920708
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 17:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="L9f9RLNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgJHRir (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 13:38:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63293 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJHRir (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 13:38:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E19917E848;
        Thu,  8 Oct 2020 13:38:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OiINKrDjIbc0wMZ/3DAsddQcTTQ=; b=L9f9RL
        NcdL5VSIuswe/cS3v+lc2i34XA20Bf7cr8iJC3bo1PoJxIc0306G6tiF4Q7BtlF5
        75cIFcOuVlaM20NUBjVB2EW5DDo7G6oAYrLw45pbgZtDV+OQM070JclNT3iqMrL0
        rBwgKeQjAHZkkoLOJ36XtDyDL8Rgp1weDXNvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iaRHWzvgOCaBKpKjm2oI812kvjU256Zw
        xZXqQgum/2Rw6SdsXRfFbUkPC7P7KRv5yXC7UOyoPrT2Br3702FoIEM3qd12MftK
        tRYmLQhLdOl6lKLJSyBIGQSY84yMWzyh9tbWftd7xwyWzALf1zsNJpdO2gMqFrDI
        T9SOs4Z5IRs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAB777E847;
        Thu,  8 Oct 2020 13:38:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68A0B7E846;
        Thu,  8 Oct 2020 13:38:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: ASCII-sort += lists
References: <f0f1ef1f677133eabd1bce00c6cdbbcc6477f00b.1602142738.git.liu.denton@gmail.com>
Date:   Thu, 08 Oct 2020 10:38:43 -0700
In-Reply-To: <f0f1ef1f677133eabd1bce00c6cdbbcc6477f00b.1602142738.git.liu.denton@gmail.com>
        (Denton Liu's message of "Thu, 8 Oct 2020 00:39:26 -0700")
Message-ID: <xmqq5z7ky5wc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CE079C4-098D-11EB-8DDE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> In 805d9eaf5e (Makefile: ASCII-sort += lists, 2020-03-21), the += lists
> in the Makefile were sorted into ASCII order. Since then, more out of
> order elements have been introduced. Resort these lists back into ASCII
> order.

OK.  I tend to agree with the comment on Resort (by Dscho??  Sorry I
forgot), so I'll locally do s/Resort/Sort/ while applying.

By the way, I have a mixed feelings about a patch like this very
close to prerelease freeze.  It is a good timing because not much
_ought_ to be changing, and a small mechanical code churn like this
one whose correctness is so obvious is easy to accept without risk
of breaking things.  But at the same time, it is distracting when we
would rather see contributors' and reviewers' time spent on double
checking that the changes made during this cycle did not introduce
regressions.

Will queue.  Thanks.
