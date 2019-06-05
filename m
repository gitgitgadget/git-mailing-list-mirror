Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA9491F462
	for <e@80x24.org>; Wed,  5 Jun 2019 20:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfFEUjS (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 16:39:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52589 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfFEUjS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 16:39:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8BEA5164AE3;
        Wed,  5 Jun 2019 16:39:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PYDIWAsnZU6jYXbx2u5p/ZSFSGU=; b=sov/hF
        wea9JIyDkaY+rw/aSuQgvgsEZEGFWzLVPWpmIAfUnECg7tkKQmDdj3IV/8bVGE9B
        hlbIUmcikpDM2uA/9ZClBdWfxyHMPJGFjaV+gc73/rgjpvTIxPzJC+niSlXPII8l
        BnchqvrAS/hfqxEvkutjslKSgdH4s6TMdDQ/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=l7c9YHZnDLJdnwvC1R3/bfQb4nX3eJU4
        rqWUbmDbfIeWohcKO4SEJdH+RzwjzwZSLi3ZfVO+dos1WpchH/LhRehOHv9lleNQ
        d/m5eucvwU+pJLQ+chO+nVOVlO1Fj9KqDgf+6wvKs7Df34/nkyQSTM+k8LO2Nmuk
        K2RGktC+nEM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 850DB164AE2;
        Wed,  5 Jun 2019 16:39:11 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED8C6164AE1;
        Wed,  5 Jun 2019 16:39:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/11] [RFC] Create 'core.size=large' setting to update config defaults
References: <pull.254.git.gitgitgadget@gmail.com>
Date:   Wed, 05 Jun 2019 13:39:09 -0700
In-Reply-To: <pull.254.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Mon, 03 Jun 2019 13:18:18 -0700 (PDT)")
Message-ID: <xmqqftonsr6a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F92CBBE8-87D1-11E9-BD14-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series includes a few new config options we created to speed up
> certain critical commands in VFS for Git. On their own, they would
> contribute little value as it is hard to discover new config variables.
> Instead, I've created this RFC as a goal for probably three sequential patch
> series:
>
>  1. (Patches 1-3) Introduce a new 'core.size' config setting that takes
>     'large' as a value. This enables several config values that are
>     beneficial for large repos. We use a certain set in VFS for Git (see
>     [1]), and most of those are applicable to any repo. This 'core.size'
>     setting is intended for users to automatically receive performance
>     updates as soon as they are stable, but they must opt-in to the setting
>     and can always explicitly set their own config values. The settings to
>     include here are core.commitGraph=true, gc.writeCommitGraph=true,
>     index.version=4, pack.useSparse=true.

... and not the configuration introduced by the other two points in
this list?

"If you set this, these other configuration variables are set to
these default values" is a very valuable usability feature.  It
looks a lot more "meta" or "macro", and certainly is not a good idea
to call it as if it sits next to variables in any existing hierarchy.

I also wonder if this is something we would want to support in
general; random things that come to mind are:

 - should such a "macro" configuration be limited to boolean
   (e.g. the above core.size that takes 'large' is a boolean between
   'large' and 'not large'), or can it be an enum (e.g. choose among
   'large', 'medium' and 'small', and core.bigFileThreshold will be
   set to 1G, 512M and 128M respectively---this silly example is for
   illustration purposes only), and if so, can we express what these
   default values are for each choice without writing a lot of code?

 - if we were to have more than just this 'core.size' macro, can two
   otherwise orthogonal macros both control the same underlying
   variable, and if so, how do we express their interactions?
   "using these two at the same time is forbidden" is a perfectly
   acceptable answer for the first round until we figure out the
   desired semantics, of course.

 - perhaps we may eventually want to allow end users (via their
   ~/.gitconfig) and system administrators (via /etc/gitconfig)
   define such a macro setting (e.g. setting macro.largeRepoSetting
   sets pack.usebitmaps=true, pack.useSpars=true, etc.) *after* we
   figure out what we want to do to the other points in this list.

 - even if we do not allow end users and system administrators futz
   with custom macros, can we specify the macros we ship without
   casting them in code?

