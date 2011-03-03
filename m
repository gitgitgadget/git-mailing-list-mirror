From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 0/3] Fix unnecessary (mtime) updates of files during merge
Date: Wed,  2 Mar 2011 23:13:09 -0700
Message-ID: <1299132792-17497-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 03 07:13:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv1mo-0003e5-To
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 07:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051Ab1CCGNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 01:13:14 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37884 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab1CCGNN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 01:13:13 -0500
Received: by qwd7 with SMTP id 7so617671qwd.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 22:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=tUpnpJmBIJg2Cde3DzOcsRa1T95hpws7ifUPaZFD/j4=;
        b=EwdJ9VlRPXqGg5r7sICfJ6OUcMcm3ENcDjesrMC+Z6qnN4TdaldLC0VbxRLdykD8//
         pqlqf/M7QXGPRTSwaNkP7F+Thse81Vjuc6+9ji3U7xmjZ4apnTotgSgj7MJRHWBUpgdU
         D3zMGpviJ8CqPUjfgvm0JAkF67vMAvxha88YI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Dn17kFtgqhrtuNtyuGy2pU99mVkmdSj04xyr34VQILKq1as2lvDIPm+cIAMUqjvPUH
         h19YqNcui/WlljqhNW39aNzyTO5YnnwxQ7yEaeYiv6y0kInLxYfvNT5HALo+goKMfWRK
         WqyoopzKJpRP0dMnK2DBKb6s6w0cQiillsBl0=
Received: by 10.224.205.132 with SMTP id fq4mr635907qab.297.1299132792163;
        Wed, 02 Mar 2011 22:13:12 -0800 (PST)
Received: from Miney.hsd1.nm.comcast.net. (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id s32sm402361qco.38.2011.03.02.22.13.09
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Mar 2011 22:13:10 -0800 (PST)
X-Mailer: git-send-email 1.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168375>

This patch series fixes a bug reported by Stephen Rothwell -- that
during merges git would unnecessarily update modification times of
files.  As noted by both Jeff and Junio, it's a bit of a band-aid
since it doesn't dive into fixing make_room_for_path() and
make_room_for_directories_of_df_conflicts(), but that would be a
much bigger and more invasive change.

Changes since last version:
  * Portability fixes for the tests suggested by Hannes (thanks!)
  * Additional test cleanups suggested by Jeff
  * Jeff's acks have been added

Elijah Newren (3):
  t6022: New test checking for unnecessary updates of renamed+modified files
  t6022: New test checking for unnecessary updates of files in D/F conflicts
  merge-recursive: When we detect we can skip an update, actually skip it

 merge-recursive.c       |   17 ++++++++----
 t/t6022-merge-rename.sh |   65 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 6 deletions(-)

-- 
1.7.4
