From: Adrian Cornish <git@bluedreamer.com>
Subject: Stop a git commit by a specific author using pre-commit hook
Date: Thu, 8 Mar 2012 18:15:37 -0700
Message-ID: <CAGc=MuCQoQ711uXnB8J80RqsY+pqbaeCOXHjy0-mjq7a_ESdyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 09 02:22:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5oWu-0001fH-J5
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 02:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087Ab2CIBV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 20:21:56 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:52634 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab2CIBVz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 20:21:55 -0500
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Mar 2012 20:21:54 EST
Received: by wibhj6 with SMTP id hj6so36252wib.1
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 17:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=tkcOeSBpALmcW1x+PTf6+0iGPHeAdh187rKcCe+Auc4=;
        b=Rg8Ub/x6Dd34kV1GlEnCoGTFkFE78a2/c0UHlxQMXrdkrLyuEgsif5iCUYsS1IeavN
         1JEr2NHEKpcIdMhyXPLtjlswtI4RHMMKH3QtwCS/kLH5JmoCqYbFS1GZjCswdw3kXz7N
         aMX6kXfEa/walC7shq+x0ak9a/kfJOkBK5+kFkiRgkwHbJuhNB0Vw4RfE9VD5dPU8S2I
         BjoPyncDILe7Ex32xPrvnoh5+GQbFf3I9Ymw5o2PrtdktckIaIp52dAz2EuCq76jMdla
         HIQkV8p604p3UWo2dDWQ0qa6wxnRbp/kxwh7KsN+p25EqLzN3Igul3dQwyGEFBJFrSJ1
         6IXA==
Received: by 10.216.135.69 with SMTP id t47mr167308wei.85.1331255738026; Thu,
 08 Mar 2012 17:15:38 -0800 (PST)
Received: by 10.216.178.8 with HTTP; Thu, 8 Mar 2012 17:15:37 -0800 (PST)
X-Google-Sender-Auth: wH2rJ_ORScgojnA2S8FHd3BW73A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192669>

Hi All,

My plan is to use git to keep track of changes in /etc but when
committing I want to have the person making the change specify
themselves as author by adding the --author option on the commandline.

So I would like to stop accidental commits as root.

I tried creating this pre-commit hook but it is not working - git var
is still returning root even if I specify the author on commit line.

TIA
Adrian

AUTHOR=`git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/\1/p'`
if [ "$AUTHOR" == "root <root@localhost>" ];
then
   echo "Please commit under your own user name instead of \"$AUTHOR\":"
   echo 'git commit --author="Adrian"'
   echo "or if your name is not already in logs use full ident"
   echo 'git commit --author="Adrian Cornish <a@localhost>"'
   exit 1
fi
exit 0
