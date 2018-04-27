Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD94A1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 20:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759282AbeD0Usl (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 16:48:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:35405 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759274AbeD0Usf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 16:48:35 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MOBOi-1fHg412YVQ-005XQy; Fri, 27 Apr 2018 22:48:29 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 3/4] sequencer: always commit without editing when asked for
Date:   Fri, 27 Apr 2018 22:48:28 +0200
Message-Id: <b4c41988ab591e5b67c78cca91c834ddfc8ded84.1524862093.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.33.gfcbb1fa0445
MIME-Version: 1.0
In-Reply-To: <cover.1524862093.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524862093.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
X-Provags-ID: V03:K1:7xUDorn8xfkcmtnKDTfgFPvKX87DDLLNjA90lXN7NKUx85V17bg
 S2rnlfd9rX8GvzaprqbO5NsouB8UHgyUctR0XbGqswfFyP3mLEv79hyu0Mc3GQIcDRlPtCL
 Jv2haguGsfAUOyxx1K+hJbj0CdUNbtt4+D1qDUqi4rknARQJMZWEwFsi5SvmYl1DRvVrg7y
 fZpVyoE3JaoBhFyKj3nww==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0u5uQ5dkhQU=:PXMxGZf/ekleqqOUXNaHyE
 omNEukwFGQ0Ejr+zhbzCHbOemWWyf70/Kp5/GrSexZy7iifWj1Vc5mOlh2ryIRp8oHisxlMAa
 KXQGSHa7MTLWmVKgB8w4d85jwUzy23aL/75h0NB+W10kyBOXM9kDlmoq1ouJk9eINE2XDU0zK
 HGIdU7GUfmYyqzgpd1mT5li/XmQxyduLycQ/5Eh/DEnsc4nffzoYaFKgNztffuT8xItxqmZmP
 bkxmQFNsBFb0ZPAP4Zs/n0ExA6x9qz6WDIxVjDvqS1mWzu/9FiTKzJEg5VTpsi2xY+8pMacEp
 1+4BoE3dJc7/mHixWRq06TCSR/QeSAkWNdYpxc7dXQZS1nGdtXYVlsFJF0z1qA3xnYAxBjkcb
 LvvG3iMuYAjRu+HXVLm6noCUZlKTmYLLJ8llr1DwMBADJ7Vtc2+8Ok61EC7420Zv6UzV8s67N
 UG1dSRYiUv9d07iCSddOjdyzCzKAEx0sgPJ69JcbdL93g/ceM29gKNw+s/WFFr+0rIkzx0fQs
 O2OeQOHuWSvaC4se90NYf0jd9MYPfuw/TyBzch2DMeXd9npvvJ1/TIG1x37rc6cqU2rSu56lh
 y8JAJDTWGVc5igYqsJG1sTJAn+W/Pybq4NWWaZnapfpRyfYjkxKwOMtixeM4/JjlAxLxLERCm
 ted3psFTu1mDktb9WpCcf2itsIaJhP9r0qwmy9cu4gemSQOHabtkRztBmZUpj479qQ4TCsnZ/
 49+JUZxMTnnZezwUmKc+FdoGUiqC318RlS1ioKkwgj2uYipbVRLh8LRBrnHw8xURO3kEXgJd9
 gSyxcXS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, we only called run_git_commit() without EDIT_MSG when we also
passed in a default message.

However, an upcoming caller will want to commit without EDIT_MSG and
*without* a default message: to clean up fixup/squash comments in HEAD's
commit message.

Let's prepare for that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index d2e6f33023d..56166b0d6c7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -717,6 +717,8 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_pushf(&cmd.args, "-S%s", opts->gpg_sign);
 	if (defmsg)
 		argv_array_pushl(&cmd.args, "-F", defmsg, NULL);
+	else if (!(flags & EDIT_MSG))
+		argv_array_pushl(&cmd.args, "-C", "HEAD", NULL);
 	if ((flags & CLEANUP_MSG))
 		argv_array_push(&cmd.args, "--cleanup=strip");
 	if ((flags & EDIT_MSG))
-- 
2.17.0.windows.1.33.gfcbb1fa0445


