Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1A8C433F5
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 12:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350261AbiD2Mg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 08:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242740AbiD2Mg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 08:36:57 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682CFC90DF
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 05:33:38 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso83576447b3.5
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 05:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=9l9G3cWnCNBkb9zr0CoUEOZ2AMvHZk391niZUaU7LMY=;
        b=RwC4r3UvgV/Cwolj1gcpxCac6XAlpcGYJZxwKdSyxH05vbS5pESC5NWXASN0u/pDRs
         Z0chNy5qOmuU9ATXCoDwuqv7rsbRn5PM/5K+o61IqVFFjfo4qdhU4JZeCIE4cnRPUtBr
         0zIiyusio7CpmL3c2QUffwjMFY5rX56oowD0AU6CIJ2BtxnImro3i60xaOuU5pRT0Q0r
         vtdyXJUMsJvlmmftuvdYRCT1LaTsMlhLqvGueSZKCNFhxP93d2bWvuoCjfFSFCC7I1Wy
         bLpBOItYmT0qeyFeOLDGV6fv9WbwHTQ0pIXSOhMiy0myX6LLDgNY0oYeeuSvW/M9RwOC
         MYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9l9G3cWnCNBkb9zr0CoUEOZ2AMvHZk391niZUaU7LMY=;
        b=uKTGRqVksQ8O0An6gmkg5aSLln6tX3iPvLMt6MlgTN7XhNNXLqArW0ffBgZYqjVJyv
         wSW6dsT1V1ba0Zg7j1CaQ3WinxymiHTUVKEMECJlPCmp4irv0dW+hJ7VYiGVHyqKQ/md
         +S2JL/PMCTsrLh/CFSZQrHv8SjTBUVpS4V2WfMubyUQDcJAw3Nv58KtaOJIgapqECjOZ
         Va0s+jbjxfX3VKdO2OZC+COfxppqPMcXYzxSl4qL8gZ6Vzy+8FgDbSHQJdMvm+u8EjGQ
         PmPHA7RgtMVw36INv9tkriTydZXHlziHQidITUVtnfgEl+WdyBzBFLIZTUM3cxoqrGPi
         byaA==
X-Gm-Message-State: AOAM532Pdv4FUWtNqU4vGoK0FH1YLmzSEnlhi0hzRy/E+HnK21diflST
        QbO5XIVVfkPksvmX+eKlPWPjRZaL9u9YCTxKm+yEqAdu
X-Google-Smtp-Source: ABdhPJxnidv4hTunlcyB+xgp23m6XoVVheykIErk3eyrFNlpIWzqsZDeTbNY6f/p92eNCDS8Yw+UhhlD6Ee7RoKWXKs=
X-Received: by 2002:a81:b88:0:b0:2f7:ccdd:642f with SMTP id
 130-20020a810b88000000b002f7ccdd642fmr30060035ywl.303.1651235617544; Fri, 29
 Apr 2022 05:33:37 -0700 (PDT)
MIME-Version: 1.0
From:   Jack Adrian Zappa <adrianh.bsc@gmail.com>
Date:   Fri, 29 Apr 2022 08:33:26 -0400
Message-ID: <CAKepmahKwpe_YVrVrS0L3hMAu44W8VgbmvHY2LRpbrC6CQ0AKQ@mail.gmail.com>
Subject: Getting an odd diff
To:     git-mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, I have a regex to select words so that I can focus on the actual
changes.  But then I noticed that it did something weird.  It grouped
some parenthesis with another word.  I generated a minimal example for
that line and it was reproducible.

Before:
var result = ((res.State == ResultState.Succeeded) &&
string.IsNullOrEmpty(res.ErrorCode) )? (byte)0 : (byte)1;

After:
var result = res.State == ResultState.Succeeded ? (byte)0 : (byte)1;

Diff:
$ git diff2 --no-index b a
warning: LF will be replaced by CRLF in b.
The file will have its original line endings in your working directory
warning: LF will be replaced by CRLF in a.
The file will have its original line endings in your working directory
diff --git a/b b/a
index 4e3604a8e..619d21e4e 100644
--- a/b
+++ b/a
@@ -1 +1 @@
var result = [-((res-]{+res+}.State == ResultState.Succeeded[-) &&
string.IsNullOrEmpty(res.ErrorCode) )-] ? (byte)0 : (byte)1;

I tried to make a smaller example and it didn't cause the issue.

Before:
var abc = ((xyz.Stuff == other_stuff) && stuff.yay(question) ? yes : no;

After:
var abc = xyz.Stuff == other_stuff ? yes : no;

Diff:
$ git diff2 --no-index b a
warning: LF will be replaced by CRLF in b.
The file will have its original line endings in your working directory
warning: LF will be replaced by CRLF in a.
The file will have its original line endings in your working directory
diff --git a/b b/a
index df18ca34e..1024d6b68 100644
--- a/b
+++ b/a
@@ -1 +1 @@
var abc =[-((-] xyz.Stuff == other_stuff[-) && stuff.yay(question)-] ? yes : no;

So, my question is, what's going on here?

The alias is as follows:
     diff2 = diff --color=always --ignore-space-change
'--word-diff-regex=((\\r\\n?|\\n\\r?)[\\t
]*)?([a-zA-Z_][a-zA-Z_0-9]*|0([xX]([0-9][a-fA-F])+|[0-7]+|[bB][01]+)|[1-9][0-9]*(\\.[0-9]+)?([eE][0-9]+|[pP][0-9a-fA-F])?|\\S)(\\r\\n?|\\n\\r?)?'
-p

Thanks,


JAZ
JAZ
