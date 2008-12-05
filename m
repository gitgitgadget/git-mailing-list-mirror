From: "kanagesh radhakrishnan" <rkanagesh@gmail.com>
Subject: Using repo to work with multiple GIT repositories
Date: Fri, 5 Dec 2008 16:50:24 +0530
Message-ID: <ece1079f0812050320n7191097sbc1c10c353b23708@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 12:21:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8Ykk-0006nO-Ak
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 12:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbYLELU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 06:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbYLELU3
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 06:20:29 -0500
Received: from rn-out-0910.google.com ([64.233.170.190]:64601 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbYLELU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 06:20:27 -0500
Received: by rn-out-0910.google.com with SMTP id k40so3913024rnd.17
        for <git@vger.kernel.org>; Fri, 05 Dec 2008 03:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=miF3gOGqrhO1PZ7OtrXQqYL+ZTMWBh19O/2pYuGhRko=;
        b=unBe2dVKz+CQfbdhJcbFp/mGKhvpzDppnMWDapcFeCC+lvDm91lAJ1RwqH1yyzjEmp
         4LKd3c313jxVDWGdkmpfPc3CKaSUtymMLb1J8GHneIlD38lOjIiaMLYJl13xyYO7UOXW
         xyksB30bl0V7V7hMDtyasT492U/1W8W51/9lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=o7HkmnxlZxdvvVmo//PIfMzQZ1E0uI6gR8oB8m6A2JFNUzlkQQYqw/sAPitlETfiRP
         y9UHA+3KW0AL7DeCcYWLVd3zUJzh37n6ESllQlDX21+33bYcnG8ENd+7PMXgrOaHMIdA
         Sg8L1gvzVDZSrvM0+v0fQy9HSEGSrEjDz8e6k=
Received: by 10.142.14.20 with SMTP id 20mr6367672wfn.79.1228476024869;
        Fri, 05 Dec 2008 03:20:24 -0800 (PST)
Received: by 10.143.98.7 with HTTP; Fri, 5 Dec 2008 03:20:24 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102399>

Hello All,

My work currently resides in four different source trees, namely:

   * bootloaders   (git://192.168.10.1/bootloaders)
   * kernel           (git://192.168.10.1/kernel)
   * applications  (git://192.168.10.1/apps)
   * build             (git://192.168.10.1/build)

I maintain them as four different git repositories.  They are hosted
on a local server enabling any other developer to be able to clone
from one of the trees, make changes, commit locally and then push to
the git server.

I was browsing through the Android source code and found that they
have a similar situation where code is maintained in a large number of
independent GIT repositories.  The tool 'repo' is being used to
initialize and sync each tree.

I have been trying to bring in this approach to maintain my work too.
I have had success to some extent :-) I have created a manifest.git
and repo.git in my local server.  The default.xml file being
maintained in manifest.git has a list of the GIT repositories being
hosted by my local GIT server.

In order to clone the four GIT trees from the server, I do the following:

   $ repo init -u git://192.168.10.1/manifest.git
   $ repo sync

This clones from the four source trees maintained in the GIT server.

I am able to make changes locally in each tree and commit them.
However, when I attempt to push the commits to the main repository on
the GIT server, it always says that 'everything is up to date'

   $ git push user@192.168.10.1:/home/git/applications
   user@192.168.10.1's password:
   Everything up-to-date

Further, when I try to pull in any recent updates with the git-pull
command, I get the following error:

   $ git-pull
   fatal: 'origin': unable to chdir or not a git archive
   fatal: The remote end hung up unexpectedly

I know pushing to the repository on the GIT server works since I am
able to push local commits when I have cloned the working copy
manually (instead of using repo init and repo sync).
-----------------------------------------------------------------
   $ git-clone git://192.168.10.1/applications
   Initialized empty Git repository in /home/user/work/applications/.git/
   remote: Counting objects: 6857, done.
   remote: Compressing objects: 100% (3805/3805), done.
   remote: Total 6857 (delta 2943), reused 6853 (delta 2941)
   Receiving objects: 100% (6857/6857), 9.51 MiB | 10547 KiB/s, done.
   Resolving deltas: 100% (2943/2943), done.
   $

   <edit, make changes, save, commit changes locally>

   $ git-commit -a -m "Changed rule to build with custom tools"
   Created commit bd55a06: Changed rule to build with custom tools
   1 files changed, 1 insertions(+), 1 deletions(-)
   $

   <push changes to repository on GIT server>
   $ git-push user@192.168.10.1:/home/git/applications
   user@192.168.10.1's password:
   Counting objects: 8, done.
   Compressing objects: 100% (6/6), done.
   Writing objects: 100% (6/6), 611 bytes, done.
   Total 6 (delta 4), reused 0 (delta 0)
   To user@192.168.10.1:/home/git/applications
   dce4bea..bd55a06  master -> master
   $
-----------------------------------------------------------------

May I know what I have to look at to solve this problem?  Has anyone
faced a similar problem?  Any pointers would be of help.

Thanks in advance.

Regards,
Kanagesh
