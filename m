Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 505AE20954
	for <e@80x24.org>; Tue,  5 Dec 2017 02:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbdLECxl (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 21:53:41 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:42018 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdLECxk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 21:53:40 -0500
Received: by mail-it0-f66.google.com with SMTP id p139so17958938itb.1
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 18:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eyFcX2ZIkj3le35lyTviYvcur4CWkKO80iq4MHM6uWQ=;
        b=CgWVw3avkWa+9gGq7GGXzgjYJwTTOpxjq342TZo7PsX1KlBBY/xvkXWh1Yj2wOoscj
         O7nCshjgNTwG5dUFX/SYsrIvST5ZKctqHgrP0yF2jp9fD9BetK6uQg2f5DRi7HCQGHJN
         EsWAykSTx4g7p14F5/L6E8LwIqu/32tHUxLULsjwojnczWFpQJOgbX8DJT4xxCBzg9Vq
         p0E8WtHMZqZwGQu1mK/czrAqFxt4eyMDo/AGURT0oTI7NrDZrbGcLb+fmK6yr9aRhgbK
         iWqvagf/Q4HJf0e+MkOD/HKrI7vNXTfAUqKYKqZMmjOuNqQs55rcyvq7/FLaM0Ve/uig
         YQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eyFcX2ZIkj3le35lyTviYvcur4CWkKO80iq4MHM6uWQ=;
        b=VYP9UUfHSTvKDMLju5eeN7wRbiYngXkDaBZsPwO9hY3+MmlGnfMzH7OdOedqgZhtRN
         tb9paKs3+elNwO/5N3MQwnb72SRhTMXrEoCbgoOzIfVK19vPi3l+1Gyzo6GlKKDxWvpt
         VL5lQe0daRuFZ6IpNIITv6yCHQyBSAqz6+XAAofPi43vekb29bMh0+PXltFaq41+IO/f
         wWa8hpwx38VWyq7K/qYLnvatXkz6Ow51yIKNSuSroTRs+2XkeF/i3BvpqqwhYT7u3Axx
         tnATw+iRhjj69TN+A6Uidd34eEx38iTU2Hqhn4ISGEGHirVZggNLINzI7zO7jc8Q4soa
         YV0Q==
X-Gm-Message-State: AJaThX6r4CFE31A2xSf36rwEVLuivgz/oElD1XGjoSfHMiXUjoK94iqt
        K06ITVfvDMsQM1HYdCEvR16IZF15wOk=
X-Google-Smtp-Source: AGs4zMZaTOMwKvT1gNgb7unVhrc6+FRHA8iZW6qS6uknIhr4uJsPpS3931vsoNZBc++3T7RpOY11HA==
X-Received: by 10.107.183.84 with SMTP id h81mr27887762iof.57.1512442419339;
        Mon, 04 Dec 2017 18:53:39 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w186sm4528501itd.12.2017.12.04.18.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Dec 2017 18:53:38 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH] Documentation/git-clone: improve description for submodule recursing
Date:   Mon,  4 Dec 2017 18:53:32 -0800
Message-Id: <20171205025332.9835-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c9-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There have been a few complaints on the mailing list that git-clone doesn't
respect the `submodule.recurse` setting, which every other command (that
potentially knows how to deal with submodules) respects.  In case of clone
this is not beneficial to respect as the user may not want to obtain all
submodules (assuming a pathspec of '.').

Improve the documentation such that the pathspec is mentioned in the
synopsis to alleviate the confusion around the submodule recursion flag
in git-clone.

While at it clarify that the option can be given multiple times for complex\
pathspecs.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 83c8e9b394..42ca7b5095 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
-	  [--recurse-submodules] [--[no-]shallow-submodules]
+	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
 	  [--jobs <n>] [--] <repository> [<directory>]
 
 DESCRIPTION
@@ -231,14 +231,17 @@ branch of some repository for search indexing.
 	After the clone is created, initialize and clone submodules
 	within based on the provided pathspec.  If no pathspec is
 	provided, all submodules are initialized and cloned.
-	Submodules are initialized and cloned using their default
-	settings.  The resulting clone has `submodule.active` set to
+	This option can be given multiple times for pathspecs consisting
+	of multiple entries.  The resulting clone has `submodule.active` set to
 	the provided pathspec, or "." (meaning all submodules) if no
-	pathspec is provided.  This is equivalent to running
-	`git submodule update --init --recursive` immediately after
-	the clone is finished. This option is ignored if the cloned
-	repository does not have a worktree/checkout (i.e. if any of
-	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
+	pathspec is provided.
++
+Submodules are initialized and cloned using their default settings. This is
+equivalent to running
+`git submodule update --init --recursive <pathspec>` immediately after
+the clone is finished. This option is ignored if the cloned repository does
+not have a worktree/checkout (i.e. if any of `--no-checkout`/`-n`, `--bare`,
+or `--mirror` is given)
 
 --[no-]shallow-submodules::
 	All submodules which are cloned will be shallow with a depth of 1.
-- 
2.15.0.531.g2ccb3012c9-goog

