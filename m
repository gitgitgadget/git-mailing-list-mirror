Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB5BC433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 20:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJJUi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 16:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJJUiM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 16:38:12 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D2B636C
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 13:38:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C09C41CCF5B;
        Mon, 10 Oct 2022 16:38:09 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TsDv7o7OJEos
        UlIEU7hD8kRTEivMXRRa2jCLbMFj2rM=; b=eu7vX1WTSpGoK34ItH8Rya4sIXXA
        6YOgIbaB/FsDxewpqg9xtVIYOJnxrEwDnSWu+1lbHPzC2KfUYFoDiz4zV9dy1CeZ
        AxrnpnAlhUeZ2wl5A2XuIAT6CzYbQa/wIm5w+GtsW5nB/ro+ctBX20w51RJdpX/r
        MF0ymbpMGV8icmk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B98F91CCF5A;
        Mon, 10 Oct 2022 16:38:09 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F27051CCF59;
        Mon, 10 Oct 2022 16:38:06 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] CodingGuidelines: mention dynamic C99 initializer elements
Date:   Mon, 10 Oct 2022 13:37:57 -0700
Message-Id: <20221010203800.2154698-3-gitster@pobox.com>
X-Mailer: git-send-email 2.38.0-140-gc6454a6c7f
In-Reply-To: <20221010203800.2154698-1-gitster@pobox.com>
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
 <20221010203800.2154698-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 723EAEF6-48DB-11ED-A04E-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

The first use of variables in initializer elements appears to have
been 2b6854c863a (Cleanup variables in cat-file, 2007-04-21) released
with v1.5.2.

Some of those caused portability issues, and e.g. that "cat-file" use
was changed in 66dbfd55e38 (Rewrite dynamic structure initializations
to runtime assignment, 2010-05-14) which went out with v1.7.2.

But curiously 66dbfd55e38 missed some of them, e.g. an archive.c use
added in d5f53d6d6f2 (archive: complain about path specs that don't
match anything, 2009-12-12), and another one in merge-index.c (later
builtin/merge-index.c) in 0077138cd9d (Simplify some instances of
run_command() by using run_command_v_opt()., 2009-06-08).

As far as I can tell there's been no point since 2b6854c863a in 2007
where a compiler that didn't support this has been able to compile
git. Presumably 66dbfd55e38 was an attempt to make headway with wider
portability that ultimately wasn't completed.

In any case, we are thoroughly reliant on this syntax at this point,
so let's update the guidelines, see
https://lore.kernel.org/git/xmqqy1tunjgp.fsf@gitster.g/ for the
initial discussion.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
index 386ca0a0d2..8afda28cfc 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -213,6 +213,11 @@ For C programs:
    compilers we target have only partial support for it. These are
    considered safe to use:
=20
+   . since around 2007 with 2b6854c863a, we have been using
+     initializer elements which are not computable at load time. E.g.:
+
+	const char *args[] =3D {"constant", variable, NULL};
+
    . since early 2012 with e1327023ea, we have been using an enum
      definition whose last element is followed by a comma.  This, like
      an array initializer that ends with a trailing comma, can be used
--=20
2.38.0-167-gf9a88ca9e9

