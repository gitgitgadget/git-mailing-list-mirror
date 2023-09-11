Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B002EE7FF4
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 06:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbjIKGa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 02:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjIKGa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 02:30:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3FAEA
        for <git@vger.kernel.org>; Sun, 10 Sep 2023 23:30:52 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 829A31BD9BD;
        Mon, 11 Sep 2023 02:30:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=wqZVKfmXEw6SWiqNQm494eZ4OJCExoSlbHbeb6
        I/9sw=; b=kGWEkt29nNxoKUjD0EubTWy6fCK1IS9bP8/Y/T5/NSZp+kZge0HvFf
        xFLh9QfzaqiyIhJXhCZ8o3y0Hm8qO7OL1nVC2WeWurFK7NwUOlpwDyE8zYErjAlx
        OKv9lPhewKMHE5ywIqChj6zqgeQ1E/svvJD3ZcVftD2NSKyr4YpJo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 769BE1BD9BC;
        Mon, 11 Sep 2023 02:30:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D2D9E1BD9BB;
        Mon, 11 Sep 2023 02:30:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 25/32] pack-compat-map:  Add support for .compat files
 of a packfile
In-Reply-To: <20230908231049.2035003-25-ebiederm@xmission.com> (Eric
        W. Biederman's message of "Fri, 8 Sep 2023 18:10:42 -0500")
References: <87sf7ol0z3.fsf@email.froward.int.ebiederm.org>
        <20230908231049.2035003-25-ebiederm@xmission.com>
Date:   Sun, 10 Sep 2023 23:30:49 -0700
Message-ID: <xmqqfs3li5ly.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C058D6B8-506C-11EE-808B-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

> diff --git a/pack-write.c b/pack-write.c
> index b19ddf15b284..f22eea964f77 100644
> --- a/pack-write.c
> +++ b/pack-write.c
> @@ -12,6 +12,7 @@
>  #include "pack-revindex.h"
>  #include "path.h"
>  #include "strbuf.h"
> +#include "object-file-convert.h"
> ...
> +/*
> + * The *hash contains the pack content hash.
> + * The objects array is passed in sorted.
> + */
> +const char *write_compat_map_file(const char *compat_map_name,
> +				  struct pack_idx_entry **objects,
> +				  int nr_objects, const unsigned char *hash)

Include "pack-compat-map.h"; otherwise the compiler would complain
for missing prototypes.
