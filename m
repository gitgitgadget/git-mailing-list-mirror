Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD87C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 02:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7557365287
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 02:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhCIC3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 21:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhCIC3i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 21:29:38 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C64C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 18:29:38 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id v14so813927pgq.2
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 18:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gFi3VcLCxEreqCGh5V7uSahomk1SdwO4QHxv2wpuj3o=;
        b=Ffakl2KdnKVR8gZSl3xqhNp2f/kMeUPmvwb/q1a+xWK4gPT8pAe5MMwJ/Yog8WD1f/
         NoI2oVLSqYbylqWjdNet+G+s6b3n+hsjpzjSaE4nXQyy9Z7ENvWxF2giHy45SeZV/l+t
         Od3u1J+RB7J7ybeVU3zB6enRrAgZx3TFGKnx4Y8K98DAqT5T82Sgawfd0gpAkCWrCVy9
         Q/Se1d+2rrwLxElMEMdg9V+oiE4XksLNseRHgztOKxn/8JtqfyomTc/uSMSKKaF56Tkl
         h52+j5wLH/rlWL4mSwmsDtmSB4sYJfm3vE5W7Kwr/X5gueRCHj0ikdK9iRw5h612ZVEF
         YQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gFi3VcLCxEreqCGh5V7uSahomk1SdwO4QHxv2wpuj3o=;
        b=g98hE8Bh9Zj1bJJx2becchJWgytuFf4m2aZsHXnh7vwaaYS7rED7CC2tf+ef8GKdCl
         VbbTdVz5dBm2DOQqRZoorb6MdZxQfttlapaPwTQthHe7D50XTnm3Oiys9e9pMR2WAYbH
         XDTkvBAqA4jVDJE8WUgZq6F1oi3GfN1VOYO2fyeiZCBirtJa3Zv+EkMUrNaLxqg3ruWk
         71/UbTQpTVeUszPbpn6q+3E+h948Y1QYLiT6cDLRKeB8BAa22cdAyUd7EhNHbw6jmz6n
         1iwTe856DFJYOVKNTXgfjhazm6VpvxwgiF4wu6NFGWk276rW9PppG3/KkeAGAUq2mrWn
         RVIQ==
X-Gm-Message-State: AOAM530ImNC+JKVN4clTnNMpEyBJbxrhSTbxdXOQ12yh+IUjUTxu2rzy
        6Fd5xcNes46Knv/j/SGBlL8=
X-Google-Smtp-Source: ABdhPJzkbf88hg5p+PPMlCcddyO9T21UIGwuNJUApJO4LCUE/DpmZtG9O1kAd7vkRpCEnbISwTdAqQ==
X-Received: by 2002:a62:52d7:0:b029:1f5:c33e:811c with SMTP id g206-20020a6252d70000b02901f5c33e811cmr8407625pfb.50.1615256978114;
        Mon, 08 Mar 2021 18:29:38 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:f842:23b4:7165:e34])
        by smtp.gmail.com with ESMTPSA id q10sm3986062pgs.44.2021.03.08.18.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 18:29:37 -0800 (PST)
Date:   Mon, 8 Mar 2021 18:29:35 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>,
        Dana Dahlstrom <dahlstrom@google.com>
Subject: [PATCH] mergetool: do not enable hideResolved by default
Message-ID: <YEbdj27CmjNKSWf4@google.com>
References: <20210130054655.48237-1-seth@eseth.com>
 <20210209200712.156540-1-seth@eseth.com>
 <20210209200712.156540-2-seth@eseth.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209200712.156540-2-seth@eseth.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A typical mergetool uses four panes, showing the content of the file
being resolved from MERGE_BASE ('BASE'), HEAD ('LOCAL'), MERGE_HEAD
('REMOTE'), and the working copy.  This allows understanding the
conflicts in context: by seeing the entire content of the file from
MERGE_HEAD, say, we can see the full intent of the code we are pulling
in and understand what they were trying to do that conflicted with our
own changes.

Sometimes, though, the exact content of these three competing versions
of a file is not so important.  Especially if the mergetool supports
folding unchanged lines, the new 'mergetool.hideResolved' feature can
be helpful for allowing a person resolving a merge to focus on the
portion with conflicts.  For sections of the file where BASE matched
LOCAL or REMOTE, this feature makes all three versions match the
resolved version, so that the user resolving can focus exclusively on
the portions with conflicts.  In other words, hideResolved makes a
multi-pane merge tool show a similar amount of information to the file
with conflict markers with conflictstyle=diff3, saving the operator
from having to pay attention to parts that resolved cleanly.

98ea309b3f (mergetool: add hideResolved configuration, 2021-02-09)
which introduced this setting enabled it by default, explaining:

    No adverse effects were noted in a small survey of popular mergetools[1]
    so this behavior defaults to `true`. However it can be globally disabled
    by setting `mergetool.hideResolved` to `false`.

In practice, however, this has proved confusing for users.  No
indication is shown in the UI that the base, local, and remote
versions shown have been modified by additional resolution.
Especially in cases where conflicts involve elements beyond textual
conflict, it has resulted in incorrect resolutions and wasted work to
figure out what happened.  Flip the default back to the traditional
behavior of `false`: although the old behavior involves slightly
slower merges in the only-textual-conflicts case, it prevents this
kind of painful moment of betrayal by one's tools, which is more
important.

Should we want to migrate to hideResolved=true in the future, we still
can.  It just requires a more careful migration, including a period
where "git mergetool" shows a warning or errors out in affected cases.

Reported-by: Dana Dahlstrom <dahlstrom@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Seth House wrote:

> No adverse effects were noted in a small survey of popular mergetools[1]
> so this behavior defaults to `true`. However it can be globally disabled
> by setting `mergetool.hideResolved` to `false`.

Thanks much for protecting this by a flag.  We tried this out
internally at Google when it hit "next" and not too long later
realized that the new default of "true" is not workable for us.  I
don't believe it's the right default for Git, either, hence this
patch.

Thanks for working on the merge resolution workflow; it's much
appreciated.

Sincerely,
Jonathan

 Documentation/config/mergetool.txt | 2 +-
 git-mergetool.sh                   | 9 ++-------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 90f76f5b9b..cafbbef46a 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -53,7 +53,7 @@ mergetool.hideResolved::
 	resolution. This flag causes 'LOCAL' and 'REMOTE' to be overwriten so
 	that only the unresolved conflicts are presented to the merge tool. Can
 	be configured per-tool via the `mergetool.<tool>.hideResolved`
-	configuration variable. Defaults to `true`.
+	configuration variable. Defaults to `false`.
 
 mergetool.keepBackup::
 	After performing a merge, the original file with conflict markers
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 911470a5b2..f751d9cfe2 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -358,13 +358,8 @@ merge_file () {
 		    enabled=false
 		fi
 	else
-		# The user does not have a preference. Ask the tool.
-		if hide_resolved_enabled
-		then
-		    enabled=true
-		else
-		    enabled=false
-		fi
+		# The user does not have a preference. Default to disabled.
+		enabled=false
 	fi
 
 	if test "$enabled" = true
-- 
2.31.0.rc1.246.gcd05c9c855

