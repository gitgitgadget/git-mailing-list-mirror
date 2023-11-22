Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRrjHQ6R"
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4777D10E
	for <git@vger.kernel.org>; Tue, 21 Nov 2023 23:56:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40839652b97so29367345e9.3
        for <git@vger.kernel.org>; Tue, 21 Nov 2023 23:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700639765; x=1701244565; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AKEjtwYDnXUJc5evWBYVlkDuGTUNNACGMkGnPFOPMTg=;
        b=kRrjHQ6RHx/HRcIadqcxi7v2nGLaPA8azHmNfz8w6x306q6PPo3cqyfOHCVGDqIg25
         cZ7j04UeJQsqesT8V604MROL5IdpebNsROK0h+ZcY+awNqgPaF2pal0exd3ud0V4LQPI
         bNGojQ4KJcGGbMS99r7cHOpYmcMNqeAOhmq8A5/3WZesegpSRkeCkQP2MixWuxcp3038
         TE9+EF/UGPm5fuuvQUE1FHmsHEttW4sJhV6UIZnS1T6zPEUTVHIhtf+UcZ7LGcKhBTYh
         MwNAUbC1ohLUbQH1QTB5/GRnRDKg0njLvptNL5nj2KMM7H+PEc9Q8NhSY4i8GT/D1RzB
         qksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700639765; x=1701244565;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKEjtwYDnXUJc5evWBYVlkDuGTUNNACGMkGnPFOPMTg=;
        b=MK4EWZoC7GChMHjOoHeBZZAol0bvexMYRrVg1fMdg4mtmuj/lkdWBZTBx7ZQm/La4k
         QA6AiLXXJhxjNmfsMIw5kwbZHtNuAyICzWn2NPSPhB8hEZYEbfCt6CjhoM/6AvL65oYF
         iVHA3KTdR5EYTwSzVJ2vFyBHDva7woUdB+SLbJsID7toI+5ELlZ3j8TJJekDie4ih/Ow
         DQnHpMMW8IpPyXkInr8vPY4Xmj53nUlKuv2JTQ5eP0aqFcBvkZO3NbjaRJheTNo4SJUR
         i4msoVviMn4J9Js1LJT6Q7kUvywq/MtNuI0PE7Y4yBE+exT1dSKMYl/Oi5qj63llky2B
         jqzQ==
X-Gm-Message-State: AOJu0YyNfJQCzAQM1d/r8PLz0+nejBGJmZHXZhK37sJJRnAAEzfgzh0D
	lw+ymIWsvzNFtXixO+ynNYy+JJEF2uo=
X-Google-Smtp-Source: AGHT+IFfIjzewX8mWlX3liX8JfcXuj0ZXO/5XoB2gLfF5MuRBmkGCClnd+nHJJPtAf+3sTLz0U4ITA==
X-Received: by 2002:a05:600c:1394:b0:402:ff8d:609b with SMTP id u20-20020a05600c139400b00402ff8d609bmr1396540wmf.33.1700639764826;
        Tue, 21 Nov 2023 23:56:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y10-20020adfee0a000000b0032dcb08bf94sm16245121wrn.60.2023.11.21.23.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 23:56:04 -0800 (PST)
Message-ID: <pull.1609.git.git.1700639764041.gitgitgadget@gmail.com>
From: "Alisha Kim via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 22 Nov 2023 07:56:03 +0000
Subject: [PATCH] git-p4: fix fast import when empty commit is first
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Alisha Kim <pril@pril.cc>,
    Alisha Kim <pril@pril.cc>

From: Alisha Kim <pril@pril.cc>

When executing p4 sync by specifying an excluded path, an empty commit
will be created if there is only a change in the excluded path in
revision.
If git-p4.keepEmptyCommits is turned off and an empty commit is the
first, fast-import will fail.

Signed-off-by: Alisha Kim <pril@pril.cc>
---
    git-p4: fix fast import when empty commit is first
    
    When executing p4 sync by specifying an excluded path, an empty commit
    will be created if there is only a change in the excluded path in
    revision. If git-p4.keepEmptyCommits is turned off and an empty commit
    is the first, fast-import will fail.
    
    The error log is as follows Ignoring revision 14035 as it would produce
    an empty commit. fast-import failed: warning: Not updating
    refs/heads/p4/master (new tip new commit hash does not contain parent
    commit hash) fast-import statistics: ...

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1609%2Fdaebo01%2Fgit-p4-pr-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1609/daebo01/git-p4-pr-v1
Pull-Request: https://github.com/git/git/pull/1609

 git-p4.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0eb3bb4c47d..a61200e29e4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3466,7 +3466,7 @@ class P4Sync(Command, P4UserMap):
         if not files and not allow_empty:
             print('Ignoring revision {0} as it would produce an empty commit.'
                 .format(details['change']))
-            return
+            return False
 
         self.gitStream.write("commit %s\n" % branch)
         self.gitStream.write("mark :%s\n" % details["change"])
@@ -3533,6 +3533,8 @@ class P4Sync(Command, P4UserMap):
                     print("Tag %s does not match with change %s: file count is different."
                            % (labelDetails["label"], change))
 
+        return True
+
     def getLabels(self):
         """Build a dictionary of changelists and labels, for "detect-labels"
            option.
@@ -3876,10 +3878,12 @@ class P4Sync(Command, P4UserMap):
                             self.commit(description, filesForCommit, branch, parent)
                 else:
                     files = self.extractFilesFromCommit(description)
-                    self.commit(description, files, self.branch,
+                    isCommitted = self.commit(description, files, self.branch,
                                 self.initialParent)
                     # only needed once, to connect to the previous commit
-                    self.initialParent = ""
+                    if isCommitted:
+                        self.initialParent = ""
+
             except IOError:
                 print(self.gitError.read())
                 sys.exit(1)

base-commit: cfb8a6e9a93adbe81efca66e6110c9b4d2e57169
-- 
gitgitgadget
