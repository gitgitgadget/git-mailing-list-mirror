From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 00/26] refs backend pre-vtable patches
Date: Thu, 15 Oct 2015 15:46:24 -0400
Message-ID: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:47:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoUZ-0006Z5-Ay
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:47:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbbJOTrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:47:06 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33855 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbbJOTrE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:04 -0400
Received: by qkfm62 with SMTP id m62so42888586qkf.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ucNWaz/aDGZzaUmJgi2jSZGBe/q5M99CsPXe8QbEBuQ=;
        b=j1mKwFuqTJCbtUtsSuWO7Nr3v1MsTcuI2ep9WF31XLpKuvP3gAwnClHgN98ptR8A5t
         iIqe3qdDOGkdmyRY9fyQfglzWyJcHBY2iyzkmjnW/cEVbAGYGZnOMgKMXapwmepWffXr
         46uzKPs9zpMaz8liOafvQl8ZfirD2WTg5hf4/rBOt/R/APCu/jDCQjRA+dkrqcxqtwuC
         Mv4txRx8Sab5AfswHYKd4SI227M+mim64qF5fXXNmEPT34yLyMULNjdWqBEER5RSXSS3
         IX8kHxXmYwFtj9CqO07Pl+gxpSAiaX2agYrvyZw5NhNun7teyyOQILR+1xgojF9Am4j6
         am/w==
X-Gm-Message-State: ALoCoQnclBFMvfYT5uP9dnJaY3UdJUjSZGJjZ2PGyIplx7kQsTm1iQM2iov+9mwBzGXsZ15uagTL
X-Received: by 10.55.33.214 with SMTP id f83mr13791234qki.69.1444938424204;
        Thu, 15 Oct 2015 12:47:04 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:03 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279680>

Michael and Junio want to split the refs-backend patches into multiple
sections: pre-vtable, vtable, and maybe lmdb.

This is the pre-vtable section.  It includes multiple fixes suggested
by Michael:

1. When we move chunks around between files, make sure we don't cut
new versions and paste old versions!

2. Some rearrangement of patches

3. Made fewer things public, since they are really only needed for
files-backend optimizations.

4. Comment fixes (and moving doc-comments to refs.h when functions
become public)

Also, on my own, I moved Jeff's repository format patch into this
chunk, since it should be relatively non-controversial.

David Turner (9):
  refs: make repack_without_refs and is_branch public
  refs: move transaction functions into common code
  refs.c: move refname_is_safe to the common code
  refs.c: move copy_msg to the common code
  refs.c: move peel_object to the common code
  refs.c: move should_autocreate_reflog to common code
  initdb: move safe_create_dir into common code
  refs: make files_log_ref_write functions public
  refs: break out ref conflict checks

Jeff King (1):
  introduce "extensions" form of core.repositoryformatversion

Ronnie Sahlberg (16):
  refs.c: create a public version of verify_refname_available
  refs-be-files.c: rename refs to refs-be-files
  refs.c: add a new refs.c file to hold all common refs code
  refs.c: move update_ref to refs.c
  refs.c: move delete_pseudoref and delete_ref to the common code
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

 Documentation/technical/repository-version.txt |   81 +
 Makefile                                       |    1 +
 builtin/init-db.c                              |   12 -
 cache.h                                        |   11 +
 path.c                                         |   12 +
 refs-be-files.c                                | 3513 ++++++++++++++++
 refs.c                                         | 5172 ++++--------------------
 refs.h                                         |  187 +-
 setup.c                                        |   37 +-
 t/t1302-repo-version.sh                        |   38 +
 10 files changed, 4645 insertions(+), 4419 deletions(-)
 create mode 100644 Documentation/technical/repository-version.txt
 create mode 100644 refs-be-files.c

-- 
2.4.2.644.g97b850b-twtrsrc
