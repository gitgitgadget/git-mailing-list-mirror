From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 00/25] Extending the shelf-life of "git describe" output
Date: Tue,  3 Jul 2012 14:36:50 -0700
Message-ID: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:38:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAnP-0004qt-2h
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992Ab2GCVhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:37:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34756 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726Ab2GCVhR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:37:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B05C8618
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=3X04gTd7lJtTdCKG2YeZaJ/1Oqs
	=; b=db6Kc1D1owr00ppuoh6HraTVGa8CAxTKF8+aC0frFL/uKIcCPn6TUMWeAUY
	ufYahxZasWlymqmCVZEmT1yF/2/hwGQV94/LrVcu2uIXfZE9LXLZzW704CvYSE7T
	cLa3n0WQ5djTcp1u60JJisYYZG+3vfNmAp3BZmCOhOt0h9kk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=N5AIL90D/3G/fbxGBIhDQ9vbwFnRy
	MteqaZ1MxKCtDMokL91NONlWKJOGX3Cn/ZYFdfRUjOY71hGqDHQG+JHZypgPTv1E
	HHgCChsj9Qm6NbEuOGASUQv8q1l39ag1w9DmUeA7xyFRWkyOKVJ6JgGMCEaKfaQW
	zWJRct+LiSC/GY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3273C8617
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 999BC8616 for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:37:16 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
X-Pobox-Relay-ID: 4280E098-C557-11E1-BD48-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200947>

This is take 5.  The earlier rounds were $gmane/200165, 200387,
200506 and 200869.

Except that the typo advise function is now called
"maybe_die_on_misspelt_object_name()", per discussion with Matthieu,
the early part of the series up to "restructure disambiguation"
(Patch #9) is the same as before.

I thought the thinking behind the fix to a minor regression pointed
out by Peff deserves to be kept as a separate commit, so it appears
as such as Patch #10.

Patches #20-#24 are new.  The test script added in Patch #13 includes
the tests for these new features, all start as "expect-failure", and
these flip them to "expect-success" as they implement them.

The last one #25 adds a new option to rev-parse to let you enumerate
objects that would match if you give too short an abbreviation.  It
would independently help the issue in "blame" output that did not
attempt to make the commit object names unique, reported in
$gmane/200839.


Junio C Hamano (25):
  sha1_name.c: indentation fix
  sha1_name.c: hide get_sha1_with_context_1() ugliness
  sha1_name.c: get rid of get_sha1_with_mode_1()
  sha1_name.c: get rid of get_sha1_with_mode()
  sha1_name.c: clarify what "fake" is for in find_short_object_filename()
  sha1_name.c: rename "now" to "current"
  sha1_name.c: refactor find_short_packed_object()
  sha1_name.c: correct misnamed "canonical" and "res"
  sha1_name.c: restructure disambiguation of short names
  get_sha1(): fix error status regression
  sha1_name.c: allow get_short_sha1() to take other flags
  sha1_name.c: teach get_short_sha1() a commit-only option
  sha1_name.c: get_describe_name() by definition groks only commits
  sha1_name.c: get_sha1_1() takes lookup flags
  sha1_name.c: many short names can only be committish
  sha1_name.c: teach lookup context to get_sha1_with_context()
  sha1_name.c: introduce get_sha1_committish()
  revision.c: allow handle_revision_arg() to take other flags
  revision.c: the "log" family, except for "show", takes committish
  sha1_name.c: add support for disambiguating other types
  apply: --build-fake-ancestor expects blobs
  commit-tree: the command wants a tree and commits
  reset: the command takes committish
  rev-parse: A and B in "rev-parse A..B" refer to committish
  rev-parse --disambiguate=<prefix>

 Documentation/git-rev-parse.txt     |   6 +
 builtin/apply.c                     |   2 +-
 builtin/cat-file.c                  |   2 +-
 builtin/commit-tree.c               |   8 +-
 builtin/log.c                       |   3 +
 builtin/pack-objects.c              |   2 +-
 builtin/reset.c                     |  10 +-
 builtin/rev-parse.c                 |  14 +-
 cache.h                             |  28 +-
 commit.c                            |   2 +-
 revision.c                          |  38 +--
 revision.h                          |   5 +-
 setup.c                             |   8 +-
 sha1_name.c                         | 494 ++++++++++++++++++++++++++----------
 t/t1512-rev-parse-disambiguation.sh | 263 +++++++++++++++++++
 15 files changed, 713 insertions(+), 172 deletions(-)
 create mode 100755 t/t1512-rev-parse-disambiguation.sh

-- 
1.7.11.1.229.g706c98f
