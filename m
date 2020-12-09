Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D939C1B0E3
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 22:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7CF23B85
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 22:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbgLIWbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 17:31:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51871 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388819AbgLIWbb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 17:31:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 038289EF76;
        Wed,  9 Dec 2020 17:30:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UcOh3T/DGtcg
        39wIxq8xj1cykIc=; b=qH+tILWUwwbKEEPaNLASqZndrqEPp7foZ4HpivjQ6ORn
        +rNa1qmcQ+uzUrvnQGX+fQxVUA47YrwVTQ7atatMRMEXaivSYMdgrAjUFhFHjqOt
        q8jMT1zoJWjJ0Ky8kU5FexEjeIZc9I2Wzugst/3t8/z6GnOPynr/9yxf4KqBwYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wE4G/1
        3YI4SBWvGuxM9VWKrG6hnF94kMd4yjh5wY9wYQQ/b2qKQgz5/ABq1OU5X5udtcal
        Woy7nWRG2p/cI4t9PaI2aAdLPmpGFuhQLwmnVpxTy2D3R/jeVqi38tzicklhdsle
        GcnvDTkGHHbLU4vIMc5mhl/hjfx6Fqc7E7H/s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EF6EC9EF75;
        Wed,  9 Dec 2020 17:30:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 734BE9EF74;
        Wed,  9 Dec 2020 17:30:46 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 00/10] make "mktag" use fsck_tag()
References: <20201126222257.5629-1-avarab@gmail.com>
        <20201209200140.29425-1-avarab@gmail.com>
Date:   Wed, 09 Dec 2020 14:30:45 -0800
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 9 Dec 2020 21:01:30 +0100")
Message-ID: <xmqq7dpq1uju.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2E70AEA4-3A6E-11EB-9509-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This version should address all the comments Junio made on v2. Changes:
>
>  * The whole "extra" fsck option is gone, I just didn't realize I
>    could set the new check to "ignore", and then manually promote it.
>
>  * Ejected "mktag: reword write_object_file() error". It was the same
>    phrasing as "git tag" uses, let's just keep it.
>
>  * Clarifications in docs/commit messages
>
>  * There's 2 extra patches at the end now which take the first steps
>    into making "git mktag" more of a normal builtin. It reads fsck.*
>    config variables, so you can turn off that "no extra headers" check
>    through the normal fsck.<msg-id>=3Dignore config.
>
>    It should also be moved to getopts, and we could make it support
>    --no-strict to have the same idea of error/warning as fsck itself,
>    but that's #leftoverbits, along with moving it to i18n.
>
>    It would be nice to have patches 1-8 merged down if they're deemed
>    ready, and if 9-10 aren't deemed wanted just discard them. I think
>    it makes sense though...

Thanks.  I haven't read the individual patches, but spotted an
obvious "is is" typo in the doc while scanning through the end
result of applying all of them.

 Documentation/git-mktag.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git c/Documentation/git-mktag.txt w/Documentation/git-mktag.txt
index e1506dde56..2c1afedef6 100644
--- c/Documentation/git-mktag.txt
+++ w/Documentation/git-mktag.txt
@@ -27,10 +27,9 @@ write a tag found in `my-tag`:
 The difference is that mktag will die before writing the tag if the
 tag doesn't pass a linkgit:git-fsck[1] check.
=20
-The "fsck" check done mktag is is stricter than what
-linkgit:git-fsck[1] would run by default in that all `fsck.<msg-id>`
-messages are promoted from warnings to errors (so e.g. a missing
-"tagger" line is an error).
+The "fsck" check done mktag is stricter than what linkgit:git-fsck[1]
+would run by default in that all `fsck.<msg-id>` messages are promoted
+from warnings to errors (so e.g. a missing "tagger" line is an error).
=20
 Extra headers in the object are also an error under mktag, but ignored
 by linkgit:git-fsck[1]. This extra check can be turned off by setting
