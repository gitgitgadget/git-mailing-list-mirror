From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 00/13] Reference iterators
Date: Mon, 30 May 2016 09:55:21 +0200
Message-ID: <cover.1464537050.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon May 30 09:56:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7I3W-0001FJ-0L
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 09:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932671AbcE3H4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 03:56:04 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45477 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932141AbcE3H4A (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 03:56:00 -0400
X-AuditID: 12074413-487ff700000008c7-93-574bf2024011
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id E1.FA.02247.202FB475; Mon, 30 May 2016 03:55:46 -0400 (EDT)
Received: from michael.fritz.box (p508EADDB.dip0.t-ipconnect.de [80.142.173.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4U7tgRp032144
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 30 May 2016 03:55:44 -0400
X-Mailer: git-send-email 2.8.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsUixO6iqMv0yTvc4ONKGYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DA7sHn8ff+ByWPnrLvsHs969zB6XLyk7LHg+X12j8+b5ALY
	orhtkhJLyoIz0/P07RK4M2Y83shUcEWlovnpCpYGxvmyXYycHBICJhLti+eydTFycQgJbGWU
	eNp2nRnCOckk0bxqJSNIFZuArsSinmYmEFtEIEKi4VULI0gRs8A+RomT6+azgCSEBbQkZt/r
	ZQaxWQRUJXYefsMGYvMKmEtM6LrJCrFOTuLy9AdQcUGJkzOfAPVyAA1Sl1g/TwgkzCwgL9G8
	dTbzBEbeWUiqZiFUzUJStYCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrrlebmaJXmpK6SZG
	SLgK72DcdVLuEKMAB6MSD2+Bpne4EGtiWXFl7iFGSQ4mJVFeNw6gEF9SfkplRmJxRnxRaU5q
	8SFGCQ5mJRHet4+BcrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4lCV6e
	D0CNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aAIiy8GxhhIigdobxVIO29xQWIu
	UBSi9RSjLseR/ffWMgmx5OXnpUqJ89qDFAmAFGWU5sGtgCWnV4ziQB8L8/aCVPEAExvcpFdA
	S5iAlpid8wJZUpKIkJJqYCzcxyr5VSzhMkPmo8un3vUUF/KcO81tnrb88OnOQh2nTRZOCq+6
	N3JpJ9+M/r+hvC5zY6+XzAKN1UFVm9USi2a/PcxyPG5Z0trNUh+/TRc8pLakc9vN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295860>

This patch series implements a new iteration paradigm for iterating
over references using iterators. This approach was proposed earlier as
an RFC [1].

The justification for this change is laid out in the RFC [1] and in
the commit message for patch 09/13 [2]. Please refer to those, as I
won't repeat them here.

There are several obvious followup steps that are not included in this
patch series (because they don't help with the initial transition to
pluggable reference backends). I've written prototypes of several of
these:

* The iterator interface could be made public and callers could start
  using it directly.

* A filter_ref_iterator could let references be filtered based on a
  callback function (this would be useful, for example, for
  for_each_glob_ref()).

* A single_ref_iterator could "iterate" over a single reference (e.g.,
  HEAD).

* A series_ref_iterator could iterate over multiple iterators, for
  callers that want to operate on, say, HEAD plus all branches.

* The ref_cache could be fed from an iterator, to better decouple
  caching from reading packed and loose references, and to make it
  easy to use caching with other reference storage backends.

* Per-worktree refs could be overlaid on top of shared references
  using merge_ref_iterator rather than mixing them up in the same
  ref_cache.

* The dir_iterator could be used in more places; for example, when
  reading loose references from disk.

Table of contents of changes:

* The first eight patches are cleanups.

  * Patch 05/13 fixes a code path that unlinks symrefs directly
    instead of using the refs API.

* Patch 09/13 is the most important part of this series. It introduces
  not only reference iterators, but also (1) a pattern that other
  iterator interfaces can follow (along with some useful constants in
  iterator.h), and (2) a pattern for building OO code with
  inheritance.

* Patch 10/13 actually uses the new reference iteration mechanism.

* Patch 11/13 avoids aborting reflog iterations if an unexpected file
  is found under `$GIT_DIR/logs`. This fixes a bug that could cause
  objects needed by reflogs to be pruned, breaking the reflogs.

* Patch 12/13 adds an iterator interface for iterating over
  directories (using the same model as patch 09/13).

* Patch 13/13 implements for_each_reflog() on top of an iterator
  interface (essentially the analogue of patch 10/13, but for
  reflogs).

Note that it is not necessary to rebuild for_each_reflog_ent() on top
of iterators at this time, because that function deals with only a
single reference at a time. Therefore, composability is not important
here (for example, it won't have to deal with multiple refs backends
at the same time).

This patch series applies on top of mh/split-under-lock. It is also
available from my GitHub repository [3] as branch "ref-iterators".

I haven't yet completely rebased the ref-store changes (virtualization
of the refs API) on top of all of these changes, but I will work on
that next.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/290409
[2] http://mid.gmane.org/89634d216544d1102dafd5d18247bff2581d48a8.1464537050.git.mhagger@alum.mit.edu
[3] https://github.com/mhagger/git

Michael Haggerty (13):
  refs: remove unnecessary "extern" keywords
  do_for_each_ref(): move docstring to the header file
  refs: use name "prefix" consistently
  delete_refs(): add a flags argument
  remote rm: handle symbolic refs correctly
  get_ref_cache(): only create an instance if there is a submodule
  entry_resolves_to_object(): rename function from
    ref_resolves_to_object()
  ref_resolves_to_object(): new function
  refs: introduce an iterator interface
  do_for_each_ref(): reimplement using reference iteration
  for_each_reflog(): don't abort for bad references
  dir_iterator: new API for iterating over a directory tree
  for_each_reflog(): reimplement using iterators

 Makefile             |   2 +
 builtin/fetch.c      |   2 +-
 builtin/remote.c     |   8 +-
 dir-iterator.c       | 180 +++++++++++++++
 dir-iterator.h       |  86 +++++++
 iterator.h           |  81 +++++++
 refs.c               |  20 ++
 refs.h               | 139 +++++++-----
 refs/files-backend.c | 630 +++++++++++++++++++++++++++++++--------------------
 refs/iterator.c      | 376 ++++++++++++++++++++++++++++++
 refs/refs-internal.h | 225 +++++++++++++++++-
 11 files changed, 1427 insertions(+), 322 deletions(-)
 create mode 100644 dir-iterator.c
 create mode 100644 dir-iterator.h
 create mode 100644 iterator.h
 create mode 100644 refs/iterator.c

-- 
2.8.1
