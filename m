Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BF6C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FFAC238D7
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 19:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgLGTcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 14:32:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64586 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgLGTce (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 14:32:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CA75ADD29;
        Mon,  7 Dec 2020 14:31:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3iqMURgjGhd6DogN3hObV+87s8g=; b=cLRSug
        imeS/CPpfQpz5OBQZsc9Jlo82lUKLuQJLuCZ+Zqko940kTKmPJfKUM6xbmTktm9e
        IYAOcYrbpkpIwCrpMkW3JOolLAhEDuVzwt2+RMvKtxTOZFMA2OFJfA2WJ99Bfiw/
        FhKDQ7iCDlTyK03cs+VnSK0e+v/HSBe/hsm/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SOsmp9VHLlEZVFil2PDYxLUB1kyo1rnd
        A7ODHRkK/yEZPM3GHke9Gj/OCZ1HRdPemRg/LamtVYr1BqxHdCKE2Y+mYJnD35xp
        v+0LqyOHeKpnwgcO6Sm5i6Hg9p00kQP8bf5teRbEUuIIuoymi/0rErqwpI2R5KAE
        os1ZtmuycfU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 347F5ADD28;
        Mon,  7 Dec 2020 14:31:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1F1AADD27;
        Mon,  7 Dec 2020 14:31:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH] init-db: init the_repository->hash_algo early from
 GIT_DEFAULT_HASH
References: <pull.924.git.git.1606419582190.gitgitgadget@gmail.com>
        <xmqq5z5mruia.fsf@gitster.c.googlers.com>
        <CAFQ2z_M3OO_nR6dhw6zzE0orYxcawP1DaJ_EOL5=+RUiZgCo8w@mail.gmail.com>
        <xmqqtut2fp5z.fsf@gitster.c.googlers.com>
        <CAFQ2z_OsyseuPWxpj9S4R_Pp_Koa0JuJeO2gte+TLxDh+oHPNg@mail.gmail.com>
Date:   Mon, 07 Dec 2020 11:31:51 -0800
In-Reply-To: <CAFQ2z_OsyseuPWxpj9S4R_Pp_Koa0JuJeO2gte+TLxDh+oHPNg@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 7 Dec 2020 12:52:11 +0100")
Message-ID: <xmqqy2i99zvc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB3587AC-38C2-11EB-A4CA-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> You said earlier that maybe ref_store should hold a link to 'struct
> repository'. However, "struct repository" doesn't have a documented
> purpose (there is literally no comment documenting its purpose), so
> it's hard to tell upfront how to correctly configure the relation
> between "struct ref_store" and "struct repository".

Folks, who have been pushing to recurse into submodules in-process,
does any of you care to help out?

In order to deal with separate repositories inside a process,
instead of allowing many API functions to assume that they only have
to work in the repository "git" started in, you need to be able to
make them to work on a different repository, which would have
different configuration files, with working tree locations that are
different from that of the initial repository, and certainly would
have different set of refs, etc., and the way to do so is by passing
an instance of the repository structure.  To the API functions that
have been converted to take such an instance, working in the
repository "git" started in is done by working with the_repository
instance.


