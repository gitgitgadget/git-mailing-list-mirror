Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454341F790
	for <e@80x24.org>; Tue,  2 May 2017 16:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdEBQCZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:02:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:53074 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750725AbdEBQCX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:02:23 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MGBB1-1dKgf31e6h-00F7i5; Tue, 02
 May 2017 18:02:06 +0200
Date:   Tue, 2 May 2017 18:02:05 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 12/25] split_commit_in_progress(): fix memory leak
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <8cc59c706934134294e91a99062f7dcc0bda17db.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:adNc3oQgJnB8DErgDHmnmxaBZG0UlApNokqTyozAavMfozLIiq3
 J5bp5EBnYEbuhgkliL2MLEhojZUt6ni+VWhtJnwQsKbPFQaW2HNz/gorAaC5+qur/LS5HA/
 ud4ARYxGJjCBH7ANzC5kqEWjCyKlOXC6bAMRjoafNyLYS5RgW6HtTdr9j4D6r9aoB+A6sKU
 cIqfxkMiSoRJeynpUsGqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:S1FfVGcF+og=:zv7nojDUnc4iQ02+X4z343
 Lvlpc40zUxEQ9crNOIB1Ka+NvRj+LhBRq/NzBYEWya/iPFKZRbugEUxAESVTC9Ckf4Op6e0ap
 +ZFz/Rpme8j/HZUKWl8wCTxDTDlnT5edvFw3slDc3aIvQzT1lUXfnlu/KPdD7IceXXeNEkvPy
 xn709YdJ1BdUdnU8MhU+owIhi+iZhFucgALfJLEQDoLk6XrImqyR5bfSa2Z30LjvvCVTM16WC
 0aIaF/WAqAE+WH/gv2N5RotjXPY9NsQtNA3RUoqcwPLpBWPxxqDrJ91teAoQtgWuxaWBvqJPe
 z1+PeJELTg4LwA+ina69J5Y7Ry8b/27icudRynYwNbhKE5dG8zJDf9fV4uPy/z5aAPwtt5fQB
 gmJ/L8HT1Yt//1g3d2cmfMt+Nd7lf+39cpQM+fngNQpzjfZBPBw6wUT+yU8m38zVcOKRpzZ/f
 yweQeKZUz9iNzVY0ddz4j6FVQYRXtEX7oyQVUrioIlfDDQLx/kbRjIo2WMrVM7Inoo2h5Hoin
 YTGmGwLK9q/X38qrXHHSiVWRMv49iu/XtXzmsutiFHOjVmx/FQYTyWE7arwpL2i46JxipEq23
 XnCjLbtzc5S6oaG/R5UM1hRYt40bV2lOjx8lHGuUVhmiYfohSdzbxUgxOEkC1G5y7nR3wPLRL
 pimhiZ0jgLO3X58QtWqwUzr9WhfwiwVWIXkuVp2bACYfvGlvaShTTKhQOryHKGExkbyfkk3e2
 6z0TmNh5rITvQD924Cpq4kuPCJomTvhCHfs0wfPNAxt3MKALcz7c71XsqM10Q41hc5cAxQipK
 wmvTxpx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 0a6e16dbe0f..1f3f6bcb980 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1088,8 +1088,13 @@ static int split_commit_in_progress(struct wt_status *s)
 	char *rebase_orig_head = read_line_from_git_path("rebase-merge/orig-head");
 
 	if (!head || !orig_head || !rebase_amend || !rebase_orig_head ||
-	    !s->branch || strcmp(s->branch, "HEAD"))
+	    !s->branch || strcmp(s->branch, "HEAD")) {
+		free(head);
+		free(orig_head);
+		free(rebase_amend);
+		free(rebase_orig_head);
 		return split_in_progress;
+	}
 
 	if (!strcmp(rebase_amend, rebase_orig_head)) {
 		if (strcmp(head, rebase_amend))
-- 
2.12.2.windows.2.800.gede8f145e06


