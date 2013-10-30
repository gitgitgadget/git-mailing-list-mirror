From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/23] Change semantics of "fetch --tags"
Date: Wed, 30 Oct 2013 06:32:49 +0100
Message-ID: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:33:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOPg-0005jn-5X
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145Ab3J3Fdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:33:47 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:60289 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750768Ab3J3Fdq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:33:46 -0400
X-AuditID: 1207440f-b7f306d000006d99-95-52709a3a5165
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 97.FF.28057.A3A90725; Wed, 30 Oct 2013 01:33:46 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIB014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:33:42 -0400
X-Mailer: git-send-email 1.8.4.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsUixO6iqGs1qyDI4OJrJovpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE74+ueP4wFJ2QrTj6+x9TAuFSsi5GTQ0LARGLNmg5mCFtM4sK99WxdjFwcQgKXGSWurzjN
	CuFcYZKYsesjC0gVm4CuxKKeZiYQW0RATWJi2yEWkCJmgYnMEsenLwIrEhawkej5c5cdxGYR
	UJXYNLUTbAWvgIvE6vk7mCDWKUjcaJ7KOoGRewEjwypGucSc0lzd3MTMnOLUZN3i5MS8vNQi
	XRO93MwSvdSU0k2MkEDk38HYtV7mEKMAB6MSD6/Bg/wgIdbEsuLK3EOMkhxMSqK8aVMKgoT4
	kvJTKjMSizPii0pzUosPMUpwMCuJ8E4/DlTOm5JYWZValA+TkuZgURLnVV+i7ickkJ5Ykpqd
	mlqQWgSTleHgUJLgVZ4JNFSwKDU9tSItM6cEIc3EwQkiuEA28ABt4AEp5C0uSMwtzkyHKDrF
	qCglzqsAkhAASWSU5sENgKWMV4ziQP8IQ7TzANMNXPcroMFMQIP3sOSBDC5JREhJNTCGz8kV
	O76erVE0uczBOol95hWlepky06mLP/4Sj279+mrHmttpO7bECe6cvEF7RqR7oJ7obAPdgkO/
	G3bsUZasEnHZOdtd59Lp1oInop4ZteYaYmHhTELnHF6tqrive/rfzlJdPfa0i6xz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236958>

This is v2 of my proposed fix for the "local tag killer" problem that
I reported recently [1].  Thanks a lot to Junio for his feedback on
v1.

Changes since v1:

* Rebase to current upstream master (0d6cf2471f); no conflicts were
  encountered.

* Incorporate feedback from Junio:

  * Improve the documentation as suggested

  * Fix a few typos

* Document get_expanded_map() and fix a minor memory leak that I found
  there.

* get_ref_map(): Do not look for references that can be updated
  opportunistically among the entries added by "--tags".  Preserve the
  order of output list when changing the function to handle the new
  "--tags" semantics.  (I know more about how the output is used and
  am less worried now that the changes will have bad interactions with
  the rest of the system.)

* Improve the description of tag-following in the "git fetch" manpage.

* Moved the changes to ref_remove_duplicates() later in the series, as
  they were not really integral to the rest of the patch series.
  Make the following changes to that function:

  * Add tests of how it handles duplicates.

  * Simplify the loop in a different way than v1, to make it more
    modular.

  * Extract a function to handle duplicates.

  * Improve the error messages emitted if ref_remove_duplicates()
    finds conflicting duplicates, and mark the messages for
    translation.

  * Do not die() if a user-specified refspec conflicts with
    an opportunistic update.

[1] http://article.gmane.org/gmane.comp.version-control.git/234723

Michael Haggerty (23):
  t5510: use the correct tag name in test
  t5510: prepare test refs more straightforwardly
  t5510: check that "git fetch --prune --tags" does not prune branches
  api-remote.txt: correct section "struct refspec"
  get_ref_map(): rename local variables
  builtin/fetch.c: reorder function definitions
  get_expanded_map(): add docstring
  get_expanded_map(): avoid memory leak
  fetch: only opportunistically update references based on command line
  fetch --tags: fetch tags *in addition to* other stuff
  fetch --prune: prune only based on explicit refspecs
  query_refspecs(): move some constants out of the loop
  builtin/remote.c: reorder function definitions
  builtin/remote.c:update(): use struct argv_array
  fetch, remote: properly convey --no-prune options to subprocesses
  fetch-options.txt: simplify ifdef/ifndef/endif usage
  git-fetch.txt: improve description of tag auto-following
  ref_remove_duplicates(): avoid redundant bisection
  t5536: new test of refspec conflicts when fetching
  ref_remove_duplicates(): simplify loop logic
  ref_remote_duplicates(): extract a function handle_duplicate()
  handle_duplicate(): mark error message for translation
  fetch: improve the error messages emitted for conflicting refspecs

 Documentation/config.txt                 |   4 +-
 Documentation/fetch-options.txt          |  26 +--
 Documentation/git-fetch.txt              |  14 +-
 Documentation/technical/api-remote.txt   |  20 +--
 builtin/fetch.c                          | 298 ++++++++++++++++---------------
 builtin/remote.c                         | 196 ++++++++++----------
 git-pull.sh                              |   2 +-
 remote.c                                 |  94 +++++++---
 remote.h                                 |   8 +-
 t/t5510-fetch.sh                         |  36 +++-
 t/t5515/fetch.br-unconfig_--tags_.._.git |   1 +
 t/t5515/fetch.master_--tags_.._.git      |   1 +
 t/t5525-fetch-tagopt.sh                  |  23 ++-
 t/t5536-fetch-conflicts.sh               | 100 +++++++++++
 14 files changed, 503 insertions(+), 320 deletions(-)
 create mode 100755 t/t5536-fetch-conflicts.sh

-- 
1.8.4.1
