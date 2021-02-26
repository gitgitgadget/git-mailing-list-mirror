Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B7DC433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 02:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF2B64EFA
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 02:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBZCFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 21:05:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62107 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBZCFp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 21:05:45 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA53411E602;
        Thu, 25 Feb 2021 21:04:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G0jxBQtld/J1mmXyWo2CmOiIgS0=; b=bUxfpI
        GyOfkpz7gdwrpe8VMpIhUbnhml51ZeVV8h5drhD5sH/hx8VdgTd4apmQPMrHqpty
        cCYHjk9dIn/oj1Zn8GaQ0GPUlyRRR8odx2cJqKeWbNkjDhqWrwKIi5TEwomSlfvy
        XaGi6ZRz0IvWJu044yd/JDLvfI9mjFRTt2VyY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CHAzOzfGVdl8sRv0UlQ0ZEai0+HLAKt5
        RON9Co42vpDtxtm+7LwxC+CPAz3br+cYft4aXTsHhzjJHmUR9FV7/m+v1nZOG+km
        HjdDf8RDxtqzCELu6GynIp6AAwrPKuCrgFWFMJ+nb/ILGkU2SJATZKjtkaop0my/
        27PNZO4J920=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B2D4411E601;
        Thu, 25 Feb 2021 21:04:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0231611E600;
        Thu, 25 Feb 2021 21:04:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, pudinha <rogi@skylittlesystem.org>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 0/1] mergetools/vimdiff: add vimdiff1 merge tool variant
References: <20210214022840.849312-1-seth@eseth.com>
        <b3467a47-dffd-154f-76f9-e09b8145a5e5@gmail.com>
        <YDhBAPbU/T8BldrS@ellen.lan>
Date:   Thu, 25 Feb 2021 18:04:53 -0800
In-Reply-To: <YDhBAPbU/T8BldrS@ellen.lan> (Seth House's message of "Thu, 25
        Feb 2021 17:29:52 -0700")
Message-ID: <xmqqh7lzshx6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04FC424E-77D7-11EB-901D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> On Thu, Feb 25, 2021 at 01:45:16PM -0500, Philippe Blain wrote:
>> I think it would be good to add a short note about these variants somewhere
>> in Documentation/git-mergetool.txt. Might be in this patch, or not if you don't
>> feel like it...
>> 
>> Going further, we could even add a short (few words) description of each tool
>> and have that description show up in the output of  'git mergetool --tool-help',
>> something like this:
>> 
>> $ git mergetool --tool-help
>> 'git mergetool --tool=<tool>' may be set to one of the following:
>> 		emerge		Emacs (Emerge)
>> 		opendiff	Apple FileMerge
>> 		vimdiff		Vim (??)
>> 		vimdiff2	Vim (3 panes)
>> 		vimdiff3	Vim (4 panes)
>
> Great suggestions, thanks. A little explanation would be very helpful --
> I've been confused by those variants too and wondered why I might want
> to use one over another.
>
> I'll roll those into this patch.

I'd rather see it as a completely separate patch.

