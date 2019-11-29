Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0451C432C0
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E77C2464B
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="N4CtcAHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387433AbfK2Vjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:39:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61889 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387424AbfK2Vjg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 16:39:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3355336029;
        Fri, 29 Nov 2019 16:39:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FIUlxL7iEdm8s0QRD2MuZOljOXI=; b=N4CtcA
        HyKmESVohvzl8aWcK4+Cb7rxL0ZqCNwq1D/dOD+9OvJuZk3mXXUcPamxVpR0AJhX
        IJ+VxfYdzqHXvqe+2/MPlGlV098SKUXxdcR3V1KUQTx7UxfQ+nGmWU1Y9FF34NoH
        wwJXi+8JqK1lA1PImgcNyjQF2h25sH/MFqNJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R1ovHQ9VVSIVLr6C/4QttpJ8pn7GFKYt
        wCjh0zu0AZngNmYB925RETR6jS5SsmIIVVtJXFiGiYHKFDITz6+yydhyJjEqXML0
        xRKX6SuWd7ehkxrmNDAPgleylR0halbGsCh/kDz9qGucjxuvSEPgndoQUD7M8iu1
        Cg3tcrnj1XE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B9C936028;
        Fri, 29 Nov 2019 16:39:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A93536026;
        Fri, 29 Nov 2019 16:39:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 22/26] t7700: consolidate code into test_no_missing_in_packs()
References: <cover.1574731022.git.liu.denton@gmail.com>
        <cover.1574884302.git.liu.denton@gmail.com>
        <a99a45cb6f2cc7328ef0e52fc2ea8fec537bfba9.1574884302.git.liu.denton@gmail.com>
Date:   Fri, 29 Nov 2019 13:39:30 -0800
In-Reply-To: <a99a45cb6f2cc7328ef0e52fc2ea8fec537bfba9.1574884302.git.liu.denton@gmail.com>
        (Denton Liu's message of "Wed, 27 Nov 2019 11:53:54 -0800")
Message-ID: <xmqq7e3i4b1p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA553C06-12F0-11EA-AF0E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> The code to test that objects were not missing from the packfile was
> duplicated many times. Extract the duplicated code into
> test_no_missing_in_packs() and use that instead.
>
> Refactor the resulting extraction so that if any git commands fail,
> their return codes are not silently lost.
>
> We were using sed to filter lines. Although not incorrect, this is
> exactly what grep is built for. Replace this invocation of sed with grep
> so that we use the correct tool for the job.

Well, 

    $ sed -n -e 's/required match/desired part of the line/p'

is much much more approirate than 

    $ grep -e "requred match" |
      extract desired part of the line

"grep" is better only if the original were

    $ sed -n -e '/required match/p'

but everybody would write it with grep to begin with ;-)

So, I dunno about this part of the conversion.

> Instead of verifying each file of `alt_objects/pack/*.idx` individually
> in a for-loop, batch them together into one verification step.

Do you mean this one?

	git verify-pack -v alt_objects/pack/*.idx

where we may pass 1 or more .idx file to the command?  At first my
reading was interrupted by a "Huh?", but that does look good.  We'd
need to be a bit careful to make sure that we have at least 1 .idx
file, as the shell will happily feed a file whose name is "*.idx",
which verify-pack would be unhappy about.

> The original testing construct was O(n^2): it used a grep in a loop to
> test whether any objects were missing in the packfile. Rewrite this to
> sort the files then use `comm -23` so that finding missing lines from
> the original file is done more efficiently.

OK.  If we an show measurable speedups, it would be great, but the
loop structure does look O(n^2) and unnecessary costly.

> +test_no_missing_in_packs () {
> +	myidx=$(ls -1 .git/objects/pack/*.idx) &&
> +	test_path_is_file "$myidx" &&

If there are 2 or more .idx files, or if there is none, $myidx would
hopefully be a concatenation of these filenames or a string that
ends with asterisk-dot-idx and would fail path_is_file.  Sounds OK.

Ah, I do not have to review this part---these are repeated patterns
in the original.

> +	git verify-pack -v alt_objects/pack/*.idx >orig.raw &&
> +	grep "^[0-9a-f]\{40\}" orig.raw | cut -d" " -f1 | sort >orig &&

If output from 'grep' can be used as-is, it is worth doing, but if
you have to pipe it to cut, the original that used sed to filter and
edit the line would probably be a better way to write it.

> +	git verify-pack -v $myidx >dest.raw &&

This part does not quote $myidx" (inherited from the original); it
probably is OK, as any potentially problematic value in $myidx would
have been caught as an error much earlier in this test.

