Return-Path: <SRS0=ybwr=BB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19402C433DF
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E261022B3F
	for <git@archiver.kernel.org>; Wed, 22 Jul 2020 21:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fSNlmE4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgGVVJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:09:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50833 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVVJp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 17:09:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D6E7D3CDD;
        Wed, 22 Jul 2020 17:09:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OEv5XoFC+eU+se5CJVc92pQdHrk=; b=fSNlmE
        4ko/U2u78fYC7+AixzHLd9t031uAB46BQOWml6Nqnu/T+CwKIdoDS77BwaX9NKzB
        jFfEpqePsuRnO+LQkX89+eZYal6/tcw/KZyrv83WRkt9SgYVrHdPFby8F8egdMlp
        nPBuDd1IkwBA1lMkvKG8gu1qoiPala0F/RXTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qINWETLwDc1OEUkPc5EToiY/FJIbpa3K
        MR4W9Iqj+GfwRUbhOLRDdyTu9AX4G0rHT1I4+NwTg9C7RWJrt0MhVNcpg0wv5HAm
        PMwO3lw6LMEu8zRVTAAQVCURc2cNkEfRkAXEx5rq2EMMoXMuO58OBdtiqDZq08OW
        sswlmLXIlCs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5634BD3CDC;
        Wed, 22 Jul 2020 17:09:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 99D28D3CDB;
        Wed, 22 Jul 2020 17:09:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2] doc: remove misleading documentation on pack names
References: <20200722202629.109277-1-johannes@sipsolutions.net>
Date:   Wed, 22 Jul 2020 14:09:37 -0700
In-Reply-To: <20200722202629.109277-1-johannes@sipsolutions.net> (Johannes
        Berg's message of "Wed, 22 Jul 2020 22:26:29 +0200")
Message-ID: <xmqq5zaf5ka6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7BE5DD8-CC5F-11EA-97BD-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> The index-pack documentation explicitly states that the pack
> name is derived from the sorted list of object names, but
> that clearly isn't true. I can't seem to be able to figure
> out if this was ever changed though.
>
> Be less explicit in the docs as to what the exact output is,
> and just say that it's whatever goes into the pack name.
>
> Really it seems to be the sha1 of the entire file, without
> the checksum footer.

Please avoid "seems to be" and spend a bit of effort digging the
history especially when we are not in a hurry to get to the definite
answer.  We can go "less explicit", or be a bit more informative by
saying that it is the trailer hash that is standard practice shared
across our binary files like the index and the packfile.

I think this is 1190a1ac (pack-objects: name pack files after
trailer hash, 2013-12-05).  It forgot to update the comment before
write_idx_file() function when it did this change:

 /*
  * On entry *sha1 contains the pack content SHA1 hash, on exit it is
  * the SHA1 hash of sorted object names. The objects array passed in
  * will be sorted by SHA1 on exit.
  */
 const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects,
 			   int nr_objects, const struct pack_idx_option *opts,
-			   unsigned char *sha1)
+			   const unsigned char *sha1)
 {

Obviously, after it turned *sha1 into 'const', it no longer is
possible for it to have anything different from what was passed in
upon exit.

> +Once the index has been created, the hash that goes into the name of
> +the pack/idx file is printed to stdout. If --stdin was also used then
> +this is prefixed by either "pack\t", or "keep\t" if a new .keep file
> +was successfully created. This is useful to remove a .keep file used
> +as a lock to prevent the race with 'git repack' mentioned above.

The change is good---I made sure that among these filve lines, what
changed was only the first one and half lines.  I however would have
preferred not to see the line rewrapping.

Thanks.
