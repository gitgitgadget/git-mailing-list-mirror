Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF8C01F51C
	for <e@80x24.org>; Thu, 17 May 2018 18:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeEQSkV (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 14:40:21 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45666 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeEQSkU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 14:40:20 -0400
Received: by mail-pl0-f66.google.com with SMTP id bi12-v6so3037637plb.12
        for <git@vger.kernel.org>; Thu, 17 May 2018 11:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SR1mZXlgMP51z+H43va6nrEyO4zl81q23wo318DgLX8=;
        b=QeDuKGV8/gdyc00Kw7OJRwgEc/9DccNWuGpYQF1W/v/ldz8nYECFUpyKqNdreNY6Oq
         9/7zC8lQZu788woO4hmsHc3/ErTda0TGEdnhybHbiH4sBgCWDGLJbcgDvrh1RI1u7xa1
         PYUXlpY05wvR/TwBzjaS/iRwnDgo1bJOcQKIDdvC8muxFmMrcID1sri80tbewgoJXN9x
         2Zw+2jQVT+czrLd0TuRlmdwuVZDs5ci0NYs0uVDYTX4GQvc2+nOjYz5zsdIoBMb3xFW7
         5dfS9pSvTZmURGMHRlogZoQnd95DJqRB3qbQBIp8kT0E3+5Wnv1gbGfMvLkd2Q3C9ClS
         Rzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SR1mZXlgMP51z+H43va6nrEyO4zl81q23wo318DgLX8=;
        b=YRFW9ZE2YqH2mPEjn0uP6HVqcgYQ+B3gHDovASoWjjCxN8TuIPbFjoE/crKgCj7deK
         5n9z4X2ErE6+83Rap95cjyECIWVTkeCsgQvjV4d219IXLzxKSeXjsHgHsFIgyPngN1W0
         SjP1n80aOtO9AOI4EWX2Iy5WymZ9Mw4VfgzcvJyrbpf7VP/yKu46xNIEQmG2qbQCgvLu
         +OqPTpvcwAHTIH+NLFRVQe/d62SkGSVYjYUz3tG/AX081Gs40QXEVKsT5Nu+WWEgb+PE
         XRLGhY6de6UYHSUTiOHdk3Zy0yJ0zKBh4kn/7VSKXLGEoMgurzYP3FhY99DRiku9GeMK
         vSXQ==
X-Gm-Message-State: ALKqPwcCweEhB0z1ft9z9CWi1UUMqVjqJkmTo47mYcye5xXiopLyUjnS
        bms+uB5W2cIJyLmS429DWxMr3GTGgqk=
X-Google-Smtp-Source: AB8JxZo1Qn6eE6GE7mfsbXg22ZgbM1DSs5FSiq/8U/r8Nk2d9L9gcsg08r8hh2cpGkbnQVDYOEnDNw==
X-Received: by 2002:a17:902:543:: with SMTP id 61-v6mr6269168plf.47.1526582418525;
        Thu, 17 May 2018 11:40:18 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14893981pfe.119.2018.05.17.11.40.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 11:40:18 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     leif.middelschulte@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Leif Middelschulte <Leif.Middelschulte@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] merge-recursive: give notice when submodule commit gets fast-forwarded
Date:   Thu, 17 May 2018 11:40:08 -0700
Message-Id: <20180517184008.25445-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c44.dirty
In-Reply-To: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
References: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Leif Middelschulte <Leif.Middelschulte@gmail.com>

Inform the user about an automatically fast-forwarded submodule. The
silent merge behavior was introduced by commit 68d03e4a6e44 ("Implement
automatic fast-forward merge for submodules", 2010-07-07)).

Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

>> * sb/submodule-merge-in-merge-recursive (2018-05-16) 3 commits
>>  - merge-recursive: give notice when submodule commit gets fast-forwarded
>>  - merge-recursive: i18n submodule merge output and respect verbosity
>>  - submodule.c: move submodule merging to merge-recursive.c
>>
>>  By code restructuring of submodule merge in merge-recursive,
>>  informational messages from the codepath are now given using the
>>  same mechanism as other output, and honor the merge.verbosity
>>  configuration.  The code also learned to give a few new messages
>>  when a submodule three-way merge resolves cleanly when one side
>>  records a descendant of the commit chosen by the other side.
>>
>>  Will merge to 'next'.
>
>Merging would be ok, but I would rather not.
>A resend will be only for cosmetic effect, as I messed up the last commit
>
>So, please hold in pu.

This is the resend, with an interdiff as follows.

Junio wrote in http://public-inbox.org/git/xmqqk1s474vx.fsf@gitster-ct.c.googlers.com:

> Perhaps Leif can elaborate why this change is a good idea in the
> first place?

which is also outstanding.

Leif can you pick this patch and resend it with a proper commit message?


    # diff --git c/merge-recursive.c w/merge-recursive.c
    # index 29a430c418a..a9aecccb8c3 100644
    # --- c/merge-recursive.c
    # +++ w/merge-recursive.c
    # @@ -1094,7 +1094,7 @@ static int merge_submodule(struct merge_options *o,
    #  	if (in_merge_bases(commit_a, commit_b)) {
    #  		oidcpy(result, b);
    #  		if (show(o, 3)) {
    # -			output(o, 1, _("Fast-forwarding submodule %s to the following commit:"), path);
    # +			output(o, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
    #  			output_commit_title(o, commit_b);
    #  		} else if (show(o, 2))
    #  			output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(b));
    # @@ -1106,7 +1106,7 @@ static int merge_submodule(struct merge_options *o,
    #  	if (in_merge_bases(commit_b, commit_a)) {
    #  		oidcpy(result, a);
    #  		if (show(o, 3)) {
    # -			output(o, 1, _("Fast-forwarding submodule %s to the following commit:"), path);
    # +			output(o, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
    #  			output_commit_title(o, commit_a);
    #  		} else if (show(o, 2))
    #  			output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(a));


diff --git a/merge-recursive.c b/merge-recursive.c
index 0571919ee0a..a9aecccb8c3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1093,10 +1093,26 @@ static int merge_submodule(struct merge_options *o,
 	/* Case #1: a is contained in b or vice versa */
 	if (in_merge_bases(commit_a, commit_b)) {
 		oidcpy(result, b);
+		if (show(o, 3)) {
+			output(o, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
+			output_commit_title(o, commit_b);
+		} else if (show(o, 2))
+			output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(b));
+		else
+			; /* no output */
+
 		return 1;
 	}
 	if (in_merge_bases(commit_b, commit_a)) {
 		oidcpy(result, a);
+		if (show(o, 3)) {
+			output(o, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
+			output_commit_title(o, commit_a);
+		} else if (show(o, 2))
+			output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(a));
+		else
+			; /* no output */
+
 		return 1;
 	}
 
-- 
2.17.0.582.gccdcbd54c44.dirty

