From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Suggestion: add author info to TODO list in git-rebase--interactive
Date: Fri, 5 Jun 2015 15:00:17 -0400
Message-ID: <CANoM8SWX+UVWdV-Aeqqn8DuMf74zUWx=rbEaz3ctNDwa_ZZbeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 21:00:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0wrD-0007Ny-Nm
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 21:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbbFETAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 15:00:39 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:35014 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbbFETAi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 15:00:38 -0400
Received: by obbgp2 with SMTP id gp2so38717934obb.2
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 12:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=ljmfUT+vbMks/GPbz7rFHqf2Mxd9xgRS9jK/8Twypp4=;
        b=vhylcNgmif7lK+iVIzeZyjETob+IOq1i6okehMI7lAZO/30dF2fqu/Zj0I6x+OKjGT
         t+KDtcZGrC0zvxLlYY+dfxCAMUCb9ROBHTpvxlLqqmFrHL6Prh8LbyDcwFFf/Fi0OpXP
         WReosptPshQ9HvlmntrzLbhA/62IjeImxQQxuI/KuOkclD5VfNjB494KTDHrE6Xk3Vsg
         CvonMae+svf0qJTCiCPHVuTuUW+uWe6aSIqCLD3dx/1Y0mhyDvuGm/oTukw41WBWgXSx
         nfn5FLX76mCWjLIMSX3K7DpJt0EDuwnXVjXV5KTsRtefxsI3LJu61sSCBD4gHAUHwfBI
         TDpw==
X-Received: by 10.182.213.227 with SMTP id nv3mr4204552obc.10.1433530837955;
 Fri, 05 Jun 2015 12:00:37 -0700 (PDT)
Received: by 10.202.204.20 with HTTP; Fri, 5 Jun 2015 12:00:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270872>

I find that If I am doing a rebase with the intention to squash or
re-order commits, it is helpful to know the commit author.

However, the alteration that I have made to git-rebase--interactive
may not be entirely correct.  Here is the change:

---
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index dc3133f..ec44d41 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -977,7 +977,7 @@ else
        revisions=$onto...$orig_head
        shortrevisions=$shorthead
 fi
-git rev-list $merges_option --pretty=oneline --reverse --left-right
--topo-order \
+git rev-list $merges_option --pretty="%m%h [%an] %x09%s" --reverse
--left-right --topo-order \
        $revisions ${restrict_revision+^$restrict_revision} | \
        sed -n "s/^>//p" |
 while read -r sha1 rest
--
2.4.2


The problem, as I see it is that the original '--pretty=oneline' only
produces a single line of output (of course).  However, the changed
version '--pretty="%m%h [%an] %x09%s"' produces multiple lines.  The
command seems to ignore the unimportant lines, and the expected output
is put into the TODO list though.

Is there a better way of providing this information, or is this still
acceptable?

_Mike
