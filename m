Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89994211B4
	for <e@80x24.org>; Wed,  5 Dec 2018 02:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbeLEC0F (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 21:26:05 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56526 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLEC0F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 21:26:05 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 30AEA3062D;
        Tue,  4 Dec 2018 21:26:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wwc9/KES8kbYJE77CYcjAQGwpak=; b=uxBuYh
        xVoFg9v7qXjP/mZKWKyeDR+jb70o7bwra9n5Hg4A0cjptMcgilvOZTaWHzUT4gL2
        O7R6x/xykTDT62ViiU+M2JemGbTLiLy29DuulCed8oVqZny/E8KE7OgV4edTVZ+J
        8nb2PVRqhHiQNoIAl6Lqn2aQNRXIJVhYHlBjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=saTCDErRV2myTjFtVfE1UTHZFQCtCQbb
        hRUcr5bYwL0l/BBz/pRGvMYtPrKCglHXc1Dm+0E6P+Zzt59xhYDlamnAo9UtWK1c
        9RTa58MrXlVMqzRyRpmAApv3fTTD4HzNkVS2GydjjELeRkZdwR7mgKbejZow7fjn
        v3I+xIzi1DU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29B253062A;
        Tue,  4 Dec 2018 21:26:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 472A130629;
        Tue,  4 Dec 2018 21:25:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Stefan Xenos <sxenos@google.com>
Subject: Re: [PATCH v3 07/14] checkout: split into switch-branch and restore-files
References: <20181127165211.24763-1-pclouds@gmail.com>
        <20181129215850.7278-1-pclouds@gmail.com>
        <20181129215850.7278-8-pclouds@gmail.com>
        <CABPp-BHQ68pkvO8yXYuy=0D6ne8u=5CUMDqiN0jtRrxCL55n2g@mail.gmail.com>
        <CACsJy8BTs+WKzTTEF2XVTT-LVJk_exYCz_hN+hXU1Dw+oquBpA@mail.gmail.com>
        <CABPp-BGRcaiiD-aks1kaLr7ATLQ_oGSyooQBDD+2acgerA+Phg@mail.gmail.com>
        <CACsJy8D9Rgsf-E6yweQxpopFaOVZ1bgihEbg200yS1gup+Gt7Q@mail.gmail.com>
Date:   Wed, 05 Dec 2018 11:25:55 +0900
In-Reply-To: <CACsJy8D9Rgsf-E6yweQxpopFaOVZ1bgihEbg200yS1gup+Gt7Q@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 4 Dec 2018 19:17:39 +0100")
Message-ID: <xmqqpnugemks.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 191CF292-F835-11E8-BF0A-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Dec 4, 2018 at 6:43 PM Elijah Newren <newren@gmail.com> wrote:
>> > > > +--ours::
>> > > > +--theirs::
>> ...
>> go away.  Maybe it can still be fixed (I haven't dug too deeply into
>> it), but if so, the only fix needed here would be to remove this long
>> explanation about why the tool gets things totally backward.
>
> Aha. I' not really deep in this merge business to know if stages 2 and
> 3 can be swapped. This is right up your alley. I'll just leave it to
> you.

Please don't show stage#2 and stage#3 swapped to the end user,
unless that is protected behind an option (not per-repo config).
It is pretty much ingrained that stage#2 is what came from the
commit that will become the first parent of the commit being
prepared, and changing it without an explicit command line option
will break tools.

> I'm actually still not sure how to move it here (I guess 'here' is
> restore-files since we won't move HEAD). All the --mixed, --merge and
> --hard are confusing. But maybe we could just make 'git restore-files
> --from HEAD -f :/" behave just like "git reset --hard HEAD" (but with
> some safety net) But we can leave it for discussion in the next round.

Perhaps you two should pay a bit closer attention to what Thomas
Gummerer is working on.  I've touched above in my earlier comments,
too, e.g.  <xmqqefb3mhrs.fsf@gitster-ct.c.googlers.com>
