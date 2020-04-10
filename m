Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A464FC2BA19
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 00:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAD920768
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 00:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u+YLeoE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgDJADw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:03:52 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61731 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDJADw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 20:03:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CAB61BD821;
        Thu,  9 Apr 2020 20:03:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ta2HiEAas2a6
        3mgeyR2ZHtvNPHA=; b=u+YLeoE0kM3mIEFujqGa6JPqbVatmlF859o2pkDffmhH
        9nqdjMAd7HIqhRU6aXVbuOqfUVMbARms+ebZgL55nLABTMHt91z63BnBOCRgebnf
        0Dsl6n1MmoF0FyeYPKiT4wnupe+0VAjRXDTmghP/pi4zY6z2IROcVKvzJ74mnkc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UtULEe
        /jiYWc7TILy6l4OtTeVjp/6sD3i+HH5NakXTkotEMH5bD3H7chSIjSR5wEXULcIn
        y8IrlwD0/ibW5AqhznnXGS/X350ERDPaSEipvnhAUeN3UyX65T5O+Ivx7pE4d/Kv
        hgMC3ikcUQDOXl/y+zYskDgQhsy7QbJMaFCWk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C15BDBD820;
        Thu,  9 Apr 2020 20:03:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0FF70BD81B;
        Thu,  9 Apr 2020 20:03:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?=C3=89rico?= Rolim <erico.erc@gmail.com>,
        git@vger.kernel.org
Subject: Re* [BUG] segmentation fault in git-diff
References: <CAFDeuWO+2JEGudtnHZvSsSUOVRR83U9ziLEjSoDyMWxYhvDMKg@mail.gmail.com>
        <xmqqh7xsmg7j.fsf@gitster.c.googlers.com>
        <xmqqd08gmg3s.fsf@gitster.c.googlers.com>
        <xmqq4ktsmfnn.fsf@gitster.c.googlers.com>
        <20200409234152.GA42330@coredump.intra.peff.net>
Date:   Thu, 09 Apr 2020 17:03:45 -0700
In-Reply-To: <20200409234152.GA42330@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 9 Apr 2020 19:41:52 -0400")
Message-ID: <xmqqv9m8kxzy.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C089356A-7ABE-11EA-8F58-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But there are a bunch of other commits around the same time replacing
> the_repository, and it seems like an easy mistake to make. Perhaps we
> should rename the "refs" member of "struct repository" to something mor=
e
> clearly private, which would force callers to use the access method.

Here is the final version that I am going to apply and merge to
'jch' branch.  This is an ancient regression in Git timescale, so
its fix is not all that urgent, though.

-- >8 --
Subject: [PATCH] sha1-name: do not assume that the ref store is initializ=
ed

c931ba4e (sha1-name.c: remove the_repo from handle_one_ref(),
2019-04-16) replaced the use of for_each_ref() helper, which works
with the main ref store of the default repository instance, with
refs_for_each_ref(), which can work on any ref store instance, by
assuming that the repository instance the function is given has its
ref store already initialized.

But it is possible that nobody has initialized it, in which case,
the code ends up dereferencing a NULL pointer.

Reported-by: =C3=89rico Rolim <erico.erc@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1-name.c                   | 2 +-
 t/t4208-log-magic-pathspec.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sha1-name.c b/sha1-name.c
index d9050776dd..3aba62938f 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1771,7 +1771,7 @@ static enum get_oid_result get_oid_with_context_1(s=
truct repository *repo,
=20
 			cb.repo =3D repo;
 			cb.list =3D &list;
-			refs_for_each_ref(repo->refs, handle_one_ref, &cb);
+			refs_for_each_ref(get_main_ref_store(repo), handle_one_ref, &cb);
 			refs_head_ref(repo->refs, handle_one_ref, &cb);
 			commit_list_sort_by_date(&list);
 			return get_oid_oneline(repo, name + 2, oid, list);
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.s=
h
index 4c8f3b8e1b..6cdbe4747a 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -55,6 +55,10 @@ test_expect_success '"git log -- :/a" should not be am=
biguous' '
 	git log -- :/a
 '
=20
+test_expect_success '"git log :/any/path/" should not segfault' '
+	test_must_fail git log :/any/path/
+'
+
 # This differs from the ":/a" check above in that :/in looks like a path=
spec,
 # but doesn't match an actual file.
 test_expect_success '"git log :/in" should not be ambiguous' '
--=20
2.26.0-106-g9fadedd637

