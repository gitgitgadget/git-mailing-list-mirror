From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/9] Fix GIT_CEILING_DIRECTORIES that contain symlinks
Date: Sat, 29 Sep 2012 08:15:53 +0200
Message-ID: <1348899362-4057-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 08:16:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THqLg-0002L7-Qr
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 08:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555Ab2I2GQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 02:16:15 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:62395 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752587Ab2I2GQO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2012 02:16:14 -0400
X-AuditID: 12074413-b7f786d0000008bb-e8-5066922d22e3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id C9.49.02235.D2296605; Sat, 29 Sep 2012 02:16:13 -0400 (EDT)
Received: from michael.fritz.box (p57A246BE.dip.t-dialin.net [87.162.70.190])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8T6G73v026219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 29 Sep 2012 02:16:12 -0400
X-Mailer: git-send-email 1.7.11.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsUixO6iqKs7KS3AYPJTbYuuK91MFg29V5gt
	jp6ysLi9Yj6zxfp3V5kdWD3+vv/A5LFz1l12j4uXlD0+b5ILYInitklKLCkLzkzP07dL4M7Y
	0f+dqeAxV8Wdtw4NjFc4uhg5OSQETCSevzjPDmGLSVy4t56ti5GLQ0jgMqPEw2Or2CGcs0wS
	M24+ZgOpYhPQlVjU08wEYosIqElMbDvEAlLELDCJUaJnwwOgDg4OYQFPie8/U0FqWARUJb6e
	+MQMYvMKOEvceXmIFWKbosSP72uYJzByL2BkWMUol5hTmqubm5iZU5yarFucnJiXl1qka66X
	m1mil5pSuokREhbCOxh3nZQ7xCjAwajEw6t9PDVAiDWxrLgy9xCjJAeTkihvzsS0ACG+pPyU
	yozE4oz4otKc1OJDjBIczEoivBnFQOW8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWp
	RTBZGQ4OJQleQ5ChgkWp6akVaZk5JQhpJg5OEMEFsoEHaEMNSCFvcUFibnFmOkTRKUZFKXHe
	RJCEAEgiozQPbgAsgl8xigP9I8wbCFLFA4x+uO5XQIOZgAYv3ZQEMrgkESEl1cDop/eP65/G
	JiONmw6HbPVVJ4lIeujET318ZV/wa0a+xu/rDJdGsIffmGfgKpIZwB+5lEct5VVCcPiv0H+v
	xGa8U71wSvS70fpNtxe6O+W2eaypP1DwvLazdM8sj3VnXL62TuFUcV+ZoFC46vCeV4r9xS7f
	Fr10av+uoRT2qL9De9Gm/ULpFzuVWIozEg21mIuKEwF1hhHUuwIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206633>

v2 of the series, with the following changes from v1:

Patch 2/9 is new.

Patch 4/9: remove an unnecessary memcpy().  (This change doesn't
affect the tip of the branch because the memcpy() was removed anyway
in the second-to-last patch.)

Patch 8/9: remove a superfluous "len++", and improve the excuses in
the commit message for removing the tests of
longest_ancestor_length().

Thanks to Junio for his helpful comments.

Michael Haggerty (9):
  Introduce new static function real_path_internal()
  real_path_internal(): add comment explaining use of cwd
  Introduce new function real_path_if_valid()
  longest_ancestor_length(): use string_list_split()
  longest_ancestor_length(): explicitly filter list before loop
  longest_ancestor_length(): always add a slash to the end of prefixes
  longest_ancestor_length(): use string_list_longest_prefix()
  longest_ancestor_length(): resolve symlinks before comparing paths
  t1504: stop resolving symlinks in GIT_CEILING_DIRECTORIES

 abspath.c               | 105 ++++++++++++++++++++++++++++++++++++++----------
 cache.h                 |   1 +
 path.c                  |  54 +++++++++++++++----------
 t/t0060-path-utils.sh   |  64 -----------------------------
 t/t1504-ceiling-dirs.sh |  67 +++++++++++++++---------------
 5 files changed, 151 insertions(+), 140 deletions(-)

-- 
1.7.11.3
