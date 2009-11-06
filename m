From: Jay Soffian <jaysoffian@gmail.com>
Subject: Bug in git remote prune?
Date: Thu, 5 Nov 2009 19:34:03 -0500
Message-ID: <76718490911051634w2d364b73m567e73039508c857@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 06 01:37:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6CmM-0003TS-9H
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 01:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759107AbZKFAd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 19:33:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759095AbZKFAd6
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 19:33:58 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:56505 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759083AbZKFAd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 19:33:58 -0500
Received: by iwn10 with SMTP id 10so486567iwn.4
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 16:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=3YYTSWuIUWfh1CwnvelG1BRpc7xOAFtZ31JlO38Ulwg=;
        b=DarfXCDp19dCYXT+sX0cP/6FE5NOwt7rVYzP3mlM239fmfypA+iMw6HpkDU1ybrsTe
         lVMT+MYfYP8LgChPimeCNjvtvy8ZSb/fLrmS0qrEQ6zJFWZKfQ2GIjW8QVv7DLfJJnCB
         B0MMkXUHMM5Pr2oNwX0lsZ+ty+mGsuhjNweR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=D/q8o47G9k7XEMzQV5uFrkcwDFdZni6QByPbxDiny4u/iBGSuPVEz0MkTZMKmfpshd
         E405luoE+xoEUYFwcSrcYbkaroIFzrtfMnzrj59JPK181mOLdUMVS+vu3gAhxFI1/sp+
         8hTCyKx0Crx6AWaQbUAZDmyHmpxcbGbr/zBlM=
Received: by 10.231.24.208 with SMTP id w16mr2995544ibb.38.1257467643108; Thu, 
	05 Nov 2009 16:34:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132260>

Let's say you've got the following tracking branches:

refs/remotes/origin/master
refs/remotes/origin/next
refs/remotes/origin/ghost

And origin has only "master" and "next" (ghost has been removed upstream).

Further, let's say you've got a refspec of:

[remote "origin"]
  fetch = +refs/heads/master:refs/remotes/origin/master

What should "git remote prune origin" do?

In my opinion, it should prune "next" and "ghost".  "ghost" is gone
from upstream, so that's obvious. I think "next" should also be pruned
because the refspec indicates the user is no longer interested in it.

Currently it doesn't do anything (it only considers "master" per the
refspec, which is still on origin, so it doesn't think there is
anything to prune).

Thoughts?

j.
