From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: erratic behavior commit --allow-empty
Date: Tue, 2 Oct 2012 09:51:56 +0200
Message-ID: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 09:52:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIxGx-0002D6-SY
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 09:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab2JBHv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 03:51:58 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:50812 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab2JBHv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 03:51:57 -0400
Received: by vbbff1 with SMTP id ff1so6270974vbb.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 00:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=VXh10pKnWqj/J88lkbhDxtw5Qqx7cL64OM5jgKnN0SM=;
        b=vHu6KA9CNLXbWUPm1Y+kUiP8rR3sZFSF0iu3VkSSLlhAkNXyN3yaiBF0NyW3z5eLkm
         JOykdis2yXBn2FImuuDETz8AK6Gzzojou4GN9XQmnsYJmbQlxpYK67M18Cb+T7iqhQ1N
         huwcoXJLjKBNdGuVssWq3Y7hrN5nW+XOd5XdL5cHIbcJPCn0MvPn+yYYiXJQp20yZWvU
         +Mxumu6M3VmqYrr9xolxcvOn6i5DhzjoIU4oGfKqu52QEEgxjt+6G0IK9qEIwKK9bLNO
         EyIhFVpH5QtNalwUtyZ6A2xLmqqDSqFK9cUvgeC4NIsEfxl5VtN+8XcARiGTEeSGc1v2
         VKPA==
Received: by 10.58.94.44 with SMTP id cz12mr10139080veb.34.1349164316685; Tue,
 02 Oct 2012 00:51:56 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Tue, 2 Oct 2012 00:51:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206788>

Hi

I have noticed an erratic behavior of git commit --allow-empty: sometimes
it creates a new commit, but sometimes not.
I have executed two times the following script, emptycommit:

#!/bin/bash
set -x
rm -rf local
mkdir local
cd local
git init
echo "aaa" >f1
git add f1
git commit -m A
git checkout --orphan feature
git commit -m A --allow-empty
git rev-list --all --pretty=oneline

This is the log of the first execution:

$ emptycommit
+ rm -rf local
+ mkdir local
+ cd local
+ git init
Initialized empty Git repository in d:/gtest/local/.git/
+ echo aaa
+ git add f1
warning: LF will be replaced by CRLF in f1.
The file will have its original line endings in your working directory.
+ git commit -m A
[master (root-commit) 07e7d37] A
warning: LF will be replaced by CRLF in f1.
The file will have its original line endings in your working directory.
 1 file changed, 1 insertion(+)
 create mode 100644 f1
+ git checkout --orphan feature
Switched to a new branch 'feature'
+ git commit -m A --allow-empty
[feature (root-commit) 2297c4e] A
warning: LF will be replaced by CRLF in f1.
The file will have its original line endings in your working directory.
 1 file changed, 1 insertion(+)
 create mode 100644 f1
+ git rev-list --all --pretty=oneline
2297c4e34ec27f3cdeca8c0dcdcd61b4a079f411 A
07e7d379c2339ed375ed4903f6196d627367b7bf A

>>>>> note that git commit -m A --allow-empty creates a commit

This is the log of the second execution:

$ emptycommit
+ rm -rf local
+ mkdir local
+ cd local
+ git init
Initialized empty Git repository in d:/gtest/local/.git/
+ echo aaa
+ git add f1
warning: LF will be replaced by CRLF in f1.
The file will have its original line endings in your working directory.
+ git commit -m A
[master (root-commit) 1b86218] A
warning: LF will be replaced by CRLF in f1.
The file will have its original line endings in your working directory.
 1 file changed, 1 insertion(+)
 create mode 100644 f1
+ git checkout --orphan feature
Switched to a new branch 'feature'
+ git commit -m A --allow-empty
[feature (root-commit) 1b86218] A
warning: LF will be replaced by CRLF in f1.
The file will have its original line endings in your working directory.
 1 file changed, 1 insertion(+)
 create mode 100644 f1
+ git rev-list --all --pretty=oneline
1b8621851f6ae2943347da655661e9d5dc978208 A

>>>>> note that git commit -m A --allow-empty DOES NOT create a commit

The script has been run on Windows 7 with git version 1.7.11.msysgit.1

-Angelo
