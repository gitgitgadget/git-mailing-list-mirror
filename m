From: David Turner <dturner@twopensource.com>
Subject: [PATCH 00/16] LMDB refs backend atop pre-vtable
Date: Wed,  2 Dec 2015 19:35:05 -0500
Message-ID: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Dec 03 01:36:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4HsZ-0006lr-VZ
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 01:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756467AbbLCAfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 19:35:36 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34782 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754717AbbLCAff (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 19:35:35 -0500
Received: by igvg19 with SMTP id g19so2205878igv.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2015 16:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=4j8sSGwxIqXOhQQbHrzAWJUSEvOS2onZt48qcojLoiI=;
        b=bXHaDAR3Dr+PCsyOCLfb/Nd9nLblLtlz1IPO6qweNIHWRKVHLG1uDCDxzSVJrUj6kU
         5k0kTjF7HceYPGWpAwDfIhZEwbr+BAe6rRAZAOpz/ozM95LU1mV2guCbVUsooE9bAwUV
         Xe2z8xq+F0QUQsk6J4iTY7FG9iYo7Kl6vNdp7SPTVK0BWsvrvNMeCmVqwLi/FyYdYeL1
         akeUyM/9p0RGTO77rHbh7AwjjCL9wMGIArJEchbLm5uyvt+GV7dUq4iOmI654vT/6Vly
         gKqOJ2cwyUpEnPLnPzyqgR3xUidp777nL2rsgQBNEkmOgW/levIVmc/H3jidmFiaIIB7
         Mdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4j8sSGwxIqXOhQQbHrzAWJUSEvOS2onZt48qcojLoiI=;
        b=HgVmwcD3b/acWk2G9pdAfGEdiKJUQD5DOxS4SYC1k6Oas54uOJQp10O5Yr+FuPP9ZY
         +/OYGfoVRncCdUVOeZwMzli5SF75PMQSvTp4GwQ98dUgERlGqnbOIrEtbzdywWbGUCuP
         8xfqMWX8HSfLf7UakkY2W15ELqm8u5HVVhicPnMA9gSErjapICV3Eo4PNXfoBSOtnesA
         SHsL3VOXq/5OAJeNeAoX5hmJLroLfge4szKLSfKDVrsTmkWK1UOGCe+sFjFLQv9xaC+9
         Uv1c1yrgwm2Z30gg2V5NzSpR29BdaKdjAvQGphhjY5cGUEuMjsuUPfwJpbloeGqoEY+M
         FVtA==
X-Gm-Message-State: ALoCoQn5iTwHNUAUXeMvdeOGC+Q4QQ6HiJGtvLyheVjdO8gDh15Pk5UL0+3yuQbFIuYnqYSV7d2W
X-Received: by 10.50.13.72 with SMTP id f8mr35804268igc.38.1449102935070;
        Wed, 02 Dec 2015 16:35:35 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id z15sm2108571iod.37.2015.12.02.16.35.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Dec 2015 16:35:34 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g0ed01d8-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281925>

I'm starting the patchset numbering over from 1 here, because this
version of the patchset is a subset of the last version.

This version of the patch set applies on top of
dt/refs-backend-pre-vtable.  This required moving a bunch of stuff
that was in refs.h in previous versions into refs/refs-internal.h.

Since the last patchset, I added support for symlink HEAD refs, and
broke out the initdb stuff into a separate commit.

I also rearranged the order of the backend functions to make the vtable
easier to read.

I removed for_each_reftype_fullpath, which was at one point in next
but is not anymore.  And I did a bit more code cleanup/rearrangement
on the LMDB stuff: I removed memory leaks, improved style, and just
generally spruced things up.

As usual, the normal tests and the same set of hacked tests pass.

I've read over each of these patches a few times, but I've probably
still managed to miss things.  I look forward to your review.

David Turner (13):
  refs: add do_for_each_per_worktree_ref
  refs: add methods for reflog
  refs: add method for initial ref transaction commit
  refs: add method for delete_refs
  refs: add methods to init refs backend and db
  refs: add method to rename refs
  refs: make lock generic
  refs: move duplicate check to common code
  refs: always handle non-normal refs in files backend
  init: allow alternate backends to be set for new repos
  refs: allow ref backend to be set for clone
  refs: add LMDB refs backend
  refs: tests for lmdb backend

Ronnie Sahlberg (3):
  refs: add a backend method structure with transaction functions
  refs: add methods for misc ref operations
  refs: add methods for the ref iterators

 .gitignore                                     |    1 +
 Documentation/config.txt                       |    7 +
 Documentation/git-clone.txt                    |    4 +
 Documentation/git-init-db.txt                  |    2 +-
 Documentation/git-init.txt                     |    7 +-
 Documentation/technical/refs-lmdb-backend.txt  |   50 +
 Documentation/technical/repository-version.txt |    5 +
 Makefile                                       |   12 +
 builtin/clone.c                                |   27 +-
 builtin/init-db.c                              |   35 +-
 builtin/submodule--helper.c                    |    5 +-
 cache.h                                        |   10 +
 config.c                                       |   34 +
 configure.ac                                   |   33 +
 contrib/workdir/git-new-workdir                |    3 +
 environment.c                                  |    1 +
 path.c                                         |   32 +-
 refs.c                                         |  406 ++++-
 refs.h                                         |   17 +
 refs/files-backend.c                           |  257 +--
 refs/lmdb-backend.c                            | 2054 ++++++++++++++++++++++++
 refs/refs-internal.h                           |  118 +-
 setup.c                                        |   32 +-
 t/t1460-refs-lmdb-backend.sh                   | 1109 +++++++++++++
 t/t1470-refs-lmdb-backend-reflog.sh            |  359 +++++
 t/test-lib.sh                                  |    1 +
 test-refs-lmdb-backend.c                       |   68 +
 27 files changed, 4553 insertions(+), 136 deletions(-)
 create mode 100644 Documentation/technical/refs-lmdb-backend.txt
 create mode 100644 refs/lmdb-backend.c
 create mode 100755 t/t1460-refs-lmdb-backend.sh
 create mode 100755 t/t1470-refs-lmdb-backend-reflog.sh
 create mode 100644 test-refs-lmdb-backend.c

-- 
2.4.2.749.g0ed01d8-twtrsrc
