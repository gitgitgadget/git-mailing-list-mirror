Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFB3C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 12:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiARMqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:46:05 -0500
Received: from mout.web.de ([212.227.15.14]:58289 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236231AbiARMqE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 07:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642509957;
        bh=0Ok/U1qdYCReZRdYlnT0Cf0+vms1mEJNngogswSY1b4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kXQhN8C+WK+3hexwyLR/w4ypwoh6RSSPlp91moHNF2eLA53RBkOfe4dzF6ie2g8Ie
         7RxqdFsRpQ6uWMfONQ3klRLnp+vbmvNp3G9UTmsncurDuYQ2AJE6Fk79yiYQpLUl3o
         CWOYbhK1iqWCR4kIRVR5qHYN0UweL9my5jqDMO68=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjxeO-1mTqI92sBs-00kifW; Tue, 18
 Jan 2022 13:45:57 +0100
Message-ID: <46fe0774-66e7-8947-cd79-d35229eec25a@web.de>
Date:   Tue, 18 Jan 2022 13:45:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: [PATCH v2 1/4] bisect--helper: report actual bisect_state() argument
 on error
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Ramkumar Ramachandra <r@artagnon.com>,
        Christian Couder <christian.couder@gmail.com>,
        "Miriam R." <mirucam@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p1oqmdrpIgQSAWZwGDvRcwxpy5z31WZY8CPVKubkR/RCR6CD84w
 Jd35bOQL0ARBCGDiI54oSSlBXDlgbG9UldpinNuNET+QEZR7O77CAi9oVuuq7xf2PgWtlrr
 wyTYbzLHmsSFC4/XamnbU7SozpPb0aip7R9Ud9+Rqf4ZsA4MI7IHgja1pqtYADY8sFf6ac/
 zaB6Kx6EqBmJXJO7+g/gQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J3vejJbd890=:GurTomo12x6xKpW/4UgXvt
 bIPd4L8jLkN7DfTwIBG4P4VTuBc7B6JOmKdUqO/wF2Jqycrc1l6mVu06OD3nWH4AN3Wp/ooLv
 BtPwTRseHqj2augvDmc5pXVHA+q2GCbfMNQBx5RM9knABoq2yFbPhYsWjeBPmJZbS2sA6P6Lj
 PaxUt23rrP3E29M94tfIPKB1FEEwvyrl7suz7aSRxpZzws4AF6KIkRziVzsfEKvEAMxFKsA90
 MZSNAe93u4bTg+AHwXynDbUUWXY4LtpSRkJsng8/avL2ioDXtV40V/B4iY/BB6vNmrwUU/oNa
 a1Cx/paM3BTYu7fUtLSIj4kDpFM4A6Up6s8VVMTkWR5MXCAPU8DvbckNsbrsDBgjVc4DtflGP
 ftp+geXDX49uZ/NDApYAVeSafACnCyAGI8IH7GrVUcB5GXCbyidqxnZHCS0Am/WkBOKUZjGSd
 iqfS2eYrFEt4S48EVXWTdaDv2OSmOdIhZnThSjWpw31Ux7hvFGS5IrGfhoJ6k6/XlCena09Jp
 0AeHQL5+T0BLR4qzhYBrklDsUTWMZjNiZ5oD7kHNHDN2zFxocRVysuV7JuYX4o1I3xWviqhjf
 dcH5JP99a1Umb8D1tjODcIvNMSx3ez04lwK1nuBX60+TB1y+3ujuPovTArN6Wsj6Jz5pH5G2O
 RbLgfNe6qNHE+YJ9wgJkHlkUQz/+xFVsNYoME0Tjwn/nlHQ0XqpepGyb+o7xN/GfvI+kKnfm7
 8lV/Ep8aHrJmKwpkg+pD6dLRlH0zTSY5+ju44xTmHMhW5D/j/ln1r7V2cjpDqaofC5vYGIMuI
 +hDZmW2D+uC71IfymTyNd5jkQ8s+DDVFccZBJJnWNJJ4Q1d8wvl4kEzMsSntctG4c9F2MShnv
 QehO9WSuSUtvKioXgksqXY/+shKXPb7ardQniMNvpxw4Yy4UsttzHHg6r6rpis52aSGhxpK+3
 PYUSBeb3T/jg+CBHTFpp3i9He/JJfXkYwRLaUuybK+Uz5a7ymuS9mte6UfIhG17FacXXjQoHY
 pizrZ6hRM9a4AtSBjci6dqyvOS59SSo0G8Mht2qPw0NvrCA6dMdDKwkzwWIBOFgiP+3gxEzqo
 l0wWizazK03dQs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The strvec "args" in bisect_run() is initialized and cleared, but never
added to.  Nevertheless its first member is printed when reporting a
bisect_state() error.  That's not useful, since it's always NULL.

Before d1bbbe45df (bisect--helper: reimplement `bisect_run` shell
function in C, 2021-09-13) the intended new state was reported if it
could not be set.  Reinstate that behavior and remove the unused strvec.

Reported-by: Ramkumar Ramachandra <r@artagnon.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Title and commit message slightly improved, same code change as in
https://lore.kernel.org/git/5d8c8a72-6c4f-35e4-a6a4-4ed7d6f23c4e@web.de/

 builtin/bisect--helper.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a575..1dbc6294ef 100644
=2D-- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1093,7 +1093,6 @@ static int bisect_run(struct bisect_terms *terms, co=
nst char **argv, int argc)
 {
 	int res =3D BISECT_OK;
 	struct strbuf command =3D STRBUF_INIT;
-	struct strvec args =3D STRVEC_INIT;
 	struct strvec run_args =3D STRVEC_INIT;
 	const char *new_state;
 	int temporary_stdout_fd, saved_stdout;
@@ -1111,8 +1110,6 @@ static int bisect_run(struct bisect_terms *terms, co=
nst char **argv, int argc)
 	strvec_push(&run_args, command.buf);

 	while (1) {
-		strvec_clear(&args);
-
 		printf(_("running %s\n"), command.buf);
 		res =3D run_command_v_opt(run_args.v, RUN_USING_SHELL);

@@ -1158,13 +1155,12 @@ static int bisect_run(struct bisect_terms *terms, =
const char **argv, int argc)
 			res =3D BISECT_OK;
 		} else if (res) {
 			error(_("bisect run failed: 'git bisect--helper --bisect-state"
-			" %s' exited with error code %d"), args.v[0], res);
+			" %s' exited with error code %d"), new_state, res);
 		} else {
 			continue;
 		}

 		strbuf_release(&command);
-		strvec_clear(&args);
 		strvec_clear(&run_args);
 		return res;
 	}
=2D-
2.34.1
