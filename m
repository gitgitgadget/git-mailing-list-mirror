Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84C1120966
	for <e@80x24.org>; Thu, 30 Mar 2017 21:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934598AbdC3VEN (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 17:04:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32926 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934226AbdC3VEL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 17:04:11 -0400
Received: by mail-wr0-f194.google.com with SMTP id u18so15455746wrc.0
        for <git@vger.kernel.org>; Thu, 30 Mar 2017 14:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=F1va71Y2ppKIKMLSuAj32DgXgGjqLrShMkU43Y63/ic=;
        b=hT4KSZNdrL0YFwvOOfaDzFEXt1ZBV8o0n7Ik570tCCUc7b5MCU6jKwf2xTtS97cFyy
         mxp/fKL3ysExdHgn0BAnllQQGfM5XUXpSA+JrjLVawVJ0BAEr19PJAMLo5azEUiz3Cnv
         3dCcpINJpnclya+ONMJnoe4LigISddFLEqqBcn6YjT/1LSBLxDo+qCoPr2daovXLW181
         /PoM9THwZNbdMgDJJRW6ISIPBlh5m3Ki8F4z0d6T2A/n1/AKOqIiCgizFmEYXT0OjVO+
         kQV6ykHNj5rnRendblan2QeJewKX8FLuJKBK9CPrpNjpgyS1+OpbtxYRIPLkkqjDg5+p
         LbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F1va71Y2ppKIKMLSuAj32DgXgGjqLrShMkU43Y63/ic=;
        b=SxOridgqJQLrysctJVbI++vR0FFmzNLLU/2rA2DjjZ7qTiPKn6/9EWOZdw+5pIkQfR
         OXdzir5AUWsXXWmty3Uzmwvc4xrNRisfhSuvRFDuVFmUVbNk1au8JoysXjsR9jq5Roi5
         FylXxX8iqsTMtqLX2FKTqxxn+v8Pbl3kc1o6joSJqd2RVnXbgSDgCcyTPm6hgmw1qDfL
         iBY6rTdmRA5Goi8xqg7p1w2m76AZ0D/qtFuIKHFGzSWqVsO3HPBATb6+qnmYSVijvJ7g
         wMCiRP3ZOgu9NaS4xcQtKVzvx/P3weqG4kwNCDkbpfO+XPVcEeauk0427GiPVQ9qQWoe
         cJGg==
X-Gm-Message-State: AFeK/H0ehfuPmGqVl730zKttx0tTBX9D/hHKOWZvvHWDpTVRTDBicIwe3uc3y83/8xtMKw==
X-Received: by 10.223.168.77 with SMTP id l71mr1444814wrc.185.1490907849747;
        Thu, 30 Mar 2017 14:04:09 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k32sm4117306wre.18.2017.03.30.14.04.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Mar 2017 14:04:08 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] read-cache: avoid using git_path() in freshen_shared_index()
Date:   Thu, 30 Mar 2017 23:03:54 +0200
Message-Id: <20170330210354.20018-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.rc0.23.g4ed838fb8d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When performing an interactive rebase in split-index mode,
the commit message that one should rework when squashing commits
can contain some garbage instead of the usual concatenation of
both of the commit messages.

Bisecting shows that c3a0082502 (read-cache: use
freshen_shared_index() in read_index_from(), 2017-03-06) is involved,
which points to the unsafe use of git_path() in
freshen_shared_index().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
The only changes in this v2 compared to the previous version are
in the title and commit message, which have been changed according
to:

http://public-inbox.org/git/CAP8UFD29xWU5bHwewUSq26pVTwK-gy3uSVG2aGTCrDak3620=A@mail.gmail.com/

 read-cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index e447751823..2f10242c24 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1682,9 +1682,10 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
  */
 static void freshen_shared_index(char *base_sha1_hex, int warn)
 {
-	const char *shared_index = git_path("sharedindex.%s", base_sha1_hex);
+	char *shared_index = git_pathdup("sharedindex.%s", base_sha1_hex);
 	if (!check_and_freshen_file(shared_index, 1) && warn)
 		warning("could not freshen shared index '%s'", shared_index);
+	free(shared_index);
 }
 
 int read_index_from(struct index_state *istate, const char *path)
-- 
2.12.0.rc0.23.g4ed838fb8d

