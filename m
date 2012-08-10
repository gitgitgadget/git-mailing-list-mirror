From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH/RFC] [git-subtree.sh] Use raw subject and body modifier "%B" instead of "%s%n%n%b" for commit
Date: Fri, 10 Aug 2012 09:15:57 +0800
Message-ID: <1344561358-2953-1-git-send-email-techlivezheng@gmail.com>
Cc: apenwarr@gmail.com, greened@obbligato.org,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 10 03:15:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szdp5-0004ON-O2
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 03:15:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315Ab2HJBP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 21:15:27 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40521 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440Ab2HJBP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 21:15:26 -0400
Received: by pbbrr13 with SMTP id rr13so1807450pbb.19
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 18:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=9e99wzwb1yHbvOktUkW44cbPwSlnmkr0xDkUTOGQtb4=;
        b=OxG/SE64d9hHwLqjsOvBFKNCrqsrlZA45lhDcmqt03URdc3KnJ0NLXBabxCQoMTwM/
         ga1feLMoLVXVWu6W7DhtguyGzB2LB1ccp5uOE3yNVRZZhom3XIKgjnInOl9haVzrBnvN
         5NquAXxGrZ4YJwRx9Z0NuY7ELWIfzQk67JbZJV2E+1JoZ2UjFrIVo9tMh/GkUUh7Ax5u
         SgC+/ouQvsyGFeWGa9ZI2Ku5dR9v9wlhKZvNjtmEDhFVFhgxtDxruvDEBytMD/w033Aq
         4rYlsEdQpbJeSEnG5WcFDXjwnRxzwx5+TEg8cdN18XeFP2H2bBR5zHEtC3wnpyA8uj7k
         15mw==
Received: by 10.68.189.104 with SMTP id gh8mr8070198pbc.152.1344561325709;
        Thu, 09 Aug 2012 18:15:25 -0700 (PDT)
Received: from home.techlive.me ([122.244.154.180])
        by mx.google.com with ESMTPS id gh9sm2187321pbc.20.2012.08.09.18.15.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Aug 2012 18:15:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203196>

I don't know if it is the right place to post this patch, I have sended
an email to the original author apenwarr and have no response. According
to <https://github.com/apenwarr/git-subtree/blob/master/THIS-REPO-IS-OBSOLETE>,
this is the place, but <https://github.com/git/git/blob/master/contrib/README> says
different, which is really confusing. Anyway, here I am.

Recently, I imported a foreign git project as a sub directory into a
main repo which I intend to maintain as primary.

Due to the project I imported has its own remote repo which hosted
on the github, I expected after a 'git-subtree.sh split' the newly
generated subtree branch would be exactly identical to the original
branch. Unfortunately, it is not. I have fixed the committer date
and make everything looks the same with the original branch, but
they just did not end up with same commit sha1 hash. Then, I used
`git cat-file -p` to view the raw output of the both commits and
found that the commit generate by git-subtree has a extra 'new-line'
character appended at the end of the subject which causes the problem.

I checked the source and found "%s%n%n%b" were used to generate the
commit message, this works the fine when a commit has a subject as
well as a body, but most of my commits only have a subject under
which condition a extra 'new-line' character is appended.

Instead, a raw subject and body message modifier '%B' should be used.

Though I think this patch should be applied by default, but the mistake
has been there for a long time, applying this patch may cause the patched
git-subtree generate a different branch for those whose subtree branch
has already been generated using the old git-subtree. Maybe this should
be explained in the help or man page, and add a condition check or a
compatible mode somehow.

Techlive Zheng (1):
  subtree.sh: Use raw subject and body modifier "%B" instead of "%s%n%n%b"

 contrib/subtree/git-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.7.11.4
