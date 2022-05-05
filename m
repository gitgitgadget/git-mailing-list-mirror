Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D02C433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 19:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377833AbiEETnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 15:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbiEETnY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 15:43:24 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6425D5F6
        for <git@vger.kernel.org>; Thu,  5 May 2022 12:39:43 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAB8C128257;
        Thu,  5 May 2022 15:39:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BfJnxXmTtip/O+IVFCMeelDCY1waRL2E2OWD5q
        XCGT0=; b=XtLs3A2pYBSA2kcM5g+lyAv1JfaCNOcJAwJuAmMK0vUOq9KpacAJmM
        FxXUU14UD/TehrwBTzhiB0SG1X31sXvidl0gnGQs2eJDmK7NOUyqTuMi9KhYfK17
        ReWuRpVuGCJWyyDT2EJQWAv+uAOIDRaI6oO3FAxpevS/iiQ/C/fgo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B1A0F128256;
        Thu,  5 May 2022 15:39:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DB65128255;
        Thu,  5 May 2022 15:39:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
References: <20220428105852.94449-1-carenas@gmail.com>
        <20220503065442.95699-1-carenas@gmail.com>
        <20220503065442.95699-2-carenas@gmail.com>
        <nycvar.QRO.7.76.6.2205051439290.355@tvgsbejvaqbjf.bet>
        <xmqqlevfesnu.fsf@gitster.g>
Date:   Thu, 05 May 2022 12:39:40 -0700
In-Reply-To: <xmqqlevfesnu.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        05 May 2022 11:33:09 -0700")
Message-ID: <xmqqczgrdb0j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BE93230-CCAB-11EC-9934-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I like the GIT_TEST_ASSUME_DIFFERENT_OWNER because it is fairly
> clear that it cannot be used as a new attack vector, even with
> social engineering.
>
> It would be nice if we can do something similar, but I am coming up
> empty while trying to think of "we are testing; pretend that ..."
> that is good for testing this SUDO_UID special case *and* clearly
> cannot be used as an attack target.
>
> So I very much like the suggestion in principle, but I am not sure
> how useful the suggestion would be to make the resulting code better
> in practice.
> ...

The worst part is that the SUDO_UID stuff is about _loosening_ the
protection the other parts of the mechanism implements.  We do not
allow access when euid does not match st_uid, but with SUDO_UID, we
instead use that for checking when euid is root.  So setting for
testing such a feature works to loosen the protection, which would
make the attack surface larger.  So I am not so optimistic that we
can invent a GIT_TEST_* knob as good as ASSUME_DIFFERENT_OWNER for
that.

Thanks.
