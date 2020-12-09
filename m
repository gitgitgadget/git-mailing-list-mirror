Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C64C2BBCA
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B23423BC6
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbgLITnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387862AbgLITm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:42:56 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDC9C061285
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:41:40 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l9so3013520wrt.13
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hyvwgKigN49SfW+u94jG33nqWjb5pbiDPIv9LvaOhYc=;
        b=STlDTH9IhcbK2/nUpqrDdePTDLxK5WSyCOnQn+6BtjTMFn5g5x9mHQvNDx7cwIQeBs
         6lYp7ocvU6tLX5//KuANNj9LmwxWC7k7V1elzSTQRHDnyyk2TNjB4n+vAThJ9VGcXB61
         YFTDkGem828yJ0aY1LKnnqMxlxOLBhYkMnpKPhQ2yEkijGDtHZOjdsmb6JclfLWt8Y8j
         /kT+qc43faX+JJqvi2aqGdjSed1XwMLwylq7Qx42sqRIXvWivMGpSziMzj6T9DgQ/+Gi
         7h0Rb4YXa6zqKhJx/c84RC0vMvPjHH8eHs2pI5//csG+RN2TSyPk+ezNoroGyr5QLDlk
         aOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hyvwgKigN49SfW+u94jG33nqWjb5pbiDPIv9LvaOhYc=;
        b=IyBszgzp+zuADWOv4GVuhaMsv4FFJat+xa3GonmGjmqZRyzWFRzNCahS07jFCBD8A9
         TJ3Y2mme2f1VXKgZFH6tzB1KUE9LHCjbEeqyV7BN9BNQSai9fSVEBHFGl78qzPPVbsHn
         otSx6fjB//Kiu18wm9+h9RfeIcKQkhxdS7gxBeh080fy363mpBVKMZ5bUa5BMDHKj6xn
         q4qvCvYE3B7HHc54GLfBP6MWZCQ5APdhMsm0iPzTClnJ4Pdf6dWtJcMNLabYAPLV79c6
         lH6KPmoqOMraT1MX2+NXAjG3gZOwpWeMsvOUlR7zSfz//8E6k41JjcmpNbxhhdMl0SP/
         h2rw==
X-Gm-Message-State: AOAM531FM3+I2aIQBduLG9x/t9WmhLF1yf5m560s58bmWoTNtqJzMYKx
        MLXmk7hMFUmUbUK3eR4zfHKu8Q1b/HI=
X-Google-Smtp-Source: ABdhPJxkqAFc5RLP2iWZ+x+U91Ne0tcCufgUTzgcQr8+u9k3ooTX7w9JAn6RchnE9jyhU5J+DoMSaw==
X-Received: by 2002:a5d:5385:: with SMTP id d5mr484949wrv.384.1607542898614;
        Wed, 09 Dec 2020 11:41:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k18sm6186905wrd.45.2020.12.09.11.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:41:38 -0800 (PST)
Message-Id: <14baa5874afc12f3ba9534c71b9d70f2c481c465.1607542887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.git.1607542887.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 19:41:26 +0000
Subject: [PATCH 10/11] merge-ort: add implementation of normal rename handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Implement handling of normal renames.  This code replaces the following
from merge-recurisve.c:

  * the code relevant to RENAME_NORMAL in process_renames()
  * the RENAME_NORMAL case of process_entry()

Also, there is some shared code from merge-recursive.c for multiple
different rename cases which we will no longer need for this case (or
other rename cases):

  * handle_rename_normal()
  * setup_rename_conflict_info()

The consolidation of four separate codepaths into one is made possible
by a change in design: process_renames() tweaks the conflict_info
entries within opt->priv->paths such that process_entry() can then
handle all the non-rename conflict types (directory/file, modify/delete,
etc.) orthogonally.  This means we're much less likely to miss special
implementation of some kind of combination of conflict types (see
commits brought in by 66c62eaec6 ("Merge branch 'en/merge-tests'",
2020-11-18), especially commit ef52778708 ("merge tests: expect improved
directory/file conflict handling in ort", 2020-10-26) for more details).
That, together with letting worktree/index updating be handled
orthogonally in the merge_switch_to_result() function, dramatically
simplifies the code for various special rename cases.

(To be fair, the code for handling normal renames wasn't all that
complicated beforehand, but it's still much simpler now.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/merge-ort.c b/merge-ort.c
index 412a3b1da76..f2e4edf6506 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -843,7 +843,11 @@ static int process_renames(struct merge_options *opt,
 					 rename_branch, delete_branch);
 			} else {
 				/* normal rename */
-				die("Not yet implemented");
+				memcpy(&newinfo->stages[other_source_index],
+				       &oldinfo->stages[other_source_index],
+				       sizeof(newinfo->stages[0]));
+				newinfo->filemask |= (1 << other_source_index);
+				newinfo->pathnames[other_source_index] = oldpath;
 			}
 		}
 
-- 
gitgitgadget

