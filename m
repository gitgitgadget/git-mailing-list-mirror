From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 00/32] Lockfile correctness and refactoring
Date: Sat,  6 Sep 2014 09:50:14 +0200
Message-ID: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 06 09:58:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQAtE-0004Ps-6N
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 09:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbaIFH6W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Sep 2014 03:58:22 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:59865 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750724AbaIFH6V (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Sep 2014 03:58:21 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Sep 2014 03:58:21 EDT
X-AuditID: 1207440f-f79156d000006a5c-10-540abcf71f35
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 17.1B.27228.7FCBA045; Sat,  6 Sep 2014 03:51:19 -0400 (EDT)
Received: from michael.fritz.box (p5DDB3D26.dip0.t-ipconnect.de [93.219.61.38])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s867pFGx006967
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 6 Sep 2014 03:51:16 -0400
X-Mailer: git-send-email 2.1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsUixO6iqPt9D1eIwZcvghZdV7qZLBp6rzBb
	PJl7l9ni9or5zBY/WnqYLTo7vjI6sHn8ff+ByePhqy52j2e9exg9Ll5S9vi8Sc7j9rNtLAFs
	Udw2SYklZcGZ6Xn6dgncGctu7GIseKVYsW7eMaYGxjeSXYycHBICJhLzb25ihbDFJC7cW8/W
	xcjFISRwmVHi542NTBDOMSaJb1MfsIBUsQnoSizqaQZLiAi0MUrsurgZrJ1ZIEWi43k3I4gt
	LGAncWXmArAGFgFViePt38BsXgEXiUUn17FDrJOT2LD7PyNEXFDi5MwnQDUcQHPUJdbPE4IY
	KS/RvHU28wRGvllIqmYhVM1CUrWAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6JXm5miV5q
	SukmRkgY8+9g7Fovc4hRgINRiYe3wIErRIg1say4MvcQoyQHk5Iob95yoBBfUn5KZUZicUZ8
	UWlOavEhRgkOZiUR3o7JQDnelMTKqtSifJiUNAeLkjiv+hJ1PyGB9MSS1OzU1ILUIpisDAeH
	kgTvjd1AjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgyIsvBsYeSIoHaO9ZkHbe
	4oLEXKAoROspRl2OdZ3f+pmEWPLy81KlxHmZgGlHSACkKKM0D24FLGm9YhQH+liY9z7IKB5g
	woOb9ApoCRPQEvN0TpAlJYkIKakGxsBvi2/NcdtmNGXfSyl+YVElyd/TJGMTznrcm1UybX2a
	3ksbZp+4v+d+3F2t27n06osbjssYnrLrMX+p+nNfIvWFb7P9dafX91ayLVut3y3U 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256564>

Sorry for the long delay since v3. This version mostly cleans up a
couple more places where the lockfile object was left in an
ill-defined state. Thanks to Johannes Sixt and Torsten B=C3=B6gershause=
n
for their review of v3.

I believe that this series addresses all of the comments from v1 [1],
v2 [2], and v3 [3].

This series applies to the current "master". There is a trivial
conflict between these changes and "next", and a few not-too-serious
conflicts between these changes and Ronnie's reference-related series
in "pu". I've figured out how to resolve the conflicts locally. Is
there some form in which I can put the conflict resolution that would
help you?

Changes since v3:

* Rebase to the current master, including adjusting the patch series
  for 93dcaea2 (addition of reopen_lock_file()).

* Perform the internal consistency check right away in
  commit_lock_file(), rather than after possibly having closed the
  file.

* Improve the explanation of the rationale for marking lock_file
  fields volatile.

* Fix comments that still referred to lock_file::filename[0] even
  though it is now a strbuf.

* Change rollback_lock_file() to exit early if the lock is not active
  (rather than nesting the rest of the function in an "if" statement).

* Fix Johannes's email address in the trailers.

* Extract a function commit_lock_file_to(lk, filename) and delegate to
  it from commit_lock_file() and commit_locked_index() so that the
  latter gets the benefit of the improvements in this patch series.

[1] http://thread.gmane.org/gmane.comp.version-control.git/245609
[2] http://thread.gmane.org/gmane.comp.version-control.git/245801
[3] http://thread.gmane.org/gmane.comp.version-control.git/246222

Michael Haggerty (32):
  unable_to_lock_die(): rename function from unable_to_lock_index_die()
  api-lockfile: expand the documentation
  rollback_lock_file(): do not clear filename redundantly
  rollback_lock_file(): exit early if lock is not active
  rollback_lock_file(): set fd to -1
  lockfile: unlock file if lockfile permissions cannot be adjusted
  hold_lock_file_for_append(): release lock on errors
  lock_file(): always add lock_file object to lock_file_list
  lockfile.c: document the various states of lock_file objects
  cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
  delete_ref_loose(): don't muck around in the lock_file's filename
  prepare_index(): declare return value to be (const char *)
  write_packed_entry_fn(): convert cb_data into a (const int *)
  lock_file(): exit early if lockfile cannot be opened
  remove_lock_file(): call rollback_lock_file()
  commit_lock_file(): inline temporary variable
  commit_lock_file(): die() if called for unlocked lockfile object
  commit_lock_file(): if close fails, roll back
  commit_lock_file(): rollback lock file on failure to rename
  api-lockfile: document edge cases
  dump_marks(): remove a redundant call to rollback_lock_file()
  git_config_set_multivar_in_file(): avoid call to rollback_lock_file()
  lockfile: avoid transitory invalid states
  struct lock_file: declare some fields volatile
  try_merge_strategy(): remove redundant lock_file allocation
  try_merge_strategy(): use a statically-allocated lock_file object
  commit_lock_file(): use a strbuf to manage temporary space
  Change lock_file::filename into a strbuf
  resolve_symlink(): use a strbuf for internal scratch space
  resolve_symlink(): take a strbuf parameter
  trim_last_path_elm(): replace last_path_elm()
  Extract a function commit_lock_file_to()

 Documentation/technical/api-lockfile.txt |  67 +++++--
 builtin/commit.c                         |  16 +-
 builtin/merge.c                          |  15 +-
 builtin/reflog.c                         |   2 +-
 builtin/update-index.c                   |   2 +-
 cache.h                                  |  16 +-
 config.c                                 |  28 +--
 fast-import.c                            |   4 +-
 lockfile.c                               | 299 ++++++++++++++++++-----=
--------
 read-cache.c                             |  12 +-
 refs.c                                   |  29 +--
 shallow.c                                |   6 +-
 12 files changed, 296 insertions(+), 200 deletions(-)

--=20
2.1.0
