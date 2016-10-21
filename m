Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF0DB20229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755362AbcJUMYW (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:24:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:59637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755305AbcJUMYS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:24:18 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MPlMc-1c1Qko1PNa-0052k7; Fri, 21 Oct 2016 14:24:04
 +0200
Date:   Fri, 21 Oct 2016 14:24:03 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 03/27] sequencer: avoid unnecessary indirection
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <2c79d34e66b1f2b1a4b0f30445996c6c1a89d39a.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Vartah8S9Ig+KvFNa0+RpRmuH6/rCblC9isSdBv9/lSR642jT9p
 feFgx5MJAZFAF1ObgoN3MTNB9a9gZzBLXlodOvw9wLCU8v1OIgne4bxkw8OlQjvvPqGK6+l
 vJ+NzXGQAVcX6yqeBDo2PYaihMtR+6vw5mFJrQzr3Ov1NjnI36f1BqnfbtrUcdzyh7IOsSu
 N5A6iPpOVdJxVgiVmnJRA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fgrmgQOB03g=:0tH3wzX1tr1AaZKxYHtnjD
 fLNOO+WgVZMkT5GPdC+FiuzkohmVG9fn2cW0W9zYcj/Fv7wWl3bmbMGoqvNgObwXvhcq7ReBD
 23EitfmtjcSEDFihHiFaWXbVplimKV9dV+ytgrLooq6/rgY7CyPvTbenS0jjHQl+X4dIAeElS
 GOwtz1ISFC8bBrspTuc2aivEHeQfqzJy74d0T6pN1ZiALtvXSpktK24yRuzIaSlFk2LEJDCRM
 hZyDgPuaSH7VfvIpVPHTrEAJZzx6A/pD7nNc3s1snCuBAjD8AiVNmlskN9AfNiEObz/hEDkzu
 QTIJoaCuGOMksI/6MWjOjGutiw5yioR2IOcKiam26uekBjHmgO+mm58GVFCUJ2x1WTRmJxn3q
 4RsxlGqPOL1IYfMWVvP3/1s9rv9VYzncD+B+pf4BvXenuvgBACOEHNbULUd51TRhP8DYeP1/X
 xXJXIpTmwRXs/8/6pc0EbCnYXy26PaH6MUJB5UeExaPdRLDXN13Apl1qtfDbFjzvOy3CzKi0m
 MPml2tEcU2ZDTFM0s+orCUfWVR4xP1OytTKNVMFBFGZmRqLUhGgjkxjclCKos2BvsynIwlU+M
 RLTFh3nlkoUqb32WfBvpfCjoHqsGoeu8JE53pOy4uwnDrdBVQ5eMCOadcQO5KMuhi+k8PIdGi
 BOjGQAwt7M/MFDgl0F1C8GzuAru7Cyb8WqD0ssmMGUaHmuAgbk1LVhALv29Q23ugqIFuUPwKz
 p7G291sKFkzJqpTRXPcH9ktjSSa7wsHS3Boxuo4NGoDAfBqA7MoxVZzlRKCvvu2Jy+1VK/P81
 zkyxwhh
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
2.10.1.583.g721a9e0


