Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E449C433E0
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 19:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E3664E3A
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 19:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhBGTfd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 14:35:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52057 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGTfd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 14:35:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D308CA6E9F;
        Sun,  7 Feb 2021 14:34:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oJ/xPIiNxseGTaEf4eTIuvIs4dI=; b=QTkGwA
        CR25uDTKibcuGUKd7542XjzK/KpZUPRJuoB/ief4TGRArl1lyNqKooOo2tdJDnz7
        n3LNW9SO1ZQcewNi4gfWVTd3j/y4jpRY7x3lA7ej/I6kmMTUY3BExD26/cB46wTz
        UTZMSh1nOMxY8GudnaBVNpxrWVeScIzNASMdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H01pw9wGbPoaXb3iqR5KPPvQiGd3ys6/
        g2HeZynlHYQC2n5cSrVCeA2jurIXmCxPCxt3h66250WpUAA6hRJiERb+d2/IR9nb
        MS1HZ/cMAg54DenEBIbzjzrvOvz9AFzyza6nMr2c6qvJpkVFiZeLGjCjTAcFstDw
        lwB4WTmT4XI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CBBE4A6E9E;
        Sun,  7 Feb 2021 14:34:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 559ACA6E9D;
        Sun,  7 Feb 2021 14:34:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <periperidip@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        levraiphilippeblain@gmail.com
Subject: Re: [RFC] [BUDFIX] 'git rm --cached <submodule>' does not stage the
 changed .gitmodules
References: <20210207144144.GA42182@konoha>
        <xmqq1rdr8yl2.fsf@gitster.c.googlers.com>
Date:   Sun, 07 Feb 2021 11:34:49 -0800
In-Reply-To: <xmqq1rdr8yl2.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 07 Feb 2021 11:30:49 -0800")
Message-ID: <xmqqwnvj7jty.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B4938C6-697B-11EB-AC57-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Shourya Shukla <periperidip@gmail.com> writes:
>
>> So, my question is, do we need to fix this to make sure that the changed
>> '.gitmodules' is staged?
>
> When "--cached" is given, the user is asking the module to be
> removed ONLY from the index, without removing it from the working
> tree, no?
>
> So I think ".gitmodules" in the working tree should not be touched
> at all.
>
> Removing the entry for the module from the ".gitmodules" registered
> in the index, when a submodule registered in the index, might be
> desirable, and what you say here

typofix: "registered in the index IS REMOVED, might be" is what I meant.

>
>> And its entry is not removed from the file. What should be done about
>> this? I would appreciate your opinions.
>
> may be related to it.
>
> But I doubt it is a good idea to let "git rm" be the one touching
> ".gitmodules" either in the index or in the working tree for that to
> happen.
