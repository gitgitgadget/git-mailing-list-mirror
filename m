Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AEEC433E1
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 11:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F204A619D6
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 11:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhCTLM3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 07:12:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54197 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbhCTLMG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 07:12:06 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76C54BACA8;
        Sat, 20 Mar 2021 02:53:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KZEv5vyVFpbTjWKds9t6Zi5Q0hA=; b=kGl8Ko
        asz0ZRHLBkrZqgcvBt7IDh8IEzB82ACHB7t71Oo8s2DxvzipDXsgLQvGnCDCLGON
        VSwxGKTutJQBnwIryfbPols5IjvoculHA9Q06Z2G4jUttqU5Bhcv3ru/kkzy/T5/
        u9XZYmn15L7GZyITd5oJxRtZ66B4TLupKhOqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oeJ8C3poeIxZB92u2bf6Fn35nXfXRsBa
        DEPai9xLznAf3Mwa+Ikw0B4QgfGUFZ60xT5xVhlyPVfuNNhFEDB2vJh5kdnnX01h
        Y6vtVyXIGJ7A8tf7vDGER9wbaGwqiNtFtVHC6AEp5ddXUi6fQjJJJkQzp8Dt1DRD
        t8PvdHw6kno=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D515BACA7;
        Sat, 20 Mar 2021 02:53:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA334BACA6;
        Sat, 20 Mar 2021 02:53:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [PATCH v10 2/3] interpret-trailers: add own-identity option
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
        <pull.901.v10.git.1616066156.gitgitgadget@gmail.com>
        <42590e95deeece6ba65e0432c3a59746e717fee3.1616066156.git.gitgitgadget@gmail.com>
        <xmqq1rcctgj7.fsf@gitster.g>
        <CAOLTT8RzvQzD0baWPdJzRLK3Q+WeJR_HNA4RVHMxRmwHeym9QQ@mail.gmail.com>
        <xmqq7dm3p344.fsf@gitster.g>
        <CAOLTT8TQdT1PkdfuOk92U89Lgk9o_YhdeMyHb6SrE7GW+6PQJQ@mail.gmail.com>
        <YFWCvePMGvBY/I9v@coredump.intra.peff.net>
        <xmqq4kh6l6fd.fsf@gitster.g>
        <CAOLTT8RE6LOx2AUH8PJMzFdqp4_GJkiY41K0xE1YiSQNixKCRA@mail.gmail.com>
        <CAOLTT8T54RHPm8P=mJ3vOKZPEwpJQgnbeU3VqczWbPSk36wZcA@mail.gmail.com>
Date:   Fri, 19 Mar 2021 23:53:09 -0700
In-Reply-To: <CAOLTT8T54RHPm8P=mJ3vOKZPEwpJQgnbeU3VqczWbPSk36wZcA@mail.gmail.com>
        (ZheNing Hu's message of "Sat, 20 Mar 2021 14:38:11 +0800")
Message-ID: <xmqqzgyyjoyy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EEAB6A96-8948-11EB-8038-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> In actually ,
>
> @@ -1071,6 +1071,7 @@ static const char *find_author_by_nickname(const
> char *name)
>                 strbuf_release(&buf);
>                 format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
>                 clear_mailmap(&mailmap);
> +               reset_revision_walk();
>                 return strbuf_detach(&buf, NULL);
>         }
>
> then we can reuse this function.
>
> But I think I can give find_author_by_nickname another arg for choice if we want
>  `reset_revision_walk()`.

That is half fixing and half breaking.  It would allow us to call
the helper number of times as long as there is no other revision
traversal is in progress; calling reset_revision_walk() would mean
any and all revision traversal in progress will be broken.  So we
cannot use the helper to tweak each and every commit we encounter
while running "git log", for example.  Imagine adding an option to
"git format-patch" to allow each commit it formats to be tweaked by
adding "--trailers=foo:@ZheNing" and the like.  There is one primary
traversal that is used to list which commit to format in what order,
and every time that primary traversal yields a commit, if we run
find_author_by_nickname(), we end up initiating another traversal,
and then by calling reset, we clear all object flags that are used
for revision traversal, thereby breaking the primary traversal.

The only safe way to introduce a generally usable helper (without
rewriting the revision traversal machinery) is to spawn a subprocess
and do an equivalent of find_author_by_nickname() in it.

A standalone "interpret-trailers" command, as long as it won't do
any other revision traversal, would not have such a problem, and
calling reset every time find_author_by_nickname() is called may be
sufficient.  The only thing I care about is *not* to pretend that
find_author_by_nickname() plus reset() is the generally reusable
helper function and advertise it as such, which will mislead future
developers into misusing the function in a context they shouldn't
(i.e. while they are performing their own revision traversal).

Thanks.
