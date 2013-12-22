From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/5] Fix two mkdir/rmdir races
Date: Sun, 22 Dec 2013 08:14:06 +0100
Message-ID: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 22 08:22:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VudMM-0003VM-F6
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 08:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394Ab3LVHVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 02:21:38 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:52775 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752147Ab3LVHVi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Dec 2013 02:21:38 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Dec 2013 02:21:38 EST
X-AuditID: 1207440c-b7f566d000004272-88-52b6915b6b0d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 64.DE.17010.B5196B25; Sun, 22 Dec 2013 02:14:36 -0500 (EST)
Received: from michael.fritz.box (p57A25B75.dip0.t-ipconnect.de [87.162.91.117])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rBM7ERFK023935
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 22 Dec 2013 02:14:34 -0500
X-Mailer: git-send-email 1.8.5.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsUixO6iqBszcVuQwZUFLBZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ3RvkS04C9rRX/TFcYGxg8s
	XYycHBICJhKLt15jh7DFJC7cW8/WxcjFISRwmVFiyasJ7BDOCSaJOX17WEGq2AR0JRb1NDOB
	2CICahIT2w6BTWIWcJDY/LmREcQWFtCTOLXuNFg9i4CqxP/jF5lBbF4BF4lt8yBqJAQUJPZd
	Osk0gZF7ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdQ73czBK91JTSTYwQ3/PsYPy2TuYQ
	owAHoxIP7wGJbUFCrIllxZW5hxglOZiURHm5JwCF+JLyUyozEosz4otKc1KLDzFKcDArifCu
	cQXK8aYkVlalFuXDpKQ5WJTEeVWXqPsJCaQnlqRmp6YWpBbBZGU4OJQkeDtAhgoWpaanVqRl
	5pQgpJk4OEEEF8gGHqANC0EKeYsLEnOLM9Mhik4xKkqJ8/aAJARAEhmleXADYFH6ilEc6B9h
	3mUgVTzACIfrfgU0mAlosPHaTSCDSxIRUlINjOq7frox9NznyTd6+Vlia63x5pizLCsvRUZI
	pBowvvhhynBukod++OTOg+FXjoZ8efP497OdW2dGeQsmXvhzqfTvhfVnXO4vu9LNtdHYI8jv
	r9nZFrvs1JKtj5xPKdyf8bWVb9ra+IZPl521dq7wjhTp73h58/21qT2bL9Z/X329XbbrzHkP
	HmklluKMREMt5qLiRAA5ZRcTrQIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239638>

There seem to be a lot of mkdir/rmdir races in the Git code.  Fix two
of them.

It is hard to construct test cases for races without a lot of extra
test infrastructure.  So I have tested them as best I can using
instrumented code (not included here).

Michael Haggerty (5):
  safe_create_leading_directories(): modernize format of "if" chaining
  safe_create_leading_directories(): reduce scope of local variable
  safe_create_leading_directories(): add "slash" pointer
  safe_create_leading_directories(): fix a mkdir/rmdir race
  rename_ref(): fix a mkdir()/rmdir() race

 refs.c      | 10 +++++++++-
 sha1_file.c | 56 +++++++++++++++++++++++++++++++++-----------------------
 2 files changed, 42 insertions(+), 24 deletions(-)

-- 
1.8.5.1
