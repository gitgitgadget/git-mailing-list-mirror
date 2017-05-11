Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A7252018D
	for <e@80x24.org>; Thu, 11 May 2017 13:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932957AbdEKNsV (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 09:48:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:55669 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755821AbdEKNrs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 09:47:48 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaE4a-1dSXBg0ly4-00Jtcz; Thu, 11
 May 2017 15:47:44 +0200
Date:   Thu, 11 May 2017 15:47:43 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/11] remote: warn loud and clear when .git/branches/ is
 *still* used
In-Reply-To: <cover.1494509599.git.johannes.schindelin@gmx.de>
Message-ID: <5da6c76ca5f6805ad868b361b27ae61d8427819a.1494509599.git.johannes.schindelin@gmx.de>
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:OGIHK2Y7SYnWlSBjd3wYEC16TVbpMYsreuXcw9qj3lbYrBlV6Mm
 ZOMkB9Kr03uZIC4lx+kWInMPidTJ4rjDPAIP2+C+fvqAcqHMcb0jTQC1MSVGVpCX1JnwUqh
 4zOE1Mx1JmYDwALX+PiXcN5VBKGa+iLT3A3HBIZlqdhoEB257ZHyXnfpjp5sQh7w1Jd/E3h
 wt+7pvBxkuOUVAQSCaJhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Rw2G22FEY3Y=:c8XnE44z3I6DM8MPQUJSMu
 EWzuGP1Ic/MTI3KQUoV51/n/fQG6LMAASP5yX5JRhbN/II2vbceKrlFr+juVy1wabtjcdgKRc
 PrdaGkOalEwLm4OaM74rsxxaI8HGGC+EFB52ZsPqVRBn/HlootG2n24IfvT0ND0dYcp1mUv+6
 DpwTy8kvzxA7+ANgUW1lF8udZRZDz8DtfytzTGvGQfZ9NWTsOfDlNYufe163LFR5mgEss37yR
 06+Ogdpob8DEUIOm0wQBDj1ylyEnAsJPxuoghSoK0q0ixIPIPqofAje1B7JZNwxE9/Cu36gfx
 nc+FK6PWi+kpLMWmHuiZ5uki5VYRU/K84SQT7wiPMHuKTKfLR4zDAQ+5F88AySVXNmoHQtrmH
 U0fh9izzFW0zyE79t8irjxBDALB9tDSQb51/E//7mUi4LyNa0E8E9zik9kk099KpaVVhF33zK
 0lzwUSfL5jnEtO68UqYNQRxJMeRfLXTV0oSGJc2y2ntMte8c43i8PTPCUlbOictAWpgwiF2AK
 xZ65o7sl8r9emuO9hIXXL8OFlamfI6zZwL40e176sDDzpFxB6pIzvPckLwYT2F0/1zALLEM1I
 lr5XZnu/HPz1JAjk0FvlCdMdwozUc4wO5Av0avauUKWOEdg+U0UWu0p8uFzoIF1mWeWuG9gPC
 cWYNDNl+nLVHTZ6VCahFY5W/lmgf+6CcCnNKU+1OhZkyoMlYHzpnO5PzZkaNVdRFeAMZsxWRI
 zbQo9lNxThpPTHsANvqk54D7pT+XPCkoTIYi7JOg4ztwQczyALR0hkpiLEtmdp8v3eN2yeJBr
 Pu3THQn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since at least 5751f49010e (Move remote parsing into a library file out
of builtin-push., 2007-05-12), we strongly prefer remotes and upstream
branches to be specified in the config rather than .git/remotes/ and
.git/branches/.

For some time, we still retained compatibility with Cogito (which was an
excellent project demonstrating many useful features that eventually
were integrated into Git proper) by creating the branches/ subdirectory
upon git-init.

In preparation for removing support for this ancient compatibility that
should no longer be necessary, let's warn everybody who is still using
that feature (if there is anybody left, that is).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/remote.c b/remote.c
index 801137c72eb..04ab2230337 100644
--- a/remote.c
+++ b/remote.c
@@ -290,6 +290,9 @@ static void read_branches_file(struct remote *remote)
 		return;
 	}
 
+	warning(_("the branch '%s' uses the long-deprecated '%s' file"),
+		remote->name, git_path("branches/%s", remote->name));
+
 	remote->configured_in_repo = 1;
 	remote->origin = REMOTE_BRANCHES;
 
-- 
2.12.2.windows.2.800.gede8f145e06


