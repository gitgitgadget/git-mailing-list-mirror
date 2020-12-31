Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9409CC433DB
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 23:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C0EE20658
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 23:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgLaX5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 18:57:38 -0500
Received: from mout.web.de ([212.227.15.3]:42017 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgLaX5h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 18:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1609458941;
        bh=zo0JFZoT2p7tjDHm/QkcdssWs0vfog4GzQ5/eGnjAN4=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=r3nKq9To/3wwDwu+K7wisab9ER+mczLtzrU7pKmnbKNlNoiaaTD3STty8nADjlxKK
         CkSBRYKi0K0cGulSSjtPE3nFhuSGI12getx5jAaNEZPd9zhCzIBaCXm7MjZsFEOj+v
         44GTMPnVleknpsBIWxjvTupq/vIeYlQq9SOvMOiA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ldmkd-1kCxTD3V11-00j19U; Fri, 01
 Jan 2021 00:55:40 +0100
Subject: [PATCH] rebase: verify commit parameter
To:     LeSeulArtichaut <leseulartichaut@gmail.com>, git@vger.kernel.org
References: <ECF77241-0631-45D6-8B79-4250EE777A5D@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <49e25873-90e0-8ae2-7a40-01bec3f99e5f@web.de>
Date:   Fri, 1 Jan 2021 00:55:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ECF77241-0631-45D6-8B79-4250EE777A5D@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1p11OKY8GcWR1YRoMjGtp49UIl8Kvf+qIpl0sGznTlRlaV1hdPn
 spyUfvDexMhhORIId2oPb9g2KMcOANiikXtYmtTHaHUpQ6IFpVhC0WGVvBiOiztA5mzdwn3
 GCzDCD6ls3Ht0JzDVtDaHLNZgUeEZB+yxqC7q+4wOFXE+/lEZNnzYv1X0Ozj0MtlVqHpj9Y
 yslgt97hI5A9QqGFySDrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vGeUGCcrBsM=:hW2KzSoccSimGsUcrZ8FV5
 02+/rDjIUAJzh686p1ay9B+F5BlOY1aYZGa13hIU1AkonT5OPHnXwRjvtG+oIBkyJ7ACcIrvt
 MMkIxBsu2EDnwwNvTtAJPzesJ4miHTZsqLFH4iF/q2siRfJ+QHdKz5RxbzCyifwIfIt55B45I
 TmLFnFp3X+NWNBxcySDtnSdsxC+hlAUcHOi/vfSI053XveYFtRT/XVl9srHtq+E21zAVkPRFh
 4pptnkNawo72fORzXsr2EJfW7VmD2XbQ44oX/blD4a1lI2B23FblEPE+tYAqEMr3rRNIVE0At
 XrU6JsG/TpsfhievK7iwgganFTAAoelcODaBDuNBPK76LFChSlxRJnzFO4TTQrkp9A38OgTsf
 KL3eXaD2SbklPLx7UA0BfRRN20aElOrfnCKdtMLrlyoFTvwz60whGo8cADaEecc+75HfnXBF+
 tTQvggjuoIBgaKRww8KCnFM4G+RbaQKd8FENUrAefbELR/PMO4i8MfH58tVZya1QFOWn6vVlA
 5+1R5GfWfkd1FKulIj7SG+uuron/DyAlG8QPwDYEzokWyxhe35rrlT50oybtO0Kix9xlHxHjo
 naBhP38OxCXduQ7NQBQvz0QT4HmSLYBUZ9ZE1Anhg+G8nHDabEgWPvGeqGQ3d3NxapAyNypn+
 jwXmB22ALi6GyDF9PdYRHDBezUpXJ+Ak8qDqpNLOQ226yhCUTSemyizDa/Leq2dMLf45inw9J
 8FckZOPLnn0c5kYe1HaPWFPFFuvdWp6LvwXrs1tEwXrIlIYyUtRW9LbyWa6UqcGa5J72FY8st
 IhnTE1OQhxkaW0OPKuNQ9oibvnuCDXnDCrTup07TmGSd6P9wAFOSyMgSsWaZNCl5oXSNB6sIg
 GsE52f8d8LcpJzzzR3+w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the user specifies a base commit to switch to, check if it actually
references a commit right away to avoid getting confused later on when
it turns out to be an invalid object.

Reported-by: LeSeulArtichaut <leseulartichaut@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
git-legacy-rebase.sh also accepted non-commits, if I read the code
correctly.

 builtin/rebase.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 19c7b377aa..840dbd7eb7 100644
=2D-- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1917,7 +1917,9 @@ int cmd_rebase(int argc, const char **argv, const ch=
ar *prefix)
 			die_if_checked_out(buf.buf, 1);
 			options.head_name =3D xstrdup(buf.buf);
 		/* If not is it a valid ref (branch or commit)? */
-		} else if (!get_oid(branch_name, &options.orig_head))
+		} else if (!get_oid(branch_name, &options.orig_head) &&
+			   lookup_commit_reference(the_repository,
+						   &options.orig_head))
 			options.head_name =3D NULL;
 		else
 			die(_("fatal: no such branch/commit '%s'"),
=2D-
2.30.0
