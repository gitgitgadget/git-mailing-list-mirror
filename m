Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DC3C2D0B1
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6482020661
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InwIWT5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfLDW3s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:29:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46791 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbfLDW3q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:29:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so1058146wrl.13
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Gl/kCKnStjrJrZ8zYMAsY2UtbM6GFFGrW5BTTTWrAJo=;
        b=InwIWT5f0TWB+CWZDzIb8hZ7i9caFbha13Llo188+2lvOPKMX85rLyCXGrRW50GUVN
         /lHnSn2MbY6PjBe4Gn/WsB5yAUSOBNacQ7XnY4pfpCik5fVfB8FvqmHRLM1FfD7WoY8J
         ZSTUQTGJkGXmy02bhRUYxSmzRy2AMuwzit75hO/7vR5O5I79q+JW0UWQKsu3F9E5DcX5
         0xcRcumZAuKRSaRfTxAirZ+l04huq2rso3iCduzKr+AK0bKVLTUkCvJzio24UHsCUU/1
         ADwI7M3kV4p/AnR6RqV8R1HbQtk/0t4yOwoIjRQXPAj2qdpbge3E89j+vDfUYch33a0y
         Ezbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Gl/kCKnStjrJrZ8zYMAsY2UtbM6GFFGrW5BTTTWrAJo=;
        b=gEOJHmsnypDdv31lqyEobJylv+rzkfpCLt4UzHhA1Uken5U5KP8IEClR8HpJVU+Khc
         6mILw+0PFn4vf6mdOAQh8ZEGFpCnIrihVSD065a3iHQVS3PmJdjPlYiD21tzQcE4wxHq
         DwZ3q1x8KBCunf3VHQ9RfkDWhAkvyBXXR5KZE0LruhzaMfrlQqdzSyGBfznD22HlRYCs
         KGhmqN3LaEJSk8vI29Oy6rwbvme5zbYQ9OohMdvey3S8cOoKw8kPbdvJKdnq9pX69LQ6
         78S7OGCpQoEFavQzdVbWLjnlUOvrJLnb1muWGpQp8jXaCcfNd4Iw+/MOsw+PaQmhwRqz
         mRRQ==
X-Gm-Message-State: APjAAAWNp4/mA+fs5Ap4gnWaU4OWgsuY8wpOwQ9LY0SQ6d24zJ5LSt/X
        E67ys1PdkMHmrl72A09UPC0OKnPl
X-Google-Smtp-Source: APXvYqzxmb29+gDHimSo89zXuslpXY7zRA5R/oopMPUi3Cse2Q4wMUMQ+jmTSauBE3tdcBlP1XKz9w==
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr6488357wrw.311.1575498584553;
        Wed, 04 Dec 2019 14:29:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s10sm9960434wrw.12.2019.12.04.14.29.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 14:29:44 -0800 (PST)
Message-Id: <8f5752c12737fd861274609fdafac095ad95c519.1575498578.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
        <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Dec 2019 22:29:32 +0000
Subject: [PATCH v4 06/11] git-p4: Fix assumed path separators to be more
 Windows friendly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

When a computer is configured to use Git for windows and Python for windows, and not a Unix subsystem like cygwin or WSL, the directory separator changes and causes git-p4 to fail to properly determine paths.

Fix 3 path separator errors:

1. getUserCacheFilename should not use string concatenation. Change this code to use os.path.join to build an OS tolerant path.
2. defaultDestiantion used the OS.path.split to split depot paths.  This is incorrect on windows. Change the code to split on a forward slash(/) instead since depot paths use this character regardless  of the operating system.
3. The call to isvalidGitDir() in the main code also used a literal forward slash. Change the cose to use os.path.join to correctly format the path for the operating system.

These three changes allow the suggested windows configuration to properly locate files while retaining the existing behavior on non-windows operating systems.

Signed-off-by: Ben Keene <seraphire@gmail.com>
(cherry picked from commit a5b45c12c3861638a933b05a1ffee0c83978dcb2)
---
 git-p4.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2659531c2e..7ac8cb42ef 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1454,8 +1454,10 @@ def p4UserIsMe(self, p4User):
             return True
 
     def getUserCacheFilename(self):
+        """ Returns the filename of the username cache 
+	    """
         home = os.environ.get("HOME", os.environ.get("USERPROFILE"))
-        return home + "/.gitp4-usercache.txt"
+        return os.path.join(home, ".gitp4-usercache.txt")
 
     def getUserMapFromPerforceServer(self):
         if self.userMapFromPerforceServer:
@@ -3973,13 +3975,16 @@ def __init__(self):
         self.cloneBare = False
 
     def defaultDestination(self, args):
+        """ Returns the last path component as the default git 
+            repository directory name
+        """
         ## TODO: use common prefix of args?
         depotPath = args[0]
         depotDir = re.sub("(@[^@]*)$", "", depotPath)
         depotDir = re.sub("(#[^#]*)$", "", depotDir)
         depotDir = re.sub(r"\.\.\.$", "", depotDir)
         depotDir = re.sub(r"/$", "", depotDir)
-        return os.path.split(depotDir)[1]
+        return depotDir.split('/')[-1]
 
     def run(self, args):
         if len(args) < 1:
@@ -4252,8 +4257,8 @@ def main():
                         chdir(cdup);
 
         if not isValidGitDir(cmd.gitdir):
-            if isValidGitDir(cmd.gitdir + "/.git"):
-                cmd.gitdir += "/.git"
+            if isValidGitDir(os.path.join(cmd.gitdir, ".git")):
+                cmd.gitdir = os.path.join(cmd.gitdir, ".git")
             else:
                 die("fatal: cannot locate git repository at %s" % cmd.gitdir)
 
-- 
gitgitgadget

