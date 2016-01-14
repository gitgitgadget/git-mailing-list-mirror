From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 00/20] refs backend rebase on pu
Date: Thu, 14 Jan 2016 11:25:57 -0500
Message-ID: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 14 17:26:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJkjL-00023c-U8
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbcANQ0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:26:31 -0500
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33145 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbcANQ0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:26:31 -0500
Received: by mail-qg0-f42.google.com with SMTP id b35so356504076qge.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 08:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=RPkNSWvK8rD1BKnaQ61SW8P0Q7HSZ58NS7Jh0jfL81Q=;
        b=MhR+zaNo2OvXaDcy5iOQu/QpipYQGi2TVcWjl4hlQUNtIJlJq9BBBvjSoro92QOIIP
         PEdnvJo2kXYg43BKHbPunJ2nC92txn1zgISz+92tszlVjC9njv8SAduyHlx6UPsSkWRO
         U7T1Hzy0vqLzwe43UH7W2busTYwDYNskW8tvIEZx9DcfpTHEvrzSV9MABROWu5Qxu6Sd
         O4YXtA98JWCHWqy5vFIFIE6JPU/twfX8NFDAaI/Ts2XtU5U2iWFbP45/CtYQ85O6hSIm
         b9i0FRHiX4oBrMh0up8p+IJZkJ+BpmIWnZFDkAI2k8bvKpE4JSbuxSQKMPFy8hbUO+ZO
         XCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RPkNSWvK8rD1BKnaQ61SW8P0Q7HSZ58NS7Jh0jfL81Q=;
        b=Dx16ztqb/J/9gGFXSBviszOlfafJVFLyTG+7MksfGY2nM/k/0KOtkmmcR3wW1LiBNX
         I6ltOnK8M7fRRFVZZWy1Pi6z2J/u/wZtFh6Fw9jewwcr/tIn+7RsOCuME3uT3l7sg5xa
         kESsor8C4d/nlUDrB/5WGwr2G8Lq6XaCovMs0r6VLDMzoF4ooj60iinuqEymY0yRqThj
         B+lVmhwkVrD8457QUzlz8ge3r8z88NrUIAgClYQ7eBtmdiYYscY18dO7lGCO4TT3OUjY
         sarH1cC1KL7P8if6AC2TJTiQ9eRcO2DJvWQjKwVy3hzLW1tv0EZImBJJppwm2A5fHL4U
         d89Q==
X-Gm-Message-State: ALoCoQmA1ecAfa3TeDVb1fsPdPxdatfQrL08PQiZ6omJSKVYRk+Qxje+7BlpyRNQ2Mj9wuJmqAnFTrB97vV3KX2GKnIFrAxtNg==
X-Received: by 10.140.220.207 with SMTP id q198mr7144713qhb.24.1452788790288;
        Thu, 14 Jan 2016 08:26:30 -0800 (PST)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id b95sm2724213qge.47.2016.01.14.08.26.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jan 2016 08:26:29 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284036>

I rebased this on top of 20fabf9b194c4099d329582c734e433f9f6586a3 (the
commit before the previous version of this series).

This entailed removing Michael Haggerty's patch to builtin/clone.c,
since a patch by Stefan already did approximately the same thing.

There was a somewhat hairy merge of "resolve symbolic refs first", but
I think the new one is fine (the same tests all pass except for the
one TODO noted in the lmdb code).

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

Ronnie Sahlberg (3):
  refs: add a backend method structure with transaction functions
  refs: add methods for misc ref operations
  refs: add methods for the ref iterators

 .gitignore                                     |    1 +
 Documentation/config.txt                       |    7 +
 Documentation/git-clone.txt                    |    6 +
 Documentation/git-init-db.txt                  |    2 +-
 Documentation/git-init.txt                     |    7 +-
 Documentation/technical/refs-lmdb-backend.txt  |   52 +
 Documentation/technical/repository-version.txt |    5 +
 Makefile                                       |   12 +
 builtin/clone.c                                |    5 +
 builtin/init-db.c                              |   40 +-
 builtin/submodule--helper.c                    |    2 +-
 cache.h                                        |    2 +
 config.c                                       |   29 +
 configure.ac                                   |   33 +
 contrib/workdir/git-new-workdir                |    3 +
 git-submodule.sh                               |   13 +
 git-svn.perl                                   |    6 +-
 path.c                                         |   29 +-
 refs.c                                         |  451 +++++-
 refs.h                                         |   17 +
 refs/files-backend.c                           |  397 +++--
 refs/lmdb-backend.c                            | 2051 ++++++++++++++++++++++++
 refs/refs-internal.h                           |  128 +-
 setup.c                                        |   23 +-
 t/t0001-init.sh                                |   24 +
 t/t1460-refs-lmdb-backend.sh                   | 1109 +++++++++++++
 t/t1470-refs-lmdb-backend-reflog.sh            |  359 +++++
 t/t1480-refs-lmdb-submodule.sh                 |   85 +
 t/test-lib.sh                                  |    1 +
 test-refs-lmdb-backend.c                       |   64 +
 transport.c                                    |    7 +-
 31 files changed, 4767 insertions(+), 203 deletions(-)
 create mode 100644 Documentation/technical/refs-lmdb-backend.txt
 create mode 100644 refs/lmdb-backend.c
 create mode 100755 t/t1460-refs-lmdb-backend.sh
 create mode 100755 t/t1470-refs-lmdb-backend-reflog.sh
 create mode 100755 t/t1480-refs-lmdb-submodule.sh
 create mode 100644 test-refs-lmdb-backend.c

-- 
2.4.2.749.g730654d-twtrsrc
