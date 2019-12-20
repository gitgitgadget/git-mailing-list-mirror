Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE85C43603
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDDC20866
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 22:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cD2jHoBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLTWe4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:34:56 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53636 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfLTWez (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 17:34:55 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D3CD4A2313;
        Fri, 20 Dec 2019 17:34:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rnOw1eTr7ct+3ZyZ7QP7sn1vXmQ=; b=cD2jHo
        BiM77z3bbcbovalcdXOXN8B5nLL/ARRHlHlQCLzf1KRa3kZhYfhwfePFoIFa5JPn
        HDasJD0fVbWlyO2iE5zMGp3fVxaUYH7IpXUsUPH4EclJWLj3+6l7oTV6skPa1qHV
        lCsdD9WqnGfIZHPZ2JCtOWD/Azgsxe1mNCwnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XwRgDQJbxNRItZ161Tb/6rXQJm/a6oJE
        VA+ndbQxB1ZL5CReF1zKYmgHUdCHN/Pf5rc/vMnb0sJaV+t47UNiQd33oSp2iDOy
        KolMRr9hTj4jPhI02z5ZgyRuOkgSrsgRKbeWjguKGi/bIEFUMI46Kc9nBlStBJpN
        VKwooekPDxI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CAFF7A2312;
        Fri, 20 Dec 2019 17:34:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EBA3CA2311;
        Fri, 20 Dec 2019 17:34:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pavel Roskin <plroskin@gmail.com>
Subject: Re: [PATCH 1/2] am: pay attention to user-defined context size
References: <pull.680.git.git.1576868036.gitgitgadget@gmail.com>
        <e1870f3fee8be6ebbecdd618ae1803afb878e67e.1576868036.git.gitgitgadget@gmail.com>
        <xmqqwoaq94ql.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFYyF5RbZVuwo8LtDZZQ9KQ2od4FQqQYaeSqNCNKcZXPw@mail.gmail.com>
        <CABPp-BGvh-NvooVE-K-WYpv9RAs4BZ_d0=Mv=b5iEoGbNt5amA@mail.gmail.com>
Date:   Fri, 20 Dec 2019 14:34:47 -0800
In-Reply-To: <CABPp-BGvh-NvooVE-K-WYpv9RAs4BZ_d0=Mv=b5iEoGbNt5amA@mail.gmail.com>
        (Elijah Newren's message of "Fri, 20 Dec 2019 14:22:55 -0800")
Message-ID: <xmqq1rsy8w3c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF861632-2378-11EA-81AD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> diff.context should NOT affect plumbing.  So if it's not plumbing by
> that test, and it's not *UI* as per what you say, what exactly is it?

I actually was saying that diff.context is UI thing, and should make
no effect on how "am" interprets its input.

Which the codepath in "am" are you trying to affect?  "am" is mainly
a consumer of "diff" output, and not a producer, so ...



