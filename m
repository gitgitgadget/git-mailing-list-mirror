Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B34C3567B
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92FA20836
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 09:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feBrb2J7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgBXJNC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:13:02 -0500
Received: from mail-yb1-f171.google.com ([209.85.219.171]:34595 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgBXJJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 04:09:57 -0500
Received: by mail-yb1-f171.google.com with SMTP id u47so4334603ybi.1
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 01:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KbWtixSSrwzQ8Z0NPfwwBQ7MERfZZn+r21Qah2tKtkg=;
        b=feBrb2J7sDSr56iBXA2a27mXwlaxzAdFsoCRnSD61JdYwObL0RI/W6mdw0rKpgSziZ
         lHP7osP9aKmNGiy9d74iHjQideG5VlC4Fjcx0q3v1xuovgDWk+aHOzyIwGUeXDp78yqX
         I2beN31E/W50v+r1OtQVqzzIt8J9oqKr3mHKDCSB6g7EYkB2hAfMRJSOoKIG+p+TSXU2
         4jVRMWWyD7PQ72/0spwFH5+r6IKbof1k6kVvMJH4EVIGSgMzlOeU8hSf/mCjaKj5gZJh
         mmjvOK0vLhAzD2Qvl9d7c9xqYwAdUNPIT0b+gP1ijK19sJKGuVYZG1V2twyDuGOK5b1O
         g/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KbWtixSSrwzQ8Z0NPfwwBQ7MERfZZn+r21Qah2tKtkg=;
        b=EG9CBeZwHO3Aex6urGDAYtxoB4XIKqf9oGvnfPkWdBVkbbx87F15h22ZOfeZUhzgoj
         YvWsxk8U9AoBmfKGrE0mgI7G6riwSXSCUCe+7yhBp7HrVAMMiEpLnoThLbH52fhN5s0R
         khv/9ke/b34D4Z3QACRYhdpyXZzP1Bb5p1keaykVse3ZhVqAUEcNB6TMDZV8BQulmsXh
         Ksw1NCQOQKXR2l25STJgQ0vMP2zLgE3HA69v1eq+tgOpPg7hp+D1fWdt6l+jeRkYio2J
         wDpr0c5eXbOEssjUbFhkkWMFLQuLKP9S+OIBMNbu4e1mQD+3qsuHY+6CsxgIqY3ToAz9
         cxvw==
X-Gm-Message-State: APjAAAUM7cNnnkYBhR4Jr4cE7S2pZzGGtmoqHPCrATU9fWBbHobNv3PA
        hCbNpXbf/c19msxvs4myaOC8G9+d
X-Google-Smtp-Source: APXvYqwfiCoulsFVm7/Kn+HwY6vR6Iy+xA67gUYjwBux21CpOVgu0mOD+pUuJGU8xFnquBkBeot0Bg==
X-Received: by 2002:a25:5a41:: with SMTP id o62mr22029386ybb.329.1582535395998;
        Mon, 24 Feb 2020 01:09:55 -0800 (PST)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id g29sm5045988ywk.31.2020.02.24.01.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 01:09:55 -0800 (PST)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Cameron Gunnin <cameron.gunnin@synopsys.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/3] worktree: improve find_worktree() documentation
Date:   Mon, 24 Feb 2020 04:08:46 -0500
Message-Id: <20200224090848.54321-2-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.25.1.526.gf05a752211
In-Reply-To: <20200224090848.54321-1-sunshine@sunshineco.com>
References: <CAPig+cQh8hxeoVjLHDKhAcZVQPpPT5v0AUY8gsL9=qfJ7z-L2A@mail.gmail.com>
 <20200224090848.54321-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do a better job of explaining that find_worktree()'s main purpose is to
locate a worktree based upon input from a user which may be some sort of
shorthand for identifying a worktree rather than an actual path. For
instance, one shorthand a user can use to identify a worktree is by
unique path suffix (i.e. given worktrees at paths "foo/bar" and
"foo/baz", the latter can be identified simply as "baz"). The actual
heuristics find_worktree() uses to select a worktree may be expanded in
the future (for instance, one day it may allow worktree selection by
<id> of the .git/worktrees/<id>/ administrative directory), thus the
documentation does not provide a precise description of how matching is
performed, instead leaving it open-ended to allow for future
enhancement.

While at it, drop mention of the non-NULL requirement of `prefix` since
NULL has long been allowed. For instance, prefix_filename() has
explicitly allowed NULL since 116fb64e43 (prefix_filename: drop length
parameter, 2017-03-20), and find_worktree() itself since e4da43b1f0
(prefix_filename: return newly allocated string, 2017-03-20).

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 worktree.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/worktree.h b/worktree.h
index caecc7a281..b8a851b92b 100644
--- a/worktree.h
+++ b/worktree.h
@@ -44,8 +44,18 @@ int submodule_uses_worktrees(const char *path);
 const char *get_worktree_git_dir(const struct worktree *wt);
 
 /*
- * Search a worktree that can be unambiguously identified by
- * "arg". "prefix" must not be NULL.
+ * Search for the worktree identified unambiguously by `arg` -- typically
+ * supplied by the user via the command-line -- which may be a pathname or some
+ * shorthand uniquely identifying a worktree, thus making it convenient for the
+ * user to specify a worktree with minimal typing. For instance, if the last
+ * component (say, "foo") of a worktree's pathname is unique among worktrees
+ * (say, "work/foo" and "work/bar"), it can be used to identify the worktree
+ * unambiguously.
+ *
+ * `prefix` should be the `prefix` handed to top-level Git commands along with
+ * `argc` and `argv`.
+ *
+ * Return the worktree identified by `arg`, or NULL if not found.
  */
 struct worktree *find_worktree(struct worktree **list,
 			       const char *prefix,
-- 
2.25.1.526.gf05a752211

