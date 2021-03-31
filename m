Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5868C433ED
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 23:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDD3C61057
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 23:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhCaX0n (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 19:26:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61600 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhCaX01 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 19:26:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 78451125012;
        Wed, 31 Mar 2021 19:26:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pE4A/vbbOeET
        tllk45oRTIYjPgU=; b=tUWWQPezZmKjNob1LUJiwjdo1St9Gd8ufRCbLsQ95wwc
        zX5Tu7pgRVKgtbq0kFC2KZg2C+eEOVO0i6Wagjf7BM1zl8pHU2aDBD1sbtmbb9lv
        ebDE0Zg5djKGCsk5OCYRvURkH5Lh/3RIEDhvifK4AdsVOzF94WDChlNe/g0hYSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AqsByu
        gAb0bXFq97wjfaQksz9nFBG2WlEphDoVw7gQfcGRGs/i3CLaBNzTjO/tGGq4R37f
        BFDV4kQSQqDRDSy1nfJ0kMsD8OvNdwTPdfH1qynse04Os15nqrIAQcDueT9B+QsH
        bGZGYK3bQpKzRcNcQ6n8nJDKePyTnt/NqNJy8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 71629125011;
        Wed, 31 Mar 2021 19:26:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9D915125010;
        Wed, 31 Mar 2021 19:26:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 08/18] blame: emit a better error on 'git blame
 directory'
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
        <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
        <patch-08.19-3c2ca98716d-20210331T190531Z-avarab@gmail.com>
Date:   Wed, 31 Mar 2021 16:26:22 -0700
In-Reply-To: <patch-08.19-3c2ca98716d-20210331T190531Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 31 Mar
 2021 21:09:36
        +0200")
Message-ID: <xmqqwntm52ht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 82697EFC-9278-11EB-A41A-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change an early check for non-blobs in verify_working_tree_path() to
> let any such objects pass, and instead die shortly thereafter in the
> fake_working_tree_commit() caller's type check.
>
> Now e.g. doing "git blame t" in git.git emits:
>
>     fatal: unsupported file type t
>
> Instead of:
>
>     fatal: no such path 't' in HEAD

Sorry, but I fail to see why "unsupported file type t" is quite an
improvement.  Is this one of these irrelevant clean-up while at it
whose benefit is unclear until much later, I have to wonder.

> The main point of this test is to assert that we're not doing
> something uniquely bad when in a conflicted merge. See

"this test" refers to the logic "it is OK to skip the check if one
of the parents does have it as a blob", introduced in 9aeaab68
(blame: allow "blame file" in the middle of a conflicted merge,
2012-09-11)?


> -		if (!get_tree_entry(r, commit_oid, path, &blob_oid, &mode) &&
> -		    oid_object_info(r, &blob_oid, NULL) =3D=3D OBJ_BLOB)
> +		if (!get_tree_entry(r, commit_oid, path, &blob_oid, &mode))
>  			return;
>  	}

At least, the original logic makes sense to me in that if an early
parent has the path as a directory we do not declare it is OK but
keep going until we find a blob in a later parent before deciding to
short-cut.  I am not sure what the updated "in this case we can
bypass the real check" condition even means.  Mechanically, it says
"if any parent has the path as any filesystem entity, even if it
were a directory, then it is OK", but why?

Thanks.
