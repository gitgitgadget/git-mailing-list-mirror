Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D900C2D0EA
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 06:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270072075E
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 06:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="efgHJ40t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDHGCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 02:02:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64789 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDHGCf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 02:02:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4133E5A678;
        Wed,  8 Apr 2020 02:02:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V+CpcaL5yFf2vSsTvnOjEVkjuws=; b=efgHJ4
        0t7TSBPaJmmgxIM23GXU5CnXHp25gxmHMMyzfUK13rDIReVdkioDUoHJpUW8cK7J
        6Jzk111zD84KSHyzwU2Lem7WGGGpJrWtsAfFFhDRZTu2npmdEkoQjNkJffp4qvrY
        NJDgxczlJlYrOi2AQm2i+d7K/Ilh+Z0vF/8RI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bE/d4P+v0YN1XVpy+WSQUcAQD9x5Isg2
        UJ7MAJqBgkI1YsWYUqO25GtkMgMX0rWZBh9K9NmHKo8zzJHxhqLh3aqcrU428nfU
        ktuyDgvLCKPJgPZWkLUB8gAvXkKLwXRZJJUOtbXaU6FZtuv4WXj+NTsgVI2NDBkN
        lTZMEC7xHqg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28E695A677;
        Wed,  8 Apr 2020 02:02:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 955D45A676;
        Wed,  8 Apr 2020 02:02:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] oidmap: make oidmap_free independent of struct layout
References: <20200408040659.14511-1-abhishekkumar8222@gmail.com>
Date:   Tue, 07 Apr 2020 23:02:32 -0700
In-Reply-To: <20200408040659.14511-1-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Wed, 8 Apr 2020 09:36:58 +0530")
Message-ID: <xmqqr1wyplaf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8956BC54-795E-11EA-AB55-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> c8e424c introduced hashmap_free_entries, which can free any struct
> pointer, regardless of the hashmap_entry field offset.

    c8e424c9 (hashmap: introduce hashmap_free_entries, 2019-10-06)
    introduced hashmap_free_entries(), which ...

is how we refer to existing commits and functions.

> oidmap does not make use of this flexibilty, hardcoding the offset to
> zero instead. Let's fix this by passing struct type and member to
> hashmap_free_entries.

Makes sense.

> Additionally, removes an erroneous semi-colon at the end of
> hashmap_free_entries macro.

s/removes/remove/

Good eyes.  Of course, your if/else would have broken without this
fix ;-)

Looking good.  Thanks.

> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  hashmap.h | 2 +-
>  oidmap.c  | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hashmap.h b/hashmap.h
> index 79ae9f80de..6d0a65a39f 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -245,7 +245,7 @@ void hashmap_free_(struct hashmap *map, ssize_t offset);
>   * where @member is the hashmap_entry struct used to associate with @map
>   */
>  #define hashmap_free_entries(map, type, member) \
> -	hashmap_free_(map, offsetof(type, member));
> +	hashmap_free_(map, offsetof(type, member))
>  
>  /* hashmap_entry functions */
>  
> diff --git a/oidmap.c b/oidmap.c
> index 423aa014a3..65d63787a8 100644
> --- a/oidmap.c
> +++ b/oidmap.c
> @@ -26,8 +26,10 @@ void oidmap_free(struct oidmap *map, int free_entries)
>  	if (!map)
>  		return;
>  
> -	/* TODO: make oidmap itself not depend on struct layouts */
> -	hashmap_free_(&map->map, free_entries ? 0 : -1);
> +	if (free_entries)
> +		hashmap_free_entries(&map->map, struct oidmap_entry, internal_entry);
> +	else
> +		hashmap_free(&map->map);
>  }
>  
>  void *oidmap_get(const struct oidmap *map, const struct object_id *key)
