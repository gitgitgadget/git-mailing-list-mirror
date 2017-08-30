Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 332FD20285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbdH3SAn (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:00:43 -0400
Received: from mout.web.de ([217.72.192.78]:54206 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752566AbdH3SAj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:00:39 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lal2C-1d78iE0hSq-00kMai for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 20:00:38 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 22/34] remote: release strbuf after use in read_remote_branches()
Date:   Wed, 30 Aug 2017 20:00:25 +0200
Message-Id: <20170830180037.20950-3-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830180037.20950-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830180037.20950-1-l.s.r@web.de>
X-Provags-ID: V03:K0:9yfoYGFZMpMnuXcUD33QCvtqWBDiwnC4SKdUEGhkJXVpW9epfmb
 pADr3oi+2kuOBM50B88gpkhAEadkxjH5mH2n2BIP5nHmtSs7E4Wy+FqQ2tLRZieKBAGgZoG
 SGVsvo6k8SUMInEogAFNQL2VBNNIy6CvTn0DLPJFVtUuT/WFZ2XnSIKYGO2jxjG5qzRZzN5
 eUM0iAb00TjAwDd7MCSsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GzkXXhds/mo=:0xCmjJ8rZ8ttqGwVoL185h
 YO4TZVHbiUzZhfY1NTqbZQ2tT584T1bFQ6Gb0i+VpALpllUNm8G8cVrZAGHYi8mQKHvV91pDw
 bn2d5qdvFoSPH3LiNpcMZR+xs/e+BvZAcOwTLnfavKCGtutO1IdxaApF5U355mw2kl3EwuWqC
 2C6yvRGHzknQ1pemfam7U/eV222BcjC35zcX/js7OCCGqFXdwdnS/E9mzJQWS/t6ZZkty87hh
 DW2CaYXAzrukr8gecYBmxzasPFA9lckcr0R7gjg/3SYOu07husvlS9YdNET7iljkIsb8wQcX4
 qfbavhRl2ARdolyGe4rQwEYjYQ0JDnqedNP1b7D3R+pDWv2ANi/pLjFqTWZvIGVK1J+sVF4UK
 BtT8PRpgFocMYGNqCWWBnKp3LBiNRGzj3z037EjrkNhPSwxOWNpuOtnkWIK2cDveDRPBiqgot
 JgjVny1g1/wQsRNNsgR6wcHOU12/DgReoGsFGA4wtg33f48UnTctjO6n2lwZfR6vq4i6LNuTI
 m9/J4pBAZS03zyOyhBl5RBzGRWEK0qTi51GQpZte58mDdHyPoy+afx1XX/xfdUSSoiMnk2gvC
 cmtKnSNLUduDN2BOmlQiTxc52rGdSvgq5PW+P6/zzQD9xAkyIbxc65u+FdMKYa5MwNBMeVtwD
 E9xVQOyZ/4o6Im+hLWQOMnO8BPcpmij2wUoJcGigwyYIIYnGOk4kAYuiyJLJ23FnCPwEMGZh5
 gQ/294yFsTYTczWhLhWhjpK+v7TtMBSaABR8Y6IxFU4uHfxmSOw9yVwNYOj0HQXkJl5efa4A5
 v5SDPhFxlMkgR3YE/WreZ9RbBWdEg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/remote.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index a995ea86c1..d0bf999abf 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -554,23 +554,24 @@ struct rename_info {
 static int read_remote_branches(const char *refname,
 	const struct object_id *oid, int flags, void *cb_data)
 {
 	struct rename_info *rename = cb_data;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list_item *item;
 	int flag;
 	struct object_id orig_oid;
 	const char *symref;
 
 	strbuf_addf(&buf, "refs/remotes/%s/", rename->old);
 	if (starts_with(refname, buf.buf)) {
 		item = string_list_append(rename->remote_branches, xstrdup(refname));
 		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING,
 					    orig_oid.hash, &flag);
 		if (flag & REF_ISSYMREF)
 			item->util = xstrdup(symref);
 		else
 			item->util = NULL;
 	}
+	strbuf_release(&buf);
 
 	return 0;
 }
-- 
2.14.1

