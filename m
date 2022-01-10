Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DFEC433FE
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 09:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242896AbiAJJDk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 04:03:40 -0500
Received: from mout.web.de ([212.227.17.11]:38293 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242277AbiAJJBc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 04:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641805283;
        bh=KyMpleeQhCW9l+k4Fcnxc9PiHKr1q7H2DOdB7T46mcw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=AfZrgMd82jPFIfpvr+K27WxUGBnZizF1JakO+yOvS/qh0Jbm7I1mitBeeFKQ3rPNs
         M58cKLJJkMDgnpuCBCW3leF8N2Ykihyym0/+OsAjlbCQa3hui0dBMHsiHaZVVDg1Up
         hURLM0ei1lm5Y99WuyFAc2XbL3g/NQWzz9hwuhrM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mw9xG-1mGwFy44Bg-00sQr3; Mon, 10
 Jan 2022 10:01:23 +0100
Message-ID: <5d8c8a72-6c4f-35e4-a6a4-4ed7d6f23c4e@web.de>
Date:   Mon, 10 Jan 2022 10:01:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: [PATCH] bisect: report actual bisect_state() argument on error
Content-Language: en-US
To:     Ramkumar Ramachandra <r@artagnon.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y0xvtqNZav5duPETsfHjim2ZuQUAD4r3i6C8YADg24VIySMgCOy
 bBo6V1OS1LvT1pUTvuSme9UQpHRnnyf5k79JCLK6Q+BbReS9Hx3yuj6bFDIi3SEl6DHvxE6
 /177OSJ5MEkQDqFSJ4k8NGpyDRWw1bVJGWNiqVQEeCvMAXmv5aLOjMWP0O490sXuUMR5kEc
 c0QYWicfoX9JkmJQj/nIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MKk8OR1JLec=:kutH3Tbk4Yo92aJ+8DVHWQ
 l+imu8PA9LfWGkrWRO+4ELaI4QhHRDZgDy7FIauhto8ribci8KGErsK/rOC5p9aJh1htCn/A/
 AB03qtc1+4TUR2jO/ezz+PgRxB4DCfajgOvQt+bm8tNRJlpOwfvZYC5U2nldDptwbsXRZVoFX
 RRq+c7k6euYYFB3T1K8lrB5mau3ol9+2gjZ5EooZE4qEizaqE7wU5vva6AsAXQ4lIzydhJPGm
 hEyz6uT0xJ7PBULGJSd2fvCA6FSCIkthqt1dw5PagtlaFRd6xYo5hlrU4zBckuicrgmLMRx7E
 Dcd4kzXy3W87sKMM/wQl3DDXOYg8NwqidQlAdp+wM88oJsSzY91PJvH4yLiHt9QPP9YLkHQ8Y
 uVerjVTtndjW6QMcYity5RuHvSxXR9REnUweI7cTNK7lU85yEt+rtjJV0nMbPEYqf6HCK9Re7
 s3KoPH9DEGlCSZENmKtNG9AQFqgBYNqWEEQtEdVB+KaVMM1tbLiiON4zEs4RLFcjvKwK4wK0R
 bSaDkO74yb4YPovK1NQifpiOkU1nNH4HGOv7W1PiGUeLkiNSZ6JJo5Sg7FQY3GPdXrluPVT7F
 HRH8SdhRNnP+eKi/QqhNou7R1GdrcrB1ijOdzk0d8HG/+18y8vScaip1xdVJpjvPj/SsPlLAG
 p91HyJKjKDGLr4xTj98zNkklvSBi+8RTPILBbnTYaZ0eC4XVTPHO2NCd4nZVnqmFIS8+hIGLt
 3gO0INV43HJII3aKqwn4Ca3o5exJ55FsQFkUlK+VTWtoHMlbe5p51gTYu9s6Rbl6CVMqNLYDm
 rKq3anVr5gMWp1W4k28NJ8W1KwUx/XCHVyu0qIYa4Mud1U4un3wwcTroYGDeiiqL0G1qkmuZs
 8nYS1PRu1xA1lF1heUW5Djy3l/lT9pPwIOI3fmeoj4wMHvDCp2ZM/kDumHaja5nyd99Vk4sa3
 3Hrz28WIIN6xWV6CkQNO0pT9mgodS90ZdZgB+L7Zvpklqy7t4QsYQNdnJoPCnYflPoic47QMc
 i+ML+V0l2ssHKhXPHolmGYFY5LLwym58zpWhnfkojsgf0m2e7KRla5hqCjBUtQiptw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The strvec "args" in bisect_run() is initialized and cleared, but never
added to.  Nevertheless its first member is printed when reporting a
bisect_state() error.  That's not useful, since it's always NULL.

Before d1bbbe45df (bisect--helper: reimplement `bisect_run` shell
function in C, 2021-09-13) the new state was reported if it could not
been set.  Reinstate that behavior and remove the unused strvec.

Reported-by: Ramkumar Ramachandra <r@artagnon.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
This doesn't fix your problem, only replace the "(null)" in the error
messages with the actual state name -- which may be useful for
diagnosing its cause, though.

Patch generated with --function-context for easier review.

 builtin/bisect--helper.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a575..1dbc6294ef 100644
=2D-- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1092,80 +1092,76 @@ static int bisect_visualize(struct bisect_terms *t=
erms, const char **argv, int a
 static int bisect_run(struct bisect_terms *terms, const char **argv, int =
argc)
 {
 	int res =3D BISECT_OK;
 	struct strbuf command =3D STRBUF_INIT;
-	struct strvec args =3D STRVEC_INIT;
 	struct strvec run_args =3D STRVEC_INIT;
 	const char *new_state;
 	int temporary_stdout_fd, saved_stdout;

 	if (bisect_next_check(terms, NULL))
 		return BISECT_FAILED;

 	if (argc)
 		sq_quote_argv(&command, argv);
 	else {
 		error(_("bisect run failed: no command provided."));
 		return BISECT_FAILED;
 	}

 	strvec_push(&run_args, command.buf);

 	while (1) {
-		strvec_clear(&args);
-
 		printf(_("running %s\n"), command.buf);
 		res =3D run_command_v_opt(run_args.v, RUN_USING_SHELL);

 		if (res < 0 || 128 <=3D res) {
 			error(_("bisect run failed: exit code %d from"
 				" '%s' is < 0 or >=3D 128"), res, command.buf);
 			strbuf_release(&command);
 			return res;
 		}

 		if (res =3D=3D 125)
 			new_state =3D "skip";
 		else if (!res)
 			new_state =3D terms->term_good;
 		else
 			new_state =3D terms->term_bad;

 		temporary_stdout_fd =3D open(git_path_bisect_run(), O_CREAT | O_WRONLY =
| O_TRUNC, 0666);

 		if (temporary_stdout_fd < 0)
 			return error_errno(_("cannot open file '%s' for writing"), git_path_bi=
sect_run());

 		fflush(stdout);
 		saved_stdout =3D dup(1);
 		dup2(temporary_stdout_fd, 1);

 		res =3D bisect_state(terms, &new_state, 1);

 		fflush(stdout);
 		dup2(saved_stdout, 1);
 		close(saved_stdout);
 		close(temporary_stdout_fd);

 		print_file_to_stdout(git_path_bisect_run());

 		if (res =3D=3D BISECT_ONLY_SKIPPED_LEFT)
 			error(_("bisect run cannot continue any more"));
 		else if (res =3D=3D BISECT_INTERNAL_SUCCESS_MERGE_BASE) {
 			printf(_("bisect run success"));
 			res =3D BISECT_OK;
 		} else if (res =3D=3D BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
 			printf(_("bisect found first bad commit"));
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
 }
=2D-
2.34.1

