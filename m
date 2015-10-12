From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 00/44] alternate refs backends
Date: Mon, 12 Oct 2015 17:51:20 -0400
Message-ID: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:52:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll12-0004Ch-Ql
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbbJLVwP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2015 17:52:15 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36164 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558AbbJLVwO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:14 -0400
Received: by qgx61 with SMTP id 61so129589851qgx.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=zf5TriR9viu1LSurwNe1lH5DmQ1ms8w9j0XZegyme+U=;
        b=fbhTOq5qz2gJ9wwLpDXaiDtVAUcRiK0Y70D9Lj1//GkuGiCbR+4Kge0vNRAlNOYBnZ
         D4QhyPCwYTSr2zwSYQsGUVX+xLFeV8o7KyHU8Kl94gB4Rp6cvCSFpMtON+AIW7FaLetO
         JVfZqjqzjBUfIlsp7VPNjA2ns1E2JRL9PNgsEIfEK12UJkH/sjNPvoWBeoxRZQvYm4p3
         2W7PsCR2dgQck4vorhTMygWLlwu8fFwWbTq+TJODzZW5K2A9bUol8JmT5gPVLvq98rKM
         Fff9iwhGaeVqolacCRx3C8dDXW3oEr7r991BjBUxHBuX5mTtD6T7LiHZfM1PZ5DcOjlv
         QN2A==
X-Gm-Message-State: ALoCoQk+VSg8iCVq33696x+p+4WkMiP/11Evr9KzSCGfsx1aklOoDBib17MtmwK2gOmeAjBiu+XQ
X-Received: by 10.140.93.195 with SMTP id d61mr14275088qge.89.1444686733408;
        Mon, 12 Oct 2015 14:52:13 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:12 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279423>

This version of the patch set includes the following changes:
1. Numerous formatting and style updates.  Thanks for Michael Haggerty =
to
pointing these out; remaining errors are of course my own.

2. Fixed warnings.  Thanks to Michael Haggerty, Michael Blume, and
Torsten B=C3=B6gershausen for pointing these out.

3. I reworded some commit messages.

4. Made tests work with LMDB turned off. Thanks to Dennis Kaarsemaker.

5. Added Jeff King's core.repositoryformatversion patch.

6. After discussion with Michael Haggerty and Junio, redesigned the
backend structure.  Now the generic code builds ref transactions, and
backends apply these transactions.  The ref transaction backend patch
changed as a result of this, and I added three more patches:

refs: make lock generic (to allow ref backends to use a generic ref_upd=
ate
struct to handle their own locking)

refs: move duplicate check to common code (to simplify the implementati=
on
of ref backends, and to simplify the next patch)

refs: always handle non-normal refs in files backend (cross-backend
transactions)


David Turner (24):
  refs: make repack_without_refs and is_branch public
  refs: move transaction functions into common code
  refs-be-files.c: add method for for_each_reftype_...
  refs-be-files.c: add do_for_each_per_worktree_ref
  refs.c: move refname_is_safe to the common code
  refs.h: document make refname_is_safe and add it to header
  refs.c: move copy_msg to the common code
  refs.c: move peel_object to the common code
  refs.c: move should_autocreate_reflog to common code
  refs.c: add ref backend init function
  refs.c: add methods for reflog
  refs.c: add method for initial ref transaction commit
  initdb: move safe_create_dir into common code
  refs.c: add method for initializing refs db
  refs-be-files.c: add method to rename refs
  refs: make lock generic
  refs: make files_log_ref_write functions public
  refs: break out a ref conflict check
  refs: move duplicate check to common code
  refs: always handle non-normal refs in files backend
  refs: allow ref backend to be set for clone
  refs: add register_refs_backend
  refs: add LMDB refs backend
  refs: tests for db backend

Jeff King (1):
  introduce "extensions" form of core.repositoryformatversion

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
  refs.c: move read_ref, read_ref_full and ref_exists to the common cod=
e
  refs.c: move resolve_refdup to common
  refs.c: move check_refname_format to the common code
  refs.c: move is_branch to the common code
  refs.c: move prettify_refname to the common code
  refs.c: move ref iterators to the common code
  refs.c: move head_ref_namespaced to the common code
  refs: add a backend method structure with transaction functions
  refs-be-files.c: add methods for misc ref operations
  refs-be-files.c: add methods for the ref iterators

 .gitignore                                     |    1 +
 Documentation/config.txt                       |    7 +
 Documentation/git-clone.txt                    |    4 +
 Documentation/git-init-db.txt                  |    2 +-
 Documentation/git-init.txt                     |    6 +
 Documentation/technical/refs-be-lmdb.txt       |   50 +
 Documentation/technical/repository-version.txt |   86 +
 Makefile                                       |   13 +
 builtin/clone.c                                |   27 +-
 builtin/init-db.c                              |   47 +-
 builtin/submodule--helper.c                    |    5 +-
 cache.h                                        |   19 +
 config.c                                       |   34 +
 configure.ac                                   |   33 +
 contrib/workdir/git-new-workdir                |    3 +
 environment.c                                  |    1 +
 path.c                                         |   12 +
 refs-be-files.c                                | 3521 ++++++++++++++++
 refs-be-lmdb.c                                 | 1997 +++++++++
 refs.c                                         | 5322 +++++-----------=
--------
 refs.h                                         |  306 +-
 setup.c                                        |   69 +-
 t/t1302-repo-version.sh                        |   38 +
 t/t1460-refs-be-db.sh                          | 1109 +++++
 t/t1470-refs-be-db-reflog.sh                   |  359 ++
 t/test-lib.sh                                  |    1 +
 test-refs-be-lmdb.c                            |   68 +
 27 files changed, 8849 insertions(+), 4291 deletions(-)
 create mode 100644 Documentation/technical/refs-be-lmdb.txt
 create mode 100644 Documentation/technical/repository-version.txt
 create mode 100644 refs-be-files.c
 create mode 100644 refs-be-lmdb.c
 create mode 100755 t/t1460-refs-be-db.sh
 create mode 100755 t/t1470-refs-be-db-reflog.sh
 create mode 100644 test-refs-be-lmdb.c

--=20
2.4.2.644.g97b850b-twtrsrc
