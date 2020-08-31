Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46300C433E2
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 04:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2345620782
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 04:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q7G5qp3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgHaEYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 00:24:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56126 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgHaEYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 00:24:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0E308EE9D;
        Mon, 31 Aug 2020 00:24:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rJkeZgVVtg+CKA7k2i+4QJX+iTg=; b=Q7G5qp
        3AZeIfD5AT6ZUURwFfO6fqLyTo7kDga9VziqIO2qGA9GsGtud0XleCT5piLxUMv9
        7hTnqHzgM1txk6JOFvY4qNwjjP8OLoO+NpP0zCjl4vyw+kQS2UsoKnuIf6+y5L6B
        I4dDBfSoLRCcrcqZbVuNig24N34I7LBOPQIAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BK5N8BKhOziUzUl9GdAKimr+Goyx+OXL
        eWnpUqDiMgS62J62OpM57KIW711rZPg9669o9Oyddj0iPtb0liWIP3MnvfTMXpJ9
        V5w05ziDUxr7Yh6dDTIy2sAjfsqmvocBrgVT7HhHntUbYZK2YzWHntikw1/3W5RM
        6feX7XyPVGk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A34E88EE9C;
        Mon, 31 Aug 2020 00:24:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B305B8EE9B;
        Mon, 31 Aug 2020 00:24:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Makefile: add support for generating JSON compilation database
References: <pull.714.git.1598815707540.gitgitgadget@gmail.com>
        <20200830221004.GB241078@camp.crustytoothpaste.net>
Date:   Sun, 30 Aug 2020 21:24:03 -0700
In-Reply-To: <20200830221004.GB241078@camp.crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 30 Aug 2020 22:10:04 +0000")
Message-ID: <xmqqsgc3h28s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDDE7B5A-EB41-11EA-9CD5-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2020-08-30 at 19:28:27, Philippe Blain via GitGitGadget wrote:
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>> 
>> Tools based on LibClang [1] can make use of a 'JSON Compilation
>> Database' [2] that keeps track of the exact options used to compile a set
>> of source files.
>
> For additional context why this is valuable, clangd, which is a C
> language server protocol implementation, can use these files to
> determine the flags needed to compile a file so it can provide proper
> editor integration.  As a result, editors supporting the language server
> protocol (such as VS Code, or Vim with a suitable plugin) can provide
> better searching, integration, and refactoring tools.

I found that the proposed commit log was very weak to sell the
change; some of what you gave above should definitely help strenthen
it.

Thanks.
