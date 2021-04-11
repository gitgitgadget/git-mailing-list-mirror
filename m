Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28257C433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF016101B
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhDKOD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 10:03:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60935 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhDKOD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 10:03:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE1E112525E;
        Sun, 11 Apr 2021 10:03:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=MVfeMCfSBVyDpJpLISdYnXN5Zzc=; b=UTnlGAjhVj7znt2DhCf/
        8VMOeZtZry8qehXnK0tLEw6KD8H0aGgaNC4JXOtnmyhgIqQ6FqE3ZIkwSl9mOZbK
        iOI+7TY8yvDBh++77ui6HxB1mI8KarGTgLMvk6c8s0dq9WkcLAlt531kzqKgSPiU
        l92ebJhQgV8Yg3hUmpBdeHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=UmnIn872OqYtZhoz+Nj4YtuQdZ/YmtWbyYGdXyPX+zOYh4
        YziHsPlvpMBFvpKpo/c50DO+sUot0iqBGYMxmGMKoY/xf6Jenat9rtUpQsyypGML
        v+NMUTW/eJUpOjsoLYd1D4jpgdhYlvSU6DPYGGaIHZTZpF+xklgylrVRP8eF4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E790312525D;
        Sun, 11 Apr 2021 10:03:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1B21912525B;
        Sun, 11 Apr 2021 10:03:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 10/15] hash: provide per-algorithm null OIDs
References: <20210410152140.3525040-1-sandals@crustytoothpaste.net>
        <20210410152140.3525040-11-sandals@crustytoothpaste.net>
Date:   Sun, 11 Apr 2021 07:03:05 -0700
Message-ID: <xmqqy2dohqau.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A40E7068-9ACE-11EB-9088-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/object-file.c b/object-file.c
> index 5f1fa05c4e..50bb5b6ca4 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -55,7 +55,6 @@
>  	"\x6f\xe1\x41\xf7\x74\x91\x20\xa3\x03\x72" \
>  	"\x18\x13"
>  
> -const struct object_id null_oid;
>  static const struct object_id empty_tree_oid = {
>  	EMPTY_TREE_SHA1_BIN_LITERAL,
>  	GIT_HASH_SHA1,
> @@ -64,6 +63,9 @@ static const struct object_id empty_blob_oid = {
>  	EMPTY_BLOB_SHA1_BIN_LITERAL,
>  	GIT_HASH_SHA1,
>  };
> +const struct object_id null_oid_sha1 = {
> +	{0}, GIT_HASH_SHA1,
> +};

sparse wants this to be a file-scope static.
