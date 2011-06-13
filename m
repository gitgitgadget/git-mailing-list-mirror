From: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
Subject: [PATCH] Preserve ORIG_HEAD if already up-to-date with remote.
Date: Mon, 13 Jun 2011 13:05:24 +0530
Message-ID: <1307950525-8011-1-git-send-email-kunal.gangakhedkar@gmail.com>
Cc: git@vger.kernel.org,
	Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 13 09:35:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW1gT-0001hq-H4
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 09:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081Ab1FMHfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 03:35:37 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56691 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab1FMHfg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 03:35:36 -0400
Received: by pzk9 with SMTP id 9so2012148pzk.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 00:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=Nr+Q/NBMheOw29JvP+ckrnAMXBRU6oqTdxpYj24+5VY=;
        b=txDdcRFPxpv2q9ba60hunZZ9vtsAw2Ln4o3zy9PGajgNtD5O2qxvVr99kvOfnR8tnY
         yxGYOW5rK2279AK7SrLqd+jfBh0VgmH65MkOqSwZsVbbwGFQpLM/eOslyrtwbmhHqKi7
         tkLOpWKS+2k/xFBa42zqchZQTkzSjUmqVcUzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QAZCfvoP5vuLmMpLt/PpfNHEw1o4hyqyzFicL3u8mbzXzu1AkdHjvq8CrBfmHFDiA7
         mOik3zTEAObqT29SECcIQj+PQNe6tOYI3k5k7krE22GrGoTMOQF74C5/cghmuJFyJoIJ
         9R/SnNuhZV8DfO6pO+FFaLetfinbK+k3MDmQk=
Received: by 10.68.24.102 with SMTP id t6mr1844171pbf.503.1307950535270;
        Mon, 13 Jun 2011 00:35:35 -0700 (PDT)
Received: from plutonium.lan ([122.169.26.91])
        by mx.google.com with ESMTPS id m9sm4439235pbd.55.2011.06.13.00.35.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Jun 2011 00:35:34 -0700 (PDT)
Received: by plutonium.lan (Postfix, from userid 1000)
	id 4E5F5B852D; Mon, 13 Jun 2011 13:05:28 +0530 (IST)
X-Mailer: git-send-email 1.7.6.rc1.2.g20c4a.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175689>

By default, the ORIG_HEAD ref is moved to point to HEAD during a merge.
If there are no changes (i.e. if the local is in sync with remote), it
becomes difficult to see the last set of changes as the range of commits
is lost.

This is especially true when the pull is performed via a cronjob or a
script.

Following this mail is a patch that tries to address the problem 
by not updating the ORIG_HEAD ref when it detects an empty merge
(i.e. local is in sync with the remote).
That way, one can still do diffstat/log between ORIG_HEAD..HEAD.

It's still possible to revert to old behavior with:
o. --force-update-orig-head cmd line option
o. merge.forceupdateorighead config option

Please review the patch and let me know if:
a) it makes sense to have this functionality
b) if the patch looks OK

Please let me know if there are any changes required.
I'll write the test cases and send them in another mail later.

Thanks,
Kunal

Kunal Gangakhedkar (1):
  merge: Preserve ORIG_HEAD if already up-to-date with remote.

 builtin/merge.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

-- 
1.7.6.rc1.2.g20c4a.dirty
