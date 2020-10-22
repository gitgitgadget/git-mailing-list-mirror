Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B87AC4363A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 17:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F205E24182
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 17:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D05HJ0gp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S367986AbgJVRa2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 13:30:28 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53209 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508305AbgJVRa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 13:30:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB1FEEDAC5;
        Thu, 22 Oct 2020 13:30:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c2GzkmaKyHPyfJVhTC0c1s93O3A=; b=D05HJ0
        gpo9pwhblQYbrDypCnMA7Lul1ClfCAUQSa2dWZiJyr9qINvLxdNhscqa4QQzF6AV
        6EhWU6/3zV0lo8Uk+i3BaFd3Azv1/b2d8MwzJq4r1Cp42r7YqtOwhM03tplyp6R1
        cUZxMogI+5tQQ4BnGE1uCx7yZc/Q3H4OFoh2o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aq6iqW05u/cPsjzE+AwRkw87cd9KzSG1
        kbUfEWhD3JQW1bZUMrWB4WGN1wVuhVOkwb4aaT/Guh97Bx9fdyfynW8aG+2AFjTA
        taumgVtC76JQlOz5DNW9ERZI8wrAby/xBc3criCXxIr9QgyB93SsXVu3ADbtS9QW
        QsHoR5XA2V8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D51CBEDAC4;
        Thu, 22 Oct 2020 13:30:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 00580EDAC2;
        Thu, 22 Oct 2020 13:30:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Victor Engmark <victor@engmark.name>, git@vger.kernel.org
Subject: Re: [PATCH v3] userdiff: support Bash
References: <a07042af-d16c-1975-c0d1-f22f4fec5827@kdbg.org>
        <6c6b5ed2166ec2c308c53bf87c78b422fdc5084f.camel@engmark.name>
        <0d9f9ad1-2ba7-567e-97a1-a96f0b7cd4be@kdbg.org>
Date:   Thu, 22 Oct 2020 10:30:21 -0700
In-Reply-To: <0d9f9ad1-2ba7-567e-97a1-a96f0b7cd4be@kdbg.org> (Johannes Sixt's
        message of "Thu, 22 Oct 2020 08:08:29 +0200")
Message-ID: <xmqqr1pqmamq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43C8CE06-148C-11EB-9C09-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 22.10.20 um 01:45 schrieb Victor Engmark:
>> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
>> index 2d0a03715b..5e8a973449 100644
>> --- a/Documentation/gitattributes.txt
>> +++ b/Documentation/gitattributes.txt
>> @@ -802,6 +802,9 @@ patterns are available:
>>  
>>  - `ada` suitable for source code in the Ada language.
>>  
>> +- `bash` suitable for source code in the Bourne-Again SHell language.
>> +  Covers a superset of POSIX function definitions.
>
> OK. POSIX *shell* function definitions would have been even better, but
> I think I can live with this version.

I can't, so I'll locally amend ...

> This is very well done. Thank you!
>
> Acked-by: Johannes Sixt <j6t@kdbg.org>

... and with this in the trailer block.

Thanks, both.  Queued.
