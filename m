From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 00/56] Convert parts of refs.c to struct object_id
Date: Mon, 25 May 2015 18:38:26 +0000
Message-ID: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:40:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxIK-0000kV-1U
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbbEYSkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:06 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50584 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751246AbbEYSkF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:05 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 91BC32808F;
	Mon, 25 May 2015 18:40:02 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269851>

This is a conversion of parts of refs.c to use struct object_id.

refs.c, and the for_each_ref series of functions explicitly, is the
source for many instances of object IDs in the codebase.  Therefore, it
makes sense to convert this series of functions to provide a basis for
further conversions.

Changes from v2:
* Adopt Michael Haggerty's patch series that uses an adapter function.
* Squash some of these patches together where it makes sense in order to
  reduce the quantity of patches.

This does only slightly more than my original series, just in a
different way, with a larger number of much smaller patches.  If the
quantity of patches is too large for people's tastes, I can do a v4
based off of v2 that has less of this problem.

Converting most of the for_each_ref series of functions all at once is
important to avoid confusing interface mismatches.  I intend to send
smaller patch series in the future to make reviewers' lives easier.

This passes the testsuite at each step and is based off of master.

Also available in branch oid-refs-adapter-squashed at:

  https://git.crustytoothpaste.net/git/bmc/git.git
  https://github.com/bk2204/git.git

Michael Haggerty (55):
  each_ref_fn: change to take an object_id parameter
  builtin/rev-parse: rewrite to take an object_id argument
  handle_one_ref(): rewrite to take an object_id argument
  register_ref(): rewrite to take an object_id argument
  append_ref(): rewrite to take an object_id argument
  add_pending_uninteresting_ref(): rewrite to take an object_id argument
  get_name(): rewrite to take an object_id argument
  builtin/fetch: rewrite to take an object_id argument
  grab_single_ref(): rewrite to take an object_id argument
  name_ref(): rewrite to take an object_id argument
  builtin/pack-objects: rewrite to take an object_id argument
  show_ref_cb(): rewrite to take an object_id argument
  builtin/reflog: rewrite ref functions to take an object_id argument
  add_branch_for_removal(): rewrite to take an object_id argument
  add_branch_for_removal(): don't set "util" field of string_list
    entries
  builtin/remote: rewrite functions to take object_id arguments
  show_reference(): rewrite to take an object_id argument
  append_matching_ref(): rewrite to take an object_id argument
  builtin/show-branch: rewrite functions to take object_id arguments
  append_one_rev(): rewrite to work with object_id
  builtin/show-branch: rewrite functions to work with object_id
  cmd_show_branch(): fix error message
  fsck: change functions to use object_id
  builtin/show-ref: rewrite to use object_id
  show_ref(): convert local variable peeled to object_id
  builtin/show-ref: rewrite to take an object_id argument
  append_similar_ref(): rewrite to take an object_id argument
  http-backend: rewrite to take an object_id argument
  show_head_ref(): convert local variable "unused" to object_id
  add_ref_decoration(): rewrite to take an object_id argument
  add_ref_decoration(): convert local variable original_sha1 to
    object_id
  string_list_add_one_ref(): rewrite to take an object_id argument
  add_one_ref(): rewrite to take an object_id argument
  remote: rewrite functions to take object_id arguments
  register_replace_ref(): rewrite to take an object_id argument
  handle_one_reflog(): rewrite to take an object_id argument
  add_info_ref(): rewrite to take an object_id argument
  handle_one_ref(): rewrite to take an object_id argument
  shallow: rewrite functions to take object_id arguments
  submodule: rewrite to take an object_id argument
  write_refs_to_temp_dir(): convert local variable sha1 to object_id
  write_one_ref(): rewrite to take an object_id argument
  find_symref(): rewrite to take an object_id argument
  find_symref(): convert local variable "unused" to object_id
  upload-pack: rewrite functions to take object_id arguments
  send_ref(): convert local variable "peeled" to object_id
  mark_complete(): rewrite to take an object_id argument
  clear_marks(): rewrite to take an object_id argument
  mark_complete_oid(): new function, taking an object_oid
  mark_complete(): remove unneeded arguments
  rev_list_insert_ref_oid(): new function, taking an object_oid
  rev_list_insert_ref(): remove unneeded arguments
  each_ref_fn_adapter(): remove adapter
  warn_if_dangling_symref(): convert local variable "junk" to object_id
  struct ref_lock: convert old_sha1 member to object_id

brian m. carlson (1):
  refs: convert struct ref_entry to use struct object_id

 Documentation/technical/api-ref-iteration.txt |   2 +-
 bisect.c                                      |   8 +-
 builtin/branch.c                              |   4 +-
 builtin/checkout.c                            |   4 +-
 builtin/describe.c                            |  12 +--
 builtin/fetch.c                               |  15 ++--
 builtin/for-each-ref.c                        |   5 +-
 builtin/fsck.c                                |  20 ++---
 builtin/name-rev.c                            |   6 +-
 builtin/pack-objects.c                        |  14 ++--
 builtin/receive-pack.c                        |   5 +-
 builtin/reflog.c                              |   9 ++-
 builtin/remote.c                              |  21 +++---
 builtin/replace.c                             |  16 ++--
 builtin/rev-parse.c                           |   8 +-
 builtin/show-branch.c                         |  73 ++++++++++--------
 builtin/show-ref.c                            |  28 +++----
 builtin/tag.c                                 |  18 ++---
 fetch-pack.c                                  |  29 +++++--
 help.c                                        |   2 +-
 http-backend.c                                |  18 ++---
 log-tree.c                                    |  12 +--
 notes.c                                       |   2 +-
 reachable.c                                   |   5 +-
 refs.c                                        | 104 +++++++++++++-------------
 refs.h                                        |   2 +-
 remote.c                                      |  13 ++--
 replace_object.c                              |   4 +-
 revision.c                                    |  11 ++-
 server-info.c                                 |   7 +-
 sha1_name.c                                   |   7 +-
 shallow.c                                     |  12 +--
 submodule.c                                   |   7 +-
 transport.c                                   |  14 ++--
 upload-pack.c                                 |  32 ++++----
 walker.c                                      |   6 +-
 36 files changed, 300 insertions(+), 255 deletions(-)

-- 
2.4.0
