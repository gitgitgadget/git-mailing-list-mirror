Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEE8C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 10:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5449B23A84
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 10:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbgLRKFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 05:05:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59957 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgLRKFK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 05:05:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C527D94890;
        Fri, 18 Dec 2020 05:04:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=AAuALYN6Y1M2PPoXcoUh+lWuUd4=; b=MOmIa/oc70zEXh0cNiVP
        +ar1WhUym4N2aanp+1H3lu5QppGT44zQFceE7T9Ds5WdB6sXdbU3As4tsI0MW4FS
        Bb+EynxfdwqiIJYI7/2BrjA1ukEN/JPvXD5ihnhlJSFFcMWAwYlJVq9N4/eZZnmJ
        IYy6FyakQzb/3OpfVnBdoCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=KAnpCEgWzhCcmMUlsfko7gEnsmDMwlsiISJUmfns6NaGg6
        5ZEocnv0flKEub8nGMqNpY3kzq9xf+5gfYcT0mhS562e/41l+WKNkJ9ojZAFG6Uy
        aect5TYnq0NlZBRTi9TWvpTEIXysBbDVpkGHrpIBtpq2XF40WpRWXZqJkQeUg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC1249488F;
        Fri, 18 Dec 2020 05:04:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 42A449488D;
        Fri, 18 Dec 2020 05:04:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
References: <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
        <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
        <5fdaef83a40ba_d0e26208f6@natae.notmuch>
        <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
        <20201217094424.GA75257@ellen> <5fdb3471c6bb7_d6d032087@natae.notmuch>
        <20201217175037.GA80608@ellen>
        <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
        <20201218023534.GA117762@ellen>
        <5fdc18a91c402_f2faf20837@natae.notmuch>
        <20201218054947.GA123376@ellen>
Date:   Fri, 18 Dec 2020 02:04:23 -0800
Message-ID: <xmqq3603v3a0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 67E38C64-4118-11EB-84FA-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

> On Thu, Dec 17, 2020 at 08:49:13PM -0600, Felipe Contreras wrote:
>> And no person is the sole arbiter of truth, in this list, or anywhere.
>> People have managed to change Junio's mind.
>
> I'm not worried about Junio but I am wondering if anyone has managed to
> change your mind. You and I have been going back and forth on this list
> and on Reddit for two solid days and, to be frank, I'm running out of
> steam.
> ...
> I, as a user of diffconflicts, may want to both disable this flag for
> diffconflicts but enable this flag for VS Code and kdiff3. It is not
> unusual for people to use more than one mergetool. Some of them are
> better or worse at visualizing different kinds of conflicts. Sometimes
> a conflict is small and straightforward; othertimes a conflict is
> complicated and requires deep knowledge of the history of both branches.
> If we force this to be a global flag only then users will not be able to
> make different choices for different tools.
>
> Someone who does use multiple mergetools but only uses tools from group
> one may appreciate a single global flag so s/he doesn't need to set it
> for each tool.
> ... there's every possibility that a user will prefer it a different
> way or that a mergetool author will. And there's every possibility that
> there will be differing opinions between users and authors like there is
> between you and me. But that's ok! Because it's just a configuration
> option.

Well explained.  I do not think I need to add much.

It makes sense to at least allow people to enable/disable the
behaviour independently for different tools.  When unconfigured, I
would say we should enable the feature by default to give it wider
exposure.

Because what I care is not about the set of tools we happen to have
right now, but is about leaving users access to an escape hatch in
case things go wrong.  If it turns out that all the tools we happen
to have do not seem to break with this new option with just a few
days' survey, it does not mean we do not need a per-tool escape
hatch they can use until the next release either fixes the feature
or makes it disabled by default, when there is unexpected breakages
discovered later.  The time between a release and the next is a long
time that the users cannot keep the tool they have learned to rely
on broken.  And that's a conservative maintainer's view.

When a tool that never wants its input munged appears, we might
further want to have the mechanism to give different default per
each tool for users who have no configuration, so that such a tool
can be disabled while other tools are enabled by default while
allowing users to choose.  But such a code to set different
enabled/disabled default per tool (the one I outlined in the
footnote of the other message) won't be exercised in practice with
the set of tools we have (hence a bug in such a code would go
unnoticed for a long time), so I tend to think we might be better
off to wait until the need arises before implementing per-tool
fallback default for users who do not configure at all.

Another reason why allowing users to disable the feature per tool is
important is because as far as I know we have kept the mergetool
framework to allow adding a tool that can merge binary data, and
leaving these three files pristine was one ingredient for that.
With only a single knob, we would be making a decision to declare
that such a tool is unwelcome, which is not quite acceptable.  I
expect that users would want the new feature most of the time
because they would be managing text files more of the time, and
having only a single knob would force an unnecessary choice on those
who want to use such a binary-capable tool as well.
