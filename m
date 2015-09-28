From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 00/43] lmdb ref backend
Date: Mon, 28 Sep 2015 18:01:35 -0400
Message-ID: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:03:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggVi-0000QE-Ji
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbbI1WC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:02:58 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33645 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbbI1WC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:02:57 -0400
Received: by qkas79 with SMTP id s79so9401049qka.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:02:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EeOru28MjTejR3Kk9PMhJf4s7JSXnpGDIL7Scu96jRc=;
        b=O7QQlHwR1f8GO8g6pTJ2vDTZAsM4RwwdPcCbQpeNPtBopsM4dn0QRh1HDkdxNYipb/
         Toy/GSJmNv9Nsy1lUMpEdSVXYNU7vlXsc5gcVFMh0dNKZTzFGYT1ooFWFfTBqMZgOg/D
         ORwxwQxERYtrxms7shTl4zV6DevmqOsv41A9z+urMWHjPOEHuxkbwHypBrij6qqUNFo9
         2XAGQjIGH3XsC6HonTJvyUrXgndCQnK1MsoHHiAHwg92aOcj/tEGWZIRiry0jZpQ8RJu
         KfTybj45LejaCX6aeasvFmpL3fs0gPusKOE6vYnEUIcayVg4Ng67+3fmeChYxz5hHoxx
         BhDw==
X-Gm-Message-State: ALoCoQnUYC/JHVJLHN2S7Vy9xAQbC/GnQtd3cYOrtSBFIOLKx5UZDSWvC+/VFGD59ubTg/9HPWCA
X-Received: by 10.55.192.201 with SMTP id v70mr6199666qkv.97.1443477776086;
        Mon, 28 Sep 2015 15:02:56 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.02.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:02:55 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278757>

This version rebases on top of pu.  Mainly, this just moves a couple
of methods to the backend.

I added support for long symrefs to the lmdb backend.  Peff added this
to the files backend in pu, and there's a test for it.

I cleaned up some formatting (long lines), and moved one patch to put
it closer to its related patches. I added a comment to a bit I found confusing
when re-reading the patch (in the lmdb backend patch).

I re-ran the tests under lmdb, and everything that passed last time
passes this time.

David Turner (24):
  refs: make repack_without_refs and is_branch public
  refs-be-files.c: add method for for_each_reftype_...
  refs-be-files.c: add do_for_each_per_worktree_ref
  refs.c: move refname_is_safe to the common code
  refs.h: document make refname_is_safe and add it to header
  refs.c: move copy_msg to the common code
  refs.c: move peel_object to the common code
  refs.c: move should_autocreate_reflog to common code
  refs.c: add ref backend init function
  refs.c: add methods for reflog
  refs-be-files.c: add method to expire reflogs
  refs.c: add method for initial ref transaction commit
  initdb: move safe_create_dir into common code
  refs.c: add method for initializing refs db
  refs.c: make struct ref_transaction generic
  refs-be-files.c: add method to rename refs
  run-command: track total number of commands run
  refs: move some defines from refs-be-files.c to refs.h
  refs: make some files backend functions public
  refs: break out a ref conflict check
  refs: allow ref backend to be set for clone
  refs: add register_refs_backend
  refs: add LMDB refs backend
  refs: tests for db backend

Ronnie Sahlberg (19):
  refs.c: create a public version of verify_refname_available
  refs-be-files.c: rename refs to refs-be-files
  refs.c: add a new refs.c file to hold all common refs code
  refs.c: move update_ref to refs.c
  refs.c: move delete_ref and delete_refs to the common code
  refs.c: move read_ref_at to the common refs file
  refs.c: move the hidden refs functions to the common code
  refs.c: move dwim and friend functions to the common refs code
  refs.c: move warn_if_dangling_symref* to the common code
  refs.c: move read_ref, read_ref_full and ref_exists to the common code
  refs.c: move resolve_refdup to common
  refs.c: move check_refname_format to the common code
  refs.c: move is_branch to the common code
  refs.c: move prettify_refname to the common code
  refs.c: move ref iterators to the common code
  refs.c: move head_ref_namespaced to the common code
  refs-be-files.c: add a backend method structure with transaction
    functions
  refs-be-files.c: add methods for misc ref operations
  refs-be-files.c: add methods for the ref iterators

 .gitignore                               |    1 +
 Documentation/git-clone.txt              |    4 +
 Documentation/git-init-db.txt            |    2 +-
 Documentation/git-init.txt               |    6 +
 Documentation/technical/refs-be-lmdb.txt |   39 +
 Makefile                                 |   13 +
 builtin/clone.c                          |   27 +-
 builtin/init-db.c                        |   39 +-
 builtin/submodule--helper.c              |    5 +-
 cache.h                                  |   13 +
 config.c                                 |   27 +
 configure.ac                             |   33 +
 contrib/workdir/git-new-workdir          |    2 +
 environment.c                            |    1 +
 path.c                                   |   12 +
 refs-be-files.c                          | 3757 +++++++++++++++++++++
 refs-be-lmdb.c                           | 1984 +++++++++++
 refs.c                                   | 5329 ++++++------------------------
 refs.h                                   |  282 +-
 run-command.c                            |    2 +
 run-command.h                            |    1 +
 setup.c                                  |   28 +-
 t/t1460-refs-be-db.sh                    | 1103 +++++++
 t/t1470-refs-be-db-reflog.sh             |  353 ++
 test-refs-be-lmdb.c                      |   68 +
 25 files changed, 8716 insertions(+), 4415 deletions(-)
 create mode 100644 Documentation/technical/refs-be-lmdb.txt
 create mode 100644 refs-be-files.c
 create mode 100644 refs-be-lmdb.c
 create mode 100755 t/t1460-refs-be-db.sh
 create mode 100755 t/t1470-refs-be-db-reflog.sh
 create mode 100644 test-refs-be-lmdb.c

-- 
2.4.2.644.g97b850b-twtrsrc
