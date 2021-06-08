Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77F5C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 13:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8812D6128E
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 13:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbhFHNyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 09:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhFHNyB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 09:54:01 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747C4C061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 06:51:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x19so3527200pln.2
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 06:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mm5+uOpxtZO+PnLrJD2WjlCbgIAxz31pYAQ68CEC4ys=;
        b=LkfBbTVwF66Yq9WAH12KbLhC42Lu0syD5S3AvM+/YIsCe2t4gtCpA2LZAClJrfeSwz
         leeaICfthzdY+fBJvsRvqGVk19pjRdIGLR/gZxdReaJW0UZLnYb659r6AA0nwxlskrgl
         39UPZTazkpGzxHZwx+tzbvYs+Nz6pmJ/1C0O8sJ8IT6Epd4gIBx2//HKLqL5ngj5Y4ic
         2lDwXn2Ooh9DDjWANgvtibmRAcCgSHhqpkuleM7SCfnuReXBZ49DZkeB/NcphoHHh35P
         SsqZstgf4Ov8G+9dpJWSFBi7ph+D3hZbes9mjw8tEKna/mgR90Vpqc2rZ7QhuYA/MRXb
         2gHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mm5+uOpxtZO+PnLrJD2WjlCbgIAxz31pYAQ68CEC4ys=;
        b=FSQsDL1oIYVSOBlXwJ3PUWyP/7F6OQ4jZs9uFWklxu1nkDlxDzyzQ9KqIIB5NRAY+9
         Bv9AYfYUVZx5J0eeWxcZrY54yW/4LCJDLIjuCkg7mV5QoliCRM6bk6HYBkh4zPY3rul7
         taB5V/NS8GFjxx09ButbmpyAJUtGlEcIxriGe3jOYpYW60tpq68/riSh+A8edKOTuUJU
         ItuezEgZfjZkjnZ+fRotXnrD3VzHC7XfGsoYpsm1wODvFHZrquKavxqNjHIrWXyBVm5A
         hQ984UB6QbucuzhWdPETFuouo6e+G005qec0DAY5qpO0ZZML2Pp8mEtBNt+d7ko9zoBE
         8ceg==
X-Gm-Message-State: AOAM530a86dGcqZgSugzpX/Cfl2FTC0VQZGHJGHBcfFBOxj7/4aBvPyh
        BhUgW/+MT0BmllKHY3V+rYS0Of7ToKF7r7QJrHg=
X-Google-Smtp-Source: ABdhPJyoOmx+BU6eSFp4FPH5etTZ7hFkvwOt4fuzEO4xczsOXkPX4e/nhQrCEBNHJ1uUzQ1cofBCCA==
X-Received: by 2002:a17:90a:b008:: with SMTP id x8mr26594108pjq.160.1623160316172;
        Tue, 08 Jun 2021 06:51:56 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id g4sm11929523pgu.46.2021.06.08.06.51.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 06:51:55 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH] MyFirstContribution: link #git-devel to Libera Chat
Date:   Tue,  8 Jun 2021 19:21:14 +0530
Message-Id: <20210608135114.71104-1-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's pretty safe to say that most of the regulars on #git-devel are now
on Libera Chat. This will help new contributors find the right place, if
they choose to ask questions on `#git-devel`.

Since there seems to be no way to directly link Libera's web chat to
`#git-devel` directly, I have put a generic link over the text 'Libera
Chat'. Users will have to manually type `#git-devel` in the webchat
interface, but that should be obvious enough to not be worth mentioning.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---

My heuristic for determining "most of the regulars are on Libera Chat" is the
fact that the last biweekly standup happened there.

 Documentation/MyFirstContribution.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index af0a9da62e..cd9e2069d4 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -47,7 +47,7 @@ Veteran contributors who are especially interested in helping mentor newcomers
 are present on the list. In order to avoid search indexers, group membership is
 required to view messages; anyone can join and no approval is required.
 
-==== https://webchat.freenode.net/#git-devel[#git-devel] on Freenode
+==== #git-devel on https://web.libera.chat[Libera Chat]
 
 This IRC channel is for conversations between Git contributors. If someone is
 currently online and knows the answer to your question, you can receive help
@@ -826,9 +826,9 @@ NOTE: You can typically find someone who can `/allow` you on GitGitGadget by
 either examining recent pull requests where someone has been granted `/allow`
 (https://github.com/gitgitgadget/git/pulls?utf8=%E2%9C%93&q=is%3Apr+is%3Aopen+%22%2Fallow%22[Search:
 is:pr is:open "/allow"]), in which case both the author and the person who
-granted the `/allow` can now `/allow` you, or by inquiring on the
-https://webchat.freenode.net/#git-devel[#git-devel] IRC channel on Freenode
-linking your pull request and asking for someone to `/allow` you.
+granted the `/allow` can now `/allow` you, or by inquiring on the #git-devel IRC
+channel on https://web.libera.chat[Libera Chat] linking your pull request and
+asking for someone to `/allow` you.
 
 If the CI fails, you can update your changes with `git rebase -i` and push your
 branch again:
-- 
2.31.1

