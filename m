Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06914C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 08:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B74F164DE2
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 08:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBKIQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 03:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBKIQc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 03:16:32 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA37C06174A
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 00:15:52 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l17so2880032wmq.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 00:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Q0b0d2SLuJLSpH2I+t/b5G8ZQ/8tSpaZVN7xOhkzruA=;
        b=VWxxY7tGL6+dK4wzG4EYG/LS3CYHFhABesyyiI5n4gj+CY76ecrircoLj2I44uK+yu
         UWRHlW4oGl90O5caUoZX5goJ6OIkBMqjhF72LoysxjZg4ue/tNA3dulW6Lu1/3ye+9Vf
         UD99hFBCHSLjL7eevk9q0gzYD+Dnq2vlRz++Zj/8X4mwXTLtkW8d0g4qnVovv/x1tLax
         few0X4w5wXL2rVkHKuF2RHtXEOTdDM5mfCY82gL2ujZYWJ8W1BEwDsoyhsr0lG+CLSD9
         TVf5U5SmTTmyVSFPN3PP9nZjSkxvqBokuPI5l1bUbHQlpmwOinUefO0XrYluwp/ZecDO
         fddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Q0b0d2SLuJLSpH2I+t/b5G8ZQ/8tSpaZVN7xOhkzruA=;
        b=jElHaa8+NHJAEwD7Z0ZMS6By97ic/0TvxmSi9OOV1FxkekYd1PcsvaUF5/R8vYEpV4
         uQsQDWI7gBPJGgV5v1NRR7/f0TTwS76ojs1JR3pjQmwOQuR62ie0KKmgc1d5o7gIib+W
         5Vh9V6K/znNs51xttMPxree42zqBVCazGSLZvcdHeizNb2boCpmSj8fWLcJBmSZDUh4N
         zXgAXHdNDcN0aHDyKjI1ZncK8a5MSfwTMxWIKalua988WXAxELKSskLb/sv5NT0i14J0
         VUn4SISz/g+TnCJSziVbFqQFNNgjV/5sjTDjDgkdtQJUDei6f0mPnvynYiNvjXP2jSQJ
         c2hA==
X-Gm-Message-State: AOAM53225mxK/dAcd3R/Fj6Ty5CQoUtqkDH0IUkmYsPbJMBJ5FdB1/78
        b5BDxUrpVj+3GnWQT5X1HpDejKa43PI=
X-Google-Smtp-Source: ABdhPJzmA6LzA/O2ovkiBVVPed0Jlns6+1NwJ7pS5sJeflCCh7iGUF/yHRNuTnpM092Lxc+OUgpFpw==
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr3863267wmi.148.1613031351098;
        Thu, 11 Feb 2021 00:15:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t6sm7880998wmj.22.2021.02.11.00.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 00:15:50 -0800 (PST)
Message-Id: <pull.843.v4.git.1613031350.gitgitgadget@gmail.com>
In-Reply-To: <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
References: <pull.843.v3.git.1612970140.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Feb 2021 08:15:43 +0000
Subject: [PATCH v4 0/6] Optimization batch 7: use file basenames to guide rename detection
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series depends on ort-perf-batch-6[1].

This series uses file basenames (portion of the path after final '/',
including extension) in a basic fashion to guide rename detection.

Changes since v3:

 * update documentation as suggested by Junio
 * NEW: add another patch at the end, to simplify patch series that will be
   submitted later (please review!)

[1] https://lore.kernel.org/git/xmqqlfc4byt6.fsf@gitster.c.googlers.com/

Elijah Newren (6):
  t4001: add a test comparing basename similarity and content similarity
  diffcore-rename: compute basenames of all source and dest candidates
  diffcore-rename: complete find_basename_matches()
  diffcore-rename: guide inexact rename detection based on basenames
  gitdiffcore doc: mention new preliminary step for rename detection
  merge-ort: call diffcore_rename() directly

 Documentation/gitdiffcore.txt |  20 ++++
 diffcore-rename.c             | 202 +++++++++++++++++++++++++++++++++-
 merge-ort.c                   |  66 +++++++++--
 t/t4001-diff-rename.sh        |  24 ++++
 4 files changed, 301 insertions(+), 11 deletions(-)


base-commit: 7ae9460d3dba84122c2674b46e4339b9d42bdedd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-843%2Fnewren%2Fort-perf-batch-7-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-843/newren/ort-perf-batch-7-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/843

Range-diff vs v3:

 1:  3e6af929d135 = 1:  3e6af929d135 t4001: add a test comparing basename similarity and content similarity
 2:  4fff9b1ff57b = 2:  4fff9b1ff57b diffcore-rename: compute basenames of all source and dest candidates
 3:  dc26881e4ed3 = 3:  dc26881e4ed3 diffcore-rename: complete find_basename_matches()
 4:  2493f4b2f55d = 4:  2493f4b2f55d diffcore-rename: guide inexact rename detection based on basenames
 5:  fc72d24a3358 ! 5:  4e86ed3f29d4 gitdiffcore doc: mention new preliminary step for rename detection
     @@ Documentation/gitdiffcore.txt: a similarity score different from the default of
      +deleted from a different directory, it will mark them as renames and
      +exclude them from the later quadratic step (the one that pairwise
      +compares all unmatched files to find the "best" matches, determined by
     -+the highest content similarity).  So, for example, if
     -+docs/extensions.txt and docs/config/extensions.txt have similar
     -+content, then they will be marked as a rename even if it turns out
     -+that docs/extensions.txt was more similar to src/extension-checks.c.
     -+At most, one comparison is done per file in this preliminary pass; so
     -+if there are several extensions.txt files throughout the directory
     -+hierarchy that were added and deleted, this preliminary step will be
     -+skipped for those files.
     ++the highest content similarity).  So, for example, if a deleted
     ++docs/ext.txt and an added docs/config/ext.txt are similar enough, they
     ++will be marked as a rename and prevent an added docs/ext.md that may
     ++be even more similar to the deleted docs/ext.txt from being considered
     ++as the rename destination in the later step.  For this reason, the
     ++preliminary "match same filename" step uses a bit higher threshold to
     ++mark a file pair as a rename and stop considering other candidates for
     ++better matches.  At most, one comparison is done per file in this
     ++preliminary pass; so if there are several ext.txt files throughout the
     ++directory hierarchy that were added and deleted, this preliminary step
     ++will be skipped for those files.
      +
       Note.  When the "-C" option is used with `--find-copies-harder`
       option, 'git diff-{asterisk}' commands feed unmodified filepairs to
 -:  ------------ > 6:  fedb3d323d94 merge-ort: call diffcore_rename() directly

-- 
gitgitgadget
