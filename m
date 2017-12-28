Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903781F406
	for <e@80x24.org>; Thu, 28 Dec 2017 20:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754135AbdL1Ucg (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 15:32:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59461 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751296AbdL1Ucf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 15:32:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 107D3CB5DE;
        Thu, 28 Dec 2017 15:32:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ok1bmt+B9neN
        /rF4RUwkn1Duanw=; b=OwH4gBKRlL3wGMy5Ty5syf+b1aRKqHSVCA0dYqUOw3Ui
        xBlsJzIYbXQc1kFj/sXDan9E0B3yW4tpl+gviUztH146f14WW1Xgo7/XBYHhWykf
        iFUJMPfVe86e9zWTyISHypAmhMVH9vhuaMhyzRTX89bgW/XEU93BaJ2AW2Jojhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Qj9OWa
        JnUx/eaYlLP73TurCtb3aRXptvmrq/ZJ+XdRh2e4BvbBt8jAzgEEw16246b3xObw
        SbWsleWTB1yyUkdDnT9NSc3C8xLL/74Rt0l09LUcOR/2upNmfFe2AzxVVWiuDRCa
        /klDVrlJ417pTM92nWKV7sOv51RM9WE0aroEE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0760FCB5DC;
        Thu, 28 Dec 2017 15:32:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81B10CB5DB;
        Thu, 28 Dec 2017 15:32:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 0/9] revision: get rid of the flag leak_pending
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
        <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
Date:   Thu, 28 Dec 2017 12:32:33 -0800
In-Reply-To: <ac4c77a1-6403-ca20-2021-50c99201915a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 25 Dec 2017 18:41:18 +0100")
Message-ID: <xmqqd12yk2zi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3C6BA4F2-EC0E-11E7-A628-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The flag leak_pending is weird, let's get rid of it.
>
> Changes from v1: Everything.

;-)

> An independent optimization found while working on this series:
>
>   commit: avoid allocation in clear_commit_marks_many()
>
> Trivial unrelated conversions (included as bonus patches):
>
>   commit: use clear_commit_marks_many() in remove_redundant()
>   ref-filter: use clear_commit_marks_many() in do_merge_filter()
>
> A new function is introduced, will be used by checkout:
>
>   object: add clear_commit_marks_all()
>
> The users of leak_pending are are converted to use alternatives:
>
>   bisect: avoid using the rev_info flag leak_pending
>   bundle: avoid using the rev_info flag leak_pending
>   checkout: avoid using the rev_info flag leak_pending
>
> Cleanups:
>
>   revision: remove the unused flag leak_pending
>   commit: remove unused function clear_commit_marks_for_object_array()

Will take a look at.  Thanks.

>
>  bisect.c           | 30 +++++++++---------------------
>  builtin/checkout.c | 13 +------------
>  bundle.c           | 35 ++++++++++++++++-------------------
>  commit.c           | 19 ++-----------------
>  commit.h           |  1 -
>  object.c           | 11 +++++++++++
>  object.h           |  5 +++++
>  ref-filter.c       |  3 +--
>  revision.c         |  3 +--
>  revision.h         | 12 ------------
>  10 files changed, 46 insertions(+), 86 deletions(-)
