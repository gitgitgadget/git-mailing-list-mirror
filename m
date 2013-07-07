From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v2 0/2] allow git-svn fetching to work using serf
Date: Sat,  6 Jul 2013 20:39:55 -0700
Message-ID: <1373168397-7360-1-git-send-email-mackyle@gmail.com>
Cc: David Rothenberger <daveroth@acm.org>, Petr Baudis <pasky@ucw.cz>,
	Daniel Shahaf <danielsh@apache.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 05:40:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvfq2-0002xF-C8
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 05:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436Ab3GGDkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 23:40:06 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:56505 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295Ab3GGDkF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 23:40:05 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so3043729pde.37
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 20:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=U7JI5HVElPLB3aq/+u99NjDIrQeMTT3MQZ4HduN+xLo=;
        b=auo+UQD+nmV0Yfcb75fCdBZOMNRJeLZgi3pvxUXBSdgb3t1xuwT8AN8nuEO5P67zbu
         8QwY6jK8UySUga75FQujMSw/CafZ1FvHa7aUGUvquH+xuo8wkmgHZofIpzke8SHJrzYq
         cq+S1fnE+ICZtikawkMYhbcfM8noM+I4Qi0B3f2QrCLgfJgT6zPq9GZjRoVif03TGNND
         jfQH2nXXKi+STQFDfhqPMS5UglyUbiTlxc4MUSvpFxZ1XN4jIRyuF/RZNVQkfACa1nnd
         87RqMtrLLFaf9B8HtCpxNd+7fhGsyzLHyxzqFEWpuvqSVWTBPdKIfpJm5DQaSw4rfO+a
         GgSQ==
X-Received: by 10.66.218.39 with SMTP id pd7mr17393497pac.148.1373168404168;
        Sat, 06 Jul 2013 20:40:04 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id wg6sm15027459pbc.3.2013.07.06.20.40.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 20:40:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229720>

From: "Kyle J. McKay" <mackyle@gmail.com>

This patch allows git-svn to fetch successfully using the
serf library when given an https?: url to fetch from.

Unfortunately some svn servers do not seem to be configured
well for use with the serf library.  This can cause fetching
to take longer compared to the neon library or actually
cause timeouts during the fetch.  When timeouts occur
git-svn can be safely restarted to fetch more revisions.

A new temp_is_locked function has been added to Git.pm
to facilitate using the minimal number of temp files
possible when using serf.

The problem that occurs when running git-svn fetch using
the serf library is that the previously used temp file
is not always unlocked before the next temp file needs
to be used.

To work around this problem, a new temp name is used
if the temp name that would otherwise be chosen is
currently locked.

Kyle J. McKay (2):
  Git.pm: add new temp_is_locked function
  git-svn: allow git-svn fetching to work using serf

 perl/Git.pm             | 39 +++++++++++++++++++++++++++++++++------
 perl/Git/SVN/Fetcher.pm |  6 ++++--
 2 files changed, 37 insertions(+), 8 deletions(-)

-- 
1.8.3
