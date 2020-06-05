Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7DBC433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 22:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5CBD2065C
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 22:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JDOTFOdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgFEWx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:53:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58570 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbgFEWx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 18:53:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CBC8AD91EE;
        Fri,  5 Jun 2020 18:53:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AE+y7iw9kqNR88eMSgS35FupAw8=; b=JDOTFO
        dYui0xTfjeHu5vJ0X6sokDjbpW9eMhRtZGvc/67/pVmStrXgA+3zU6Npo+eQ3J/d
        dYM/vlZoohymdTVWsjE0BXM6Z4ux9Z74zqoNIgUliiSWyFrm2M0LtAPx0l2eMUou
        +etHp2nD1S7hRj/uNpxoEAv/mxw8HOm54limE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gwE2tRfW7Nvtp+SjQf0lQJT5tt+pGKSZ
        VO9wzT58QTEFjicGUR4/IekbQkTFXdrVB4dd493pHB9jYGcGkIjPXKxngS6V2HVv
        iTnUdU0vKrJiIzJW/bGqsDJM44Tb+oDjrtrIj3G+CnQ55Rb5T7utB+iNBfJS5zU0
        bBCIoE6lDug=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B7E86D91ED;
        Fri,  5 Jun 2020 18:53:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F187FD91EC;
        Fri,  5 Jun 2020 18:53:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 20/24] fast-import: permit reading multiple marks files
References: <20200222201749.937983-1-sandals@crustytoothpaste.net>
        <20200222201749.937983-21-sandals@crustytoothpaste.net>
        <xmqqimg5o5fq.fsf@gitster.c.googlers.com>
        <xmqqeeqto4x1.fsf@gitster.c.googlers.com>
        <20200605223910.GE6569@camp.crustytoothpaste.net>
Date:   Fri, 05 Jun 2020 15:53:50 -0700
In-Reply-To: <20200605223910.GE6569@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 5 Jun 2020 22:39:10 +0000")
Message-ID: <xmqqlfl1m8e9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D064EE4-A77F-11EA-A540-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We don't actually hit this case in any of the tests because we don't
> have any tests that have 1024 marks in them.  I'm having trouble coming
> up with a test even with a large number of marks because I don't think
> we produce different behavior here; we just leak a lot of memory.
>
> This does fix the reported issue, as I suspected.
>
> Do you want to write this up into a patch with a commit message, or
> should I?  If the latter, may I have your sign-off for it?

Sure, anything I write for this project you can assume to be signed
off by me.  As I was just "fixing" what I thought was a botched
conversion, without really figuring out where it actually leads to
leaks, I'd need further work if I were to wrap it up with a sensible
log message, so thanks for volunteering ;-)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
