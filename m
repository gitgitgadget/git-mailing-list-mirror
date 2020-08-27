Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EC1C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20ACE2087D
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 15:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JrRGpKKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgH0Pvu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:51:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60662 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgH0Pvt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 11:51:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9394072486;
        Thu, 27 Aug 2020 11:51:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vm5AHno0Pw02MfosV0/HBc9b4UM=; b=JrRGpK
        KMuqiWmIFeH7I1fY1/6zveuGzfQvfwH4M+WUHStmVqPe6EtP8K6HcxWoHf3LO5I6
        2kSFkbXNI8yXeG3GOt1I0qfJ2vErbl/cWejdDS+C2n6n/a613B6f5uPi+4Qe1r9K
        SMdQhZ97bib+0GIn4RVGzpCjzzW2YsOnWh0Z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yjkZkI7PnSx7aVud+11GC0rRx/ix5LC+
        S64WJK5QsOZLNIBAG2uVtkQiuzIzUUOH69Z+bwOh1WbnzuoxGdqow+xcYOR8Iu3M
        ZYdU9mFGMqV8dga6JnTPOPGVouHv60g4+vUHkBKiTWgWBZNnpW6fmoz5GjzSrrnX
        a/omJehubJk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A52172485;
        Thu, 27 Aug 2020 11:51:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1076A72484;
        Thu, 27 Aug 2020 11:51:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Tom Rutherford <tmrutherford@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: post-checkout hook aborts rebase
References: <CAHr-Uu_KeAJZrd+GzymNP47iFi+dZkvVYsWQPtzT_FQrVnWTDg@mail.gmail.com>
        <xmqq7dtlt080.fsf@gitster.c.googlers.com>
        <xmqq3649szs8.fsf@gitster.c.googlers.com>
        <CAHr-Uu8umDQJ=LORaBNJX+wnmaeM1hHxxpG7xROPgCqgEPrwdw@mail.gmail.com>
        <CAPx1GvfSt=s5VP9_+ZtndHWaBZ5W7nFxAf8bTF2tXnJkS95Dfg@mail.gmail.com>
Date:   Thu, 27 Aug 2020 08:51:45 -0700
In-Reply-To: <CAPx1GvfSt=s5VP9_+ZtndHWaBZ5W7nFxAf8bTF2tXnJkS95Dfg@mail.gmail.com>
        (Chris Torek's message of "Wed, 26 Aug 2020 22:44:35 -0700")
Message-ID: <xmqqzh6gqe7i.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35E2F270-E87D-11EA-A10B-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Torek <chris.torek@gmail.com> writes:

> This might be intended as a feature, but if so, the documentation
> needs a tweak: the githooks docs say in part
>
>     This hook cannot affect the outcome of git checkout.
>
> If "outcome" includes exit status -- to me, it does -- either the docs
> are wrong or the code is wrong.

I suspected that this was a case of adding the hook that just runs
without affecting the exit code and then somebody later changed the
behaviour (either deliberately or by mistake) and forgot to update
the documentation.  But it seems that ever since the hook support
was introduced at 1abbe475 (post-checkout hook, tests, and docs,
2007-09-26), the command was made to exit with the same status from
the hook.

So I agree that depending on reader's view on "the outcome", this is
documented incorrectly (if the exit code is part of "the outcome")
or just fine (otherwise).  Apparently, the author of the patch and
the reviewers back then thought the latter.

I still suspect that the checkout run, merely as an implementation
detail of rebase (or any other git subcommand), should not trigger
any hook, but before any such code change, at least let's update the
documentation to clarify what we mean by "the outcome".

Hopefully something like the below may be a good starting point?

 Documentation/githooks.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 31b601e4bc..cf95d6d02b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -193,7 +193,9 @@ worktree.  The hook is given three parameters: the ref of the previous HEAD,
 the ref of the new HEAD (which may or may not have changed), and a flag
 indicating whether the checkout was a branch checkout (changing branches,
 flag=1) or a file checkout (retrieving a file from the index, flag=0).
-This hook cannot affect the outcome of `git switch` or `git checkout`.
+This hook cannot affect the outcome of `git switch` or `git checkout`,
+other than that the hook's exit status becomes the exit status of
+these two commands.
 
 It is also run after linkgit:git-clone[1], unless the `--no-checkout` (`-n`) option is
 used. The first parameter given to the hook is the null-ref, the second the



