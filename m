From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 0/9] stash: modifiy handling of stash-like references
Date: Sun,  8 Aug 2010 14:46:02 +1000
Message-ID: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, ams@toroid.org, nanako3@bluebottle.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 06:47:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhxnJ-0007jr-Oc
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 06:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774Ab0HHErT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 00:47:19 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37021 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab0HHErS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 00:47:18 -0400
Received: by pxi14 with SMTP id 14so3342990pxi.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 21:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=QbikBVyGuc5ul+8nBBgpsghRXGpIS2s81CMte2oRIkA=;
        b=XzO4XtTHuiXbHk6d8qTUpZopkVM0QjFFywhw5Y8+iFgi7fcnUKXhYVNeKbeFcDsRCp
         QYKzUWyZ3Y8thCo5r6rZFP8izVOuW8595n0N1Xa1IVZgauEigMQxpcW/B7rD1QtvdRhp
         lnUyArrRCh4jMQMRpZCapQ810MERkd/51Ma/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bB/9uyMrYewQHkBVNLrkGsT4mWGf5NZYRjEh+J0osQV1YIcQ2DWleX86dkyDWoHXFN
         qoPBMO6UMDVVZLDCjvZ5HepRPfmworitCj4TxyUFSJNFAHD7Z8VplymDLwQk82Dsrh+N
         ZPNZ96oRqTgoRvktv0eDV+2TCn1vqJ9I1m09A=
Received: by 10.142.144.16 with SMTP id r16mr12364981wfd.91.1281242838002;
        Sat, 07 Aug 2010 21:47:18 -0700 (PDT)
Received: from localhost.localdomain ([120.16.216.92])
        by mx.google.com with ESMTPS id n2sm4295884wfl.13.2010.08.07.21.47.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 21:47:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.47.gc532
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152884>

This series teaches git stash branch and git stash show to be more tolerant of 
stash-like references that are not actually stash entry references, while 
teaching git stash pop and git stash drop to be less tolerant of stash-like 
references that are not actually stash entry references.

Junio: I did not adopt your suggestion to make git stash drop more tolerant
of invalid stash references since failing early might help a user
to spot an incorrect assumption about the state of their working tree
and stash stack - silently handling this case might hide such an incorrect
assumption. However, if you would prefer git stash drop to behave that
way, I'll rework the series accordingly.

The first 4 commits refactor the existing code without significantly 
changing existing behaviour.

The next 4 commits modify existing behaviour to be more (or less) tolerant 
of stash-like references, as required.

The last 2 commits update the tests and documentation to reflect the modified behaviour.

Jon Seymour (9):
  stash: refactor - create pop_stash function
  stash: extract stash-like check into its own function
  stash: introduce is_stash_ref and assert_stash_ref functions.
  stash: teach git stash pop to fail early if the argument is not a
    stash ref
  stash: teach git stash drop to fail early if the specified revision
    is not a stash reference
  stash: teach git stash branch to tolerate stash-like arguments
  stash: teach git stash show to always tolerate stash-like arguments.
  t3903-stash.sh: tests of git stash with stash-like arguments
  Documentation: git stash branch now tolerates non-stash references.

 Documentation/git-stash.txt |    4 +-
 git-stash.sh                |   92 +++++++++++++++++++++++++++++++------------
 t/t3903-stash.sh            |   81 +++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+), 28 deletions(-)

-- 
1.7.2.1.51.g82c0c0
