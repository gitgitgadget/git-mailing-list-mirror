Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6583C388F9
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 19:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642912465A
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 19:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yYN8Dgxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370003AbgJVTOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 15:14:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54902 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370000AbgJVTOv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 15:14:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99D061079C4;
        Thu, 22 Oct 2020 15:14:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pDQ/YWeO/6Rb8lZiQEBWJrjr2Jk=; b=yYN8Dg
        xfhiBxqVMDqgqKERAPtQefVbm7fhpDYuAsxfmwAhsOcYuHTXdVdgAA+0r+hkzmgB
        JKc45lwWYEyiVZZNlsM2sPPuVnjUR9kHtUgOz9zhSWqr6ViBeinhVisnuHMhTQHF
        lAfoWkp1DrIicF8POfLdApsWpMXUjVnSekXHY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BAJj1Dm/jeG1ZMIJOhWRfIesF+3JL9FO
        hMbW1ulZEma3phmrHX6VtYw9eqaAlqR5oVjc6SwVi8UYHkmUxB648k6VGHnubXgc
        MBB+jGw0VjYTHLp80G50V0BToyOvHmgBP0dvJkaEc8hY4+W3htDdouf/KmKok1Zb
        eITGBKYsf0s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92BFB1079C3;
        Thu, 22 Oct 2020 15:14:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7B9291079C1;
        Thu, 22 Oct 2020 15:14:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nipunn Koorapati <nipunn1313@gmail.com>
Subject: Re: [PATCH v2 0/2] fsmonitor inline / testing cleanup
References: <pull.767.git.1603303474.gitgitgadget@gmail.com>
        <pull.767.v2.git.1603326066.gitgitgadget@gmail.com>
        <20201022174043.GA775513@nand.local>
        <xmqqblgum7qk.fsf@gitster.c.googlers.com>
        <20201022183822.GA781760@nand.local>
Date:   Thu, 22 Oct 2020 12:14:42 -0700
In-Reply-To: <20201022183822.GA781760@nand.local> (Taylor Blau's message of
        "Thu, 22 Oct 2020 14:38:22 -0400")
Message-ID: <xmqq7drim5st.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7EF2982-149A-11EB-A934-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Sorry for the confusion. I mean the following:
>
>   - These functions have existing callers that Nipunn claims do not need
>     to be explicitly inlined.

I guess "claims" is the key phrase in your responsehere.  Do you
feel that the claim is not sufficiently substantiated?

Those without fsmonitor would pay the call/return cost for no good
reason if core_fsmonitor is not set, and checking that on the caller
side may make a big difference.  How big?  That needs measurement.

This is a tangent, but with or without inlining, I find it iffy to
see that untracked_cache_invalidate_path() is called only when
fsmonitor is in use.  Does untracked_cache depend on fsmonitor for
its correct operation?  Why is it OK not to invlidate when the
caller would tell fsmonitor that a path is invalid if fsmonitor were
in use?  The call is a statement of fact that the path is no longer
valid, and that bit of information would be useful to the parts of
the system outside fsmonitor, no?  Puzzled....

>   - These functions are being moved to be part of the fsmonitor public
>     interface (presumably so that new callers can be added).

They used to be implemented as static inline functions in the
fsmonitor.h header file, so they have been part of the public
interface anyway.  Anybody that includes fsmonitor.h can use it,
with or without the patch.  So I think this one would not be
a problem.

> ...And I was wondering whether you wanted to wait for new callers
> before applying these to your tree.

Thanks.

I still do not know about the "should the inline be kept" question.
The proposed log message for the commit does not explain (let alone
justify) why "optimization" is unneeded for the fuctions in the
first place, which does not help.



