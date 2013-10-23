From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/15] Change semantics of "fetch --tags"
Date: Wed, 23 Oct 2013 17:50:33 +0200
Message-ID: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
References: <52327E62.2040301@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:59:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0pn-0006jA-Cc
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673Ab3JWP6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:58:55 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:63595 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752635Ab3JWP6y (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 11:58:54 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Oct 2013 11:58:54 EDT
X-AuditID: 12074413-b7fc76d000002aba-85-5267f086bc55
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 29.38.10938.680F7625; Wed, 23 Oct 2013 11:51:34 -0400 (EDT)
Received: from localhost.localdomain (p57A247B5.dip0.t-ipconnect.de [87.162.71.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9NFpLsr009100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Oct 2013 11:51:26 -0400
X-Mailer: git-send-email 1.8.4
In-Reply-To: <52327E62.2040301@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsUixO6iqNv2IT3IoOm5jsX0rtUsFl1Xupks
	GnqvMFvMu7uLyWLVrWXMFitn3GC0uL1iPrPF085Ki3kvXrBZ/GjpYXbg8vj7/gOTx6V1L5k8
	Dv2Zwu7x7EQ7m8ell9/ZPJ717mH0uHhJ2WNGy2sWj8+b5DwOXH7MFsAVxW2TlFhSFpyZnqdv
	l8CdsfreGZaCa5oVq46tY2tgnK3QxcjJISFgInHo+BU2CFtM4sK99UA2F4eQwGVGic0Hm6Cc
	K0wSMx7dZAKpYhPQlVjU0wxmiwioSUxsO8QCUsQsMJFZ4vj0RSwgCWEBS4kXTzeAFbEIqEos
	+nMbaBIHB6+As8T3UwkgpoSAnMTDb7EgFZwCOhJX574FqxYS0JY427qfaQIj7wJGhlWMcok5
	pbm6uYmZOcWpybrFyYl5ealFuuZ6uZkleqkppZsYIUErvINx10m5Q4wCHIxKPLwPWtKChFgT
	y4orcw8xSnIwKYnyznmXHiTEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhHfHXaAcb0piZVVqUT5M
	SpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCt+k9UKNgUWp6akVaZk4JQpqJgxNEcIFs
	4AHaMAukkLe4IDG3ODMdougUo6KUOG8DSEIAJJFRmgc3AJZeXjGKA/0jzDsbpIoHmJrgul8B
	DWYCGjxlSRrI4JJEhJRUA+OU9MPeRnftwvtZLZLsn4rkL74Z92CpzXun85tsQxY5TPVafjqp
	4c8LzQzvYsfvyVnPUu4n7VU8MDW9akte0nWrqxdbeBc3LK/tXRk806F2zfKW1Msn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236522>

This is my proposed fix for the "local tag killer" problem that I
reported recently [1].

There are three main things changed by this patch series:

1. "git fetch --tags" causes tags to be fetched *in addition to* any
   other refspecs that are configured for the remote, rather than
   *instead of*.  I believe this is more useful behavior.  It is also
   consistent with the documentation as it was written before it was
   disambiguated in 1.8.0.3.

2. "git fetch --prune" only prunes references that match an explicit
   refspec (either from the command line or from the
   remote.<name>.fetch configuration.  In particular, using "--prune"
   and "--tag" together do *not* make tags subject to pruning.  (Tags
   can still be pruned if the user specifies an explicit refspec
   "refs/tags/*:refs/tags/*".)

3. Previously, if the user invoked one of the following commands with
   --no-prune, the --no-prune option was not passed to the "git fetch"
   subprocesses that they invoked to do their work:

       git fetch --all
       git fetch --multiple
       git fetch --recurse-submodules
       git remote update

   If fetch.prune or remote.<name>.prune were set to true, this could
   result in unwanted reference pruning.  The last commit in the
   series fixes this bug and should not be controversial.

I had originally planned to solve the "local tag killer" problem by
adding a new configuration option to define which reference namespaces
were subject to pruning (e.g.,
remote.<name>.pruneRef="refs/remotes/*").  I may yet submit that patch
series as a separate feature.  But while working on it I hit on the
present solution, which I think is simpler and more elegant (albeit a
bit less flexible).

Changes (1) and (2) introduce behavior changes, but I think that they
are improvements and that the resulting backwards-incompatibility is
acceptable:

Change (1) means that "git fetch --tags <remote>" without any
additional refspec arguments will fetch more references than it did
before.  But I don't think it is very useful to want to fetch tags
without fetching other configured references, so I think it is OK [2].

Change (2) means that using "git fetch --tags --prune" will *not*
prune tags.  (This is the whole point of the change!)  As discussed in
the mailing list, it is usually bad policy to prune tags, because tags
for the local repository and for all remote repositories currently
share a single namespace, "refs/tags/*".  Therefore, pruning tags
based on information from a single remote risks pruning local tags or
tags that have been obtained from another remote.  The main exception,
when one probably *does* want to prune tags, is when fetching into a
mirror clone.  But mirror clones have
"remote.<name>.fetch=+refs/*:refs/*", and so even after this change
tags will be subject to pruning when fetching into a mirror clone.

The only other place I can find that does reference pruning is "git
remote prune", but that codepath didn't respect remote.<name>.tagopt
anyway and therefore it *didn't* prune tags unless they were part of
an explicit refspec; i.e., this codepath already behaved the "new" way
that other pruning codepaths now behave.

Patches 1-9 are just preliminary cleanup and documentation
improvements.

Patch 10 implements change (1) described above.

Patch 11 implements change (2).

Patches 12-14 are some more minor cleanups.

Patch 15 implements change (3).

[1] http://article.gmane.org/gmane.comp.version-control.git/234723

[2] Indeed, I bet that most scripts that invoke "git fetch --tags
    <remote>" also invoke a plain "git fetch" immediately before or
    after to get the rest of the references.

Michael Haggerty (15):
  t5510: use the correct tag name in test
  t5510: prepare test refs more straightforwardly
  t5510: check that "git fetch --prune --tags" does not prune branches
  api-remote.txt: correct section "struct refspect"
  get_ref_map(): rename local variables
  ref_remove_duplicates(): avoid redundant bisection
  ref_remove_duplicates(): simplify function
  ref_remove_duplicates(): improve documentation comment
  builtin/fetch.c: reorder function definitions
  fetch --tags: fetch tags *in addition to* other stuff
  fetch --prune: prune only based on explicit refspecs
  query_refspecs(): move some constants out of the loop
  builtin/remote.c: reorder function definitions
  builtin/remote.c:update(): use struct argv_array
  fetch, remote: properly convey --no-prune options to subprocesses

 Documentation/config.txt                 |   2 +-
 Documentation/fetch-options.txt          |  21 ++-
 Documentation/technical/api-remote.txt   |  20 +--
 builtin/fetch.c                          | 253 +++++++++++++++----------------
 builtin/remote.c                         | 196 ++++++++++++------------
 git-pull.sh                              |   2 +-
 remote.c                                 |  44 +++---
 remote.h                                 |   9 +-
 t/t5510-fetch.sh                         |  36 ++++-
 t/t5515/fetch.br-unconfig_--tags_.._.git |   1 +
 t/t5515/fetch.master_--tags_.._.git      |   1 +
 t/t5525-fetch-tagopt.sh                  |  23 ++-
 12 files changed, 322 insertions(+), 286 deletions(-)

-- 
1.8.4
