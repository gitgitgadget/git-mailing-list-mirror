Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C77C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 17:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C1C207ED
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 17:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t5wCVNIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgFER7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 13:59:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51610 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgFER7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 13:59:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0055C7FDEC;
        Fri,  5 Jun 2020 13:59:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3rBxlA4x+KQb2fpuyxe8IiY34OQ=; b=t5wCVN
        IrK85reWbYCTsEfOwXooVeba1WeAbbytPEIso26HmxTkMTqc4Ce2gxxzzJhbkTvy
        ef6J9Qp0r0+8+QvXlgiNX9UML/ePUuTrNo0yxtditDDT61W+BqaegrnFwkX0ydvp
        dD1PxVpX3HfCpe8gBMcSdAOHaaccLCVhMxzGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SePGTrdQyhDJEFXb7gfP4gjtAzhbE+z7
        SWmROJoG5kmhtmj7/hxeUsa+7gImexeDc2tgdMRL7jQ913nRU+2zQjpIuVmku8II
        jfY1vNEKrL2DzBHJwouSciKAF2aLMwRJNiSKmAFZlGlx+YNY37i+dK28vhfPvF22
        OIKA+gV4mB0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC5E87FDEB;
        Fri,  5 Jun 2020 13:59:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 750687FDE9;
        Fri,  5 Jun 2020 13:59:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Resnick <max.resnick@forgerock.com>
Cc:     git@vger.kernel.org
Subject: Re: name-ref on annotated-tags is null terminated, but lightweight tags arent
References: <20200605165109.jr6mjl6xz7upofdy@forgemax.local>
        <xmqqa71ho34p.fsf@gitster.c.googlers.com>
        <20200605171607.rducvc4xretxacn5@forgemax.local>
Date:   Fri, 05 Jun 2020 10:59:12 -0700
In-Reply-To: <20200605171607.rducvc4xretxacn5@forgemax.local> (Max Resnick's
        message of "Fri, 5 Jun 2020 10:16:07 -0700")
Message-ID: <xmqq3679o0lr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43CFF3D2-A756-11EA-8520-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Resnick <max.resnick@forgerock.com> writes:

> Thanks Junio for the quick response.
>
>> Presumably the long hexadecimal are supposed to be on the same line 
>> as the "name-rev" command itself?                                   
>
> Yes, sorry I didn't see that the formatting was broken before I sent.
>
>> The suffix "^0" (which has nothing to do 
>> with null-termination) means "I do not mean the tag object itself, 
>> but the object that is pointed by it".                             
>
> Ok, thanks. I need to unpack that a bit more. I tried to dig around in
> the man to see if there was indication if that's what was expected but
> didn't find anything at less for name-rev.

"git help revisions" has this, which may help.

       <rev>^[<n>], e.g. HEAD^, v1.5.1^0
                  A suffix ^ to a revision parameter means the first
                  parent of that commit object.  ^<n> means the
                  <n>th parent (i.e.  <rev>^ is equivalent to
                  <rev>^1).  As a special rule, <rev>^0 means the
                  commit itself and is used when <rev> is the object
                  name of a tag object that refers to a commit
                  object.

The help text in "git help name-rev" only says "names suitable for
human digestion", which may want to be clarified.

Thanks.
