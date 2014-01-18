From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 00/17] Fix some mkdir/rmdir races
Date: Sat, 18 Jan 2014 23:48:44 +0100
Message-ID: <1390085341-2553-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 23:49:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4ehq-0004yT-Ox
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 23:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbaARWtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jan 2014 17:49:31 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58704 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751690AbaARWt3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jan 2014 17:49:29 -0500
X-AuditID: 1207440c-b7f566d000004272-6d-52db04f8b560
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id CF.BE.17010.8F40BD25; Sat, 18 Jan 2014 17:49:28 -0500 (EST)
Received: from michael.fritz.box (p4FDD4E9C.dip0.t-ipconnect.de [79.221.78.156])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s0IMnN8r030075
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jan 2014 17:49:27 -0500
X-Mailer: git-send-email 1.8.5.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsUixO6iqPuD5XaQwbE7ZhZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ0x8+VSpoKFfBUTX29mamC8
	zd3FyMkhIWAicenddxYIW0ziwr31bF2MXBxCApcZJdacucIKkhASOMEksX+nEYjNJqArsain
	mQnEFhFQk5jYdgismVnAQWLz50ZGEFsYaOjkB2+Zuxg5OFgEVCW+zPUBCfMKOEtMOzGRESQs
	IaAgsfq60ARG7gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdA31cjNL9FJTSjcxQvzOs4Px
	2zqZQ4wCHIxKPLwZDLeDhFgTy4orcw8xSnIwKYnyKjMBhfiS8lMqMxKLM+KLSnNSiw8xSnAw
	K4nwBm+4FSTEm5JYWZValA+TkuZgURLnVV2i7ickkJ5YkpqdmlqQWgSTleHgUJLgFQCGt5Bg
	UWp6akVaZk4JQpqJgxNEcIFs4AHaIAlSyFtckJhbnJkOUXSKUVFKnFceJCEAksgozYMbAIvQ
	V4ziQP8I895nBqriAUY3XPcroMFMQINFYm+CDC5JREhJNTC2btba+n4lm3e2Kud+xg+VD9f7
	J3m7ay1/YjGJe9bsBHnmCtfVv5qvXPV7IOfktDz5nuzWFy/fmbmHZMYaPu3Zsf/Z5rSbn+fU
	J4TZye3TzF6asd6QdXbCA/MWBw6rWb6+T2+o9N4rfdW/+pyz4i3vg9//JUey7j7dauq4s8LQ
	b8GqfrszEz8psRRnJBpqMRcVJwIA4AbITasCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240651>

Sorry, I forgot to send this re-roll to the mailing list.

This version differs only very slightly from v2:

* Rebased to the current master (there were no conflicts).

* Rename a couple of local variables from "attempts" to
  "attempts_remaining".

* Patches 13, 16, and 17 have slightly improved commit messages.

Michael Haggerty (17):
  safe_create_leading_directories(): fix format of "if" chaining
  safe_create_leading_directories(): reduce scope of local variable
  safe_create_leading_directories(): add explicit "slash" pointer
  safe_create_leading_directories(): rename local variable
  safe_create_leading_directories(): split on first of multiple slashes
  safe_create_leading_directories(): always restore slash at end of loop
  safe_create_leading_directories(): introduce enum for return values
  cmd_init_db(): when creating directories, handle errors conservatively
  safe_create_leading_directories(): add new error value SCLD_VANISHED
  lock_ref_sha1_basic(): on SCLD_VANISHED, retry
  lock_ref_sha1_basic(): if locking fails with ENOENT, retry
  remove_dir_recurse(): tighten condition for removing unreadable dir
  remove_dir_recurse(): handle disappearing files and directories
  rename_ref(): extract function rename_tmp_log()
  rename_tmp_log(): handle a possible mkdir/rmdir race
  rename_tmp_log(): limit the number of remote_empty_directories()
    attempts
  rename_tmp_log(): on SCLD_VANISHED, retry

 builtin/init-db.c |  9 +++---
 cache.h           | 25 +++++++++++++--
 dir.c             | 27 +++++++++++-----
 merge-recursive.c |  2 +-
 refs.c            | 92 ++++++++++++++++++++++++++++++++++++++++---------------
 sha1_file.c       | 67 ++++++++++++++++++++++------------------
 6 files changed, 155 insertions(+), 67 deletions(-)

-- 
1.8.5.2
