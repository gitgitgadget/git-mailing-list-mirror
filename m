Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5321DC433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 18:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbiBAS7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 13:59:03 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53856 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242188AbiBAS7B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 13:59:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9DB2F1740C0;
        Tue,  1 Feb 2022 13:59:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OI8ttV+2B6qC
        YEsXPuZ7xXyDGAhHQUD6TE2uUK3vuys=; b=x8QB6DOsAU0IwU7i3iFFXmDdDnAx
        QHPC0kHXUOZisNU30e5Fcqb/7pW6qurvP5GfCrDu8uAvCKhrJuovLWgWaKb+Mwz+
        l0hSRnZ7reLYugBqDLJkNZldGfrKfczOtZAaL3QMtxlKxMQ7kcMohT45z3yab3VM
        gYg7hYU2aw1TeJM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 94C0F1740BF;
        Tue,  1 Feb 2022 13:59:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0DC0E1740BE;
        Tue,  1 Feb 2022 13:58:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 04/10] object-file API: have write_object_file() take
 "enum object_type"
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
        <patch-04.10-d6231ac68fe-20220201T144803Z-avarab@gmail.com>
Date:   Tue, 01 Feb 2022 10:58:56 -0800
In-Reply-To: <patch-04.10-d6231ac68fe-20220201T144803Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 1 Feb
 2022 15:53:06
        +0100")
Message-ID: <xmqqczk6e7m7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 02B748FA-8391-11EC-A245-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the write_object_file() function to take an "enum object_type"
> instead of a "const char *type". Its callers either passed
> {commit,tree,blob,tag}_type and can pass the corresponding OBJ_* type
> instead, or were hardcoding strings like "blob".
>
> This avoids the back & forth fragility where the callers of
> write_object_file() would have the enum type, and convert it
> themselves via type_name(). We do have to now do that conversion
> ourselves before calling write_object_file_prepare(), but those
> codepaths will be similarly adjusted in subsequent commits.

Up to this point, the series makes sense to me (I didn't check for
calls that were left uncoverted by mistake, or new callers that were
added on other topics---the compiler should flag them all).


