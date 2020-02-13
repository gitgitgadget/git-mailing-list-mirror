Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB51C3B18C
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 16:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391C420656
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 16:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dgQGyAux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgBMQIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:08:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65340 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387411AbgBMQIS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 11:08:18 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 076A63D4BC;
        Thu, 13 Feb 2020 11:08:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ymzo0jqztu2W
        bAqI8zKSS3sY2go=; b=dgQGyAuxxu2z0aiH8TtVFDcZsVaDFzAhUcGpm0v1DXRY
        CL9LbWSECAF5t58UKF+rEVWmmLhATcQU4bMn/RImvAO9BL4s9Fh8zWhqQjCjq1aG
        zK9i9x4VegoJCTVDEgcShlLxxky8Vi1PQKiw3JoUKKucn5Rd3jirKzPi01VeQiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=upJ7iO
        ErAgCJm7v7ctxZU8QzGkPOWfTKWLv48U7M0o94N4xNWqG9apRZoKg5+1CqpZ+icn
        z528f1qUKTKDJ/0fZpP1W9X9mFPexuUsoNfH7nILff611kVaMz/9GqodLTQPnSn6
        shrEZVPR+2/MYmebaQE/SsjP5fu6FhuOHLum0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EA1563D4BB;
        Thu, 13 Feb 2020 11:08:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4BA3A3D4B9;
        Thu, 13 Feb 2020 11:08:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com, martin.agren@gmail.com
Subject: Re: [PATCH v3 3/3] builtin/commit-graph.c: support '--input=none'
References: <cover.1580430057.git.me@ttaylorr.com>
        <cover.1581486293.git.me@ttaylorr.com>
        <4e85c6f7e40e7d6a8d93574645d65971b7cfa4f8.1581486293.git.me@ttaylorr.com>
        <20200213123129.GQ10482@szeder.dev>
Date:   Thu, 13 Feb 2020 08:08:15 -0800
In-Reply-To: <20200213123129.GQ10482@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Thu, 13 Feb 2020 13:31:29 +0100")
Message-ID: <xmqqzhdmsc5s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0B275856-4E7B-11EA-97E3-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Tue, Feb 11, 2020 at 09:47:57PM -0800, Taylor Blau wrote:
>> In the previous commit, we introduced '--split=3D<no-merge|merge-all>'=
,
>> and alluded to the fact that '--split=3Dmerge-all' would be useful for
>> callers who wish to always trigger a merge of an incremental chain.
>>=20
>> There is a problem with the above approach, which is that there is no
>> way to specify to the commit-graph builtin that a caller only wants to
>> include commits already in the graph.
>
> I'd like clarification on a detail here.  Is it only about not adding
> any new commits, or about keeping all existing commits as well?  IOW,
> do you want to:
>
>   - include only commits already existing in the commit-graph, without
>     adding any new commits, but remove any commits that do not exist
>     in the object database anymore.
>
> or:
>
>   - include _all_ commits already existing in the commit-graph, even
>     those that don't exist anymore in the object database, without
>     adding any new commits.

FWIW, I read it as the former, but now you brought it up, it can be
read either way.

Thanks for good review comments, as always.
