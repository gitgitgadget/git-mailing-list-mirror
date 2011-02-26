From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 0/2] Fix unnecessary updates of files during merge
Date: Sat, 26 Feb 2011 11:34:55 -0700
Message-ID: <1298745297-25713-1-git-send-email-newren@gmail.com>
References: <20110224115233.GA31356@sigill.intra.peff.net>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 26 19:35:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtOzB-0001Ny-CW
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 19:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319Ab1BZSfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 13:35:13 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45445 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070Ab1BZSfL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 13:35:11 -0500
Received: by yxs7 with SMTP id 7so1114909yxs.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 10:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=BnoY+PAwYXvn228eIPYBjvuu9g109iBCHALfqlLbT24=;
        b=epXc4TV9FJPpf/xcpE6RpZXro4A7srAzOA2M2CcePa6ERqZiKIYNnCJq+JiLUkGSir
         DabFdLrdVwR0OiYGgopiJDj6z/2yn0hDvSCnQeOJ9fo4jvpcER/qIa+SX3PkFYF/WiQ2
         kc7YsazR1RZ8sgm4KvJu4y1Hv6gSTwtdLgB8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=TUBKhQFC0bzQ4KoAZ5e+z5hWCpDdQYAw/xAHiSGegPOk39mSlixyLujFU2n5toOtW5
         Ie6fJwN8uB6wXCkW9A+x4f2BUpi2ZC/sY9mrqEt9fkBjH3YgCJ+dk7qIZ4vbcP1OqE6T
         RyaeOHTKTKa//aYEZk/nBvc4QPIfSU7hIu/oY=
Received: by 10.146.167.13 with SMTP id p13mr5285469yae.1.1298745310696;
        Sat, 26 Feb 2011 10:35:10 -0800 (PST)
Received: from Miney.hsd1.nm.comcast.net. (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id b11sm2491718ana.18.2011.02.26.10.35.08
        (version=SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 10:35:09 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.23.g4865dd
In-Reply-To: <20110224115233.GA31356@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167986>

This patch series adds a simple testcase demonstrating the problem
reported by Stephen Rothwell, and a fix.  Unfortunately, there's a bug
with the fix (hence the RFC) that makes the relevant files racily clean
rather than clearly clean (i.e. 'git diff-files' will report these files
as modified when it shouldn't).

I'll try to figure out how to fix the second problem in the next few
days.  If anyone has some hints, I'm all ears.

Elijah Newren (2):
  t6022: New test checking for unnecessary updates of renamed+modified
    files
  merge-recursive: When we detect we can skip an update, actually skip
    it

 merge-recursive.c       |    7 +++++--
 t/t6022-merge-rename.sh |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)

-- 
1.7.4.1.23.g4865dd
