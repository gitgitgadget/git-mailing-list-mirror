Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD29CC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650D5206DF
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZlTcqasj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfLDWHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:07:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61227 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDWHU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:07:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EE0353B64C;
        Wed,  4 Dec 2019 17:07:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1R5W1lljXo36bMH/TDLBOsjl1oA=; b=ZlTcqa
        sjhKS/IfSUFwrL2G0ZRu2uYU/q7ENTHuw+YmbMJ7q17c52tyyT+bO1im7MNaCHM9
        DK+Da+Y18h7U17ItnTXbNN4g6b2pQYldsWi8dPD1SNdoT3UIozpESPNp4sgV6B0O
        ZNJgn5lD2wcxmu8mO2V2FTFCHpjpeXVdmlx0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PWV12L17HudE3mxuZ7bPmsNZxxA00Ow8
        XvyWGbWeDuBde1Uda4JEFpQjxFidw8xmhEKS9imOPKPEX8iQXOJqHAbABXDn5hN3
        M1PVIeOizJFUQXniz5pxEfN5Jf2Gbrko3Sd3HJXX29nBrvlc1ST5br1MafSTPtz/
        LV8f+H/gJt4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E56873B649;
        Wed,  4 Dec 2019 17:07:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 534C23B648;
        Wed,  4 Dec 2019 17:07:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 0/5] t: test cleanup stemming from experimentally enabling pipefail
References: <xmqq1rtk557e.fsf@gitster-ct.c.googlers.com>
        <cover.1575496683.git.liu.denton@gmail.com>
Date:   Wed, 04 Dec 2019 14:07:13 -0800
In-Reply-To: <cover.1575496683.git.liu.denton@gmail.com> (Denton Liu's message
        of "Wed, 4 Dec 2019 14:03:03 -0800")
Message-ID: <xmqqfthz3fu6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D7D3FD2-16E2-11EA-A3CE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>
> Range-diff against v5:
> 1:  a99a45cb6f ! 1:  3008ce8deb t7700: consolidate code into test_no_missing_in_packs()
>     @@ Commit message
>          Refactor the resulting extraction so that if any git commands fail,
>          their return codes are not silently lost.
>      
>     -    We were using sed to filter lines. Although not incorrect, this is
>     -    exactly what grep is built for. Replace this invocation of sed with grep
>     -    so that we use the correct tool for the job.
>     -
>          Instead of verifying each file of `alt_objects/pack/*.idx` individually
>          in a for-loop, batch them together into one verification step.
>      
>          The original testing construct was O(n^2): it used a grep in a loop to
>          test whether any objects were missing in the packfile. Rewrite this to
>     -    sort the files then use `comm -23` so that finding missing lines from
>     -    the original file is done more efficiently.
>     +    extract the hash using sed or cut, sort the files, then use `comm -23`
>     +    so that finding missing lines from the original file is done more
>     +    efficiently.
>      
>          While we're at it, add a space to `commit_and_pack ()` for style.
>      
>     @@ t/t7700-repack.sh: test_description='git repack works correctly'
>      +	myidx=$(ls -1 .git/objects/pack/*.idx) &&
>      +	test_path_is_file "$myidx" &&
>      +	git verify-pack -v alt_objects/pack/*.idx >orig.raw &&
>     -+	grep "^[0-9a-f]\{40\}" orig.raw | cut -d" " -f1 | sort >orig &&
>     ++	sed -n -e "s/^\([0-9a-f]\{40\}\).*/\1/p" orig.raw | sort >orig &&
>      +	git verify-pack -v $myidx >dest.raw &&
>      +	cut -d" " -f1 dest.raw | sort >dest &&
>      +	comm -23 orig dest >missing &&

OK.

> 2:  f79240e937 = 2:  f3a0470edc t7700: consolidate code into test_has_duplicate_object()
> 3:  632a62f6e9 = 3:  c34477a5a9 t7700: replace egrep with grep
> 4:  bf70cc5a0d ! 4:  113f375192 t7700: make references to SHA-1 generic
>     @@ t/t7700-repack.sh: test_description='git repack works correctly'
>       	myidx=$(ls -1 .git/objects/pack/*.idx) &&
>       	test_path_is_file "$myidx" &&
>       	git verify-pack -v alt_objects/pack/*.idx >orig.raw &&
>     --	grep "^[0-9a-f]\{40\}" orig.raw | cut -d" " -f1 | sort >orig &&
>     -+	grep "^$OID_REGEX" orig.raw | cut -d" " -f1 | sort >orig &&
>     +-	sed -n -e "s/^\([0-9a-f]\{40\}\).*/\1/p" orig.raw | sort >orig &&
>     ++	sed -n -e "s/^\($OID_REGEX\).*/\1/p" orig.raw | sort >orig &&

Looking really good.

Thanks for following through.  Will replace and queue.

Hopefully this round is now ready for 'next'.  Knock knock...
