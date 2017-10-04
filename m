Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 001082036B
	for <e@80x24.org>; Wed,  4 Oct 2017 04:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbdJDEAn (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 00:00:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60876 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751330AbdJDEAk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 00:00:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC54094EBC;
        Wed,  4 Oct 2017 00:00:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bXXKaltCi1W7
        t81H8uCNbtVgET0=; b=eimKqEdv6iE6/SULC+Z1hZk0M0CuwKq+jJcKpErRyoiY
        LO5nhBxy+0lz6WyG13z5IJifsDD4Q/NQwNFbsvklZ6/mHX+SNtsD1DkiLtrYTKVU
        Z+6lT8GWbcEcKnGo7AtbWWhTGf/JJ8iaDMKoDIEyRjyszdN9kUm8hpSP4Igqyog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qWicqe
        c2zSmfY2WxVOC4/x/p/yX5xoAo/0FeAqSYAkyG2a3Km+Z9tLiUo9DfYdBQgrNuWN
        AIOwyfxsRcx4CUedR80mxu9wfjs4FQ3/+V4/wAEyuXxQDNQ/uxlY6sOLK5yedBkz
        gS+djppI8r+R4go09itIV0rv+0QSlaxFACrpM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3F3D94EBA;
        Wed,  4 Oct 2017 00:00:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2001394EB9;
        Wed,  4 Oct 2017 00:00:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Martin Koegler <martin.koegler@chello.at>
Subject: Re: [PATCH] fsck: check results of lookup_blob() and lookup_tree() for NULL
References: <20171003102215.9952-1-szeder.dev@gmail.com>
        <19a08fb1-2fb3-f368-772b-36646a179975@web.de>
        <54f5877b-a143-11c2-d8f6-ff28ed9e7e38@web.de>
Date:   Wed, 04 Oct 2017 13:00:36 +0900
In-Reply-To: <54f5877b-a143-11c2-d8f6-ff28ed9e7e38@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 3 Oct 2017 15:47:56 +0200")
Message-ID: <xmqqh8vfftp7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94C49788-A8B8-11E7-A129-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 03.10.2017 um 14:51 schrieb Ren=C3=A9 Scharfe:
>> Am 03.10.2017 um 12:22 schrieb SZEDER G=C3=A1bor:
>>> Furthermore, fsck.c:fsck_walk_tree() does the same "immediately
>>> reference the object member in lookup_blob()'s and lookup_tree()'s
>>> return value" thing.  I think those should receive the same treatment
>>> as well.
>>=20
>> Hmm, are put_object_name() and all the walk() implementations ready fo=
r
>> a NULL object handed to them?  Or would we rather need to error out
>> right there?
> How about this?
>
> -- >8 --
> lookup_blob() and lookup_tree() can return NULL if they find an object
> of an unexpected type.  Error out of fsck_walk_tree() in that case, lik=
e
> we do when encountering a bad file mode.  An error message is already
> shown by object_as_type(), which gets called by the lookup functions.

The result from options->walk() is checked, and among the callbacks
that are assigned to the .walk field:

 - mark_object() in builtin/fsck.c gives its own error message to diagnos=
e broken link
   and returns 1;

 - mark_used() in builtin/fsck.c silently returns 1;

 - mark_link() in builtin/index-pack.c does the same; and

 - check_object() in builtin/unpack-objects.c does the same,

when they see a NULL object.

This patch may avoid the "unexpected behaviour" coming from
expecting that &((struct tree *)NULL)->object =3D=3D NULL the current
code does, but it also changes the behaviour.  The loop used to
diagnose a fishy entry in the tree we are walking, and kept checking
the remaining entries in the tree.  You now immediately return, not
seeing if the later entries in the tree are good and losing objects
that are referenced by these entries as dangling.

I am not sure if this is a good change.  I suspect that the "bad
mode" handling should be made less severe instead.

>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  fsck.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 2ad00fc4d0..561a13ac27 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -358,14 +358,20 @@ static int fsck_walk_tree(struct tree *tree, void=
 *data, struct fsck_options *op
>  			continue;
> =20
>  		if (S_ISDIR(entry.mode)) {
> -			obj =3D &lookup_tree(entry.oid)->object;
> +			struct tree *tree =3D lookup_tree(entry.oid);
> +			if (!tree)
> +				return -1;
> +			obj =3D &tree->object;
>  			if (name)
>  				put_object_name(options, obj, "%s%s/", name,
>  					entry.path);
>  			result =3D options->walk(obj, OBJ_TREE, data, options);
>  		}
>  		else if (S_ISREG(entry.mode) || S_ISLNK(entry.mode)) {
> -			obj =3D &lookup_blob(entry.oid)->object;
> +			struct blob *blob =3D lookup_blob(entry.oid);
> +			if (!blob)
> +				return -1;
> +			obj =3D &blob->object;
>  			if (name)
>  				put_object_name(options, obj, "%s%s", name,
>  					entry.path);
