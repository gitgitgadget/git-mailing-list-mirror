Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7D5CVrN"
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A407010F1
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 08:13:59 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c8880f14eeso15576671fa.3
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 08:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701360837; x=1701965637; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM2pY1TpKfxU3GBYTpX/Ha9uGd3sphvgJxUfJTJXkXs=;
        b=Q7D5CVrNNqVa4sBACn+PI2+hvgkAQWB3wLQUI72IJUAONAHwOa9Ud/y2TQmKehh0Sf
         3VY4nFcshBF5je3X7nVwwZFrYhiP92ZWsJFHkOlFhCbQldxErcMXVbfk6KCmX0Qxer1V
         jy7n9wEzVarJ4kcwVAOJZy1qGPcWmpeB7qDpsiKY3WuOOBLBZM9T/b9LpLpfu6NMFmqP
         mab08e4+ALBY7kGGnLrWqQ+9hw4q6cihsCGrtvxCKbcRC3IgZxyHsBXIQfj03i6MFzAp
         T95uuyWmFBkAys60uO/dr73zyfe148yn/0mXmP7HlmkcGL1sC7bkTRFSX7eADZNSjgP3
         og7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701360837; x=1701965637;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vM2pY1TpKfxU3GBYTpX/Ha9uGd3sphvgJxUfJTJXkXs=;
        b=oTCPEH5podgOqX7I0awl+B009loT9jday1Ui1ZVe3gV2ZWLOh2nSGL0Sg1g5ssXIJw
         js8UQ09J+1mZn5EwJnpvIfYXuNjpbgGf7jVNvxyXskYFFYGz6XuvamahuJADG0K3C2qr
         GTy9MQHT2vwpS1eRwl8pmcqfl2yxDDoF0zJAOmyVcmhhdI9NOnZXBMhAomLrGEpSHrzh
         ptdf0Qi0/IlgxBljzy6jmne0eVa/FhPt1nwYxEAc8riytIW8QwHEPoTLQtL/d3PcU3YK
         2Dj8iMSTOuGpd3N9QKvJLIgOETYOjacs9cG2FGDudhTf9aXxqXl0bnWpXIKaJxN0bmi1
         2Slg==
X-Gm-Message-State: AOJu0Yz4hBw8w0VNIpVdmdO6+SGsHqBGomargRkfbsbkP7JRruxNgBRc
	7Lq3SlnFIwazc9OG3erk1XUBJFkaPQc=
X-Google-Smtp-Source: AGHT+IHJzAr3own0cS0GsoutkdIjn9L9g1GhnllridK5mA4oRLO1Jj2a7nU+XCbOHYofsLR6fu1wVg==
X-Received: by 2002:a2e:9557:0:b0:2c9:b623:ddf1 with SMTP id t23-20020a2e9557000000b002c9b623ddf1mr6049094ljh.51.1701360837285;
        Thu, 30 Nov 2023 08:13:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id he10-20020a05600c540a00b0040a4751efaasm2449312wmb.17.2023.11.30.08.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:13:57 -0800 (PST)
Message-ID: <pull.1291.v2.git.git.1701360836307.gitgitgadget@gmail.com>
In-Reply-To: <pull.1291.git.git.1657837073372.gitgitgadget@gmail.com>
References: <pull.1291.git.git.1657837073372.gitgitgadget@gmail.com>
From: "Julian Prein via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Nov 2023 16:13:56 +0000
Subject: [PATCH v2] hooks--pre-commit: detect non-ASCII when renaming
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
Cc: Julian Prein <druckdev@protonmail.com>,
    Julian Prein <druckdev@protonmail.com>

From: Julian Prein <druckdev@protonmail.com>

When diff.renames is turned on, the diff-filter will not return renamed
files (or copied ones with diff.renames=copy) and potential non-ASCII
characters would not be caught by this hook.

Use the plumbing command diff-index instead of the porcelain one to not
be affected by diff.rename.

Signed-off-by: Julian Prein <druckdev@protonmail.com>
---
    hooks--pre-commit: detect non-ASCII when renaming
    
    A bit later than I expected, but here is v2.
    
    Changes since v1:
    
     * Switched to using diff-index and back to just the A filter as
       suggested by Junio C Hamano

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1291%2Fdruckdev%2Fpre-commit-renames-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1291/druckdev/pre-commit-renames-v2
Pull-Request: https://github.com/git/git/pull/1291

Range-diff vs v1:

 1:  101f327a040 ! 1:  1f6ca0dd3eb hooks--pre-commit: detect non-ASCII when renaming
     @@ Metadata
       ## Commit message ##
          hooks--pre-commit: detect non-ASCII when renaming
      
     -    Currently the diff-filter that is used to check for non-ASCII characters
     -    in filenames only checks new additions.
     +    When diff.renames is turned on, the diff-filter will not return renamed
     +    files (or copied ones with diff.renames=copy) and potential non-ASCII
     +    characters would not be caught by this hook.
      
     -    Extend the diff-filter in the pre-commit sample to include `CR` as well.
     -    This way non-ASCII character in filenames are detected on a rename/copy
     -    as well.
     +    Use the plumbing command diff-index instead of the porcelain one to not
     +    be affected by diff.rename.
      
          Signed-off-by: Julian Prein <druckdev@protonmail.com>
      
     @@ templates/hooks--pre-commit.sample: if [ "$allownonascii" != "true" ] &&
       	# even required, for portability to Solaris 10's /usr/bin/tr), since
       	# the square bracket bytes happen to fall in the designated range.
      -	test $(git diff --cached --name-only --diff-filter=A -z $against |
     -+	test $(git diff --cached --name-only --diff-filter=ACR -z $against |
     ++	test $(git diff-index --cached --name-only --diff-filter=A -z $against |
       	  LC_ALL=C tr -d '[ -~]\0' | wc -c) != 0
       then
       	cat <<\EOF


 templates/hooks--pre-commit.sample | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index e144712c85c..29ed5ee486a 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -28,7 +28,7 @@ if [ "$allownonascii" != "true" ] &&
 	# Note that the use of brackets around a tr range is ok here, (it's
 	# even required, for portability to Solaris 10's /usr/bin/tr), since
 	# the square bracket bytes happen to fall in the designated range.
-	test $(git diff --cached --name-only --diff-filter=A -z $against |
+	test $(git diff-index --cached --name-only --diff-filter=A -z $against |
 	  LC_ALL=C tr -d '[ -~]\0' | wc -c) != 0
 then
 	cat <<\EOF

base-commit: 61a22ddaf0626111193a17ac12f366bd6d167dff
-- 
gitgitgadget
