From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 00/26] refs backend pre-vtable
Date: Tue, 27 Oct 2015 22:14:01 -0400
Message-ID: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:14:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGGB-0000k7-Ow
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178AbbJ1COj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:14:39 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37610 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177AbbJ1COi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:14:38 -0400
Received: by igbhv6 with SMTP id hv6so92962945igb.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=cqnZIocPjGooucxtssZSNbYEa34Fdbc4JBXMKdlwNGo=;
        b=WQkxosTueKWRu6Up+OJtnRMlyvGG+DhUNkGaQYrPikOdoUOrnQZp7Ka+K3ZEiOCWp6
         nDVgerTKxcR5gW3BWJmD/FkORok7/LYOxgMR8ORx9BmMTyeHZN712dj7mCuWapxE8Qpn
         KTHsZZsxMZZlDDiYBpOtzNVggg8PP1WxqVuKInFatcjEsyYIc4O0SmAyi1hvn718KkvV
         RiR36fqIDSH0tsg+yUr4A4D0fSvu04KsuPl+hTUt0fkNUo/xGx/BbYMeHwifw6JAUTkD
         sUBVaclB0kWTlXoKhUI9pW6B7G/SPm+YSG7LUHVSIacj/sPHciI4qud+BNA2PWxdvW+T
         edJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cqnZIocPjGooucxtssZSNbYEa34Fdbc4JBXMKdlwNGo=;
        b=H6N8iOfcda6MK72mf2/TioQ98hPGTuovYD/Hdv8h0cYJLqmwDfAyNjUW/VYbPpoILR
         0VYLeIZc9kipHBz+OVWHwf34T6LtTqNyuHCcvkWrMYN4r5hullzoJX/dWRQCyVrpxl3u
         7QCcWNdHZxFvnsZgkBmUh/Dy3dhQcWdu8ly2SGIDxVnAHpFWCSlY2wP4uvImfVMm3uAB
         lob3toeZRNoxC4t6y4PqfLTNo6bIAeH6+Y6JI9iX7xP42sQTrXRwkmA1yYPdfmNaHVSD
         RcYnqMAgZnQbKuIEhymyE8W0W+6LpY8/Ckeq3LcP9NX8EomwplfuRCqCSTgHX//CBd/c
         vKkg==
X-Gm-Message-State: ALoCoQlS9Z5M3n3K3t9wb6m7vaRPDWLcaf53axPV63oH1bsfdjwVVCjhLFQYMDJlQJ1eWnAfVsnm
X-Received: by 10.50.66.197 with SMTP id h5mr322014igt.82.1445998477607;
        Tue, 27 Oct 2015 19:14:37 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.14.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:14:36 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280325>

This version of the series makes some minor changes from v4:

refs.c: move refname_is_safe to the common code: clarify a comment
initdb: move safe_create_dir into common code: add a caveat on safe_create_dir
refs.c: move update_ref to refs.c: update commit message to include write_pseudoref
refs.c: move delete_pseudoref and delete_ref to the common code: remove spurious
added newline
refs: make files_log_ref_write functions public: reword commit message
refs.c: move ref iterators to the common code: added my DCO because this patch changed a bunch since Ronnie wrote it

Thanks to Michael and Junio for the reviews.

The rest of the patches:
David Turner (9):
  refs: make is_branch public
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
 refs-be-files.c                                | 3512 ++++++++++++++++
 refs.c                                         | 5172 ++++--------------------
 refs.h                                         |  187 +-
 setup.c                                        |   37 +-
 t/t1302-repo-version.sh                        |   38 +
 10 files changed, 4644 insertions(+), 4419 deletions(-)
 create mode 100644 Documentation/technical/repository-version.txt
 create mode 100644 refs-be-files.c

-- 
2.4.2.658.g6d8523e-twtrsrc
