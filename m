Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D3EC6FA89
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 14:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIOOzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 10:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiIOOzX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 10:55:23 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9275E663
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1663253713; bh=ZyqRspsBwsVmCO9QoQcKENUeDxFeLE6KEpbrMUz49as=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=KUawnoOligMyNMiJEawEP+XrJ8sXwMlXfcLTVPZ40CwULSFVp+jgf47+p0aNOH4LU
         uYn6RDLaWle6gcKJFwD/f6PgRh8p7ePyc8L5Yo3YfFgzbBJPgSByrxPqnFPEUXA2hK
         M9my/3v7HqWwjZWG/N8ZXUc6lVBuRH+gQ/yinjeZ2jZ5s6QXBfK5WT8c6gcpl45xtD
         hbMKcw1pWirWT6JzoihuqjnTl6EA33mpo+Pi9i5nTal34k/UldD65br4hlS7MoHraK
         nLBtGHS2jsNWUky30PfIfJ7xq+Lp5iFT1W5vN9ik6av1bmI0Sp2mW3M3bheUSIbdME
         i3/yKyTAU/dDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.24.217]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuF8x-1pSrCm0f4n-00uIla; Thu, 15
 Sep 2022 16:55:13 +0200
Message-ID: <84018532-169f-dc9b-f894-3d19bb7b4245@web.de>
Date:   Thu, 15 Sep 2022 16:55:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: [PATCH 6/6] revision: add parents after child for ^!
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tim Jaacks <tim.jaacks@garz-fricke.com>,
        Chris Torek <chris.torek@gmail.com>
References: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
In-Reply-To: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aLKpTaKPUNP/aZ7a3FCuEQAOp4hxdYvzHOcX+itNhOick8BY6cG
 TYjTCD/FMzHEvX820MIumng8RK0LGsfoFsceB7fl3Li7pRqjYjnqoMGlfBYZ5e+epobDJe8
 VZKJQ/ui2TF3uCmoHZa1n0zPmMJ6uvjhBjunx0nzGOSPg3dSF7aIf+8ajRbVtbBQha2aeqq
 77EATy2LZX5uMc703h7Lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pOtFrS55ZpQ=:pf4SuhwpLs0A2U6ptLWHfe
 2wgfw+twNkhUItaRC/m6cWYz/ALQT20cA8JAxfhMKO1gXy6s5zdkDy+jgL+6YiN8WiBZP09Yr
 3zLkKWNwjb1+WVGJcQBC5lSvTHMXIr/Pn53wXBq4N5ESSJkzcCiT4JUMVVJ8VuJWnw/Eu3r1V
 jxyjXmBzGc+ZaMZw5wKgKRu+/Ib7gLvpJf58DRsFlyjMr9yezWEoVLNiMOyD8oinmh0UDWq6d
 4NAHeJvriaOeW4F0F2LW0Kymrbz3029Qll5Xc27rhai/veJ9P2GJ3RGDcT8qpn06okqjU7Tqr
 k0jHYaxpg2DhRpsd0QmFqnM/U9eXPS8bpFMSmqshNe/5Gcg85rVgq1rZ2wKjvq/fe4zFd4VFH
 T5C+t6VyFraevzO344GA9fWjjSa7UZHEOE8TYlynA4uZ/o5YM4mVTy88NvDbK0Geu2mUgFEBC
 atnn+YmgIWXvf9thkOAbwM1htn4dzqHIJupEPSw+ra7MPXuMaWEcwsCF9zZJwWHDHvrbUom+Q
 xXiPSAlLn7TmtmjFiOqv7bcmF5B+DUdwsMzox9BB2pPyog3eVjD+i00QbPg20rV0IeX1KWrcP
 ezx5DtZJ3+5jQGQ36m6medZaAPSQxSmRU60omxixSpBScFoRR3+eQLtKxai5x1aPTiulSwMZO
 Nhv7gqOBHQs2ZcdnwtBzroMeqyqfL23qm5l7sFg+vRnHWLx3btMEmYOpuKc5REAfXQ2/H+x1+
 9MomlosgJqwIOWmOXJYrzk9r529ProIbP0hYzg9SbE75aR0k+YMBQxS8rGQlO1cKx255bXXsX
 AenchqJmd1Y3WvYhqXAiHOd0/y/tKYO0oZILV97eMUimL8wZqLSHZuMGmti73ztPFm+BuqBEU
 Tuu9W7PKiqrjup6A5OEyOebluNTfY2mxwxlDYXyLGmwsL2YUynr+O8+L11alwbNLqLhnWR17F
 CI/iGZNKpVgeEGjmipZN8IPzVnnNlG7eB4E0N4qi5hmOtzbeqSkUdc6MOzD9NV1keDf2vgm8X
 3yGuptXLyItiqjZk/cSrXioDME6/EeRU1dJMoR18iJh08akiVjljUiP4nQ3pT9iXCRP835UU+
 GFsz8pY8b/T6As5xbzlJrdKU6jESb7eBJJdFrTjZajbkifzMXZpVb4dfMc+nVZEdggLyo+Y+Y
 rAw/o=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gitrevisions(7) says: "A suffix '^' followed by an exclamation mark is
the same as giving commit '<rev>' and then all its parents prefixed with
'^' to exclude them (and their ancestors)."

handle_revision_arg_1() however adds the negated parents first.  This
leads to unexpected results with git diff and merge commits, as that
command expects the documented order.

Split up the handling of ^! by moving the actual addition of the parents
after the addition of the child.

Reported-by: Tim Jaacks <tim.jaacks@garz-fricke.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 revision.c               | 13 ++++++-------
 t/t4038-diff-combined.sh | 10 ++++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/revision.c b/revision.c
index 5e756b76aa..8385127f1a 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -2107,6 +2107,7 @@ static int handle_revision_arg_1(const char *arg_, s=
truct rev_info *revs, int fl
 	const char *arg =3D arg_;
 	int cant_be_filename =3D revarg_opt & REVARG_CANNOT_BE_FILENAME;
 	unsigned get_sha1_flags =3D GET_OID_RECORD_PATH;
+	struct commit *caret_bang_commit =3D NULL;

 	flags =3D flags & UNINTERESTING ? flags | BOTTOM : flags & ~BOTTOM;

@@ -2135,14 +2136,9 @@ static int handle_revision_arg_1(const char *arg_, =
struct rev_info *revs, int fl
 	}
 	mark =3D strstr(arg, "^!");
 	if (mark && !mark[2]) {
-		struct commit *commit;
-
 		*mark =3D 0;
-		commit =3D get_commit(revs, arg);
-		if (commit)
-			add_parents(revs, commit->parents, arg,
-				    flags ^ (UNINTERESTING | BOTTOM));
-		else
+		caret_bang_commit =3D get_commit(revs, arg);
+		if (!caret_bang_commit)
 			*mark =3D '^';
 	}
 	mark =3D strstr(arg, "^-");
@@ -2179,6 +2175,9 @@ static int handle_revision_arg_1(const char *arg_, s=
truct rev_info *revs, int fl
 	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
 	add_pending_object_with_path(revs, object, arg, oc.mode, oc.path);
 	free(oc.path);
+	if (caret_bang_commit)
+		add_parents(revs, caret_bang_commit->parents, arg,
+			    flags ^ (UNINTERESTING | BOTTOM));
 	return 0;
 }

diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 9a292bac70..2ce26e585c 100755
=2D-- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -80,11 +80,21 @@ test_expect_success 'check combined output (1)' '
 	verify_helper sidewithone
 '

+test_expect_success 'check combined output (1) with git diff <rev>^!' '
+	git diff sidewithone^! -- >sidewithone &&
+	verify_helper sidewithone
+'
+
 test_expect_success 'check combined output (2)' '
 	git show sidesansone -- >sidesansone &&
 	verify_helper sidesansone
 '

+test_expect_success 'check combined output (2) with git diff <rev>^!' '
+	git diff sidesansone^! -- >sidesansone &&
+	verify_helper sidesansone
+'
+
 test_expect_success 'diagnose truncated file' '
 	>file &&
 	git add file &&
=2D-
2.37.3
