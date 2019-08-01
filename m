Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB2831F731
	for <e@80x24.org>; Thu,  1 Aug 2019 15:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732407AbfHAP4W (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 11:56:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50770 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbfHAP4V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 11:56:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4FA914F896;
        Thu,  1 Aug 2019 11:56:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=obIM0vXGdLxe
        mWFJU/Lj6sFQNrk=; b=XbuOc69GYUF0rpx0ijIE4p5y3gLDSwyxAJGhzFWhe6Y7
        kUaBfStkQmixm/RUsCl8cJp6vSH7pIYhfwEHz5fTwoUxeGixshGDrEcV2G7mZSNa
        eG1u+1Ar5LjbfmOGucjUJkfR2opBD7/uBk5R/UUyTIT4U2QVhc4kmOH1Cwlp+IU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qD8Amd
        55f77/TdOs79Xgv5wNePRc12/aiKYn8fRBN0v4CVnDZ5CFaJw1rz6w8XmwYjt27J
        yIlBZ/OvGLYpkUnexVvW3KLh/giGWcWdLXzqUgUKRm8WYYXNOTJtOKDdiwyWV+2C
        84Ni0UOXTONZXw/hWBn2EPrttPjLdc3sP2IJY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA6BD14F894;
        Thu,  1 Aug 2019 11:56:19 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 098D814F893;
        Thu,  1 Aug 2019 11:56:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        git@vger.kernel.org
Subject: Re: Support for --stdin-paths in commit, add, etc
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
        <066cfd61-9700-e154-042f-fc9cffbd6346@web.de>
Date:   Thu, 01 Aug 2019 08:56:17 -0700
In-Reply-To: <066cfd61-9700-e154-042f-fc9cffbd6346@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 1 Aug 2019 16:26:23 +0200")
Message-ID: <xmqqef24op5q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E6A9441C-B474-11E9-9978-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Would it make sense to have a --paths-file parameter instead that allow=
s
> reading paths from a given file and honors the convention of reading
> from stdin with the special argument "-"?  Reading from stdin would
> still only work for one parameter at a time, but paths could also be
> passed via a regular file or named pipe, allowing for more flexibility.

The command's primary function itself may want to use the standard
input stream to read things other than the list of paths; if we are
not limiting ourselves to plumbing (i.e. doing one thing well), the
"--stdin-paths" may not be a general solution that is good enough.

So, reading paths from a file (which could be "-" as you suggest)
would be a good solution for that.

