Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6F0C63777
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 05:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D6D20709
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 05:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgLCF3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 00:29:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59490 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgLCF3C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 00:29:02 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DA329D81A;
        Thu,  3 Dec 2020 00:28:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OVcsR5mdzge+PRrjtxdFxF+YEns=; b=oj+Gvu
        U/J+Qlja4R9q2bmG5pJyHg7o2oosbGPyMkECk+C5L62iRzALToXvo8reYPpjpgcb
        IP+K2dTG0JvFpJhhL07+n9mrIhVmV5EGf1trTl0Ck7QPlKsCals3oz+q/73e6ZrG
        BS+Lvbu/BFZgOMshMEjH6ELSkVYOwQYnDQZ/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UPu9dz16+EJWKcN7u9d0HaYW7bjvnWcO
        bI6RkUhFU/ZTwm7VYhmSHtdtRE0Qwht8+jCkPfvEdxU+BnFwvKsQarO2u6qYs+/X
        JKqQW6N0yv30cSP+QiHjermgncv27MFjnLjbtxtBkD4d8SJVRFDoIgBi132dRHzF
        WwZn7dlWt2c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65B269D819;
        Thu,  3 Dec 2020 00:28:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD94C9D818;
        Thu,  3 Dec 2020 00:28:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 04/27] revision: provide implementation for diff
 merges tweaks
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-5-sorganov@gmail.com>
        <xmqqim9jk8zf.fsf@gitster.c.googlers.com>
Date:   Wed, 02 Dec 2020 21:28:18 -0800
In-Reply-To: <xmqqim9jk8zf.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 02 Dec 2020 16:51:16 -0800")
Message-ID: <xmqqblfbihl9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59ECAF10-3528-11EB-9DD7-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Is your naming convention that "rev_diff_" is the common prefix?
> What's the significance of "_diff" part?  After all, these are about
> tweaking the setting in the rev_info structure, so how about
>
> 	revinfo_show_merges_in_dense_combined_by_default(rev);
> 	revinfo_show_merges_by_default_with_first_parent(rev);
>
> perhaps, using just "revinfo_" as the common prefix?

Actually, I'd like to take these suggestions back.  I do not think
these names that describe "what the function does" are good names at
all.  If we can name them after what they are for, we'd be much
better off.

Given that one is part of the tweak for "show" and the other part of
"log", I presume that one is to set-up default for showing a merge
in the context of the "show" command, and the other is the same for
the "log" (actually "log -p") command.  So perhaps

	diff_merges_set_default_for_show(revs);
	diff_merges_set_default_for_log(revs);

are good names that tells us where they should be used and what for.
The former is to set up the default parameters to handle a merge
commit in the context of the "show" command, and the latter is the
same for the "log" command.  Naming them that way, we can then tweak
what should happen for "show" by default without touching the caller
if we wanted to (perhaps, "when doing first-parent traversal, really
pretend that all the commits we see are single-parent, so show the
change relative to its first parent by default without even
requiring -m" might be something the latter can learn later).

Thanks.


