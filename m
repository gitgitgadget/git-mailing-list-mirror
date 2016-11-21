Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06B391FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 14:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932325AbcKUOSe (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 09:18:34 -0500
Received: from mout.gmx.net ([212.227.15.18]:57058 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932307AbcKUOSc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 09:18:32 -0500
Received: from virtualbox ([37.24.142.46]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSutp-1cIYs81D0v-00RtTJ; Mon, 21
 Nov 2016 15:18:25 +0100
Date:   Mon, 21 Nov 2016 15:18:24 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: [PATCH 2/3] stripspace: respect repository config
In-Reply-To: <cover.1479737858.git.johannes.schindelin@gmx.de>
Message-ID: <5567548295222401fab10d3f2901c1787afbfd07.1479737858.git.johannes.schindelin@gmx.de>
References: <cover.1479737858.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jXlSbVYKBHGeXIbQl8GR+ICyZz7CEqRZj03ravASXAQ5Oqo1XXm
 fDGYqBoK+sSnBr/ydLcO/Lq5KKFfPZOSrb7NRmWkmqCITUzyfoS2jlqdjhoY4XJSFEWdzF3
 miPJASCkeVoiD6Q0jY1eqjhCT1FlQodNX1vG5cslLKJnGlFSetd3YRAsH8fIDagxYdpBoWI
 PAKOL9+Qgc1fsmxOpDOyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7QBNU4To7CQ=:Nf2Ay94X9bnz4c+SxvxtNw
 2uMzd6o244Yf6o+44fEv15TrKsGy618NntmZEvbMtwTv7hBXE4cl27VWzJwgVoqT+ox1dJEd5
 JDUFv3dC5zHw5dPYbUbVhV1PPQDHcry1Jn7QdtHJhxiQkd3cPwG3Y5ZnLPX1ZxPc8qmn48Acr
 +PKyRswKGySi+2e51R+0/pq+QnARiFT9FIkcl08ihCIV16k225yJtNB0ynfyJGmg7qpgl+rsX
 gx3HMoUPTsQJn8ppCKn93zXyjJ2R+gDRg4q5e40Bf+58UQxUhcrIW13yWa/7WsATUrVHTGRLr
 357waYzQfWFSifGQ9z2LJ8UxAQ9bGbWgB5941d5H9AyosTRArevqyI5fXIttCbkcC+l2fkW59
 dr0RwJNoZsXt1SsS3zPNdUcCN2xcX6TCGuJqNLMeEXZmEvaoFI6lcbzH7eL7ASLeQ6tM0Injn
 1esLQGydtXzfeGTRf48tn8OCbyX+RoAmebYYOUxVnChXOpnOFHXIKAK/nfn5KhK2XvZScHzIV
 6fP4krvYZ90PxbVQu/a3B1YNMF9zHemtyZQyv1Em2hHzxmjcdGN4U89AdFru15QUqBQhmWOLs
 HelsKXQ6xiy+Brruu4D7sqA4Xh8/N4HQDuuazsR2JxSK4I3W3fwSTr08hwdgviaS6NBLVtOWD
 yUu+vrcuM9HFiS8UkUNVfDdmA9JqwlEvVMj1Pu0YRAOmpCtdVCNiN+SB/fhc/7JvPCPCjmPxj
 AoUbrQuV5ePDw4avoCZz6TrAjUFqNIcuCBnYwbE60PrBBPDHfChxfNrNrfL5hX/Q2+VgIsUxJ
 EN5G4zZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When eff80a9 (Allow custom "comment char", 2013-01-16) taught the
`stripspace` command to respect the config setting `core.commentChar`,
it forgot that this variable may be defined in .git/config.

So when rebasing interactively with a commentChar defined in the current
repository's config, the help text at the bottom of the edit script
potentially used an incorrect comment character. This was not only
funny-looking, but also resulted in tons of warnings like this one:

	Warning: the command isn't recognized in the following line
	 - #

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/stripspace.c  | 4 +++-
 t/t0030-stripspace.sh | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 15e716e..1e62a00 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -44,8 +44,10 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
 	if (argc)
 		usage_with_options(stripspace_usage, options);
 
-	if (mode == STRIP_COMMENTS || mode == COMMENT_LINES)
+	if (mode == STRIP_COMMENTS || mode == COMMENT_LINES) {
+		setup_git_directory_gently(NULL);
 		git_config(git_default_config, NULL);
+	}
 
 	if (strbuf_read(&buf, 0, 1024) < 0)
 		die_errno("could not read the input");
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index 202ac07..67f77df 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -432,7 +432,7 @@ test_expect_success '-c with changed comment char' '
 	test_cmp expect actual
 '
 
-test_expect_failure '-c with comment char defined in .git/config' '
+test_expect_success '-c with comment char defined in .git/config' '
 	test_config core.commentchar = &&
 	printf "= foo\n" >expect &&
 	printf "foo" | git stripspace -c >actual &&
-- 
2.10.1.583.g721a9e0


