From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH v3 0/2] update all per-worktree HEADs when renaming a branch
Date: Sun, 27 Mar 2016 23:37:12 +0900
Message-ID: <cover.1459087958.git.k@rhe.jp>
References: <1458553816-29091-1-git-send-email-k@rhe.jp>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Kazuki Yamaguchi <k@rhe.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 27 16:37:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akBp5-0002VE-E8
	for gcvg-git-2@plane.gmane.org; Sun, 27 Mar 2016 16:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbcC0Ohj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2016 10:37:39 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:57884 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbcC0Ohj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2016 10:37:39 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id D90F75B8BE;
	Sun, 27 Mar 2016 14:37:35 +0000 (UTC)
X-Mailer: git-send-email 2.8.0.rc4.21.g05df949
In-Reply-To: <1458553816-29091-1-git-send-email-k@rhe.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290009>

Changes from v2:
- The flags REF_COMMON_DIR and RESOLVE_REF_COMMON_DIR are removed.
- create_symref_common_dir() is removed and instead adds narrower
  purpose function, set_worktree_head_symref().

[1/2]
Adds a new function set_worktree_head_symref(). This takes git_dir as
the first argument, and updates {git_dir}/HEAD.

The new function uses hold_lock_file_for_update() directly, instead of
through lock_ref_sha1_basic() which the old [v2 3/5] used.

[2/2] (from [v2 4/5])
Uses the new set_worktree_head_symref(), and the
update_worktrees_head_symref() function was renamed to
replace_each_worktree_head_symref(), to avoid confusion with
set_worktree_head_symref() added by [1/2].


Thanks,

Kazuki Yamaguchi (2):
  refs: add a new function set_worktree_head_symref
  branch -m: update all per-worktree HEADs

 branch.c             | 23 +++++++++++++++++++++++
 branch.h             |  7 +++++++
 builtin/branch.c     |  3 +--
 refs.h               |  8 ++++++++
 refs/files-backend.c | 35 +++++++++++++++++++++++++++++++++++
 t/t3200-branch.sh    | 23 ++++++++++++++++++++++-
 6 files changed, 96 insertions(+), 3 deletions(-)

-- 
2.8.0.rc4.21.g05df949
