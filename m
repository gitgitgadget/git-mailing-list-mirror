Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5EEC433E3
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 16:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4C220724
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 16:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h3GQxrMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgHUQfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:35:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59337 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgHUQfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 12:35:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9945184FD1;
        Fri, 21 Aug 2020 12:35:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KR5I3MQCnZi4L2/BLFyPwWkJxUk=; b=h3GQxr
        MuR8nqkyvNYpQaco/XvPsp/POFgUfnjSQqL+9j9aa98Mgl73yQLR6TDKYKfJV5/b
        69AZ2eSmDpKDEPUVCvA1qKGciH5zP0x8y85qr++Qa0TIA0acs+2N068eB8B64akM
        9XxQSJsr3bImb+QhRv8yYfD6VGosBBE2RQpe8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MYiOxGcUh1Tpl4KR4IXqiaSh27S20cRM
        gsmwiWPQoWKaXrzYf1ZGG8fpy0Lb32btPKgtLbzcV3ce6Q3y39ann1xg/QmJkWtQ
        ZNFhrYAUGq8DFmuNiXBwgw2ZeDW+rNiyDV9lloEHb7DEIp6mZsWqBtxD+YlQniaO
        exG3kV70GVc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EAA584FCF;
        Fri, 21 Aug 2020 12:35:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5AB6C84FCE;
        Fri, 21 Aug 2020 12:35:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>,
        christian.couder@gmail.com, git@vger.kernel.org,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v3 4/4] submodule: port submodule subcommand 'summary' from shell to C
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
        <20200812194404.17028-1-shouryashukla.oo@gmail.com>
        <20200812194404.17028-5-shouryashukla.oo@gmail.com>
        <nycvar.QRO.7.76.6.2008211708280.56@tvgsbejvaqbjf.bet>
Date:   Fri, 21 Aug 2020 09:35:07 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2008211708280.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 21 Aug 2020 17:17:42 +0200 (CEST)")
Message-ID: <xmqqimdc9cuc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46867512-E3CC-11EA-92FD-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Sadly, this breaks on Windows: on Linux (and before this patch, also on
> Windows), the error message reads somewhat like this:
>
> 	fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or directory
>
> However, with the built-in `git submodule summary`, on Windows the error
> message reads like this:
>
> 	error: cannot spawn git: No such file or directory

I think a test that relies on platform-specific error string is a
bug.  It's like expecting an exact string out of strerror(), which
we had to fix a few times.

So I am not sure we would want to butcher compat/mingw.c only to
match such an expectation by a (buggy) test.

