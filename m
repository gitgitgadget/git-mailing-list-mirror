Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4170C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 19:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E91F24685
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 19:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nAJikpCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgA1TGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:06:08 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50742 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgA1TGI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 14:06:08 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3503AB00E7;
        Tue, 28 Jan 2020 14:06:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jj3f0CT3XIHNDyXtnnhuSbXVjus=; b=nAJikp
        CowbGH3TKg6wyJkd+bH0+vWJStp038+qf9h9tniJBVMPADq7mI+XTBd48iY3d00Q
        qO1oixOji+BzpfkDMQs0s22E1oNKsIfcfflXA/pfC86mac/7xPIr0CHlcFQaNc9B
        35lN0ulgyBgUeq0yH+/6TNnw/AsGxjculcnsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DEP24eZBhABIrMeZj7vVDUWJk6++nHya
        Mymzfw/gHYl0aN0aoGQxzfwlY2AEiE/rtKkDC0FeAZdXbwTwSsPSz+gvII0ZJIer
        sJI5VjVxNQyFOKJNN0fZBGt6t3rAUp6bR7vbn7soFqjxNPAcR3MW7Ljaa8xQczHQ
        1Xg0k0dxU00=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2CF60B00E6;
        Tue, 28 Jan 2020 14:06:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5384AB00E5;
        Tue, 28 Jan 2020 14:06:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 17/23] t5616: use correct filter syntax
References: <20200125230035.136348-1-sandals@crustytoothpaste.net>
        <20200125230035.136348-19-sandals@crustytoothpaste.net>
Date:   Tue, 28 Jan 2020 11:06:01 -0800
In-Reply-To: <20200125230035.136348-19-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 25 Jan 2020 23:00:24 +0000")
Message-ID: <xmqqftfz8kpy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A96BC48-4201-11EA-9354-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> In the setup steps for the promisor remote tests, we clone a repository
> and filter out all trees with depth greater than or equal to zero, which
> also filters out all blobs.
>
> With SHA-1, this test passes because the object we happen to request
> from the server is the blob that the promisor remote has.  However, due
> to a different ordering with SHA-256, we request the tree containing
> that blob, which the promisor remote does not have.  As a consequence,
> we fail with a "not our ref" error.

Sorry, but I do not understand this part.

The object name of the original blob (which is the only thing
"promisor-remote" is given) may sort earlier or later than other
objects that are missing in the "client" repository, but it is not
clear how it makes difference in the final outcome---even if the
blob is asked first (in the SHA-1 version), wouldn't we need to
fetch the tree after that, and wouldn't that fail?  If the SHA-256
version that happens to ask for the tree first and fails, wouldn't
that mean we need to fetch both anyway?

Is it that the current test with SHA-1 is broken in that it lets the
lazy fetch fail (due to missing tree) but because the failure happens
after the blob gets feteched, and it ignores the failure of the lazy
fetch, and only checks if the blob got fetched, it happens to "pass"?

> Since what we want to test is that the blob is transferred, let's adjust
> the filter to just filter out blobs, not trees.  That means that we'll
> transfer the previously problematic tree as part of the normal clone,
> and we can then test that the blob is fetched from the promisor remote
> as expected.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t5616-partial-clone.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index fea56cda6d..9fd6e780f9 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -317,7 +317,7 @@ setup_triangle () {
>  	cp big-blob.txt server &&
>  	git -C server add big-blob.txt &&
>  	git -C server commit -m "initial" &&
> -	git clone --bare --filter=tree:0 "file://$(pwd)/server" client &&
> +	git clone --bare --filter=blob:none "file://$(pwd)/server" client &&
>  	echo another line >>server/big-blob.txt &&
>  	git -C server commit -am "append line to big blob" &&
>  
