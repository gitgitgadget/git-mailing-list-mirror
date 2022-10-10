Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBF2C433FE
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 20:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiJJUiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 16:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJJUiI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 16:38:08 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9B51F9CB
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 13:38:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 023CC1BF49A;
        Mon, 10 Oct 2022 16:38:07 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Q0+i4xq8KR1D
        boKlzNjV6vPMbre3x4rk+VESFFoS2ro=; b=CPPKef+VTqtNdxCdCMDsy1DfV02d
        wtb7ELub+37scj0+OJAz4O9AEMNfiil/tGUacebE7DvQmr9kbGiAiamzcE72YWiW
        P9rLm3/6RYv0+X1BirJdxDnAe49J1ShGmUFtc4xY1E1XuSqRB0oLSfhD9c/pu1SW
        AMLE4YJz4h+X438=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF6471BF499;
        Mon, 10 Oct 2022 16:38:06 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 32CEA1BF498;
        Mon, 10 Oct 2022 16:38:04 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] CodingGuidelines: update for C99
Date:   Mon, 10 Oct 2022 13:37:56 -0700
Message-Id: <20221010203800.2154698-2-gitster@pobox.com>
X-Mailer: git-send-email 2.38.0-140-gc6454a6c7f
In-Reply-To: <20221010203800.2154698-1-gitster@pobox.com>
References: <cover-0.5-00000000000-20221007T092505Z-avarab@gmail.com>
 <20221010203800.2154698-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 7095460A-48DB-11ED-B9CB-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Since 7bc341e21b5 (git-compat-util: add a test balloon for C99
support, 2021-12-01) we've had a hard dependency on C99, but the prose
in CodingGuidelines was written under the assumption that we were
using C89 with a few C99 features.

As the updated prose notes we'd still like to hold off on novel C99
features, but let's make it clear that we target that C version, and
then enumerate new C99 features that are safe to use.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
index 9fca21cc5f..386ca0a0d2 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -204,10 +204,14 @@ For C programs:
    by e.g. "echo DEVELOPER=3D1 >>config.mak".
=20
  - We try to support a wide range of C compilers to compile Git with,
-   including old ones.  You should not use features from newer C
+   including old ones.  As of Git v2.35.0 Git requires C99 (we check
+   "__STDC_VERSION__"). You should not use features from a newer C
    standard, even if your compiler groks them.
=20
-   There are a few exceptions to this guideline:
+   New C99 features have been phased in gradually, if something's new
+   in C99 but not used yet don't assume that it's safe to use, some
+   compilers we target have only partial support for it. These are
+   considered safe to use:
=20
    . since early 2012 with e1327023ea, we have been using an enum
      definition whose last element is followed by a comma.  This, like
--=20
2.38.0-167-gf9a88ca9e9

