Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBDCD208DF
	for <e@80x24.org>; Wed, 30 Aug 2017 17:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbdH3Ruw (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:52 -0400
Received: from mout.web.de ([217.72.192.78]:58677 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751996AbdH3RuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:08 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LecNe-1d9s2L01iI-00qOWV for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:07 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 11/34] diff: release strbuf after use in show_rename_copy()
Date:   Wed, 30 Aug 2017 19:49:42 +0200
Message-Id: <20170830175005.20756-12-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:YINn/o4SiY21eADcrjVhQ1CLzanYox4s/EPzxLHID3fGy1E2ETx
 BRGpVy979mhgJO3+Ws9bXtF9J3bTHC0+3OdJvSyu+di9ifzVMhMPeWC/ndYgVZkb89Ns0M7
 F2ao66EaE3CjqlVDR0qaV15kBrb+0lFAwSpoc1Ap7bV9nGrC50pCWTumJkuVx+nirUpJTq6
 2+szIrf6Yc+9GcjJxQv+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:07H3z6H6g/A=:BkGf9Wp9DgLnkdwdN9CuV0
 ewomPgKPcmFipUts6ayXInIYu87HJexzC5sR76vrfVc61uwjOuEuDIMDAFA3M+9Tag2fVQguz
 6oznKf+o4NdQBexbPKPEvMp9XJ3F9QLJjrM0bgL22cXVolSIkxDGrCTecfXCFkr29gJ+QQ3Rs
 eEQ+LC8E2rxJXXm0ZizfkcTRsnvR2xeZTmKOyrnRe8GaW2WrS2GT+y4VSx7H9/3W0XVbNhyjm
 EfgFti96mBcQogg7BHykhcTecsqW58VbNQ40dn2QfboN7uRwx6wgApSi3dCWoDzAgF8zzdtKp
 AaHYNsELwzZ/xJW85292Ohn1yWTzcgYie+VDkbpbv04DuEI+ethIvH8sop3V3lZgoRHoM+TTj
 CTiaS3hzYQk1l5D98M2qscm7T4E8KBJf0uZVGi7iQGvmDTlbOXiPIEzjm7JrFx3lj5/5h121a
 iszynpEPsMmM/Ukuflk5PDWpMDR3YjcwtR+HtAcEJ9arpRaG+d+73NG7V+xV95MWGK6M7N7RI
 e1RB8Dn87KmAUGm3HVxu9FT7+sUSZzpyrHumKWVGf+C5BpvB/IlOKHkDL7zNrMJME3xerspoM
 zVyPnCumcIkPvnQpXO5lcWFkQDyujJ8fNwTPqp47ntpHhDbcmEBoFKbd5dXkX1BUTlAC7YWrI
 rT+Hb2DzdiULhI4OmfJZCp+UzuOe2jrmrHRODBSkfjVS1fe7oNAxWu2JkAMnn4cPEHYa7LbQm
 WS8fZcEyaxmSTI9nDxQs4joMjqmzx/6OydIhnGph+l2dCddaViv/paMGAUg2/mPnji26wsbtC
 WhfYs250MC93ovzBPUFBKNEmZQOyA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/diff.c b/diff.c
index 4148ba6980..33c65f492d 100644
--- a/diff.c
+++ b/diff.c
@@ -5281,14 +5281,15 @@ static void show_mode_change(struct diff_options *opt, struct diff_filepair *p,
 static void show_rename_copy(struct diff_options *opt, const char *renamecopy,
 		struct diff_filepair *p)
 {
 	struct strbuf sb = STRBUF_INIT;
 	char *names = pprint_rename(p->one->path, p->two->path);
 	strbuf_addf(&sb, " %s %s (%d%%)\n",
 			renamecopy, names, similarity_index(p));
 	free(names);
 	emit_diff_symbol(opt, DIFF_SYMBOL_SUMMARY,
 				 sb.buf, sb.len, 0);
 	show_mode_change(opt, p, 0);
+	strbuf_release(&sb);
 }
 
 static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
-- 
2.14.1

