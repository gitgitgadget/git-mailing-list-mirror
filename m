Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04902C433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 12:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiB0MZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 07:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiB0MZp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 07:25:45 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECB45C878
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 04:25:09 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t14so6163994pgr.3
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 04:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UnWHy6eSjoC7Omr3jRFCulAdfH3kVNn4/HLfjIyaOH8=;
        b=mzUf/FmbQsplzqGy63mbW8btrBBguKTMMDJTRygsfa786KtHm5D8EAKwcBVzjd3DXv
         qRAWv2MR6C5kxgUU0Kw5kKb7jtsP4npIpc5o+w8W52V8sAF2DjeF0FCn/dcrTEKNBhgx
         IlIGmXMRTQjd1LRB9mB6naxh3+lEj1VTBzKmHBAGqN7dBfrSKgUAGiev2Ut/RZiLR2Fj
         3BHGKnSlSV77ny1TbxtbGrDNJGFVXN+J2grufp5iMxtw+FJwPRk2X465wFzGecjnM7SE
         lMdgCBxFxs8BhrQnDs5+OSsbomUaUZx7Ld0Y4j2Y+KfKO+kgY0l3SDp0yQXNkccvwmAP
         bO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UnWHy6eSjoC7Omr3jRFCulAdfH3kVNn4/HLfjIyaOH8=;
        b=iCClCpWQ9kqxZ/s8jX29py3wpNbwdNDBRiEYffPE0/sra4Sdh1Jqqy4yrap6kF/S7m
         hXaa02dfu3uzByqLJC5CVQGEzAJCpeTjbKzgpw+awEHwpsySWvO/J0e8YmGPGmO1CY0p
         z1V0a9RyGI/5PwVeltrtKirHKdYxL5pexVUakmcly1J6z+QNTpaCU4uTGiwJSPTS/McB
         J/JNgLgDanbVHliCFsZSgImwtQBuqCWxd1IZzyB4mMUpFeDGUo+jHrA+n6AnjQf+u35W
         8raNMOsZfw1RO2uSpn0HpZPBZl2qENLmfbZwwRn4so2LQNco7RQmBqZgucMfReM2WTF7
         9pWw==
X-Gm-Message-State: AOAM531wieupzpYF7Pi38XoqDm9Hk6rO3YkRpDg9j2Uh0u88bDtFLe5F
        rU6mXuSHDyTG23yCVLPEVoGSiT7sG4dWSU1X
X-Google-Smtp-Source: ABdhPJyfkcISuuYdDY2bBnJWdBT4mdbOyJo5oybUWeEGQJsexljhqEs7epSMXQPLKyMJrSH9/3xCig==
X-Received: by 2002:a63:6442:0:b0:362:ad55:f5e5 with SMTP id y63-20020a636442000000b00362ad55f5e5mr13254295pgb.180.1645964708396;
        Sun, 27 Feb 2022 04:25:08 -0800 (PST)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.152])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm9802969pfh.174.2022.02.27.04.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 04:25:07 -0800 (PST)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, avarab@gmail.com,
        Shubham Mishra <shivam828787@gmail.com>
Subject: [GSoC] [PATCH v2 0/2] avoid pipes with Git on LHS
Date:   Sun, 27 Feb 2022 17:54:51 +0530
Message-Id: <20220227122453.25278-1-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <220224.86o82wab31.gmgdl@evledraar.gmail.com>
References: <220224.86o82wab31.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

changes since v1:
* replaced "wc -l" with test_stdout_line_count 
* removed unnecessary "()" subshells

Shubham Mishra (2):
  t0001-t0028: avoid pipes with Git on LHS
  t0030-t0050: avoid pipes with Git on LHS

 t/t0000-basic.sh            | 10 +++--
 t/t0022-crlf-rename.sh      |  4 +-
 t/t0025-crlf-renormalize.sh |  4 +-
 t/t0027-auto-crlf.sh        | 12 +++---
 t/t0030-stripspace.sh       | 75 ++++++++++++++++++++++++-------------
 t/t0050-filesystem.sh       |  3 +-
 6 files changed, 66 insertions(+), 42 deletions(-)

Range-diff against v1:
1:  2a219ace42 = 1:  2a219ace42 t0001-t0028: avoid pipes with Git on LHS
2:  d08c144476 ! 2:  c90fc271d9 t0030-t0050: avoid pipes with Git on LHS
    @@ Commit message
         Signed-off-by: Shubham Mishra <shivam828787@gmail.com>
     
      ## t/t0030-stripspace.sh ##
    +@@ t/t0030-stripspace.sh: s40='                                        '
    + sss="$s40$s40$s40$s40$s40$s40$s40$s40$s40$s40" # 400
    + ttt="$t40$t40$t40$t40$t40$t40$t40$t40$t40$t40" # 400
    + 
    ++printf_git_stripspace () {
    ++    printf "$1" | git stripspace
    ++}
    ++
    + test_expect_success \
    +     'long lines without spaces should be unchanged' '
    +     echo "$ttt" >expect &&
     @@ t/t0030-stripspace.sh: test_expect_success \
      
      test_expect_success \
    @@ t/t0030-stripspace.sh: test_expect_success \
     -    test $(printf "$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
     -    test $(printf "$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
     -    test $(printf "$ttt$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0
    -+    printf "$ttt" | git stripspace >tmp &&
    -+    test $(wc -l <tmp) -gt 0 &&
    -+    printf "$ttt$ttt" | git stripspace >tmp &&
    -+    test $(wc -l <tmp) -gt 0 &&
    -+    printf "$ttt$ttt$ttt" | git stripspace >tmp &&
    -+    test $(wc -l <tmp) -gt 0 &&
    -+    printf "$ttt$ttt$ttt$ttt" | git stripspace >tmp &&
    -+    test $(wc -l <tmp) -gt 0
    ++    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt" &&
    ++    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt" &&
    ++    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt" &&
    ++    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt$ttt"
      '
      
      # text plus spaces at the end:
    @@ t/t0030-stripspace.sh: test_expect_success \
     -    test $(printf "$ttt$sss$sss" | git stripspace | wc -l) -gt 0 &&
     -    test $(printf "$ttt$ttt$sss$sss" | git stripspace | wc -l) -gt 0 &&
     -    test $(printf "$ttt$sss$sss$sss" | git stripspace | wc -l) -gt 0
    -+    printf "$ttt$sss" | git stripspace >tmp &&
    -+    test $(wc -l <tmp) -gt 0 &&
    -+    printf "$ttt$ttt$sss" | git stripspace >tmp &&
    -+    test $(wc -l <tmp) -gt 0 &&
    -+    printf "$ttt$ttt$ttt$sss" | git stripspace >tmp &&
    -+    test $(wc -l <tmp) -gt 0 &&
    -+    printf "$ttt$sss$sss" | git stripspace >tmp &&
    -+    test $(wc -l <tmp) -gt 0 &&
    -+    printf "$ttt$ttt$sss$sss" | git stripspace >tmp &&
    -+    test $(wc -l <tmp) -gt 0 &&
    -+    printf "$ttt$sss$sss$sss" | git stripspace >tmp &&
    -+    test $(wc -l <tmp) -gt 0
    ++    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$sss" &&
    ++    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$sss" &&
    ++    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$ttt$sss" &&
    ++    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$sss$sss" &&
    ++    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$ttt$sss$sss" &&
    ++    test_stdout_line_count -gt 0 printf_git_stripspace "$ttt$sss$sss$sss"
      '
      
      test_expect_success \
    @@ t/t0030-stripspace.sh: test_expect_success \
     -    ! (printf "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
     -    ! (printf "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
     +    printf "$ttt$sss" | git stripspace >tmp &&
    -+    ! (grep "  " tmp >/dev/null) &&
    ++    ! grep "  " tmp >/dev/null &&
     +    printf "$ttt$ttt$sss" | git stripspace &&
    -+    ! (grep "  " tmp >/dev/null) &&
    ++    ! grep "  " tmp >/dev/null &&
     +    printf "$ttt$ttt$ttt$sss" | git stripspace &&
    -+    ! (grep "  " tmp >/dev/nul) &&
    ++    ! grep "  " tmp >/dev/null &&
     +    printf "$ttt$sss$sss" | git stripspace &&
    -+    ! (grep "  " tmp >/dev/null) &&
    ++    ! grep "  " tmp >/dev/null &&
     +    printf "$ttt$ttt$sss$sss" | git stripspace &&
    -+    ! (grep "  " tmp >/dev/null) &&
    ++    ! grep "  " tmp >/dev/null &&
     +    printf "$ttt$sss$sss$sss" | git stripspace &&
    -+    ! (grep "  " tmp >/dev/null)
    ++    ! grep "  " tmp >/dev/null
      '
      
      test_expect_success \
    @@ t/t0030-stripspace.sh: test_expect_success \
     -    ! (echo "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
     -    ! (echo "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
     +    echo "$ttt$sss" | git stripspace >tmp &&
    -+    ! (grep "  " tmp >/dev/null) &&
    ++    ! grep "  " tmp >/dev/null &&
     +    echo "$ttt$ttt$sss" | git stripspace >tmp &&
    -+    ! (grep "  " tmp>/dev/null) &&
    ++    ! grep "  " tmp>/dev/null &&
     +    echo "$ttt$ttt$ttt$sss" &&
    -+    ! (grep "  " tmp >/dev/null) &&
    ++    ! grep "  " tmp >/dev/null &&
     +    echo "$ttt$sss$sss" | git stripspace >tmp &&
    -+    ! (grep "  " tmp >/dev/null) &&
    ++    ! grep "  " tmp >/dev/null &&
     +    echo "$ttt$ttt$sss$sss" | git stripspace >tmp &&
    -+    ! (grep "  " tmp >/dev/null) &&
    ++    ! grep "  " tmp >/dev/null &&
     +    echo "$ttt$sss$sss$sss" | git stripspace >tmp &&
    -+    ! (grep "  " tmp >/dev/null)
    ++    ! grep "  " tmp >/dev/null
      '
      
      test_expect_success \
    @@ t/t0030-stripspace.sh: test_expect_success \
     -    ! (printf "$sss$sss$sss" | git stripspace | grep " " >/dev/null) &&
     -    ! (printf "$sss$sss$sss$sss" | git stripspace | grep " " >/dev/null)
     +    printf "" | git stripspace >tmp &&
    -+    ! ( grep " " tmp >/dev/null) &&
    ++    ! grep " " tmp >/dev/null &&
     +    printf "$sss" | git stripspace >tmp &&
    -+    ! ( grep " " tmp >/dev/null) &&
    ++    ! grep " " tmp >/dev/null &&
     +    printf "$sss$sss" | git stripspace >tmp &&
    -+    ! (grep " " tmp >/dev/null) &&
    ++    ! grep " " tmp >/dev/null &&
     +    printf "$sss$sss$sss" | git stripspace >tmp &&
    -+    ! (grep " " tmp >/dev/null) &&
    ++    ! grep " " tmp >/dev/null &&
     +    printf "$sss$sss$sss$sss" | git stripspace >tmp &&
    -+    ! (grep " " tmp >/dev/null)
    ++    ! grep " " tmp >/dev/null
      '
      
      test_expect_success \
-- 
2.25.1

