From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 0/8] Fix GIT_CEILING_DIRECTORIES that contain symlinks
Date: Sun, 28 Oct 2012 17:16:19 +0100
Message-ID: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 17:16:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSVXj-00032Y-N8
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 17:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752944Ab2J1QQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 12:16:44 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:49627 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752894Ab2J1QQn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2012 12:16:43 -0400
X-AuditID: 12074413-b7f786d0000008bb-d5-508d5a6aada8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id F4.A0.02235.A6A5D805; Sun, 28 Oct 2012 12:16:42 -0400 (EDT)
Received: from michael.fritz.box (p57A2465E.dip.t-dialin.net [87.162.70.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9SGGXJa002689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 28 Oct 2012 12:16:39 -0400
X-Mailer: git-send-email 1.8.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsUixO6iqJsV1RtgcOYZn0XXlW4mi4beK8wW
	T+beZbY4esrC4vaK+cwWP1p6mC3Wv7vK7MDu8ff9ByaPnbPusns8fNXF7vGsdw+jx8VLyh6f
	N8kFsEVx2yQllpQFZ6bn6dslcGccnXuHqWAtb8W3ta8YGxibOLsYOTkkBEwkjrw4yQxhi0lc
	uLeerYuRi0NI4DKjxOW/c5ggnDNMEi371zKCVLEJ6Eos6mlmArFFBGQlvh/eyAhSxCxwl1Fi
	0tGpbCAJYQFPiYWz/4A1sAioSvxZ9Y8dxOYVcJH4u+Y6O8Q6OYkPex6xT2DkXsDIsIpRLjGn
	NFc3NzEzpzg1Wbc4OTEvL7VI11wvN7NELzWldBMjJISEdzDuOil3iFGAg1GJh/dSQU+AEGti
	WXFl7iFGSQ4mJVFe5qDeACG+pPyUyozE4oz4otKc1OJDjBIczEoivEu5gXK8KYmVValF+TAp
	aQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQneqZFAjYJFqempFWmZOSUIaSYOThDBBbKB
	B2jDOpBC3uKCxNzizHSIolOMilLivMcigBICIImM0jy4AbBof8UoDvSPMO9GkHYeYKKA634F
	NJgJaLAOH9jgkkSElFQDY7vYBNOfSVG/LTw3nT58zmjet3kzRdTePnuXeVJM8LXz21AenS1R
	CiuKXGU21TroSVoe5T3JkpBfoMEvy/OkV9t9aq6g7WGZ+EMLFise1Nmg5HHu4KR7bR9Yti9k
	OL340pGAuQ97vov8flRQ0f362CTFC6Wbn30KiOSanmSz553/c6vfplf6lyuxFGck 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208550>

v4 of the series; see the cover letter for v3 [1] for more editorial
comments.

Changes since v3:

* For "test-path-utils longest_ancestor_length", normalize all of the
  paths using normalize_path_copy() to counteract the path mangling
  carried out by bash on Windows.  (Thanks to Johannes Sixt for his
  helpful advice.)

* Rebased onto a more recent master.

[1] http://thread.gmane.org/gmane.comp.version-control.git/208102

Michael Haggerty (8):
  Introduce new static function real_path_internal()
  real_path_internal(): add comment explaining use of cwd
  Introduce new function real_path_if_valid()
  longest_ancestor_length(): use string_list_split()
  longest_ancestor_length(): take a string_list argument for prefixes
  longest_ancestor_length(): require prefix list entries to be
    normalized
  setup_git_directory_gently_1(): resolve symlinks in ceiling paths
  string_list_longest_prefix(): remove function

 Documentation/technical/api-string-list.txt |   8 ---
 abspath.c                                   | 105 ++++++++++++++++++++++------
 cache.h                                     |   3 +-
 path.c                                      |  46 ++++++------
 setup.c                                     |  34 ++++++++-
 string-list.c                               |  20 ------
 string-list.h                               |   8 ---
 t/t0060-path-utils.sh                       |  41 ++++-------
 t/t0063-string-list.sh                      |  30 --------
 test-path-utils.c                           |  51 +++++++++++++-
 test-string-list.c                          |  20 ------
 11 files changed, 202 insertions(+), 164 deletions(-)

-- 
1.8.0
