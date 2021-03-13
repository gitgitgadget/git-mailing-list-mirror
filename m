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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0CBC433E0
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 08:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 503DD64DF3
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 08:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhCMIiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 03:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhCMIiv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 03:38:51 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B16C061574
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 00:38:51 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id n17so9453007plc.7
        for <git@vger.kernel.org>; Sat, 13 Mar 2021 00:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ct2lXbIHqZrI3o9Fd3aaJ+ERfhp6lILvOUQpUgqvPP0=;
        b=KF4GKRtHeoUI6fsdNH3ftLQklHmIL8zIboZUPVLSowdnGXigZ+eQ5b+vJy0UuFpsXt
         YlR8CR0zHv2FYiBVB9xtjhn9ZQOES566Se37gmbctmTBfSJRMJqjh7vBxJHI/zxVduLD
         BNBv3busUOsWRGu+cK58TT332wyRzzeIa2lisQEe+RpUFkP6rFrJ4exDwUysurLxshgl
         zT4EmiQktv0CnTMuvuMdG5jqkJlUWN9a1feD0I90FG9kSp/VS6uWwdNW9BA8eezbSlG0
         CyDolFsPC1U5Z+29++4wPnHeUZdzIu9ckm+AM1mLjEIqy0u6er0Tad+dnExhxThV/2K+
         Thog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ct2lXbIHqZrI3o9Fd3aaJ+ERfhp6lILvOUQpUgqvPP0=;
        b=gE+lhpBLHUht+pgVogRlS6yg0j7lfaXO++cXbpB4YctpFjB/1I5+bTDLqotebksKa8
         Qs6HebaIais5ImzDma7d148P7nAni8MtoeNyEJXOPQsH+C2wAPnZ/J6l377tpZGSxqEy
         kO53x70GuscF9V/dmMNmKYOhLT96eaivP/gcn6u20GCBZiPEmi8W9+9c//qy5WcYlbWu
         9d12Gaciw43dmKmyOLLRVyCcCWXvEOgVTasV3YR/E/DL6QQk/gjReOyLLNXJCmwWZ0/W
         OhpVvy4rRvm+iy8bITef+rCQPd8qY+9IBCPyNk/OtGHBSlvcqaf5IRF4rJ/TBkeFwHjv
         6zoA==
X-Gm-Message-State: AOAM530qWDT0tZjbjfAy6HQFXTwmNjIJUDEP61YVMUV03MSL7joYfJq0
        7i0QHEwGGmym647i0kZPy4o=
X-Google-Smtp-Source: ABdhPJxfXy8adhI02Z1lMSsdtEX6tgt+w1CzflTSXiNO5atXvzxHtOviWbY/vNp97wCjfyBakGge5w==
X-Received: by 2002:a17:90b:228c:: with SMTP id kx12mr2490054pjb.7.1615624730941;
        Sat, 13 Mar 2021 00:38:50 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:a1e7:6707:cbf6:696d])
        by smtp.gmail.com with ESMTPSA id f6sm8183138pfk.11.2021.03.13.00.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 00:38:50 -0800 (PST)
Date:   Sat, 13 Mar 2021 00:38:48 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>,
        Dana Dahlstrom <dahlstrom@google.com>
Subject: [PATCH 1/2] mergetool: do not enable hideResolved by default
Message-ID: <YEx6GNybrU5mrlNi@google.com>
References: <20210130054655.48237-1-seth@eseth.com>
 <20210209200712.156540-1-seth@eseth.com>
 <20210209200712.156540-2-seth@eseth.com>
 <YEbdj27CmjNKSWf4@google.com>
 <xmqqmtvbjuvl.fsf@gitster.g>
 <xmqqzgzafo5o.fsf@gitster.g>
 <xmqqlfas55mk.fsf@gitster.g>
 <YEv5d0pGvEVpepoY@google.com>
 <xmqqh7lg54h4.fsf@gitster.g>
 <YEx5hM/HWby3FBJv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEx5hM/HWby3FBJv@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 98ea309b3f (mergetool: add hideResolved configuration,
2021-02-09) introduced the mergetool.hideResolved setting to reduce
the clutter in viewing non-conflicted sections of files in a
mergetool, it enabled it by default, explaining:

    No adverse effects were noted in a small survey of popular mergetools[1]
    so this behavior defaults to `true`.

In practice, alas, adverse effects do appear.  A few issues:

1. No indication is shown in the UI that the base, local, and remote
   versions shown have been modified by additional resolution.  This
   is inherent in the design: the idea of mergetool.hideResolved is to
   convince a mergetool that expects pristine local, base, and remote
   files to show partially resolved verisons of those files instead;
   there is no additional source of information accessible to the
   mergetool to see where the resolution has happened.

   (By contrast, a mergetool generating the partial resolution from
   conflict markers for itself would be able to hilight the resolved
   sections with a different color.)

   A user accustomed to seeing the files without partial resolution
   gets no indication that this behavior has changed when they upgrade
   Git.

2. If the computed merge did not line up the files correctly (for
   example due to repeated sections in the file), the partially
   resolved files can be misleading and do not have enough information
   to reconstruct what happened and compute the correct merge result.

3. Resolving a conflict can involve information beyond the textual
   conflict.  For example, if the local and remote versions added
   overlapping functionality in different ways, seeing the full
   unresolved versions of each alongside the base gives information
   about each side's intent that makes it possible to come up with a
   resolution that combines those two intents.  By contrast, when
   starting with partially resolved versions of those files, one can
   produce a subtly wrong resolution that includes redundant extra
   code added by one side that is not needed in the approach taken
   on the other.

All that said, a user wanting to focus on textual conflicts with
reduced clutter can still benefit from mergetool.hideResolved=true as
a way to deemphasize sections of the code that resolve cleanly without
requiring any changes to the invoked mergetool.  The caveats described
above are reduced when the user has explicitly turned this on, because
then the user is aware of them.

Flip the default to 'false'.

Reported-by: Dana Dahlstrom <dahlstrom@google.com>
Helped-by: Seth House <seth@eseth.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Only difference from v1 is the commit message.

 Documentation/config/mergetool.txt | 2 +-
 git-mergetool.sh                   | 9 ++-------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 90f76f5b9ba..cafbbef46ae 100644
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
index 911470a5b2c..f751d9cfe20 100755
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
2.31.0.rc2.261.g7f71774620

