Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84A0C433B4
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 20:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0412610E7
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 20:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhDAUav (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 16:30:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59980 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbhDAUav (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 16:30:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 51EBB12C3E0;
        Thu,  1 Apr 2021 16:30:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=c6O9CvQAtt7G
        R6iJMniJYehvtMo=; b=FkDcOSaKWA3+P3RvHBsnbJmJyB8zfjiDCN22fJiU8CTY
        RpKvtdzftVte2M4Y4kfL6TYvjXByQXVNAvKGM3ZdeWujMg+Thc2kmEnOrB2sbkIy
        NElWS1B+u+AF+VSl8hAsDjtHppWeINJOdU86IL+/HfP/rVs4pIyu09uLPTTZTEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=H7TDJZ
        FQnb4vpk4WXgPh7Hgxbk86VGjsZYCLyXiWlRYTVf3Xb8CZLomfujRs3lm7CO/g1b
        IttEBKluxhv2sF4znWXlHTuCc9XlOv9VHQVRUKvSzcC+eLg/H8SXPaqBs/sv8Rzw
        7mH9KFwwh0K/3oOfCl115CXG4l6YiqWxKBR04=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4AFA712C3DF;
        Thu,  1 Apr 2021 16:30:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 80C3E12C3DE;
        Thu,  1 Apr 2021 16:30:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 14/18] tree-walk.h API doc: improve documentation of
 get_tree_entry()
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
        <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
        <patch-14.19-44f16d74426-20210331T190531Z-avarab@gmail.com>
Date:   Thu, 01 Apr 2021 13:30:46 -0700
In-Reply-To: <patch-14.19-44f16d74426-20210331T190531Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 31 Mar
 2021 21:09:42
        +0200")
Message-ID: <xmqq4kgp3fyh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 24CF2588-9329-11EB-BB4E-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change a mention of sha1 to OID and change the comment to a listing of
> functions discussed below, right now there's only one function, but
> subsequent commits will add more.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  tree-walk.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tree-walk.h b/tree-walk.h
> index 09e40d9221d..cd8da84f56c 100644
> --- a/tree-walk.h
> +++ b/tree-walk.h
> @@ -166,11 +166,13 @@ struct traverse_info {
>  };
> =20
>  /**
> - * Find an entry in a tree given a pathname and the sha1 of a tree to
> + * Find an entry in a tree given a pathname and the OID of a tree to
>   * search. Returns 0 if the entry is found and -1 otherwise.
>   *
> - * The third and fourth parameters are set to the entry's sha1 and
> - * mode respectively.
> + * You always need a pointer to an appropriate variable to fill in
> + * (NULL won't do!). That variable is:
> + *
> + * get_tree_entry(): unsigned short mode

The last part after "That variable is:" makes no sense.  Sent before
completing?

The function takes a repository, tree object name, a path in that
tree as input, and find the entry in the tree at the given path.
Its finding is returned in the fourth and fifth parameters as

    struct object_id *oid
    unsigned short *mode

By the way, I think somebody forgot to update the description while
inserting the "struct repository *" as the first parameter and that
is where the "third and fourth" in the original comes from.

