Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B7B31F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 23:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfJEXlq (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 19:41:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55614 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfJEXlq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 19:41:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 85B53820F4;
        Sat,  5 Oct 2019 19:41:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ln+BgE85ifYE
        A99f9PgqR6XT8Kg=; b=ZWA+nG5nBuKls+2Ha/VK3R9mlEqwbAIZKBhWB4YE0c3L
        iQVrWd+6Mp4C49VVoZ3TxLL58mFctLyvcF53tai8wVb87LandMnPPKPM+LPNleIH
        kZNTqk1uoannKTLPT/OWdR9cbnPGPUovW7fezNSUKhqHnziFj5tH8TbxkppbFts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=FwSn0E
        APB9tVvb+AuvxTqt0XhdTeqWN+tiOffyv7W95L5rQEX3XUtNMXZ8xM9GK2fRGZde
        9B3whAMXp1aeerBnVGtKdQdK9FJGlTR6iSikpgz6TfGKnI3XOYKvVDAjq47mNzdf
        8xHVVwpbVQgT1sUjUCUqnozp3Tp+fK06S5nR4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E547820F3;
        Sat,  5 Oct 2019 19:41:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD2E6820F2;
        Sat,  5 Oct 2019 19:41:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: PATCH] remove duplicate #include directives
References: <1133ae3b-81e8-4ec1-c2d7-d071e7e65ec1@web.de>
        <xmqqh84pa0ah.fsf@gitster-ct.c.googlers.com>
        <59f7fafc-818e-1996-4e1a-5697bd4880e0@web.de>
Date:   Sun, 06 Oct 2019 08:41:39 +0900
In-Reply-To: <59f7fafc-818e-1996-4e1a-5697bd4880e0@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 5 Oct 2019 18:18:42 +0200")
Message-ID: <xmqqv9t269qk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AEB83A12-E7C9-11E9-9DAF-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> It works best for changes whose effects are constrained to within the
> affected functions, but have crucial information located outside the
> three default lines of context.  An example would be a change at the en=
d
> of a function for which a reviewer might need to know the type of some
> variables declared at the top.

Yup.

>> If there were topics in flight that touch any of these include
>> blocks, the patch would not apply and a reviewer who is interested
>> in these fixes ends up needing to wiggle them in somehow.
>
> Instructing git am or apply to ignore extra context lines using -C3
> or similar would help in such a case.

It may, but that is still extra work ;-)

> This one here requires one more piece of information, though, namely ou=
r
> convention of wrapping header files in guard defines to make repeated
> includes of them no-ops.  We do that for those removed by the patch, bu=
t
> we have a few exceptions to that rule in our repo (at least
> command-list.h, kwset.h, sha1dc_git.h, tar.h, unicode-width.h).  So in
> that sense it's not such a good example of a self-sufficient patch. :)

Not really.  "We use header guards" is an argument that demotes this
cleanup from "must have" to "nice to have".  If a project did not
use header guards or including the same header twice were an error,
the patch in question would have been more necessary, but that
wouldn't have changed the correctness of the patch, I think.
