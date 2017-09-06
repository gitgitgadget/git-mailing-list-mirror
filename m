Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7809A209AB
	for <e@80x24.org>; Wed,  6 Sep 2017 03:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753573AbdIFDQS (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 23:16:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50027 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753113AbdIFDQR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 23:16:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4771AB0777;
        Tue,  5 Sep 2017 23:16:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2CRweWreFUSf
        P6l1DZfb2ogfkVM=; b=LxebM7Y1BEZbZkjQIctAOgYtIyH4VcSIyworP36WQSnM
        2nlhGGvjB51fGo8BRIvyM1fSvoofjwFmBDnft+baL7SCUs6QKthIBtcAoZGJMcQl
        OQt8a8fWrrMZaknVGSlL8aRq9rgtLLKBTr1uEyq9A4C5/4j4EPX/++GQmvQThyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=a9nDJ7
        w/hRkZnEYTYlD13vuff/26K76J1BUTrZNa+JJNoRpxuAb1AwzcDdDKQuJJTXuQAW
        dh/CauiQcz2E4FBTMza29QnI+duIDVAU6Nye7sjdwkHIIZ7sc/CbRjfLXEv8n+/A
        s9kITqqVmAk0ihI0hDrs3bMr+hh9L59kB9yek=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 409EBB0776;
        Tue,  5 Sep 2017 23:16:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1CBDB0775;
        Tue,  5 Sep 2017 23:16:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] parse-options: warn developers on negated options
References: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com>
        <20170905230845.17108-1-sbeller@google.com>
        <xmqq8thsa901.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 06 Sep 2017 12:16:12 +0900
In-Reply-To: <xmqq8thsa901.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 06 Sep 2017 10:52:46 +0900")
Message-ID: <xmqqzia88qkj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BD17CBFA-92B1-11E7-A075-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>>   This patch disallows all no- options, but we could be more open and =
allow
>>   --no-options that have the NO_NEG bit set.
>
> "--no-foo" that does not take "--foo" is perhaps OK so should not
> trigger an error.
>
> A ("--no-foo", "--foo") pair is better spelled as ("--foo",
> "--no-foo") pair whose default is "--foo", but making it an error is
> probably a bit too much.
>
> Compared to that, ("--no-foo", "--no-no-foo") pair feels nonsense.

Ahh, I was an idiot (call it vacation-induced-brain-disfunction).  I
forgot about 0f1930c5 ("parse-options: allow positivation of options
starting, with no-", 2012-02-25), which may have already made your
new use of "--no-verify" in builtin/merge.c and existing one in
commit.c OK long time ago.  A quick check to see how your version of

	git merge --verify
	git merge --no-verify

behaves with respect to the commit-msg hook is veriy much
appreciated, as my tree is in no shape to apply and try a patch
while trying to absorb the patches sent to the list the past week.

Thanks, and sorry for a possible false alarm.

> Having said that, because the existing parse_options_check() is all
> about catching the programming mistake (the end user cannot fix an
> error from it by tweaking the command line option s/he gives to the
> program), I do not think a conditional compilation like you added
> mixes well.  Either make the whole thing, not just your new test,
> conditional to -DDEVELOPER (which would make it possible for you to
> build and ship a binary with broken options[] array to the end-users
> that does not die in this function), which is undesirable, or add a
> new test that catches a definite error unconditionally.

This part still is valid.  If Ren=C3=A9's work 2 years ago is sufficient
to address "--no-foo" thing, then there is nothing we need to add to
this test, but if we later need to add new sanity check, we should
add it without -DDEVELOPER, or we should make the whole thing inside
it.

Thanks.
