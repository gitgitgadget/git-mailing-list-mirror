Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F62C433EF
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 20:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244082AbhKXU6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 15:58:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56414 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243359AbhKXU63 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 15:58:29 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 17912FAD51;
        Wed, 24 Nov 2021 15:55:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fe9vlHy7h82jcqw/MVZW2YQkcQUPZN/fME9Fsd
        4v9zU=; b=jyMm9IDMzceIR7UqKEMjsLsFJZOhpafSxsMlI38Czbhzq4dEgk4kig
        MdMrpVL7eFgVU1C5DfbLDy61w2KhgHC0bLn50K3Aqw+ySqXEJquEOzg/o0AA+0nN
        90Vi84y51wceWNhgPE1FduyFiFQsK3x+aKjY9NE8XPNCGZ3wVnNCE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D39CFAD4F;
        Wed, 24 Nov 2021 15:55:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 652EBFAD4C;
        Wed, 24 Nov 2021 15:55:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 2/4] refs: trim newline from reflog message
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
        <xmqq35nnddw7.fsf@gitster.g>
        <CAFQ2z_PE7TMj=qfQVroK_gRfZk-xF9PKhk2yxqF-bB+2aA7eoQ@mail.gmail.com>
        <xmqqczmqajdk.fsf@gitster.g>
        <CAFQ2z_Mct+KBZ3vO6udwqeiHYA8od8CGH_w5BO5LaidP-AYDsg@mail.gmail.com>
        <xmqqzgpu7grv.fsf@gitster.g>
        <CAFQ2z_Mb+NzQfXfMhdQoPs09p2j1AWRAdXcX3JSznn+H9+T0Bw@mail.gmail.com>
        <xmqqpmqp2xmz.fsf@gitster.g>
        <CAFQ2z_PqgwYy+RxQm7d7WDQYvQQ2vVE0cXHdDKNwQJm3Xc+NFw@mail.gmail.com>
Date:   Wed, 24 Nov 2021 12:55:16 -0800
In-Reply-To: <CAFQ2z_PqgwYy+RxQm7d7WDQYvQQ2vVE0cXHdDKNwQJm3Xc+NFw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 24 Nov 2021 20:06:14 +0100")
Message-ID: <xmqqtug1z32j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D43CBFC2-4D68-11EC-A837-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> Ah, perhaps our confusion comes from the fact that I view the ref
>> API as a whole and do not draw a fine line of distinction between
>> the "ref API implementation common across backends" vs "what ref
>> files backend does".  But as the implementor of one backend, you
>> obviously have to care.
>
> Having the read function return something different than what the
> write gets still seems odd to me.
> How about having copy_reflog_msg() trim trailing space and then always add LF?
>
> The files backend can assert that the string ends in LF, and doesn't
> need to add LF itself.

Ehh, let's step back a bit.

Is there anything in the common part and files backend in ref API
that needs to be changed to fix some bug?  I do not see anything
broken that needs to be fixed by "assert that the string ends in LF
and doesn't need to add LF itself" or by "always add LF".
