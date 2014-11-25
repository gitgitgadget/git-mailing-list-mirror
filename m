From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 0/7] repack_without_refs(): convert to string_list
Date: Tue, 25 Nov 2014 09:02:28 +0100
Message-ID: <1416902555-10748-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 09:03:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtB5X-0001v2-QL
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 09:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbaKYICv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 03:02:51 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:62867 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751019AbaKYICu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2014 03:02:50 -0500
X-AuditID: 1207440e-f79d26d000001b6e-cb-547437a62561
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 99.BA.07022.6A734745; Tue, 25 Nov 2014 03:02:46 -0500 (EST)
Received: from michael.fritz.box (p5DDB361F.dip0.t-ipconnect.de [93.219.54.31])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAP82i0j027888
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 25 Nov 2014 03:02:45 -0500
X-Mailer: git-send-email 2.1.3
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqLvMvCTEYPptM4uuK91MFg29V5gt
	3t5cwmhxe8V8Zot/E2osNm9uZ3Fg8/j7/gOTx85Zd9k9Fmwq9bh4Sdnj8ya5ANYobpukxJKy
	4Mz0PH27BO6M+b29LAV/+Su2nVrL2MB4hKuLkZNDQsBEYv+8FlYIW0ziwr31bF2MXBxCApcZ
	JXZ9mQLlHGeSWHD0PBNIFZuArsSinmYwW0RATWJi2yEWkCJmgcOMEq93LmMHSQgLuErc6d/H
	AmKzCKhKzJnWCWbzCrhI3FxwG8jmAFonJ7F1nfcERu4FjAyrGOUSc0pzdXMTM3OKU5N1i5MT
	8/JSi3SN9XIzS/RSU0o3MUJChW8HY/t6mUOMAhyMSjy8DceKQ4RYE8uKK3MPMUpyMCmJ8ooY
	loQI8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuGNmgdUzpuSWFmVWpQPk5LmYFES51Vbou4nJJCe
	WJKanZpakFoEk5Xh4FCS4J1sBjRUsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhTq
	8cXAYAdJ8QDtLQJp5y0uSMwFikK0nmJUlBLnnQiSEABJZJTmwY2FJYBXjOJAXwrzTgCp4gEm
	D7juV0CDmYAGx80sBBlckoiQkmpg5Lht88It+dJ/gbkNwWeVl2/6KTUhZe9OVi+fvslhb9fP
	iq08ZBzkw8bxcw1v7wqmW/nn5jufZXL60N/wbMOqLbGiPk+mXXymvNk0566J5StHrd95xSnH
	k46yV9f6dnHmf3u0c6/KIT3mBX0fjvw6Gel94+tt3j/zF3fJzV/OUqxqpdqRvGPx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260201>

This is a re-roll of v1 [1] with the following changes:

* Fix some nits in the commit message and comment change in patch 4/7
  that were pointed out by Jonathan.

* Add a new patch 7/7 that renames sort_string_list() to
  string_list_sort() as suggested by Junio.

I would have submitted the name change as a separate patch, but since
this patch series uses the function the two series would have
conflicted. Since I didn't see any other patch series in-flight that
use sort_string_list(), I just renamed the function everywhere rather
than going to the trouble of deprecating the old function and adding
the new function.

Thanks to Junio, Jonathan, and Stefan for their reviews of v1.

[1] http://thread.gmane.org/gmane.comp.version-control.git/259831/focus=260030

Michael Haggerty (7):
  prune_remote(): exit early if there are no stale references
  prune_remote(): initialize both delete_refs lists in a single loop
  prune_remote(): sort delete_refs_list references en masse
  repack_without_refs(): make the refnames argument a string_list
  prune_remote(): rename local variable
  prune_remote(): iterate using for_each_string_list_item()
  Rename sort_string_list() to string_list_sort()

 Documentation/technical/api-string-list.txt |  4 +-
 builtin/apply.c                             |  2 +-
 builtin/receive-pack.c                      |  2 +-
 builtin/remote.c                            | 69 +++++++++++++----------------
 builtin/repack.c                            |  2 +-
 connect.c                                   |  2 +-
 notes.c                                     |  2 +-
 refs.c                                      | 38 ++++++++--------
 refs.h                                      | 10 ++++-
 remote.c                                    |  6 +--
 sha1_file.c                                 |  2 +-
 string-list.c                               |  4 +-
 string-list.h                               |  2 +-
 13 files changed, 75 insertions(+), 70 deletions(-)

-- 
2.1.3
