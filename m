From: Peter MacMillan <peterm@metavera.com>
Subject: stage/commit issue when checking out a branch
Date: Tue, 12 May 2009 12:01:14 -0400
Message-ID: <d96d20670905120901qa4c0353xc50160f880e17a21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 18:01:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3uQ5-0007sg-EG
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470AbZELQBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 12:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754731AbZELQBO
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:01:14 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:54938 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbZELQBN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:01:13 -0400
Received: by rv-out-0506.google.com with SMTP id f9so44224rvb.1
        for <git@vger.kernel.org>; Tue, 12 May 2009 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=M2xq+kzQEsxlrM64Wv2WPq4hdzElbYNzv3T5TME1cv4=;
        b=QiYtibAZCaI7SVYrVUgR7wqzKUVIZGRmauVQ39gO9xuqd1s94fBsiQlL6AL4zWfZ7L
         OtuH/idy+6L1QOHsPjcb50HtugkI+XVbITK7b2eIrwwbQ+n5V5xR0lb2mCvZdqaxoG10
         7NBMFbIQsLwZQzVYb/d+N/yfrGeDA3rNHH98k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=AqHvxBT17QAvqVAhOiqgyPtqB3cnshtswfouB81BWJYQqpVxqNethwdEvepvdoCf0f
         qDRSYEz1lhTU4YN2f5sm1Mlj0vD6Vhp1KfidcXN/v0594AqFx8C8dlCSMNfZdTdcQYRv
         NxBy/6EbC7cMDBU6YKcRSyTd89Zrf/g3YT+F0=
Received: by 10.142.135.16 with SMTP id i16mr3501090wfd.335.1242144074572; 
	Tue, 12 May 2009 09:01:14 -0700 (PDT)
X-Google-Sender-Auth: e0ce56b42b544eb9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I've run into a problem where staging changes, checking out a
different branch, and then commiting results in an empty commit.

Here is a simplified reproduction of the problem:

currently using 1.6.3, verified that it works correctly in git version 1.6.1.3.

New repo:

$ mkdir bug
$ cd bug
$ git init
Initialized empty Git repository in /home/peterm/bug/.git/

New file:

$ echo "Hello" > FILE
$ git add FILE
$ git commit -m "V1"
[master (root-commit) 5aeea22] V1
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 FILE

Simple change:

$ echo "Hello, world." > FILE
$ git add FILE

Move to a different branch:

$ git checkout -b branch
M	FILE
Switched to a new branch 'branch'
$ git status
# On branch branch
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   FILE
#

Oh, still on the stage. Great. Commit!

$ git commit -m "V2"
[branch 818175e] V2
$ git show HEAD
commit 818175efc55d2e23871541c5caa2fe771c825b73
Author: Peter MacMillan <peterm@metavera.com>
Date:   Tue May 12 11:38:02 2009 -0400

    V2
$ git status
# On branch branch
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   FILE
#

Guh? A few of us at the office have hit this and it used to work. The
only way to commit the stage is to reset to HEAD, re-add and then
commit.

Thanks for your help,

Peter MacMillan <peterm@metavera.com>

Application Developer, Metavera Solutions Inc.
502-2221 Yonge Street, Toronto, ON, M4S 2B4
416-598-9300 x 27
