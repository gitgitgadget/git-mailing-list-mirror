Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECDFB209AB
	for <e@80x24.org>; Fri, 14 Oct 2016 13:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932858AbcJNNUT (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:20:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:65192 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754552AbcJNNSK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:10 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MHbpA-1byKg51mHs-003OuO; Fri, 14 Oct 2016 15:17:17
 +0200
Date:   Fri, 14 Oct 2016 15:17:16 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 03/25] sequencer: avoid unnecessary indirection
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <5d5694fc202ad7e4b4255c3a460c8bb3d9cb3d9f.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MMH+2FNGjRqhBSyf3Vdx7pfL3VZq08f5YuprdnveP9A8epZSOrR
 9SMGW+Y6dfcS0SCAFY2IPlK0ET6lPNorKz3XhM7J7WspsKN6PfE9gKgHnyind4DzXp/bcZM
 nKZREO7usUTh15YRB0mYLfysY3kMkPV6uemljRKxkt2+wSucgePnoDfPrBQOqsylDQluAJO
 U3PLYHQ77xQQiQax5kc2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uAo8PQnFYd0=:MOKxNvI2NDfl57DOAXevr+
 QX37dY19wIxjJj6Ga5VHpm8MLv7vkpwQnLGo3QXZEo9RCwg9aOT6JH5sHmI7P6GOaTJ/MY0bC
 TtXnSnQytJNNErXYLdHVRVKtkkoJLJIaoZsJv9MhX+j6nvhA9pD0c0IFn/xBjYRaCrECegtbk
 pFsCoktPFtsKTwnlVasfbGGuYc4vk0IMgp6yAnj/8VjgimPsSPrC+aPHpETIeO78zBRQgDH4m
 esiBUwhHVtSfrXB356ya2M7B0FGsmboKfo4sJZ68oDC3DKv6asqpoR618EcC6aCEHNAsCELuU
 5zn84KPE7z48QqRnbpPqQoHVuToLM+bH9NPvRvTI2qId7cA1gZ7UX35UEuM2TmcHzPpbYxCeK
 BZxyvvehS2qPVgxx4Kt2jKStDOg6qun3zX4NLAvsL2rL++kR1+AJTdEF4mmjiG6QBPkerCq+O
 +2xqkTiHOcAzwD/C9raQ2OCI0MhQW6XI0XkEZd471fYFpsN4EwM7lmmdDFjSjNNqW4+ETtbq5
 BekoV8hNg/gFUzvx8PExjfQfyngTkHGMWc3/Ce1XQqb6SAMGFvgYZF+TVbcuMg5IUde+ee7aq
 PrtTVfi+LH0Rf1rjT014MA5R+JAEVHyu4wxxHjpNefra7ubGOtziT72GSk7BzKob9NioRTH23
 Y4/UekgiNeAChMUG1Hubwk/FmERQEDSvRB7F+Ju2CcnnS5BSN3coDYWVsduOHRwEkyp4kHjso
 ioAQYfjm1pjzr8E3x/6Sjk6zSXx0gqH6gAb9JhfHiZ5izKKeYDtKcsq9ifLYa66QST0duWrQW
 L3bFpsn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We really do not need the *pointer to a* pointer to the options in
the read_populate_opts() function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cb16cbd..c2fbf6f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -813,7 +813,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	return 0;
 }
 
-static int read_populate_opts(struct replay_opts **opts)
+static int read_populate_opts(struct replay_opts *opts)
 {
 	if (!file_exists(git_path_opts_file()))
 		return 0;
@@ -823,7 +823,7 @@ static int read_populate_opts(struct replay_opts **opts)
 	 * about this case, though, because we wrote that file ourselves, so we
 	 * are pretty certain that it is syntactically correct.
 	 */
-	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts) < 0)
+	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), opts) < 0)
 		return error(_("Malformed options sheet: %s"),
 			git_path_opts_file());
 	return 0;
@@ -1054,7 +1054,7 @@ static int sequencer_continue(struct replay_opts *opts)
 
 	if (!file_exists(git_path_todo_file()))
 		return continue_single_pick();
-	if (read_populate_opts(&opts) ||
+	if (read_populate_opts(opts) ||
 			read_populate_todo(&todo_list, opts))
 		return -1;
 
-- 
2.10.1.513.g00ef6dd


