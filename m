Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E53FC47258
	for <git@archiver.kernel.org>; Tue,  5 May 2020 12:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A095206A4
	for <git@archiver.kernel.org>; Tue,  5 May 2020 12:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyOCIBI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgEEMEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 08:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728180AbgEEMEK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 08:04:10 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59357C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 05:04:10 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so799161pfc.0
        for <git@vger.kernel.org>; Tue, 05 May 2020 05:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:subject:message-id:mime-version;
        bh=OHBclLc8YXCwvIp10/3PhAOT8L2UY1ArwGX9o8xdm9s=;
        b=VyOCIBI11qO8JP/VN3Ad1Pcoh7BOdmMYfKuveProV3nCAxriDSIWKJ8Ita9rPU2s54
         B6kPuIWQp1sUsnoHbJOc7yr7CmaYoAgfP22J03INFkD0R/hz54LRXhb6+ZVFUqHW1rxy
         fP4Lcd6ojB/TTtW1dJt9VYzkbJEgpbYggGTeNkFcWRew8AHZxdjaXDwlarMRAuHk+NA2
         tz25JTQ62jgVIZqZ7dQTljhvVxqr+jHIyNqyO/3UQNFm2n9GShy8b2V9I4ITM9G0DCrF
         jmcYkurIszsxrWrFs/sbEJDr8FYFmw1z+yyWK9tZhlv/fxutmXPh+KosX6e7R+rNDIZp
         0Fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:subject:message-id
         :mime-version;
        bh=OHBclLc8YXCwvIp10/3PhAOT8L2UY1ArwGX9o8xdm9s=;
        b=tpePEeL5ldzYBpi0gcCkvgo3nlFZ0uL++O2+s86JefJnELwJo7ZjY9Dnmmu9FxaITl
         dwN4NFg8Ama5a3VO/jQSyFJgETsaDYsOqW4/KbVPTqgO/5RGoLvphY6mZ7NhJV/e3PnG
         oNMQInSG4MtTGtlsLe6dhbCsn9pIIbPh91h11+iL9tovy9VLMzHtzaHvEa1WadNLXyCZ
         A44hWX3lnQcQAOlKz0RuOuL7Vi+pby6ZiShVPMQK5CEXUyCSEy5U7eswFBapOYbZ1TXV
         k00tpgT5UbVV426TjjFMsayI5fiMUmfIYdK53w3Rwe08MPCMTag1irOC4wyCXgi4tsvn
         3p3Q==
X-Gm-Message-State: AGi0PuYUgg1yq7VlWNfKj5J2G/dZEhO2VdB0JKZ9pN1TUxXeGPGOrq+P
        Wi41G2VWPvsOlbVW46Dk6DG5jwbjGRcoyw==
X-Google-Smtp-Source: APiQypI9Pc+uoHoZq9zUkmdeRIIDM28Z0RgE1TLZPo94DWzQ1QIK/FKCH6rGZV3jQ3JnA0/p+3734A==
X-Received: by 2002:a62:7515:: with SMTP id q21mr2999406pfc.1.1588680249214;
        Tue, 05 May 2020 05:04:09 -0700 (PDT)
Received: from WINDOW-NB ([49.49.242.39])
        by smtp.gmail.com with ESMTPSA id t14sm1483912pgr.61.2020.05.05.05.04.07
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 05 May 2020 05:04:08 -0700 (PDT)
From:   Nutchanon Wetchasit <Nutchanon.Wetchasit@gmail.com>
X-Google-Original-From: Nutchanon Wetchasit <Nachanon.Vetjasit@gmail.com>
Date:   Tue, 5 May 2020 19:03:38 +0700
To:     git@vger.kernel.org
Subject: `git am` always fails applying patch from `git format-patch -U0`
Message-ID: <20200505190338.1155dcfd@WINDOW-NB>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/KnqMVcKshU.Wsu18ago881i"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--MP_/KnqMVcKshU.Wsu18ago881i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello folks,

I was rewriting a committed change in my repository via a workflow
of git-format-patch -> edit -> git-am.

The edit I wanted to make was just a one-line change in the diff,
with no line number shift, so I generated patches with no context line
(`git format-patch -U0`) to avoid subsequent patch failure
caused by context change.

But the problem was that `git-am` appeared to erroneously
reject such patches for an unclear reason...

After editing patches, hard-resetting the branch to the parent commit
of the chain; I fed the patches to `git am`, and encountered an error
that looked like this:

> Applying: Removing second line
> error: patch failed: text.txt:2
> error: text.txt: patch does not apply
> Patch failed at 0001 Removing second line
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".

The first thing I thought, was that I somehow messed up my patches
somewhere in the edit.

So I canceled the patching process with `git am --abort`,
hard-reset the branch again, and re-attempted running `git am`
with *unmodified* patches series;
and found that `git am` still produced the same error,
which ruled out the factor of my editing mistakes.
(Why would Git refuse a patch generated by itself?)

To be sure, I retried this on a dummy repository,
with only one non-modified zero-context patch;
and the error was still consistently reproducible.

I'm not sure what caused Git to reject such zero-context patches;
although some hints could be seen when running
`git apply --verbose` with the offending patch file.
(See step 9 in "Exact steps to reproduce" below)

GNU Patch would happily apply the same patch without any error though.

Nevertheless, this does not happen when the patch
was generated with 1 or more context lines.
So the workaround would be using `git format-patch -U1` instead,
with more risk of rejects on context change caused by editing.

-----

General steps to reproduce follows:

1. Make any disposable Git repository with two or more commits
   on `master` branch.

2. Generate a zero-context patch of the latest commit with
   `git format-patch -U0 HEAD^`

3. Remove the latest commit with `git reset --hard HEAD^`

4. Re-add the commit via the patch from step 2, with `git-am`;
   it would claim that the patch does not apply.

Compare and contrast: try the same, but change step 2 to
`git format-patch -U1` HEAD^`, and you would see that `git-am`
accept it normally.

-----

Exact steps to reproduce follows:

 1. Create an empty Git repository, with dummy user name and email:
    
    $ mkdir am-nocontext
    $ cd am-nocontext
    $ git init
    $ git config user.name "Joe Average"
    $ git config user.email "joe@example.com"
    
 2. Create a dummy 3-line text file, add it as the first commit:
    
    $ printf "One\nTwo\nThree\n" > text.txt
    $ git add text.txt
    $ git commit -m "Initial commit"
    
 3. Remove the second line from that file, make it a second commit:
    
    $ printf "2d\nwq\n" | ed text.txt
    $ git commit -am "Removing second line"
    
 4. Generate patch from the second commit, with *zero* context line:
    
    $ git format-patch -U0 HEAD^
    
 5. Back out the second commit:
    
    $ git reset --hard HEAD^
    
 6. Add back the second commit using the patch from step 4:
    
    $ git am 0001-Removing-second-line.patch
    Applying: Removing second line
    error: patch failed: text.txt:2
    error: text.txt: patch does not apply
    Patch failed at 0001 Removing second line
    hint: Use 'git am --show-current-patch=diff' to see the failed patch
    When you have resolved this problem, run "git am --continue".
    If you prefer to skip this patch, run "git am --skip" instead.
    To restore the original branch and stop patching, run "git am --abort".
    
    ^ You would find that Git reported that patching was failed,
      when it should not be.
    
 8. Cancel the patching process:
    
    $ git am --abort
    
 9. Try re-applying the same patch to the working tree using Git:
    
    $ git apply --verbose 0001-Removing-second-line.patch
    Checking patch text.txt...
    error: while searching for:
    Two
    
    error: patch failed: text.txt:2
    error: text.txt: patch does not apply
    
    ^ You would see that somehow Git tried to take the first line
      in the hunk as a context, even when it wasn't marked as such.
    
10. Apply the same patch using GNU diffutils' `patch` program:
    
    $ patch -p 1 -i 0001-Removing-second-line.patch
    patching file text.txt
    $ git diff
    diff --git a/text.txt b/text.txt
    index 4fcefbf..3146b8f 100644
    --- a/text.txt
    +++ b/text.txt
    @@ -1,3 +1,2 @@
     One
    -Two
     Three
    
    ^ You would find that GNU Patch would apply
      the same patch correctly.

The full terminal transcript is attached as
<attachment:reproducing.log>,
which also includes intermediate informational steps,
and also displays the exact patch content produced by the process.

-----

System information follows...

   Git: 2.26.2 (source)
 Patch: GNU diffutils 2.6.1 (Debian)
System: Debian GNU/Linux 7.0 Wheezy i386
Locale: th_TH (local encoding TIS-620)

Note that this problem appears to exist for long way down to at least
Git 1.7.10.4 (the original version I found this error), if not earlier.

Please advice in case I overlooked something.

Regards,
Nutchanon Wetchasit
--MP_/KnqMVcKshU.Wsu18ago881i
Content-Type: text/x-log
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=reproducing.log

$ cd /tmp
$ mkdir am-nocontext
$ cd am-nocontext
$ git init
Initialized empty Git repository in /tmp/am-nocontext/.git/
$ git config user.name "Joe Average"
$ git config user.email "joe@example.com"
$ printf "One\nTwo\nThree\n" > text.txt
$ cat text.txt
One
Two
Three
$ git add text.txt
$ git commit -m "Initial commit"
[master (root-commit) e2e0c16] Initial commit
 1 file changed, 3 insertions(+)
 create mode 100644 text.txt
$ git log --pretty=oneline
e2e0c16f6d31bc8e673494ecc92d1e8f377275aa (HEAD -> master) Initial commit
$ printf "2d\nwq\n" | ed text.txt
14
10
$ cat text.txt
One
Three
$ git diff
diff --git a/text.txt b/text.txt
index 4fcefbf..3146b8f 100644
--- a/text.txt
+++ b/text.txt
@@ -1,3 +1,2 @@
 One
-Two
 Three
$ git commit -am "Removing second line"
[master 27e6e8b] Removing second line
 1 file changed, 1 deletion(-)
$ git log --pretty=oneline
27e6e8bdc3ecbecc17f5ec1407f97f1977054461 (HEAD -> master) Removing second line
e2e0c16f6d31bc8e673494ecc92d1e8f377275aa Initial commit
$ git format-patch -U0 HEAD^
0001-Removing-second-line.patch
$ cat 0001-Removing-second-line.patch
From 27e6e8bdc3ecbecc17f5ec1407f97f1977054461 Mon Sep 17 00:00:00 2001
From: Joe Average <joe@example.com>
Date: Tue, 5 May 2020 18:17:52 +0700
Subject: [PATCH] Removing second line

---
 text.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/text.txt b/text.txt
index 4fcefbf..3146b8f 100644
--- a/text.txt
+++ b/text.txt
@@ -2 +1,0 @@ One
-Two
-- 
2.26.2

$ git reset --hard HEAD^
HEAD is now at e2e0c16 Initial commit
$ git log --pretty=oneline
e2e0c16f6d31bc8e673494ecc92d1e8f377275aa (HEAD -> master) Initial commit
$ git am 0001-Removing-second-line.patch
Applying: Removing second line
error: patch failed: text.txt:2
error: text.txt: patch does not apply
Patch failed at 0001 Removing second line
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
$ git am --abort
$ git diff
$ git log --pretty=oneline
e2e0c16f6d31bc8e673494ecc92d1e8f377275aa (HEAD -> master) Initial commit
$ git apply --verbose 0001-Removing-second-line.patch
Checking patch text.txt...
error: while searching for:
Two

error: patch failed: text.txt:2
error: text.txt: patch does not apply
$ git log --pretty=oneline
e2e0c16f6d31bc8e673494ecc92d1e8f377275aa (HEAD -> master) Initial commit
$ git diff
$ patch -p 1 -i 0001-Removing-second-line.patch
patching file text.txt
$ git diff
diff --git a/text.txt b/text.txt
index 4fcefbf..3146b8f 100644
--- a/text.txt
+++ b/text.txt
@@ -1,3 +1,2 @@
 One
-Two
 Three
$ exit

--MP_/KnqMVcKshU.Wsu18ago881i--
