Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCBFC433ED
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 23:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9345160FDB
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 23:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhCaXdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 19:33:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60752 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbhCaXcc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 19:32:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06BB6A9AC4;
        Wed, 31 Mar 2021 19:32:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7vrjaMZuorJ8
        FL5Ot5U3u9PUlEQ=; b=qPzZFFC2ViIEAQr7RokWSaUeSCgWOrgGCrGbYyyUgS5d
        HqfNx8Ff1GwKVEmsrnUGVJFvhHYzLz5RB+X36lFtYnOBZr/X2+fI6Y8Vh9hKzKdx
        2Mzry//Gq2c8kgGS0tfBrTcY5Ytc1T2T5tHe948tTcm4p7jzNhokxct0yTxPPIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Dw0L/g
        TErjSbS2CQYEL5keahUkcg5BSthWMJvvsWu01tY+fOdk0KRi2nXW9JJRR177urIc
        kx0YHCBwFcmD7tcrt3EJq4qfWxFUNzPuvjznzADFRQroc5uKd25By1skA4Sga4CC
        GEECnHy1sGD+i0zwyRIOec1MN06NlNjtUJPMA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F19C9A9AC3;
        Wed, 31 Mar 2021 19:32:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3CCBFA9AC2;
        Wed, 31 Mar 2021 19:32:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 09/18] notes & match-trees: use name_entry's
 "pathlen" member
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
        <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
        <patch-09.19-749be26bf8e-20210331T190531Z-avarab@gmail.com>
Date:   Wed, 31 Mar 2021 16:32:30 -0700
In-Reply-To: <patch-09.19-749be26bf8e-20210331T190531Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 31 Mar
 2021 21:09:37
        +0200")
Message-ID: <xmqqsg4a527l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5CED2470-9279-11EB-B9F7-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  	while (desc.size) {
>  		const char *name;
>  		unsigned short mode;
> +		int len =3D tree_entry_len(&desc.entry);
> =20
>  		tree_entry_extract(&desc, &name, &mode);
> -		if (strlen(name) =3D=3D toplen &&
> +		if (len =3D=3D toplen &&

Makes sense.

> @@ -216,9 +217,7 @@ static int splice_tree(const struct object_id *oid1=
, const char *prefix,
>  			 *   - to discard the "const"; this is OK because we
>  			 *     know it points into our non-const "buf"
>  			 */
> -			rewrite_here =3D (unsigned char *)(desc.entry.path +
> -							 strlen(desc.entry.path) +
> -							 1);
> +			rewrite_here =3D (unsigned char *)(name + len + 1);

So does this.  The original using desc.entry.path even though it
called extract to learn the name does not make much sense.

>  			break;
>  		}
>  		update_tree_entry(&desc);
> diff --git a/notes.c b/notes.c
> index a19e4ad7943..e2fec12a39e 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -413,7 +413,7 @@ static void load_subtree(struct notes_tree *t, stru=
ct leaf_node *subtree,
>  	while (tree_entry(&desc, &entry)) {
>  		unsigned char type;
>  		struct leaf_node *l;
> -		size_t path_len =3D strlen(entry.path);
> +		int path_len =3D entry.pathlen;

OK.

>  		if (path_len =3D=3D 2 * (hashsz - prefix_len)) {
>  			/* This is potentially the remainder of the SHA-1 */
> @@ -483,7 +483,7 @@ static void load_subtree(struct notes_tree *t, stru=
ct leaf_node *subtree,
>  				strbuf_addch(&non_note_path, *q++);
>  				strbuf_addch(&non_note_path, '/');
>  			}
> -			strbuf_addstr(&non_note_path, entry.path);
> +			strbuf_add(&non_note_path, entry.path, path_len);

OK.

>  			add_non_note(t, strbuf_detach(&non_note_path, NULL),
>  				     entry.mode, entry.oid.hash);
>  		}

Looking good.
Thanks.
