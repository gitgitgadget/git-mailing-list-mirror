Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A89C433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A2520758
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 17:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rtzoeller.com header.i=@rtzoeller.com header.b="ASmIvbso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHSRv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:51:26 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:11445 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHSRvY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 13:51:24 -0400
Date:   Wed, 19 Aug 2020 17:51:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rtzoeller.com;
        s=protonmail; t=1597859483;
        bh=72Xq36c4lr31MHwWS+vimlo9GpTRLgkCKdT9ZSqZpmA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=ASmIvbsogXGd6pXu7wVx2HT0Z1f2XyzJXtJKz/emT8ouj+DuUDT0psFfqyBq6+YuI
         PQb1eXHiqV++DaUeMxd59TD2tpmCo9Y7S9LAdmR50Yg0pzbvilWeDgyCFQOs63eKC6
         U5kD2TBweKZVzavxPpD7mDVEqE7RQcqsIGSQKJdE=
To:     git@vger.kernel.org
From:   Ryan Zoeller <rtzoeller@rtzoeller.com>
Cc:     Ryan Zoeller <rtzoeller@rtzoeller.com>
Reply-To: Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: [RFC PATCH 2/2] completion: add GIT_COMPLETION_SHOW_ALL env var
Message-ID: <20200819175047.692962-3-rtzoeller@rtzoeller.com>
In-Reply-To: <20200819175047.692962-1-rtzoeller@rtzoeller.com>
References: <20200819175047.692962-1-rtzoeller@rtzoeller.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When set to 1, GIT_COMPLETION_SHOW_ALL causes --git-completion-helper-all
to be passed instead of --git-completion-helper.

Signed-off-by: Ryan Zoeller <rtzoeller@rtzoeller.com>
---
 contrib/completion/git-completion.bash | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/gi=
t-completion.bash
index 700d44af5b..9147fba3d5 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -39,6 +39,11 @@
 #     When set to "1", do not include "DWIM" suggestions in git-checkout
 #     and git-switch completion (e.g., completing "foo" when "origin/foo"
 #     exists).
+#
+#   GIT_COMPLETION_SHOW_ALL
+#
+#     When set to "1" suggest all options, including options which are
+#     typically hidden (e.g. '--allow-empty' for 'git commit').
=20
 case "$COMP_WORDBREAKS" in
 *:*) : great ;;
@@ -411,10 +416,17 @@ __gitcomp_builtin ()
 =09local options
 =09eval "options=3D\${$var-}"
=20
+=09local completion_helper
+=09if [ "$GIT_COMPLETION_SHOW_ALL" =3D "1" ]; then
+=09=09completion_helper=3D"--git-completion-helper-all"
+=09else
+=09=09completion_helper=3D"--git-completion-helper"
+=09fi
+
 =09if [ -z "$options" ]; then
 =09=09# leading and trailing spaces are significant to make
 =09=09# option removal work correctly.
-=09=09options=3D" $incl $(__git ${cmd/_/ } --git-completion-helper) " || r=
eturn
+=09=09options=3D" $incl $(__git ${cmd/_/ } $completion_helper) " || return
=20
 =09=09for i in $excl; do
 =09=09=09options=3D"${options/ $i / }"
--=20
2.28.0.260.g5fadab5a9c


