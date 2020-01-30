Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1D6C33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 04:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F13206D5
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 04:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uWW6e2n1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgA3EUC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 23:20:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50140 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgA3EUC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 23:20:02 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D45DF45136;
        Wed, 29 Jan 2020 23:19:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+zst32duzRIcZ0DtfvwRH8lO8DQ=; b=uWW6e2
        n1lNpREgeFXgigyNYw9xA8D9nHoulsALRBCia7J1YwXNSrYqdzxr72cehp6NPey4
        l9R9T/XOfIwOZnuDrsBHnsC6nnekf0koWCaEZD/H3N2a6fxCOratpc31qrF62I7y
        kon7pt5eYqdZwil2BFgYWfIOtvFaXFNS85dIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DlPdCVn+dV2rksTpJb1ga+OvKoJA43A2
        5rHWLy6KS7U1en3ukeVJ80SDWZAzuSlCr64i7MlskAxxC8WwsGDD4jaPPvb3KrXd
        rC1rHH2CX5ZZUs4ZcHxX6b9/9HmPkHG1Q90XOgxCGEXlpLXOAalO6knDTbn0vX1m
        a4b+0XdjdNE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB20B45135;
        Wed, 29 Jan 2020 23:19:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3EE0345132;
        Wed, 29 Jan 2020 23:19:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 2/5] create .git/refs in files-backend.c
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
        <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
        <d7d642dcf6f3c661c51302d02c69e781e201cc6e.1580134944.git.gitgitgadget@gmail.com>
        <xmqqr1zka616.fsf@gitster-ct.c.googlers.com>
        <CAFQ2z_PY3y4sL=W6Q3EKkB5Vc4PjfeaL0HyybfPUVA0AKxm1=A@mail.gmail.com>
Date:   Wed, 29 Jan 2020 20:19:58 -0800
In-Reply-To: <CAFQ2z_PY3y4sL=W6Q3EKkB5Vc4PjfeaL0HyybfPUVA0AKxm1=A@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 28 Jan 2020 16:58:05 +0100")
Message-ID: <xmqq7e19eftd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7268F6E-4317-11EA-B8F5-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> > +     files_ref_path(refs, &sb, "refs");
>> > +     safe_create_dir(sb.buf, 1);
>> > +     // XXX adjust_shared_perm ?
>
> I forgot why I put the XXX, but note that safe_create_dirs runs
> adjust_shared_perms implicitly.

That piece of information would make an excellent part of the log
message, which is to describe why "questionable" changes are made.

"git init" is designed to be runnable in an existing repository, but
safe_create_dir() would not run adjust_shared_perm() when mkdir()
says EEXIST, and I think that is why the original makes a call to
adjust_shared_perm() after safe_create_dir() returns.

Thanks.


