Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D4EC433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 22:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68CCD20732
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 22:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ghBkx5Uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbgFRWdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:33:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62550 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbgFRWdT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 18:33:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B4A32DD423;
        Thu, 18 Jun 2020 18:33:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IFfgtWwIARdV8c9qCFhgVqtY3QQ=; b=ghBkx5
        Uo5Jw9hQE0CqksUCVap7AKl1KTD++3eF6Pq6yN3uQgOCujwjUsaNn7Owr21ugigz
        78XmlH7L+JkpRZfjR51xEI87ZRuWlyBgexH5WXCRFCIJVVpR5/MDGh9uCb1fvmAs
        r5mnZXM2yanlS8RUnEjgYbC2t5kQmcZdAbBr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qJayz8iHmOedEoVZJ1e2ESxSpU2gsdMq
        V0zU7TTKksEnp2CZDT7QxYUmvCXzb/cbGhDTRYieZHSKCiT4USaEv2AckmUSYJxS
        FtszBpPqXCJVbFJ1dmWg6htVq79xMRTwqmPlwo0RJdtDlk4YGixJnJ73CjZGEKdV
        Mjl0rb1s8rw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AD1DDDD422;
        Thu, 18 Jun 2020 18:33:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 005D4DD421;
        Thu, 18 Jun 2020 18:33:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff-files: treat "i-t-a" files as "not-in-index"
References: <20200611161640.52156-1-shrinidhi.kaushik@gmail.com>
Date:   Thu, 18 Jun 2020 15:33:11 -0700
In-Reply-To: <20200611161640.52156-1-shrinidhi.kaushik@gmail.com> (Srinidhi
        Kaushik's message of "Thu, 11 Jun 2020 21:46:40 +0530")
Message-ID: <xmqqk104knrs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1E67992-B1B3-11EA-B422-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

> -test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
> +test_expect_success 'diff/diff-cached shows ita as new/not-new files' '
>  	git reset --hard &&
>  	echo new >new-ita &&
>  	git add -N new-ita &&

Interesting.  

I thought that the test originally tested "diff-files" and
"diff-index --cached" and a modernization patch forgot to update the
title when the test body was changed to use "diff" and "diff
--cached", but that is not the case here.  When 0231ae71 (diff: turn
--ita-invisible-in-index on by default, 2018-05-26) added this test,
it gave a wrong title from the beginning.

Nice catch.

> @@ -243,6 +243,29 @@ test_expect_success 'diff-files/diff-cached shows ita as new/not-new files' '
>  	test_must_be_empty actual2
>  '
>  
> +test_expect_success 'diff-files shows i-t-a files as new files' '
> +	git reset --hard &&
> +	touch empty &&

Use of "touch" gives a wrong impression that you care about the file
timestamp; use something like ": >empty &&" instead when you care
about the presence of the file and do not care about its timestamp.

> +	content="foo" &&
> +	echo $content >not-empty &&

The quoting decision is backwards in these two lines.  It is OK not
to quote when the right hand side literal is clearly a single word
without $IFS.  On the other hand, it is a good practice to always
quote when using what is in a "$variable".

> +	git add -N empty not-empty &&
> +	git diff-files -p >actual &&
> +	hash_e=$(git hash-object empty) &&
> +	hash_n=$(git hash-object not-empty) &&
> +	cat >expect <<-EOF &&
> +	diff --git a/empty b/empty
> +	new file mode 100644
> +	index 0000000..$(git rev-parse --short $hash_e)
> +	diff --git a/not-empty b/not-empty
> +	new file mode 100644
> +	index 0000000..$(git rev-parse --short $hash_n)
> +	--- /dev/null
> +	+++ b/not-empty
> +	@@ -0,0 +1 @@
> +	+$content
> +	EOF
> +	test_cmp expect actual
> +'

OK.  Do we want to show what happens when "diff" and "diff --cached"
are run with these two "added but not quite added yet" paths to
contrast with this new case?

Thanks.
