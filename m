From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [PATCH/RFC v4 01/16] GSOC remote-svn
Date: Fri, 17 Aug 2012 22:25:41 +0200
Message-ID: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:26:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2T7g-0004mj-Dz
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758857Ab2HQU0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:26:13 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33191 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab2HQU0K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:26:10 -0400
Received: by wicr5 with SMTP id r5so2005934wic.1
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=bKRnPqi0+5zVMFuRrLPg9q1XC0fS6dLPvqgdz5tr5dE=;
        b=b9dpSy4zfnXe/78t1kBAxdIw2Kq2DP0yzypUnZINH6edUjmmj0Y6Z088q/k0DvN55N
         wBS4uLJsI+LfJoc7nHUhgTubKXOLjRdKyCIS+Tk0ydn4OqV6rC5A5y2So2M6baVFrWii
         B2pbV5bkkIuGuHLZOidO8gvT03LgDHrrolx9Tyc3Pp+aXtlhO7Lah4cCIvFKxacPnSGD
         75DWx6RBkW0BmP9OqEv0jx1w/3Yr57iJNTD4BPCJn7WpXBcY5TlC6Vqtjws8jdZQofbt
         YKD8SfUaOCm2r3YqgS3z8a7YTMG0jnBwuFOoIA2UHt6j8X3b23Xakk1l8EKR1peHmDhP
         jG5Q==
Received: by 10.180.84.1 with SMTP id u1mr7732514wiy.15.1345235169073;
        Fri, 17 Aug 2012 13:26:09 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id k2sm17372232wiz.7.2012.08.17.13.26.07
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:26:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203642>

Hi!

Thanks for the reviews!
This series contains the follwing improvements. 
I decided to summarize them here, sorted by topic instead of
attaching them to the patches.

all:
- remove all merge garbage and debugging legacy (hopefully).
- reviews: style
- reorder patches

remote-svn:
- review: refactor (fct -> fn), style
- fix command batch detection
- setup_git_dir, make non-gentle.
- die on unknown commands, instead of warning

contrib/svn-fe/Makefile, symlink:
- remove symlink-creating commit
- create symlink after linking remote-svn in Makefile
- the makefile is meant as a temporary solution. Therefore, it chooses
  openssl/sha1.h unconditionally.

argv_array:
- new patch: add argv_array_detach and argv_array_free_detached

transport-helper:
- use those new functions
- free argv always after finish_command.
- remove patch that containing unconditional activation of --export-marks
  --import-marks on fast-import command line.

remote-svn:
- instead use fast-import's 'feature' command to activate marks import/export.
- use a more decriptive path for storing marks files.

Florian

 [PATCH/RFC v4 01/16] Implement a remote helper for svn in C.
 [PATCH/RFC v4 02/16] Integrate remote-svn into svn-fe/Makefile.
 [PATCH/RFC v4 03/16] Add svndump_init_fd to allow reading dumps from
 [PATCH/RFC v4 04/16] Add argv_array_detach and
 [PATCH/RFC v4 05/16] Connect fast-import to the remote-helper via
 [PATCH/RFC v4 06/16] Add documentation for the 'bidi-import'
 [PATCH/RFC v4 07/16] When debug==1, start fast-import with "--stats"
 [PATCH/RFC v4 08/16] remote-svn, vcs-svn: Enable fetching to private
 [PATCH/RFC v4 09/16] Allow reading svn dumps from files via file://
 [PATCH/RFC v4 10/16] vcs-svn: add fast_export_note to create notes
 [PATCH/RFC v4 11/16] Create a note for every imported commit
 [PATCH/RFC v4 12/16] remote-svn: Activate import/export-marks for
 [PATCH/RFC v4 13/16] remote-svn: add incremental import.
 [PATCH/RFC v4 14/16] Add a svnrdump-simulator replaying a dump file
 [PATCH/RFC v4 15/16] remote-svn: add marks-file regeneration.
 [PATCH/RFC v4 16/16] Add a test script for remote-svn.
