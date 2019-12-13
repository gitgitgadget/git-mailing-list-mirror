Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F417DC79DC5
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337B3247D5
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9ymE1pJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfLMRK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:10:26 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38003 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbfLMRK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:10:26 -0500
Received: by mail-qv1-f65.google.com with SMTP id t5so39567qvs.5
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 09:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8nMaV+BXYs+T0+uqGioxtg9ZuKbFUDXb26r6uN6uLWs=;
        b=j9ymE1pJs4H8H52H4eN32X4z9Y7PBEmtbjkrNqMvC54vBSuPxowE7MDlUo2D0fHsdD
         dj19x6n+840iRU5jwcV3TOD0WUfGdz2pkkPug/A8znPDJOQzvoI9OnjbBXme5v4DNgKN
         gNdMYrAWDc+e7mivH8qmyiylXgjtMcvbeiWk62MkxojNL8Rg8mODTBBujJL85X+6vN8Q
         uM5exoY2mVkfmgkx0rpjXMnbvyfpbCl4ZpY8uUmZySTV3w9+NA0o83QuuLezqmvI8e0c
         nkmIC8VhwUfdRJfyUM/+B7ZTNOHldWJBmLfGy+xr/TixG5BkOSAPFN56w4gqk+Y91SDp
         ChlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8nMaV+BXYs+T0+uqGioxtg9ZuKbFUDXb26r6uN6uLWs=;
        b=OeCuTS/PrQsWKY7lGme4jniDHnwH5tn4ouTWjZZ7y7qMbNCa8ituIP0QRhcbnjZ9IK
         /S5O44SO78yMnhX2S765tMgpHfEhiMs4IP3BmDwNLdnEXrwohzv9onHnKy5xbHW9pju0
         gizrjhQttHwEVBAPkXNrylRqe2qd6DuWTwYtcqs8ftuNqpNVNnjb1zzLx+XxQvjc8o7B
         GvzXZWV/+sYKoY63hc+piNPtoFtw8I6GpLcjOqia+ZmfUbzFOLreEUcse0DXgXnQUSEa
         xnhgsG+vQicjGVlz8uzo4wkxpHJzMLs6qlmu6APoh41Z0guoftkGhO9EnxExu97LTQeH
         a44Q==
X-Gm-Message-State: APjAAAWCddltvK6cDn7LfBEr9siM/XS6My0bBBe++8yI3gT3j8S/CSLi
        /AihFjhgndhBG3KZyws2Ici4q6oGL74=
X-Google-Smtp-Source: APXvYqxBj2UFy2I1Aj595s7lDyN9PbwXTD+mCQjH6F3g2ZyPalm0jBmOwU2gmyVycs8nUUsMBPgq5Q==
X-Received: by 2002:a05:6214:2b4:: with SMTP id m20mr14537540qvv.48.1576257024509;
        Fri, 13 Dec 2019 09:10:24 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id s20sm2956489qkg.131.2019.12.13.09.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 09:10:23 -0800 (PST)
Subject: Re: [PATCH 00/13] git-p4: python3 compatibility
To:     Yang Zhao <yang.zhao@skyboxlabs.com>
Cc:     git@vger.kernel.org
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
 <20191207010938.GA75094@generichostname>
 <CABvFv3+viMXJO0z5HAQbCya7MU9tWd7P_LxUhu66T74XGN99yA@mail.gmail.com>
 <b21d153a-02f9-b9a1-7388-59b5a882d4f2@gmail.com>
 <CABvFv3Jf9i06OmBqOC2zfS+7Sm88PRYa19_rB8rELtMoN2E8CQ@mail.gmail.com>
 <afa761cf-9c0e-cdcc-9c32-be88c5507042@gmail.com>
 <CABvFv3LAPPib-Lz+2MQvyZdq2qrmFTxN-Ya9ACnGg32d3tO9Rg@mail.gmail.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <27d379c4-bc84-8219-ac0d-0b84fbdc0ff0@gmail.com>
Date:   Fri, 13 Dec 2019 12:10:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CABvFv3LAPPib-Lz+2MQvyZdq2qrmFTxN-Ya9ACnGg32d3tO9Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a patch I have on my tree that I would offer -
it removes references to basestring and should be a drop in patch.


 From 1cc3c0f8570adb1ef2bacc0009aac979a3263d70 Mon Sep 17 00:00:00 2001
From: Ben Keene <seraphire@gmail.com>
Date: Tue, 3 Dec 2019 16:36:26 -0500
Subject: [PATCH] git-p4: change the expansion test from basestring to list

Python 3 handles strings differently than Python 2.7. Since Python 2
is reaching it's end of life, a series of changes are being submitted to
enable python 3.5 and following support. The current code fails basic
tests under python 3.5.

Some codepaths can represent a command line the program
internally prepares to execute either as a single string
(i.e. each token properly quoted, concatenated with $IFS) or
as a list of argv[] elements, and there are 9 places where
we say "if X is isinstance(_, basestring), then do this
thing to handle X as a command line in a single string; if
not, X is a command line in a list form".

This does not work well with Python 3, as there is no
basestring (everything is Unicode now), and even with Python
2, it was not an ideal way to tell the two cases apart,
because an internally formed command line could have been in
a single Unicode string.

Flip the check to say "if X is not a list, then handle X as
a command line in a single string; otherwise treat it as a
command line in a list form".

This will get rid of references to 'basestring', to migrate
the code ready for Python 3.

Thanks-to: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ben Keene <seraphire@gmail.com>
---
  git-p4.py | 18 +++++++++---------
  1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 25d8012e23..d322ae20ef 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -98,7 +98,7 @@ def p4_build_cmd(cmd):
          # Provide a way to not pass this option by setting 
git-p4.retries to 0
          real_cmd += ["-r", str(retries)]

-    if isinstance(cmd,basestring):
+    if not isinstance(cmd, list):
          real_cmd = ' '.join(real_cmd) + ' ' + cmd
      else:
          real_cmd += cmd
@@ -192,7 +192,7 @@ def write_pipe(c, stdin):
      if verbose:
          sys.stderr.write('Writing pipe: %s\n' % str(c))

-    expand = isinstance(c,basestring)
+    expand = not isinstance(c, list)
      p = subprocess.Popen(c, stdin=subprocess.PIPE, shell=expand)
      pipe = p.stdin
      val = pipe.write(stdin)
@@ -214,7 +214,7 @@ def read_pipe_full(c):
      if verbose:
          sys.stderr.write('Reading pipe: %s\n' % str(c))

-    expand = isinstance(c,basestring)
+    expand = not isinstance(c, list)
      p = subprocess.Popen(c, stdout=subprocess.PIPE, 
stderr=subprocess.PIPE, shell=expand)
      (out, err) = p.communicate()
      return (p.returncode, out, decode_text_stream(err))
@@ -254,7 +254,7 @@ def read_pipe_lines(c):
      if verbose:
          sys.stderr.write('Reading pipe: %s\n' % str(c))

-    expand = isinstance(c, basestring)
+    expand = not isinstance(c, list)
      p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
      pipe = p.stdout
      val = [decode_text_stream(line) for line in pipe.readlines()]
@@ -297,7 +297,7 @@ def p4_has_move_command():
      return True

  def system(cmd, ignore_error=False):
-    expand = isinstance(cmd,basestring)
+    expand = not isinstance(cmd, list)
      if verbose:
          sys.stderr.write("executing %s\n" % str(cmd))
      retcode = subprocess.call(cmd, shell=expand)
@@ -309,7 +309,7 @@ def system(cmd, ignore_error=False):
  def p4_system(cmd):
      """Specifically invoke p4 as the system command. """
      real_cmd = p4_build_cmd(cmd)
-    expand = isinstance(real_cmd, basestring)
+    expand = not isinstance(real_cmd, list)
      retcode = subprocess.call(real_cmd, shell=expand)
      if retcode:
          raise CalledProcessError(retcode, real_cmd)
@@ -547,7 +547,7 @@ def getP4OpenedType(file):
  # Return the set of all p4 labels
  def getP4Labels(depotPaths):
      labels = set()
-    if isinstance(depotPaths,basestring):
+    if not isinstance(depotPaths, list):
          depotPaths = [depotPaths]

      for l in p4CmdList(["labels"] + ["%s..." % p for p in depotPaths]):
@@ -633,7 +633,7 @@ def isModeExecChanged(src_mode, dst_mode):
  def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
          errors_as_exceptions=False):

-    if isinstance(cmd,basestring):
+    if not isinstance(cmd, list):
          cmd = "-G " + cmd
          expand = True
      else:
@@ -650,7 +650,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', 
cb=None, skip_info=False,
      stdin_file = None
      if stdin is not None:
          stdin_file = tempfile.TemporaryFile(prefix='p4-stdin', 
mode=stdin_mode)
-        if isinstance(stdin,basestring):
+        if not isinstance(stdin, list):
              stdin_file.write(stdin)
          else:
              for i in stdin:
-- 
2.24.1.windows.2


