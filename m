Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D418EC388F9
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 12:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57FE1206CB
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 12:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="BGlOQ2OT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgJaMsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 08:48:05 -0400
Received: from mout.web.de ([212.227.17.11]:56635 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbgJaMsF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 08:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1604148479;
        bh=Sd7TkMGFBeizJfgUgS4H3mAc7IaYOSkpqIZxmnAyyZw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=BGlOQ2OTLnX1l5x5ObPs1NVM8PWnVfyU2A+wqTFnQvPykYnyIPUHnuXEyu7Qt5QHX
         r7MycLvCo8/qP5utD36iEG6udmB/EKdA7FAizXOBrmQ3cCljDi8KzdZmgD41+kG8Gw
         nNO+BD9UzxfXjKwQ8KZudBxN1BmjhXZs5JGfoV7k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.17.45]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MIL4Y-1kc9ff0qI8-00EkTF; Sat, 31
 Oct 2020 13:47:59 +0100
Subject: [PATCH v2 2/2] bisect: clear flags in passed repository
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <eaefaf80-d2da-7bd0-a85f-00dfd46b7754@web.de>
Message-ID: <1d12a06f-b1ce-ae49-a18e-579d8def3133@web.de>
Date:   Sat, 31 Oct 2020 13:47:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <eaefaf80-d2da-7bd0-a85f-00dfd46b7754@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4cI/Bp1FmspV22zn7X86M/neZXx49eIiVD8Nj8JfIPpE9I3bZ+a
 Oawo1wLL99j7yaYBE8PH0k5bX/AYHW3eXqe7W6t2621auT08/z1VwUs4NplVxPKzQgqXqTs
 QxTeIlU/dQ774dLeNTeugCav7H2yx1rB5srSu5aFXNd7VwvXzPPU6RDoqrcYW0A4lhLOSwG
 zZJaNM20vRRJd8tMDU4WA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:seDUIWhuEKs=:nyOXyr+XqaEWeE08yZrd//
 Ec0wwhszBe77t38RiSbMj+3Wp1gTQcvX5I1ZBL5S2Ojmx1pQZvH5tJX8mcKTb48+4SenuslqA
 Jmc/DHUfXEJ38gtz9nsmi4Pc923XsVBCP8JaRVuhFrYFe60POt8S1wsl0KHXWQb2VUhGbzke9
 m46V+wJlTjLymrPR3yEDlhh92vqNqWsJgnj3f9U1DtnrNP/6o4Mf86IP4ClaVzzCUtohtNhzj
 Rd6ch8vCkTyeoSOi4p9DvjuNUkz45NEkhyytSzxlhFeIft1KhufanQ2lgLgNTAbvxsYlDrtTr
 +joY6NnNaEAmK+VqP5cA4EwfjfeV/R+hjqPDSnET4p/IARb47OiRGlyuVPqPDGrCdtMNjuKPH
 FW7O27Xgk0+VQi6in+PBoN+JASsdb/I8D3Zpu9L5C+zQ8l2+otQ7foG7G643ncoaexvSQAteO
 q/t33Udg5wgZ3B7+h2WOw1+XSonKOq/0yOhBxqvX0nu15BzRyvU8IQH6/XfO2OaDEY/sqwxX8
 k9el/9pXYW1gj9rKxyfnLEIvkBiWbe5wQldMfHm4EBILtudQlQjhKRi1tnOr0J8ZAUJuZIHwi
 Ra8iwvoA2J1b5hL2VCPP9brjrY4j+q9xjqec2czExTla0frdFPQRc9NSuuSp3fVOBC7scUZn2
 hErQ1kWy8tv9joNejlhXTYYHPKaCmDiiV5GIYf6U+JMEComZqyYhMRZTdSFCfWa37beVtl18u
 0mKcbFuo4yEyIvQayY/DZTs6d67Xp/w0Mz2otEXajsHAWx0dEOVF02JSUg254tXiEnrTutXTh
 fCmuWNSQx3SJp0oiLcaMR3aGPVyifB1VQuvQXPhyQC+yqLTzmuHCwTLtWFQJSW8uKWFampK3m
 ahEkUoTCBLzz4zOp8rTQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

69d2cfe6e8 (bisect.c: remove the_repository reference, 2018-11-10) kept
the implicit the_repository reference in clear_commit_marks_all, which
was made explicit by the previous commit (and which also renamed it to
repo_clear_commit_marks).  Replace it as well.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 bisect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index 3b763dab6b..58bc9c73a4 100644
=2D-- a/bisect.c
+++ b/bisect.c
@@ -1090,7 +1090,7 @@ enum bisect_error bisect_next_all(struct repository =
*r, const char *prefix)
 		  nr), nr, steps_msg);
 	free(steps_msg);
 	/* Clean up objects used, as they will be reused. */
-	repo_clear_commit_marks(the_repository, ALL_REV_FLAGS);
+	repo_clear_commit_marks(r, ALL_REV_FLAGS);

 	return bisect_checkout(bisect_rev, no_checkout);
 }
=2D-
2.29.2

