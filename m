Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95363C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FCE920658
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U2QL5+IK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMRE7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:04:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55278 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgHMRE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 13:04:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE0E5DC5B7;
        Thu, 13 Aug 2020 13:04:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r2r/Yhpoc/AbsG8PM9jGZU1KWXw=; b=U2QL5+
        IK6in/9KTfi3SuR3LRKsWxCSEn3RCE6x8U+p/ePNerpDk5mVAuUZPDdb+cb6Wv/x
        xaa5YZEeMfxX77omMF7IyWd05/vDg8E2yugZM6LALW7siS/sYrSuxmhJcbTLX/+S
        7GewqLybD7CN/mSd8G/epKF9ebnOQO049+0EA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dtNJngVwvXZ+A55MHWgP7m/2v9gNWrjr
        +fXHcTQZNzz0bZ+PPoD7aPtZj0xLqhyZrhUa503UWzySEHPK0AEGuaplOC+0Kci+
        5f+hLF3S+wBYZB4J2m/P725pHGEB10pV06V7HqDudHLQ/CAfYm98wzXL7sbA8DsR
        8wbPRtv6tLk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E6CFADC5B5;
        Thu, 13 Aug 2020 13:04:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 38DBFDC5B3;
        Thu, 13 Aug 2020 13:04:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Barret Rhoden <brho@google.com>, Nuthan Munaiah <nm6061@rit.edu>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] t8003: check output of coalesced blame
References: <20200813052054.GA1962792@coredump.intra.peff.net>
        <20200813052305.GA2514880@coredump.intra.peff.net>
Date:   Thu, 13 Aug 2020 10:04:51 -0700
In-Reply-To: <20200813052305.GA2514880@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 13 Aug 2020 01:23:05 -0400")
Message-ID: <xmqq4kp64guk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B0E69F8-DD87-11EA-93D6-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Commit f0cbe742f4 (blame: add a test to cover blame_coalesce(),
> 2019-06-20) added a test case where blame can usefully coalesce two
> groups of lines. But since it relies on the normal blame output, it only
> exercises the code and can't tell whether the lines were actually
> joined into a single group.
>
> However, by using --porcelain output, we can see how git-blame considers
> the groupings (and likewise how the coalescing might have a real
> user-visible impact for a tool that uses the porcelain-output
> groupings). This lets us confirm that we are indeed coalescing correctly
> (and the fact that this test case requires coalescing can be verified by
> dropping the call to blame_coalesce(), causing the test to fail).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t8003-blame-corner-cases.sh | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
> index b871dd4f86..1e89494ef6 100755
> --- a/t/t8003-blame-corner-cases.sh
> +++ b/t/t8003-blame-corner-cases.sh
> @@ -273,10 +273,6 @@ test_expect_success 'blame file with CRLF core.autocrlf=true' '
>  	grep "A U Thor" actual
>  '
>  
> -# Tests the splitting and merging of blame entries in blame_coalesce().
> -# The output of blame is the same, regardless of whether blame_coalesce() runs
> -# or not, so we'd likely only notice a problem if blame crashes or assigned
> -# blame to the "splitting" commit ('SPLIT' below).
>  test_expect_success 'blame coalesce' '
>  	cat >giraffe <<-\EOF &&
>  	ABC
> @@ -302,10 +298,11 @@ test_expect_success 'blame coalesce' '
>  	git commit -m "same contents as original" &&
>  
>  	cat >expect <<-EOF &&
> -	$oid 1) ABC
> -	$oid 2) DEF
> +	$oid 1 1 2
> +	$oid 2 2
>  	EOF

It has become a bit harder to grok, but for the purpose of the later
steps to see where things exactly came from (including their line
numbers), it is easier to see what is going on with the new format.

> -	git -c core.abbrev=$(test_oid hexsz) blame -s giraffe >actual &&
> +	git blame --porcelain giraffe >actual.raw &&

The original forced the abbrev length; by switching to the format
for porcelain-writers, we know we will get the full object name.  OK.

> +	grep "^$oid" actual.raw >actual &&
>  	test_cmp expect actual
>  '
