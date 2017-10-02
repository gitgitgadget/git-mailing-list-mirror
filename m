Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35C30202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 03:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbdJBDkp (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 23:40:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50137 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750969AbdJBDko (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 23:40:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E2BDFA3111;
        Sun,  1 Oct 2017 23:40:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=jZA2CzzMZYrp
        AneHaYJSlwqWmEQ=; b=eC7nOdKrWSWvTAYwYZ0t1u9etj0VroGOiUsnE38fjMPH
        sKSVe32Sj0nxaDmDnwRvHRy1Si7zZilujGw0hsg555w8AGzb3JUTIeA9hg/XEQBj
        iUDP8zmUt8xAKhzxSqyRMZ5xWkRrOSXDDkU1JXXUe4Zs+p7kDpJlXt6VERjTU8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=M4s8Qi
        DwCWYn9xh75LrJq2eO+vGllmqhvQkKQ6Z+hmhyK11WOUqYz2wsBsKNeq48L93fR0
        IQVHDZoS6HsFgBssCV+NmaE/U53477GROO6/mBXLJYNikczab8OUVx/wICxC3/MM
        6TzQWKjnSlz8VexDmF4TO2E+IIK8H7flNkTNQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAB16A3110;
        Sun,  1 Oct 2017 23:40:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 04139A310F;
        Sun,  1 Oct 2017 23:40:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 05/11] cache-tree: simplify locking logic
References: <cover.1506862824.git.martin.agren@gmail.com>
        <3475f0eee33ca0c4b2bc928191f0b06576ee29fb.1506862824.git.martin.agren@gmail.com>
Date:   Mon, 02 Oct 2017 12:40:41 +0900
In-Reply-To: <3475f0eee33ca0c4b2bc928191f0b06576ee29fb.1506862824.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sun, 1 Oct 2017 16:56:06
 +0200")
Message-ID: <xmqqh8viqksm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 77996ED6-A723-11E7-82B1-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> After we have taken the lock using `LOCK_DIE_ON_ERROR`, we know that
> `newfd` is non-negative. So when we check for exactly that property
> before calling `write_locked_index()`, the outcome is guaranteed.
>
> If we write and commit successfully, we set `newfd =3D -1`, so that we =
can
> later avoid calling `rollback_lock_file` on an already-committed lock.
> But we might just as well unconditionally call `rollback_lock_file()` -=
-
> it will be a no-op if we have already committed.
>
> All in all, we use `newfd` as a bool and the only benefit we get from i=
t
> is that we can avoid calling a no-op. Remove `newfd` so that we have on=
e
> variable less to reason about.

Nicely explained.  Makes sense.

Thanks.
