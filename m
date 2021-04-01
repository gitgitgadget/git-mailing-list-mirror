Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00267C433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 20:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC1F1610E9
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 20:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbhDAUlu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 16:41:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59463 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbhDAUlt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 16:41:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 839AFB1E58;
        Thu,  1 Apr 2021 16:41:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=47XZ9pudXwyd
        ymVU5479Bl4Q0pU=; b=Y+JhPvzJP+xbsPgdmrJ/yhDdfmjrgoqqp6fge/2eLdRx
        vr+lZ5BeNYiZYgF26usNYbOKtJo/ZKp+s7uja2pVBJm8TRBB/IJOz1o70GpndrEh
        n6zc4sdCRiRyubfMtYDSQV2kDdH4hSO0GWRLW82d7D7dChA5L0OQ8OY4WnEgqh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=MMQRke
        SxMxpNUWTAy6es2NS+zNvN1+OiizysoNUopnoha3VeX67nRHllXwitcBI/m4NOzL
        VE6uimtvUdTPIaRaBsfzKYm1hLd2Oy1E66sfkHkLVoYRKF1+P9mroPeDTMBHblmJ
        ylk56HLkyVvOXqiGQWRsVVhFh9ocbvCIKJ3gI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A3F5B1E57;
        Thu,  1 Apr 2021 16:41:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0B139B1E56;
        Thu,  1 Apr 2021 16:41:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 16/18] tree-walk.h API: add a get_tree_entry_path()
 function
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
        <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
        <patch-16.19-3ba77fd3a47-20210331T190531Z-avarab@gmail.com>
Date:   Thu, 01 Apr 2021 13:41:48 -0700
In-Reply-To: <patch-16.19-3ba77fd3a47-20210331T190531Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 31 Mar
 2021 21:09:44
        +0200")
Message-ID: <xmqqzgyh20vn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AE821488-932A-11EB-AFBB-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -		if (get_tree_entry_mode(r, hash2, del_prefix, shifted, &mode))
> +		if (get_tree_entry_path(r, hash2, del_prefix, shifted))
>  			die("cannot find path %s in tree %s",
>  			    del_prefix, oid_to_hex(hash2));

The observation that many "get_tree_entry()" users do not need the
mode bits and the code can be simplified by taking advantage of
that fact is good.

It does not automatically follow that it is a good implementation of
that simplification to introduce a variant that does not take the
mode pointer.  The original function could have just been taught to
accept NULL in the field the caller is not interested in, as in many
other functions do.

Besides, get_tree_entry_mode() vs get_tree_entry_path() does not
make any sense as pair of functions with contrasting names.  If it
were that unlike the former that returns mode, the latter returns
path instead, it would have made sense, but that is not what is
going on.  The former returns object name and mode, the latter only
returns object name without mode.

In any case, at this point in the series, it is highly dubious that
an extra function is an improvement.  Teaching get_tree_entry() (do
not even rename it) to take NULL in *mode pointer would make a lot
more sense.
