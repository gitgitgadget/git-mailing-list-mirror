From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 00/21] refs backend reroll
Date: Mon, 11 Jan 2016 20:21:59 -0500
Message-ID: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jan 12 02:22:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aInfN-00036D-FE
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 02:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761359AbcALBW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 20:22:28 -0500
Received: from mail-qg0-f52.google.com ([209.85.192.52]:34252 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761001AbcALBW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 20:22:27 -0500
Received: by mail-qg0-f52.google.com with SMTP id 6so339422580qgy.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 17:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=yjFTeGTDfmQlRJ7LciGFOoZJANvvv5WTPfGoDMSt3uE=;
        b=khBQWyeRpWIKuE/gndltcHArZnV908JFdKawy5A53Ugu4RDcz8bTg0KBFaXnWsbp9L
         2drXREx1CxYLdEtfMEA25hH2Juf/FzULCdpuRBdwmybMeL9Qm1Mvk58WYbmJADjlBKqe
         YWDTQ1gF0sVNh86+FxZHGn8NKWJhMsMgCAXtllZQeNJQ8XyWsPWfE02W98V9mc1HMgfH
         yrHXPbbur5MAhy34A9XNYIKT1XbNj2pr48OMy/P40QnZkz867/iydW9Q/NG2uxKNooT9
         aSY3PEtuDefjYne7jtnBLzqziKVArUX5TXlclHnvz9/NbtNDSRjvuBdmUN9O4UEAQ+3w
         QAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yjFTeGTDfmQlRJ7LciGFOoZJANvvv5WTPfGoDMSt3uE=;
        b=lFy7zoL9WAu32KSCJxt+nPDr+NHkmbaRdIKYesitLEqSIo4nTQtbtGAYLQZ3Tu2k+g
         r7Q7iQPwQ9kw5ka0t5715bzK1XE0wBSGk8VxzgwbFCLIS/TVnospGX2LUcmHTiGx3N7c
         gSvFTmrgJliSE2Ce2rDvowZbni5x/niYVi4mTw2K9dFPrD5Gtw8Oz3w1nQmJq4POq+Xf
         +XwLv+q4tMLkWr+19/7oRv1nmSEPd+Akv3jH1z2UvRR09LZ42CXbnMcl+09dgbrebloY
         o1SQ3OOs46JJ89FpKpVjUP2OKRc3tJobLRr72bCAkq/4a2GZKrDlp17us9jp+24DLwRs
         SIVg==
X-Gm-Message-State: ALoCoQnQdp7K4LeCa+9u0EJcI0xiMT99SKqfXrkMvuRYNn36wDUgckMWq5Y3PpX1r8PG5PxOjbMX+YKSKEvgtQh5Wh58LeAtug==
X-Received: by 10.140.230.8 with SMTP id a8mr179861131qhc.31.1452561746121;
        Mon, 11 Jan 2016 17:22:26 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id d64sm55362053qgd.48.2016.01.11.17.22.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jan 2016 17:22:25 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283739>

This version incorporates many changes suggested by Michael Haggerty,
Junio, Jonathan Nieder, Eric Sunshine, and Jeff King. I think I have
addressed of the comments that were sent to me.  Those that I chose
not to incorporate, I responded to on the mailing list.

Thanks for all of the feed back so far.

In response to comments, I did the following:

I incorporated Michael's use child_process for recursive checkouts
patch.

I fixed some formatting and convention (extern) errors.

I removed a bit of dead code.

I added checks to ensure that submodules have the same backend as
parent modules; this turned up a bunch of weird stuff, which was
mostly fixed by the above.

I rewrote the ref splitting code along the lines suggested by Michael.
Now we split symbolic-ref updates as well as separating updates by
backend.

Documentation clarifications.

Some spelling/grammar fixes.

In addition (and in part inspired by these comments), I made the
following changes:

In general, I tried to simplify alternate ref backend selection code.

The major API change is to remove the backend init function.  There
was no right place to call this function; if it got called too early,
we might not yet know what repo we're talking about, and if it got called
too late, other backend functions would fail.  So now the convention
is that backends must initialize themselves on first call.  This is
a little irritating, but does work.

I added a patch to make git-svn support alternate ref backends.

I re-tested with the usual test hacks and have no new failures
(although testing did turn up one minor missed update to transport.c;
I think I must have missed some of the test hacks in the last round).

This version fixes one silly bug in lmdb_delete_refs that I noticed
while testing.



David Turner (17):
  refs: add do_for_each_per_worktree_ref
  refs: add methods for reflog
  refs: add method for initial ref transaction commit
  refs: add method for delete_refs
  refs: add methods to init refs db
  refs: add method to rename refs
  refs: make lock generic
  refs: move duplicate check to common code
  refs: allow log-only updates
  refs: resolve symbolic refs first
  refs: always handle non-normal refs in files backend
  init: allow alternate backends to be set for new repos
  refs: check submodules ref storage config
  refs: allow ref backend to be set for clone
  svn: learn ref-storage argument
  refs: add LMDB refs backend
  refs: tests for lmdb backend

Michael Haggerty (1):
  clone: use child_process for recursive checkouts

Ronnie Sahlberg (3):
  refs: add a backend method structure with transaction functions
  refs: add methods for misc ref operations
  refs: add methods for the ref iterators

 .gitignore                                     |    1 +
 Documentation/config.txt                       |    7 +
 Documentation/git-clone.txt                    |    5 +
 Documentation/git-init-db.txt                  |    2 +-
 Documentation/git-init.txt                     |    7 +-
 Documentation/technical/refs-lmdb-backend.txt  |   52 +
 Documentation/technical/repository-version.txt |    5 +
 Makefile                                       |   12 +
 builtin/clone.c                                |   19 +-
 builtin/init-db.c                              |   40 +-
 builtin/submodule--helper.c                    |    2 +-
 cache.h                                        |    2 +
 config.c                                       |   29 +
 configure.ac                                   |   33 +
 contrib/workdir/git-new-workdir                |    3 +
 git-submodule.sh                               |   13 +
 git-svn.perl                                   |    6 +-
 path.c                                         |   29 +-
 refs.c                                         |  453 +++++-
 refs.h                                         |   17 +
 refs/files-backend.c                           |  389 +++--
 refs/lmdb-backend.c                            | 2049 ++++++++++++++++++++++++
 refs/refs-internal.h                           |  128 +-
 setup.c                                        |   23 +-
 t/t0001-init.sh                                |   24 +
 t/t1460-refs-lmdb-backend.sh                   | 1109 +++++++++++++
 t/t1470-refs-lmdb-backend-reflog.sh            |  359 +++++
 t/t1480-refs-lmdb-submodule.sh                 |   85 +
 t/test-lib.sh                                  |    1 +
 test-refs-lmdb-backend.c                       |   64 +
 30 files changed, 4762 insertions(+), 206 deletions(-)
 create mode 100644 Documentation/technical/refs-lmdb-backend.txt
 create mode 100644 refs/lmdb-backend.c
 create mode 100755 t/t1460-refs-lmdb-backend.sh
 create mode 100755 t/t1470-refs-lmdb-backend-reflog.sh
 create mode 100755 t/t1480-refs-lmdb-submodule.sh
 create mode 100644 test-refs-lmdb-backend.c

-- 
2.4.2.749.g730654d-twtrsrc
