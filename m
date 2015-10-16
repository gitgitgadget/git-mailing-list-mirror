From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] usage: do not insist that standard input must come from a file
Date: Fri, 16 Oct 2015 15:26:55 -0700
Message-ID: <xmqqh9lqcuvk.fsf@gitster.mtv.corp.google.com>
References: <xmqqvba6ekip.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 00:27:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnDSo-0003A4-Tv
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 00:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbbJPW06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 18:26:58 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34344 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbbJPW05 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 18:26:57 -0400
Received: by pabws5 with SMTP id ws5so1751964pab.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 15:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Y476r4U6GaW834WJj3MAOKvBjgaQGSEgh6oENkU7oos=;
        b=vHohovfwFymMBQl7zzKsMvjYWWZZSVru2v9nOU4NCZfazbPguoVTQQkM6mZrZ2lBpT
         VWJT4PPjLR1MJyxtcaEXpt6mLUkStiBwzRQ12zrc9vE87LWC9+0l9TheMnz5WOtffjkr
         qxXv4DcGRiUVWxuBKiA/XIv49JGASzPwATjQAK5dr0V8ZtJXMKM/pWAsMyfzXChPZKgN
         uSS6H74OCHOdq13KHIDNQZUxdu2OzPjI3rDYYsNHMRHuAwNzqp3HX4NB/3aD+jyyAIv/
         sQ+WTDLcmIXFDt373ObrbBhHKj2zLtCFJMmcPInkdDtBXXx5w14IUaMipcHIGY1R15w4
         tU5A==
X-Received: by 10.68.93.133 with SMTP id cu5mr19393654pbb.71.1445034416935;
        Fri, 16 Oct 2015 15:26:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:b1ee:7c8f:ac32:e39f])
        by smtp.gmail.com with ESMTPSA id dk2sm23034258pbd.57.2015.10.16.15.26.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 15:26:56 -0700 (PDT)
In-Reply-To: <xmqqvba6ekip.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 16 Oct 2015 11:27:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279775>

Here is what I prepared based on your review in an interdiff form.
A few points to note:

 * Stole the "fmt-merge-msg" example verbatim ;-)

 * The description of "show-ref --exclude" mode should be much
   clearer now.

Thanks.

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 07aacf2..aa3b2bf 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -28,7 +28,8 @@ OPTIONS
 	Consider `.gitattributes` in the index only, ignoring the working tree.
 
 --stdin::
-	Read pathnames from stdin instead of from the command-line.
+	Read pathnames from the standard input, one per line,
+	instead of from the command-line.
 
 -z::
 	The output format is modified to be machine-parseable.
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 149b166..59531ab 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -35,7 +35,8 @@ OPTIONS
 	for each given pathname.
 
 --stdin::
-	Read file names from stdin instead of from the command-line.
+	Read pathnames from the standard input, one per line,
+	instead of from the command-line.
 
 -z::
 	The output format is modified to be machine-parseable (see
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 9be6df3..6526b17 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -57,6 +57,18 @@ merge.summary::
 	Synonym to `merge.log`; this is deprecated and will be removed in
 	the future.
 
+EXAMPLE
+-------
+
+--
+$ git fetch origin master
+$ git fmt-merge-msg --log <$GIT_DIR/FETCH_HEAD
+--
+
+Print a log message describing a merge of the "master" branch from
+the "origin" remote.
+
+
 SEE ALSO
 --------
 linkgit:git-merge[1]
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
index 51804b0..ac44d85 100644
--- a/Documentation/git-get-tar-commit-id.txt
+++ b/Documentation/git-get-tar-commit-id.txt
@@ -15,10 +15,10 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Read an archive created by 'git archive' from the standard input and
-extracts the commit ID stored in it.  It reads only the first 1024
-bytes of input, thus its runtime is not influenced by the size of
-the archive very much.
+Read a tar archive created by 'git archive' from the standard input
+and extract the commit ID stored in it.  It reads only the first
+1024 bytes of input, thus its runtime is not influenced by the size
+of the tar archive very much.
 
 If no commit ID is found, 'git get-tar-commit-id' quietly exists with a
 return code of 1.  This can happen if the archive had not been created
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 45e5ece..814e744 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -35,7 +35,8 @@ OPTIONS
 	Read the object from standard input instead of from a file.
 
 --stdin-paths::
-	Read file names from stdin instead of from the command-line.
+	Read file names from the standard input, one per line, instead
+	of from the command-line.
 
 --path::
 	Hash object as it were located at the given path. The location of
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index f4cc202..fa6a756 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -20,8 +20,8 @@ The output is the new tag's <object> identifier.
 
 Tag Format
 ----------
-A tag signature file, to be fed from the standard input, has a
-very simple fixed format: four lines of
+A tag signature file, to be fed to this command's standard input,
+has a very simple fixed format: four lines of
 
   object <sha1>
   type <typename>
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 7816479..cf71fba 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Read a patch from the standard input, and compute the patch ID for it.
+Read a patch from the standard input and compute the patch ID for it.
 
 A "patch ID" is nothing but a sum of SHA-1 of the file diffs associated with a
 patch, with whitespace and line numbers ignored.  As such, it's "reasonably
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index b3e7488..a8a9509 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Read an idx file for packed Git archive created with
+Read the idx file for a Git packfile created with
 'git pack-objects' command from the standard input, and
 dump its contents.
 
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 2c08b08..7b74340 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -23,8 +23,9 @@ particular ref exists.
 
 By default, shows the tags, heads, and remote refs.
 
-The --exclude-existing form is a filter that does the inverse, it shows the
-refs from stdin that don't exist in the local repository.
+The --exclude-existing form is a filter that does the inverse.  It reads
+refs from stdin, one ref per line, and shows those that don't exist in
+the local repository.
 
 Use of this utility is encouraged in favor of directly accessing files under
 the `.git` directory.
