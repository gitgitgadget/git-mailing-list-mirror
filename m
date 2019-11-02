Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7860B1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 04:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbfKBEZR (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 00:25:17 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59168 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfKBEZR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 00:25:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E7FEA5AA6;
        Sat,  2 Nov 2019 00:25:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pZwLgSyNo/kbbstvIkkp6NLpxek=; b=oaa22P
        piijxIAt2d4IRQGxAN5nwo17FkHJkVcocaSic5dcRo24IPT3dmPswlCw3SPg98gU
        k3s8oOK4GyJojIlnWj2QVZH2uTx3sKfXVdaK2dm/fhVdJR75dmxHoOb9X3QTHrN/
        h5QYwsZjCYrbjfm7xnj+IkALRU/tC6s5MwjMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s7k+ixYZk3wsep4rVEFJiAmOzj9rrPqc
        qxr0Oq38r6u/v8zAkzy6JL47l71xxXmwybF8dSFgiXINy5BkL5a+4jnnHyPWiXau
        cRwgNUyinjQRZVnlLPgTkljodIY7xIFWu11PWhBWTOfAn4egm/7oy8ZusKgGkwCc
        V3D6UPUy4zY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A47FA5AA5;
        Sat,  2 Nov 2019 00:25:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 69BF1A5AA4;
        Sat,  2 Nov 2019 00:25:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Danh Doan <congdanhqx@gmail.com>
Subject: Re: [PATCH v3] submodule: teach set-url subcommand
References: <d8841c6009c91ac921d30b35ed9a441c87b332e2.1572337964.git.liu.denton@gmail.com>
        <f5f44812af2b43fe3f7ea837f8b07c4747eedcc0.1572368447.git.liu.denton@gmail.com>
        <xmqqtv7q3hhp.fsf@gitster-ct.c.googlers.com>
        <20191030175817.GA5120@generichostname>
Date:   Sat, 02 Nov 2019 13:25:10 +0900
In-Reply-To: <20191030175817.GA5120@generichostname> (Denton Liu's message of
        "Wed, 30 Oct 2019 10:58:17 -0700")
Message-ID: <xmqqzhhe52hl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C30D4754-FD28-11E9-96BF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> I think that the problem is that it's a common enough use-case but not
> common enough that people often forget to "sync" after editing the
> .gitmodules.

Which means that far from deprecating "sync", we should strive for
imprinting the need for the use of the subcommand deeper in users'
minds.  I wonder if it makes sense to make sure that .gitmodules
file starts with something like

	# Note that after updating this file, you may want to
	# run "git submodule sync" so that the URL for the remote
	# repository etc. are propagated down.

when we create it (via, say "git submodule add")?  Or alternatively,
warn the users when "git status" notices a local modification, or
something along that line?
