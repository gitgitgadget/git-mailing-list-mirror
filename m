Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04851C4332F
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 20:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiJJUic (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 16:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJJUiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 16:38:16 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4664E2B9
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 13:38:16 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0B621BF4A0;
        Mon, 10 Oct 2022 16:38:15 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0t2/B4ZNSSyi
        VOHKOxIAywRKIHfiqJfuouhFjYx13qE=; b=Hz4TNkM1zVfcYo0x++kY7sqLlDLq
        sj9LlQtX5KDEHexPeaPojrmUiYJiYXVF8uXQl8es7FABNgw3avleOGy3NbJL27Y9
        /GCiRYTpK0sZmPKId5ZH/xUoy+HdJT383t57WtaulTwEjQAVnLWWiBF+EckXBf+0
        nUeYeLETYDqAR8U=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DABBA1BF49F;
        Mon, 10 Oct 2022 16:38:15 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2001F1BF49C;
        Mon, 10 Oct 2022 16:38:13 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/5] CodingGuidelines: recommend against unportable C99 struct syntax
Date:   Mon, 10 Oct 2022 13:38:00 -0700
Message-Id: <20221010203800.2154698-6-gitster@pobox.com>
X-Mailer: git-send-email 2.38.0-140-gc6454a6c7f
In-Reply-To: <20221010203800.2154698-1-gitster@pobox.com>
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
 <20221010203800.2154698-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 75E6CCA0-48DB-11ED-8E00-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Per 33665d98e6b (reftable: make assignments portable to AIX xlc
v12.01, 2022-03-28) forms like ".a.b =3D *c" can be replaced by using
".a =3D { .b =3D *c }" instead.

We'll probably allow these sooner than later, but since the workaround
is trivial let's note it among the C99 features we'd like to hold off
on for now.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
index 9598b45f7e..cbe0377699 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -242,6 +242,10 @@ For C programs:
      printf("%"PRIuMAX, (uintmax_t)v).  These days the MSVC version we
      rely on supports %z, but the C library used by MinGW does not.
=20
+   . Shorthand like ".a.b =3D *c" in struct assignments is known to trip
+     up an older IBM XLC version, use ".a =3D { .b =3D *c }" instead. Se=
e
+     the 33665d98e6b portability fix from mid-2022.
+
  - Variables have to be declared at the beginning of the block, before
    the first statement (i.e. -Wdeclaration-after-statement).
=20
--=20
2.38.0-167-gf9a88ca9e9

