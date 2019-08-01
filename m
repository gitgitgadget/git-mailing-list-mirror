Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 084D91F731
	for <e@80x24.org>; Thu,  1 Aug 2019 20:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfHAUqD (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 16:46:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50776 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfHAUqD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 16:46:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F216776FDA;
        Thu,  1 Aug 2019 16:46:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kZcdRzSFafW+cPKWGGZ5xwirKQQ=; b=SPFaev
        43pJgvcZxZpFo/IbKf8VxARsjB3BNKzUPRDPbJ7QUdHsvawDeI/27YExJRiwP44f
        M/Cil1zCosl/96OlhvQZUjNKOV+4feJQCtLutC7IRYyM88GbaHNAtFjWYbM/VKHy
        xp5xcgHE4dFt6FcneyILTKmwDJ9N7TZLmadJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xjeNqGejDJGIdAnPSTE/i9pRgr6V+Zzo
        D55a1bcU/aAL0hfqXe4PV7oGvsVVuC1QF+YcQW701QDR+jrpkovHHfUh/pbXaque
        n3bVNFbTXZgorhd011zP/+tqmSLui/0SP94V9RoCF3uRCPEZ10XUuJ3AK90ZBkku
        uep7DXP2QXY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB07A76FD9;
        Thu,  1 Aug 2019 16:46:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B65C576FD6;
        Thu,  1 Aug 2019 16:45:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: Support for --stdin-paths in commit, add, etc
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
        <066cfd61-9700-e154-042f-fc9cffbd6346@web.de>
        <xmqqef24op5q.fsf@gitster-ct.c.googlers.com>
        <a6610e94-6318-b962-5dd0-ca379def3bba@syntevo.com>
Date:   Thu, 01 Aug 2019 13:45:55 -0700
In-Reply-To: <a6610e94-6318-b962-5dd0-ca379def3bba@syntevo.com> (Alexandr
        Miloslavskiy's message of "Thu, 1 Aug 2019 18:04:17 +0200")
Message-ID: <xmqqimrgmx6k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D2CBAE2-B49D-11E9-ADF4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com> writes:

> On 01.08.2019 17:56, Junio C Hamano wrote:
>> So, reading paths from a file (which could be "-" as you suggest)
>> would be a good solution for that.
>
> To summarize:
> 1) Implement --paths-file for high-level commands.
> 2) '--paths-file -' would mean reading from stdin.
>
> Is that something you're ready to accept patches for?

To be honest, I am personally not enthused to any move that
encourages scripting around Porcelain commands, but being able to
feed a set of paths not from the command line may still be useful
for some of them and I've taken and I'll take changes that are
against my taste, as long as there are wide support by others.

So I will *not* say "I can tell you upfront that such patches will
be waste of time as they will not be even looked at".

That does not mean that any patch along that line will automatically
be accepted, of course, so the answer to "am I ready to accept"
question is a definite no.  No, I am not ready---we will have to
look at the actual patches before deciding.


