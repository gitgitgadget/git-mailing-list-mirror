From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: config core.autocrlf changes the index
Date: Wed, 17 Oct 2012 20:30:35 +0200
Message-ID: <CAB9Jk9DPLjRDino0A4LotEXC6BSNAjftEUtPQb2bo1TKXPAd+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 20:30:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOYOF-0000ij-WA
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 20:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397Ab2JQSah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2012 14:30:37 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35856 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247Ab2JQSag (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 14:30:36 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so7412747pad.19
        for <git@vger.kernel.org>; Wed, 17 Oct 2012 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=7GnEPSB4JTWhTRTmob4SsOWf1TyFOURDF9R2oNkBpsg=;
        b=fVL6r5tzRactKQznuobGPAlEcsdDeX5g/CGkKFqzitZj1G0h6sh4H6m5bJD0cfQHxc
         6rs3zi2ON70lr04iD0uxoKQYBsxNqaSYe1OQWPF4ahQhUAqIAMcjsoTDh92NmPciiNu6
         tQLGOjDttXuU9RImenFn0DCI10pF5IiP/Wwbpj3ImqdzIkblxZIYJzosC4ApZCWPjYuJ
         eiJW3p0xD5ZWWFY/gZbweNCx+IOzVX0HxzST2lSHBfvERcHtgWCjPzSKYDcbYbL4sRRE
         0xaIYL0Z3iIdWjToKQ2j94Vbs7wn46+D79XCA71rtioXONnbWlPPm3tAA3v47fjUgnIT
         BRyw==
Received: by 10.68.212.6 with SMTP id ng6mr16895268pbc.57.1350498635595; Wed,
 17 Oct 2012 11:30:35 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Wed, 17 Oct 2012 11:30:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207934>

Hello,

git config config core.autocrlf changes the index file, apparently
making obsolete its contents
when a repository is cloned.
Run the following script:

# create a bare repository, empty
rm -rf rel.git
mkdir rel.git
cd rel.git
git init --bare
git config core.autocrlf false
cd -

# populate the bare repository
rm -rf temp
git clone rel.git temp
cd temp
echo aaa>f1
git add f1
git commit -m A
git push origin master
cd -
rm -rf temp

# clone then the bare repository
rm -rf int
mkdir int
git clone rel.git int
cd int
git status
git ls-files -s --debug
# (1)
# change then core.autocrlf in the config
git config core.autocrlf false
git status
git ls-files -s --debug
# (2)
cd -

At (1), git status reports "nothing to commit", but at (2) it reports:

 On branch master
 Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git checkout -- <file>..." to discard changes in working directory)

       modified:   f1

no changes added to commit (use "git add" and/or "git commit -a")

The two git ls-files -s --debug commands report also differences in the index.

This seems rather strange, although one can think that changing
core.autocrlf might imply that the files in the workspace might have
no longer the same contents that they had should they have benn
checked out with the new core.autocrlf.
Be as it is, at least this unexpected effect of changing core.autocrlf
should be documented.

-Angelo Borsotti
