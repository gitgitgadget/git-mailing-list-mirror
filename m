Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FB2C432C3
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14762075C
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 01:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yMsg8LFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKZBMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 20:12:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56471 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfKZBMe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 20:12:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88E3835267;
        Mon, 25 Nov 2019 20:12:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HiRT8uioMx6iIVqyk6xa14sJURI=; b=yMsg8L
        FGeQJ2KePkZfKVXBelsN9Qvocuzq2NH4SkgbE7F5fadrGoA0jKY7IjEpTW70btZm
        IJsXBPQw7Lm8vR0UR8TQtsBqPdxw2gGzC7QZcS6N0kBYqf4U5R5fs8F1OxZI5Ulr
        XViotn4BALIN0iMgNufgxKi2YpDBa4WYYpZk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o0FsG8cqV6COfj1TMkSvKXi0tdXreG5g
        TqxehOJgnX3zbs1mTyC87rsbUFGk4NErBwUMmqS0CX2JCuDEmaVnI3j2zTCV3m35
        DmbCAutKGLLMzCNdqs3MTj51bXZp4hkW0my8Ht20nbJKfvkSVxC7NkmqJMY6IRlW
        1X+lrqnF81w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8145435266;
        Mon, 25 Nov 2019 20:12:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2E3635265;
        Mon, 25 Nov 2019 20:12:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Nika Layzell via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nika Layzell <nika@thelayzells.com>
Subject: Re: [PATCH 0/1] add--interactive: skip index refresh in reset patch mode
References: <pull.475.git.1574539001.gitgitgadget@gmail.com>
        <xmqqwobpzubw.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet>
Date:   Tue, 26 Nov 2019 10:12:31 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1911251523530.31080@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Mon, 25 Nov 2019 15:24:50 +0100
        (CET)")
Message-ID: <xmqqtv6rwidc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2F83290-0FE9-11EA-8D35-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> CC'ing Dscho who has stakes in keeping the scripted "add -i" frozen,
>> while he is rewriting it in C.
>
> Thanks for pinging me!
>
> As it were, I was aware of this effort, and I am quite happy about it (and
> of course I will adjust my patch series accordingly).

Thanks, both.
