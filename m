Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A795920285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbdH3SU2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:20:28 -0400
Received: from mout.web.de ([212.227.15.3]:55483 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752681AbdH3SUT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:20:19 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfTx5-1eAafh0ADD-00P2TR for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 20:20:18 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 33/34] wt-status: release strbuf after use in read_rebase_todolist()
Date:   Wed, 30 Aug 2017 20:20:17 +0200
Message-Id: <20170830182017.21350-1-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:N6xx09O5DVAJL4PmfWTJ3Elmth7uMLVGwbgD2sTEyeJC9pslQuf
 ak3SGC6HgC7g+pXLiIafm8E8Dggky9lHCmo6NckyecDsOlB3HUTagXl3yjn+o0H89Oa2Lcd
 iZRgemrXVQDZG4Rb4HLl6Y57c67Y7wbbu/B/z7Pu0Hrubu9V1/U8uOuZboH84J94P/8Li0s
 TRGjA53LR5Yjh0x8pwE1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W8/wx+krKmQ=:D2+NtOflQMazFQ/vy25fUE
 QOcnAg2erMyfW7mlShEQcvryRSnMAjRf8LSjE+BZqtBmn5nb9r8WvUWwSjexvEm9kE44NFFRT
 /RbshNuyMSVVaoicdeMPP4JGKgO37IVDO82At+bqbyk85Qej6u0QjTuZQrU3r55sL+oj9q5by
 n93RmPKu1G6x2/oWoRgF63YglfRAhUzqx3TDmjTkb1KIzwJmXy0ABbai6PGnh/Amm2Xfycrrt
 xkNWF+yMQBf/j3Q6B3bKxrIKmufBwOZktjLx5FDbUEJY400mSYM6hhvP27A5rx+5lg7Q+o/XC
 GPyIgN2hNtAXViLXUjTL23EIkU3BSLXyKxqEhlfYdH0sKrWA/3y9ENTLPZrdD8yEnpZRkfrCo
 rBBNFunnLKyrT6Uta6alf170jFZY7s8U+yiwYR/NKjbGj2FBhXutCKFRVasbmKQd2PZG/Q6Vm
 n4xuv7411txkFUB+NDjJrkCFMIAKwxemgkQ5nqNKubDaW4874gpodKeTvjiXSza4pPTEE0PR2
 lt5X+8spjtalgcZ25fyMqd+XueRJedc01+vNkAPJLARD8RWHI6ahs2um00knjmkG3qkQvqc9j
 NVNAbtXh1Zs14QGlX88uaHCaGs0JMB4Hc62qVKwl2I27VGrB8Rtg7Ho+qUYZjvtbGo8I9w1nF
 LxUnO2w/+n9G0jLmb8PKy681+p4sHEpR9eWT5f0YQnbk41r/i5pjEGlh5ADM9jRf0V5+j+zBn
 SpmVcMnA1vmLynEV/vsf9LIxpmdRum+iAgvGUhmAcwK6epquefWhhzdlY9qmMJluC65VoRuSC
 G10FVJpHZVu5xl80OdEdKHxLO0h/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 wt-status.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/wt-status.c b/wt-status.c
index 77c27c5113..cafafb5ecd 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1175,24 +1175,25 @@ static void abbrev_sha1_in_line(struct strbuf *line)
 static int read_rebase_todolist(const char *fname, struct string_list *lines)
 {
 	struct strbuf line = STRBUF_INIT;
 	FILE *f = fopen(git_path("%s", fname), "r");
 
 	if (!f) {
 		if (errno == ENOENT)
 			return -1;
 		die_errno("Could not open file %s for reading",
 			  git_path("%s", fname));
 	}
 	while (!strbuf_getline_lf(&line, f)) {
 		if (line.len && line.buf[0] == comment_line_char)
 			continue;
 		strbuf_trim(&line);
 		if (!line.len)
 			continue;
 		abbrev_sha1_in_line(&line);
 		string_list_append(lines, line.buf);
 	}
 	fclose(f);
+	strbuf_release(&line);
 	return 0;
 }
 
-- 
2.14.1

