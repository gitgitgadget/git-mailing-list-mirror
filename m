From: Siddique Hameed <siddii@gmail.com>
Subject: GIT cloning(or pull/push) doesn't work properly if you have a
 sub-folder as its own GIT repo
Date: Sat, 23 Apr 2011 12:04:40 -0500
Message-ID: <BANLkTi=YsEr9hOz7-u_t3BJUiMt+34P+ZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 19:05:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDgGY-0003U0-MC
	for gcvg-git-2@lo.gmane.org; Sat, 23 Apr 2011 19:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230Ab1DWRFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Apr 2011 13:05:01 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:60202 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab1DWRFA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2011 13:05:00 -0400
Received: by yia27 with SMTP id 27so343182yia.19
        for <git@vger.kernel.org>; Sat, 23 Apr 2011 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=jxYInTjjtP8hX9LtsNXveygJKH9ywywUaUmJ5WIFtio=;
        b=YLfTvPkb2qa2SA7X7+EWZsJIW9U56JCNtEHJCMBZp2kGrmGZQvyYWHBhre5RPLNBie
         RHW0EATc4cOfUbVBkTMc0SjIHSor4WS1gPpbL4hyPZ8X1jO1T/6VBHLpf6Z1OLxs8ozn
         2496BBszNma4Hb+zwpfl/6mOWvaRrRUPEg8BI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=FVQ/DeNUu9jgX/cdEvyHTFdeVDwTwD0s7knumWtl9xiRGd7SljQ1jWff99NrcJGEzM
         NCbl/+CgprsryblptcfNUwn0XlveNBcfYVOSPOUPHPfVWqwaRUF4/AIWrsajrwTo2wB5
         rOkHuMuGau0Bd7MP5nraTh2tTLJ3sTJERMEuw=
Received: by 10.91.189.11 with SMTP id r11mr2120637agp.174.1303578300205; Sat,
 23 Apr 2011 10:05:00 -0700 (PDT)
Received: by 10.90.113.17 with HTTP; Sat, 23 Apr 2011 10:04:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171984>

I don't want to categorize this as bug until I hear expert panel's
opinion. Spare me if its a known issue or if I am doing something
silly :) I did enough research online and couldn't find a good answer.

Here it goes..

Let's say if I have a folder called "ParentGITRepo" which is a local
GIT repo. I have sub folders called "Child1Repo" and "Child2" with
some files on it. For some reason, whether accidentally or
deliberately, I make "Child1Repo" a GIT repo on its own. GIT
recognizes ParentGITRepo & Child1Repo as separate GIT repositories.
But, if I clone "ParentGITRepo" into somewhere else, I am missing
everything from Child1Repo. The worse thing is, even if I cleanup
"Child1Repo" by removing it's .git folder, the parent GIT repo is
ignoring any activity I do in that folder.

I think, the right way to do this setup is probably using git sub
modules or something. But given this scenario, what is the expected
behaviour? Am i missing? It would really make more sense if you can go
thro the following steps (test cases) outlined below.


# Setting up ParentGITRepo & Child1Repo and Child2
$ cd ~
$ mkdir ParentGITRepo
$ cd ParentGITRepo/
$ git init .
$ mkdir Child1Repo
$ mkdir Child2
$ cd Child1Repo/
$ git init .
$ echo "Child1RepoFile" > Child1RepoFile.txt
$ git add .
$ git commit -a -m "Adding Child1Repo content"
[master (root-commit) 01ccc52] Adding Child1Repo content
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 Child1RepoFile.txt

$ cd ../Child2/
$ echo "Child2 file content" > Child2File.txt
$ cd ..
$ echo "Parentfile" > ParentFile.txt
$ git add .
$ git commit -a -m "Adding Parent content"
[master (root-commit) b31d0a5] Adding Parent content
 3 files changed, 3 insertions(+), 0 deletions(-)
 create mode 160000 Child1Repo
 create mode 100644 Child2/Child2File.txt
 create mode 100644 ParentFile.txt

---------------------------------------
 # Now verify ParentGITRepo & Child1Repo working independently
$ cd ~/ParentGITRepo/
$ git log
commit b31d0a5aef19c6b119d89718f560905ad0f34aa7
Author: Siddique Hameed <siddii+git@gmail.com>
Date:   Fri Apr 22 11:25:15 2011 -0500

   Adding Parent content

$ cd ~/ParentGITRepo/Child1Repo/
$ git log
commit 01ccc52931f8b40f6d92b29769300a254d8dd411
Author: Siddique Hameed <siddii+git@gmail.com>
Date:   Fri Apr 22 11:22:00 2011 -0500

   Adding Child1Repo content

--------------------------------------------

# Now try cloning ParentGITRepo & verify the contents inside it
$ cd ~
$ git clone ParentGITRepo/ ParentGITRepoClone/
Cloning into ParentGITRepoClone...
done.
$ cd ParentGITRepoClone/
$ ls -a
./  ../  .git/  Child1Repo/  Child2/  ParentFile.txt

$ cd Child1Repo/
$ ls -a
./  ../

$ git log
commit b31d0a5aef19c6b119d89718f560905ad0f34aa7
Author: Siddique Hameed <siddii+git@gmail.com>
Date:   Fri Apr 22 11:25:15 2011 -0500

   Adding Parent content

--------------------------------------------

As you can see there is nothing in Child1Repo after its was cloned. I
also tried the reverse of this. Like, having a child folder as GIT
repo and make a ParentFolder a repo on its own & clone the parent
folder and the cloned folder doesnt contain anything from child repo.

Let me know if you have more questions.

Thanks,

Siddique
