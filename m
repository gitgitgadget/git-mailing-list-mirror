Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D852DC43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 15:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6452388B
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 15:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iNdIi1vB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIRP2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 11:28:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51399 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIRP2x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 11:28:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2097570DE8;
        Fri, 18 Sep 2020 11:28:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7s16j+bu7u9h4Bi6NlvAufuYBJ4=; b=iNdIi1
        vBQVXMqpXByVA0/f6RPRUhL0ZMaEFGTOp1/vCnURKO2U4IplhKwfzZlwX0o7EzfF
        3Vno3R5KSf5kMnvx4wfINTe2SAgWp7kvMDo0rZor5kkCBkL8b4HK+L0Ei0LBAvnO
        C52WsHu5w4qNH2mES+4/WSP/IBesTkZybIlZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kPCKeVokSi4Q6xGY41V/Ls2a/k0n1Kzp
        px/pIiJmMmK1PF6pCz30ZDGQAL2ubBYBceclb5xk+4py4gNbPeERVI8XVyHw0O6G
        05SfgR9nPmIIjM0IEd6ocmovyBtKCPYCl9cKatMxDQ35cvcH7llHUA6cnvu8cdJR
        6pba2dCi5xk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18E6670DE6;
        Fri, 18 Sep 2020 11:28:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F173D70DE5;
        Fri, 18 Sep 2020 11:28:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: ignore generated files
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com>
        <xmqqtuvwoyz5.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet>
Date:   Fri, 18 Sep 2020 08:28:48 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Fri, 18 Sep 2020 15:11:11 +0200
        (CEST)")
Message-ID: <xmqqft7fnlxr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6C4F590-F9C3-11EA-B9DF-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Good to catch these cruft.
>>
>> Does the equivalent of "make distclean" need to be updated to clean
>> them as well, or is it sufficient to ignore the build procedure and
>> just rely on "git clean -f -x"?
>
> Since CMake in conjunction with Visual Studio completely side-steps
> `make`, I think it would make most sense to ignore `make distclean` in
> this context and go for `git clean -dfx` instead.

I think you misunderstood the question, overlooking the "equivalent"
part.

I expected that when CMake & VS discards build artifacts, it would
not make literal use of "make distclean".  After all, it does not
use "make all" to build, either.

That led me to suspect that CMake & VS may have a build target that
is used to discard build artifacts, the moral equivalent to "make
distclean".  That is where my question "if we are making .gitignore
aware of more crufts, don't we need to tell the machinery, which is
equivalent to 'make disclean', came from.

What I am hearing here is that people with CMake & VS use "git clean
-dfx" when they want to go back to the pristine state, unlike those
who use "make distclean", and there is nothing to adjust for newly
discovered crufts we are leaving on the filesystem.  

If that is the case, it is 100% fine.  It was that I just didn't
expect not having a "remove cruft" rule in the build procedure.

Thanks.

