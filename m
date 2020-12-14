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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE53C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1025225AC
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440137AbgLNQZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440261AbgLNQXL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 11:23:11 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FFEC0611C5
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r7so17015525wrc.5
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 08:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HKfFEAEP56e8cli3HrU4PsQz5b6i5gxzOGNKStkT99I=;
        b=lY5PxzGs6Xcongk2q0NWls/XW6vM2KeE9cRuoS9PfDQnta3quL+E6j6NnkqXYj9PiI
         zaPPNIhcQAnvBtz4fp6EwloBuWT+aWzmI43ZIvJ7KH5fjYAYGmzOiOZQTwoLAFcWDdEM
         06ntDaOe+wvOfAH+EyU2DV6GV8+uiQUWhrQbfRQXd6RM0l0NoTka3arB8piXYByceDrv
         dOPVgacFK31sStpjwW7a39/fxVgKsfcChY5SIs9nudh6Nx5TJdTkp3mGj1Z7BQ3hgVFu
         w70eeY+8F3mUGSvssnZYrRPng30F/jSqLJbnzWDyHjE4HlC/8wJSinmqqDrayzg5i9Vr
         SrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HKfFEAEP56e8cli3HrU4PsQz5b6i5gxzOGNKStkT99I=;
        b=BasqMahXAZnRd/5SM3cSKUs79B8/OVUKbOkTKFRLQCNYoOY/JJgRkZ+1BGaM1qT0MV
         WDV3qF4/lMglmkkyhCR5gwbHM+9MeBneJJmrDFy42gb+jAqqfrKowQHtyU0bpczDT34v
         uZwsB9AyM65YVZ5zGCxESSG5DlqMSwZe6Y6jPaeQBaXJRvd0wLlVPqrfAwwP8SEDJdtv
         tf7GLmylbHdZ9Ie0s/nHIVnVAjKDQ8eSZZnJi5OHDaOK7h40AasR99saFdSXUlwF17mC
         jIUlN0u1KjQ1/ZXNRNBlyKVmD9z+FHxR8p8KpSL7hZyErNPne5IBFnzcrG0cOE4OwYlR
         j+/w==
X-Gm-Message-State: AOAM530fmAxYBR781hRTrL0+tCRjoLDeIzc1G1ns8pXPxDyoL5ye0tAK
        yhx7LCv3+RYmeQmpGZqaclxXGaVQSNo=
X-Google-Smtp-Source: ABdhPJzaiva9DaAFSOypgan9wsSUaVgccwDzOiP1KHBnbHJ6mD7XBAL7GZzbGUeqVCIFOcxdZlvULw==
X-Received: by 2002:adf:e705:: with SMTP id c5mr28961515wrm.303.1607962913111;
        Mon, 14 Dec 2020 08:21:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a18sm31982919wrr.20.2020.12.14.08.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 08:21:52 -0800 (PST)
Message-Id: <ff09ddb9caf73632c9792c07f1f7499a75a09606.1607962900.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
        <pull.812.v2.git.1607962900.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Dec 2020 16:21:40 +0000
Subject: [PATCH v2 11/11] merge-ort: add implementation of type-changed rename
 handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Implement cases where renames are involved in type changes (i.e. the
side of history that didn't rename the file changed its type from a
regular file to a symlink or submodule).  There was some code to handle
this in merge-recursive but only in the special case when the renamed
file had no content changes.  The code here works differently -- it
knows process_entry() can handle mode conflicts, so it does a few
minimal tweaks to ensure process_entry() can just finish the job as
needed.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 9aac33c8e31..11e33f56edf 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -778,7 +778,32 @@ static int process_renames(struct merge_options *opt,
 			 S_ISREG(newinfo->stages[target_index].mode));
 		if (type_changed && collision) {
 			/* special handling so later blocks can handle this */
-			die("Not yet implemented");
+			/*
+			 * if type_changed && collision are both true, then this
+			 * was really a double rename, but one side wasn't
+			 * detected due to lack of break detection.  I.e.
+			 * something like
+			 *    orig: has normal file 'foo'
+			 *    side1: renames 'foo' to 'bar', adds 'foo' symlink
+			 *    side2: renames 'foo' to 'bar'
+			 * In this case, the foo->bar rename on side1 won't be
+			 * detected because the new symlink named 'foo' is
+			 * there and we don't do break detection.  But we detect
+			 * this here because we don't want to merge the content
+			 * of the foo symlink with the foo->bar file, so we
+			 * have some logic to handle this special case.  The
+			 * easiest way to do that is make 'bar' on side1 not
+			 * be considered a colliding file but the other part
+			 * of a normal rename.  If the file is very different,
+			 * well we're going to get content merge conflicts
+			 * anyway so it doesn't hurt.  And if the colliding
+			 * file also has a different type, that'll be handled
+			 * by the content merge logic in process_entry() too.
+			 *
+			 * See also t6430, 'rename vs. rename/symlink'
+			 */
+			collision = 0;
+		}
 		if (source_deleted) {
 			if (target_index == 1) {
 				rename_branch = opt->branch1;
@@ -858,7 +883,11 @@ static int process_renames(struct merge_options *opt,
 			newinfo->pathnames[0] = oldpath;
 			if (type_changed) {
 				/* rename vs. typechange */
-				die("Not yet implemented");
+				/* Mark the original as resolved by removal */
+				memcpy(&oldinfo->stages[0].oid, &null_oid,
+				       sizeof(oldinfo->stages[0].oid));
+				oldinfo->stages[0].mode = 0;
+				oldinfo->filemask &= 0x06;
 			} else if (source_deleted) {
 				/* rename/delete */
 				newinfo->path_conflict = 1;
-- 
gitgitgadget
