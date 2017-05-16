Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B37C201A4
	for <e@80x24.org>; Tue, 16 May 2017 07:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbdEPHgQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 03:36:16 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34616 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdEPHgO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 03:36:14 -0400
Received: by mail-qt0-f193.google.com with SMTP id l39so19358489qtb.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 00:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=EBOM+6eb29YbMlznjWGhEHs9GKKRDmfjtwwJfVGdWBI=;
        b=tOjwKot1pw+JEAM5a19Pl9SeumiK29FXqHwG2kT9DaoUE3ENwiT1KHSmkmjmkMrBOn
         jko0mcTDeO2lFjDlvSgyrqYvEd3gXdDSQ0zOwQxlJM9WN4ZTxOAMc35s9CJNdbQiB7hr
         jh6vuDWbEwxt6wqfBBjBDdxYNAfgZqt6qPBpYxnDYCtc62opI3PlLeB+zcBMhF5Mycdk
         VCpiNd8jm3vpjExz1w+M+0Enba0ePj9WxLuS3PcbCURLoNBIAHFliHAHPuM4lDeNCNXb
         cAxcoR+VaOkuCaUXyU6lMXZVlYOwGSSdxJefazSZOUTTP6cNSLnrje78njTn1ZVKBVTA
         HEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EBOM+6eb29YbMlznjWGhEHs9GKKRDmfjtwwJfVGdWBI=;
        b=PHo2gwtVQG1ehLh+r2kZmDR7pRis7znp8GfFzgEtM1kq0GeEq9+lkPSyzjaOW2EpVI
         CeJJhH5jgLbg5QB5rpAleFnIX0etWi6laujrvlGZv1HMitvg5hTMmb0modVWWcRWmbre
         iOqI0dYpypv1JvOWe9FnRtFJSa6Tke0rI8mKuxTAjZY9k8BWIjoSB6deMLUm4imrZn5x
         mCHryLnw1VOQurP2RRINK37OzMDZ4rxmc3sKgu1WwqNuyATFj9Kujlnm2vhDrt3VGFNh
         hwNIuj4tTBj6H1Pml8x7ZwgHxXPPAyMrVZ0dvJVyPGzLUnm82obGdJvan9sgDal1br42
         Penw==
X-Gm-Message-State: AODbwcAWlAT5AcAQJ1c5DG/f7qPzhxwTkAgQ39nSUDX9FQ2k96An+A7v
        dsddMeGpbMXa+g==
X-Received: by 10.200.52.157 with SMTP id w29mr10145023qtb.161.1494920173198;
        Tue, 16 May 2017 00:36:13 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id i51sm10374103qte.28.2017.05.16.00.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 00:36:12 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v3 3/8] dir: recurse into untracked dirs for ignored files
Date:   Tue, 16 May 2017 03:34:18 -0400
Message-Id: <20170516073423.25762-4-sxlijin@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170516073423.25762-1-sxlijin@gmail.com>
References: <20170516073423.25762-1-sxlijin@gmail.com>
In-Reply-To: <20170505104611.17845-1-sxlijin@gmail.com>
References: <20170505104611.17845-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We consider directories containing only untracked and ignored files to
be themselves untracked, which in the usual case means we don't have to
search these directories. This is problematic when we want to collect
ignored files with DIR_SHOW_IGNORED_TOO, though, so we teach
read_directory_recursive() to recurse into untracked directories to find
the ignored files they contain when DIR_SHOW_IGNORED_TOO is set. This
has the side effect of also collecting all untracked files in untracked
directories as well.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index f451bfa48..6bd0350e9 100644
--- a/dir.c
+++ b/dir.c
@@ -1784,7 +1784,12 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 			dir_state = state;
 
 		/* recurse into subdir if instructed by treat_path */
-		if (state == path_recurse) {
+		if ((state == path_recurse) ||
+				((get_dtype(cdir.de, path.buf, path.len) == DT_DIR) &&
+				 (state == path_untracked) &&
+				 (dir->flags & DIR_SHOW_IGNORED_TOO))
+				)
+		{
 			struct untracked_cache_dir *ud;
 			ud = lookup_untracked(dir->untracked, untracked,
 					      path.buf + baselen,
-- 
2.12.2

