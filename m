Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBF031F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 02:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfJLCRB (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 22:17:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62460 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfJLCRA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 22:17:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8F150A1318;
        Fri, 11 Oct 2019 22:16:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wrdsJWd8ZnuEkuG+UXYdqZWvdno=; b=QE17IJ
        zjOTxcK+UbcFEAr9o4e5GRhyB/7bpldUPZbQ3e2/fXg9nJjTI0/ZonzwEmAXtfyr
        tzE+L5MxUBeaAMTFs54tMFNxuJw5anSf7FIK2WuGd8C5wI25v/0kgAWGZg4atyF2
        ni8xyrEsqYjItkECJ8qTyOXvygCGgNkMwqraE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dVERaAxmZs+kCX8dgDioqDBSc2YlE/Ur
        h+M/5Dq1WpRUhwe4tm8DeU+CC96PblWc67lHYg9gFCtVpZ7ddZSkVlW1fTv7XAog
        +e2EzbYV1g6E5QCPBMoUPU7gedswopBYGCy1YRdofA2cnT55PC1y8T1xel/QptiN
        La7gJL4JCGA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 872C7A1317;
        Fri, 11 Oct 2019 22:16:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B78BEA1316;
        Fri, 11 Oct 2019 22:16:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 2/3] format-patch: use enum variables
References: <cover.1566285151.git.liu.denton@gmail.com>
        <cover.1570821015.git.liu.denton@gmail.com>
        <19ee1f71493fa584991f530e952d9198880208eb.1570821015.git.liu.denton@gmail.com>
Date:   Sat, 12 Oct 2019 11:16:53 +0900
In-Reply-To: <19ee1f71493fa584991f530e952d9198880208eb.1570821015.git.liu.denton@gmail.com>
        (Denton Liu's message of "Fri, 11 Oct 2019 12:12:54 -0700")
Message-ID: <xmqqk19aemi2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CCCE7F8-EC96-11E9-8302-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> -#define THREAD_SHALLOW 1
> -#define THREAD_DEEP 2
> -static int thread;
> +enum thread_level {
> +	THREAD_UNSET,
> +	THREAD_SHALLOW,
> +	THREAD_DEEP
> +};
> +static enum thread_level thread;

As the assignment of values do not change, this is a safe conversion
even if an existing code did things like

	if (!thread)
        	... do this ...;

Hopefully nobody did arithmetic on it; thread_level may now become
unsigned depending on the compiler.

> -static int config_cover_letter;
> +static enum cover_setting config_cover_letter;

Likewise about the signedness.

