Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402CAC2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 19:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159352080D
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 19:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzoPOs3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLZTB7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 14:01:59 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:36200 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfLZTB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 14:01:58 -0500
Received: by mail-ed1-f45.google.com with SMTP id j17so23473704edp.3
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 11:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=zCg/P5ZDr42HNjPZpMROthw00kD6ISpFqONI+OBzTpU=;
        b=tzoPOs3sxvHr7OQDJch7ccmF8vW40RY0jT8b0sGki75cLTz/fA5xq7JaWdhvUP0ZPb
         PIZwDBZ/w1ggfcyQr6R4eOCixbiDs2xKS1VTuIznijeTnXd9O+ss8qbGvcuXpOTJNuir
         DoMPXdNH6gNGHx5U4MXXtzMCUATV+lVuVVpvqcOU95+JI4IBFAm3cotQQ01rexFnlk4q
         OS0//9pfDhi/+UONrHeNrYAjyqZWzH80W8wxRgmZYA7G2Wrv9DGiXKjsLucrvv9xWbIz
         yBW8WS5Z6kCS8DenDV48/s8TY+xL4xqWjCBAfUioraBEoPdYIJHqjXhn4R6OKVpDHXPr
         1zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=zCg/P5ZDr42HNjPZpMROthw00kD6ISpFqONI+OBzTpU=;
        b=BQpsCMq9BT/x7W0iz1upbZa45LdJVZRuJpmJK7BHmUgz8uj7EKZD0QD1kxbVfWxj2j
         RUualhzCUjKcmIAwJaopmW7Itl8D0l346IDTfcO1q4tapHkOaaAka60B1gR4hoAa5UCK
         I6e7oHh99Xuz8tEYfjK0huf/w3O3vLlC3nApdduiDEA/30kr1WIUcbXP69oK1BluBfC9
         kWrZOMu9nvDs6xpqGt2EjIvwjw4UJvIe6VXjNFDfZyJZm6l9IRXGbZH73D9s/gKAfNac
         sAz/VpLglNOxPP64O250inJy5HIfjmQWGUYjl/pamDel0UXjrH3prNczI5KKm45JTmeH
         sMxA==
X-Gm-Message-State: APjAAAVasOjja/zATwwC5v72oHNMch5xxBlEc98lrc0A0SoX16grEYoo
        TXXEry3YrmzpiuGzJp+C+NjXrEGe
X-Google-Smtp-Source: APXvYqwCAsE/m6KiggDnK+lS2Sa4gpuRY+niJ0qCxFYGYBgm5yTOTLzmKVNb/rKf12wYA6ZO1GO1Uw==
X-Received: by 2002:a05:6402:697:: with SMTP id f23mr53228579edy.0.1577386916848;
        Thu, 26 Dec 2019 11:01:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id qc1sm1671910ejb.49.2019.12.26.11.01.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Dec 2019 11:01:56 -0800 (PST)
Message-Id: <pull.499.git.1577386915.gitgitgadget@gmail.com>
From:   "Zoli =?UTF-8?Q?Szab=C3=B3?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 26 Dec 2019 19:01:54 +0000
Subject: [PATCH 0/1] git-gui: add possibility to open currently selected file
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

...in the default associated app (e.g. in a text editor / IDE).

Many times there's the need to quickly open a source file (the one you're
looking at in Git GUI) in the predefined text editor / IDE. Of course, the
file can be searched for in your preferred file manager or directly in the
text editor, but having the option to directly open the current file from
Git GUI would be just faster. This change enables just that by:

 * Diff header path context menu -> Open;
 * or double-clicking the diff header path.

One "downside" of the approach is that executable files will be run and not
opened for editing.

Signed-off-by: Zoli Szabó zoli.szabo@gmail.com [zoli.szabo@gmail.com]

Zoli Szabó (1):
  git-gui: add possibility to open currently selected file

 git-gui.sh | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)


base-commit: 23cbe427c44645a3ab0449919e55bade5eb264bc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-499%2Fzoliszabo%2Fgit-gui%2Fopen-current-file-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-499/zoliszabo/git-gui/open-current-file-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/499
-- 
gitgitgadget
