Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB8FC4363D
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 02:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6064A2087D
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 02:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rYoftBhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbgJACRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 22:17:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59151 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJACRU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 22:17:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D6018A781;
        Wed, 30 Sep 2020 22:17:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wl5INgJ1ryyK1F/jwS4ZEVsgTFQ=; b=rYoftB
        hhn0jC13Hs8d17rm+6ye5QMd/Shn3v4kAR6I+1c8HsSxFYWbRKoFVHUopIL1Ufwj
        vsmdWgYEPJwI6jX2vgQMdRGrujYs1cusr5pBL+XFUb+e0l3jOPSti9mLfXLTygqe
        vXIx4MdXva0g4foqvjgf+tpwGKkfjEDm/+9Us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xczfE9TB6vK23S/iuGQdM8x+bG0LNdCT
        kKfXHjTqRJqXkiJuIf8Z6Kfqje50lrXd5MNqAW5OWjYre9u9UN/1dpWjOIFs6uGi
        OcwWnyiVYRfIC8Toqy7EO5lH4DTA91kqamaF2P7QRPPe5Zy4sEmqQF4wqnUtOsE8
        7SmN07mpz7Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 941A68A780;
        Wed, 30 Sep 2020 22:17:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A7AE8A77E;
        Wed, 30 Sep 2020 22:17:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shengfa Lin <shengfa@google.com>
Cc:     git@vger.kernel.org, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu
Subject: Re: [RFC PATCH 0/1] adding user.hideTimezone for setting UTC timezone
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
        <20200930232138.3656304-1-shengfa@google.com>
        <xmqqlfgqes95.fsf@gitster.c.googlers.com>
Date:   Wed, 30 Sep 2020 19:17:17 -0700
In-Reply-To: <xmqqlfgqes95.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 30 Sep 2020 16:53:26 -0700")
Message-ID: <xmqqtuved70y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AC53486-038C-11EB-AB5F-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> What I said is that git () { TZ=UTC command git "$@" } is simple
> enough that I doubt it is worth the engineering effort to either
> read configuration file early (which is tricky) so that setenv() can
> be done early in cmd_main() and/or audit the codebase widely enough
> (which is time consuming) to make sure that we pay attention to the
> configuration variable in all codepaths that matter to do the
> setenv().

Regarding the implementation, the posted patch to "git commit" uses
the "futz with TZ early inside the git process" approach, but I
think we should not do so for another reason.  Our setenv() may not
be early enough---before the code that decides to call a setenv()
is run, there are many things that are outside your control (like
the tracing subsystem, repository discovery, etc.) will run, and if
any of them does something that triggers tzset() to be called, it
will be done with the value of TZ the process started with, and our
setenv() that happens much later won't have any effect to it.

Another thing is that setting TZ ourselves would affect hooks and
other programs we spawn as subprocess, which may or may not be
desired, depending on the reason why the user is forcing UTC.

All code that create object headers like committer, author and
tagger lines use the same git_author_info() and git_committer_info()
API, I think, which eventually goes to fmt_ident(), and they produce
a pair <number of seconds since epoch, offset>.  This gives us an
entirely different opening to tackle this issue from, because the
"number of seconds since epoch" part won't change the value no
matter what timezone you are in.

You can let the existing code produce its natural result and then
when the "force UTC" flag is set, override the offset part to +0000
if and only if the timezone was obtained from the current
environment (this if-and-only-if is necessary, because you do not
want to rewrite and force UTC when you run "git commit --amend"
without the "--reset-author" option to update a commit that was
created somewhere else to UTC).  That way, we do not have to futz
with TZ environment or tzset.

Just something to think about.
