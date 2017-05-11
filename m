Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CDE52018D
	for <e@80x24.org>; Thu, 11 May 2017 13:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932944AbdEKNsT (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 09:48:19 -0400
Received: from mout.gmx.net ([212.227.15.18]:56730 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932307AbdEKNrw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 09:47:52 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mda8q-1dN3Xs07oa-00PPcE; Thu, 11
 May 2017 15:47:48 +0200
Date:   Thu, 11 May 2017 15:47:47 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/11] remote: warn loud and clear when .git/remotes/ is
 *still* used
In-Reply-To: <cover.1494509599.git.johannes.schindelin@gmx.de>
Message-ID: <52d5a69b713f19d99e069054ea1a8a46828d9927.1494509599.git.johannes.schindelin@gmx.de>
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:og70qRureElnD4WCG7HLuvvHVPw/kNSYv4db+JTuP0lMwxJ1D6t
 YjtxIXROjGvBi27sVqlAnHwbmdhmo/WqXCWjJKGKedc+jevE3BrLv5OKeGrEvnOH2GlPGfo
 ylkTVSqO6Bf4QPwAzul51ej5ZySE0d45JFvvEEKvgdVNFNpTXIBsY0Un0HlGsuRtU9YR4XK
 R1rSExL42T+cNfDLAoU3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TL0+1OrQ4SA=:eIuHVgs83n7x2ie0Lj3ca6
 EUDlCFHPxa8HnY7CIOhIzt7VsXeWgC7LH8T7DjthGCHzfMSJLR5m9uDU+qHDliJ/T7uDew0VX
 ulYghiPYWDgvKxEnMENoVRrfEV1lUgFuZ+7Zc3JLHQkIaPLnhI4EQZsIp8iQKg/+gvZJdw0mn
 76yl5LkVtJ4PhDLbWnvuqm4mtJJX1fQVve3mbpPaY/aU7mXp8wcUZv3wI4vrQvt18hV9Z6Lr6
 hJUNGVwbsbhBV4ykGcX9eMlRYb6A+63ACDdF17zYgytE9ATRup8mC9ZU6ZNkEk/zZljFWKTKI
 CKhFiVYZmbnIPIXQ+gkZpy2TZZ9p2quvektIHTwnKjt2pdLrE+6+6CCAJ2mlAkHDJIZYqluyH
 UghQPGqK0B3MwDM07Ailrpxstlgfrf8Xizsif5gJhtvheVjZg6dd2beTMkFLkj3yjGG/TXuqR
 +uFEvDpOUgqaZFH8kxx0v+mu/dCnDaxKCS+BsHOnURY2Yw4om6ri+L2Dl/6pKmqcZ74OVEyc+
 hRAabrXzBO3xrduxUmBz4XysCMt0fK+YgWtzxBffyFlMT3ULJk6v9vZEtugjqDzbgOMKREwWM
 VMZAffkuiDu6wUxthxq80RSBMharfvYPkD96NgqQ8felXD8DVGoEQ4+Rm48wtzoFD9oQy6XoC
 zol4LbZhjn2hyXDIcN6GcDSjqT2IMI7wO3GMUtbc6t+2aIfU3PhANq/E0IXtvHSnLnWh32H3c
 alpedhV1IJLP5EUAWKGAHrdY79Eo4/RvrL9/GvqgDacvs/RBWNAVPIHglBB5F0VeZhhoMEkgn
 xf2wtGL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since at least 75c384efb52 (Do not create $GIT_DIR/remotes/ directory
anymore., 2006-12-19), we strongly prefer remotes and upstream branches
to be specified in the config rather than .git/remotes/ and
.git/branches/.

For some time, we still retained backwards-compatibility. At some stage,
it becomes pointless, though, as it just adds maintenance burden for no
good reason: no repositories created within the past decade have
populated these directories, and pre-existing repositories were most
likely migrated by now.

In preparation for removing support for this ancient compatibility that
should no longer be necessary, let's warn everybody who is still using
that feature (if there is anybody left, that is).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 remote.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/remote.c b/remote.c
index 04ab2230337..b2ae168035e 100644
--- a/remote.c
+++ b/remote.c
@@ -255,6 +255,10 @@ static void read_remotes_file(struct remote *remote)
 
 	if (!f)
 		return;
+
+	warning(_("the remote '%s' uses the long-deprecated '%s' file"),
+		remote->name, git_path("branches/%s", remote->name));
+
 	remote->configured_in_repo = 1;
 	remote->origin = REMOTE_REMOTES;
 	while (strbuf_getline(&buf, f) != EOF) {
-- 
2.12.2.windows.2.800.gede8f145e06


