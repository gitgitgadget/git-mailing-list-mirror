Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE0FC433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 20:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B97264F64
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 20:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhBBUYm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 15:24:42 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59258 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbhBBUWe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 15:22:34 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4ED6A101D0E;
        Tue,  2 Feb 2021 15:21:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tfe/y5us/0Cdg7wl9cvmr0zxxmE=; b=IHnvV8
        yGzDwSlhtkBKjL2JqUhAljzLhyDeYlOxihtx08iGranw7z0Kjd94obPfwuMefnbB
        gEJm0t5c0X3FxMET02Fh2OXQ5QeMcK75TY8UdwW81G+S8BFTkGv2nszFxdry3QXq
        mTXmIJy8xo18988zRD2wR1ZxSgKmGAZaJxktw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jPvdRmCKkDckNgVAm52Cm4LkY7R9eies
        H8hoYg3aHkayfOpeI4rcNIu/fSiJftejyRB0vbzdv8+kgdODe//Gn1GH2JJArr5y
        n2bRv6rge+XFZxST9B8HoYyvqPFXoLTvP0mtzRnHVDBGrUKkQZNfklKrmqVmlbIV
        ZLqP2TNEvTM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46E3B101D0D;
        Tue,  2 Feb 2021 15:21:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6E90E101D0B;
        Tue,  2 Feb 2021 15:21:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     peff@peff.net, avarab@gmail.com, git@vger.kernel.org,
        jeffhost@microsoft.com, jonathantanmy@google.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v2] t5544: clarify 'hook works with partial clone' test
References: <CAPig+cQoTpsYS+2pccHmzx=Xoc34u166cYoC=GAcEndofN4gcA@mail.gmail.com>
        <20210202192417.68663-1-jacob@gitlab.com>
Date:   Tue, 02 Feb 2021 12:21:45 -0800
In-Reply-To: <20210202192417.68663-1-jacob@gitlab.com> (Jacob Vosmaer's
        message of "Tue, 2 Feb 2021 20:24:17 +0100")
Message-ID: <xmqqtuqufcfa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 465841AC-6594-11EB-AB3D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Vosmaer <jacob@gitlab.com> writes:

> Apply a few leftover improvements from the review of ad5df6b782
> (upload-pack.c: fix filter spec quoting bug).
>
> 1. Instead of enumerating objects reachable from HEAD, enumerate all
> reachable objects, because HEAD has not special significance in this
> test.
>
> 2. Instead of relying on the knowledge that "? in rev-list output
> means partial clone", explicitly verify that there are no blobs with
> cat-file.
>
> Signed-off-by: Jacob Vosmaer <jacob@gitlab.com>
> ---
>  t/t5544-pack-objects-hook.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks.

>
> diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.sh
> index f5ba663d64..dd5f44d986 100755
> --- a/t/t5544-pack-objects-hook.sh
> +++ b/t/t5544-pack-objects-hook.sh
> @@ -64,8 +64,9 @@ test_expect_success 'hook works with partial clone' '
>  	test_config_global uploadpack.packObjectsHook ./hook &&
>  	test_config_global uploadpack.allowFilter true &&
>  	git clone --bare --no-local --filter=blob:none . dst.git &&
> -	git -C dst.git rev-list --objects --missing=print HEAD >objects &&
> -	grep "^?" objects
> +	git -C dst.git rev-list --objects --missing=allow-any --no-object-names --all >objects &&
> +	git -C dst.git cat-file --batch-check="%(objecttype)" <objects >types &&
> +	! grep blob types
>  '
>  
>  test_done
