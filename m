From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 00/19] add strbuf_set operations
Date: Mon,  9 Jun 2014 15:19:19 -0700
Message-ID: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:20:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7vM-0000Eg-38
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266AbaFIWUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:20:13 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:54969 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbaFIWUL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:20:11 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so5375162pdj.34
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=i7wogMWNUBPODOwhSPSXUdg8wB5UaiCclRhjRHo0fY4=;
        b=uto+8u8q8GWTo+wEwP6nuIvHw2vcVa9YA2gfSDxPiv7a59+tupXPxsGwCDoGpWiS2y
         YfK5wa4Z3SdnznvIel9Q+beaGAFN8Sita+/J0psvSz40x6imjcp8H3POFCysw/pBgk4D
         OjomXBMazVyjWeA7ivqHlREHFST6pcmWOYUYRFHa0zXy4SSqhfpxKvLHviHt8MMMKfK0
         zLKnqHH3RKWer9GG/+sMVkOpTLY+j4jxwiurgWzV7h747m0yUK5QtveRQDpAEtaI1CS5
         ivgveKD+DxNlGlrtzcKMfL8qGGtMfK1iaiTj7T5xb50+G+/ag98CG5i6IebPnBoqjnTZ
         DSbA==
X-Received: by 10.66.221.230 with SMTP id qh6mr1136807pac.5.1402352410885;
        Mon, 09 Jun 2014 15:20:10 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id zq5sm65819044pbb.37.2014.06.09.15.20.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:20:09 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:20:06 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251108>

Version 2 of the patch set to add strbuf_set operations.

Includes suggestions from Eric Sunshine [1]:

  - New operations and their documentation placed in one patch.

  - Less ambiguous documentation: "Replace the buffer content with [...]"

  - Use imperative mood in log messages.

  - Don't use strbuf_set operations in cases where strbuf_add is used to
    build up a buffer in multiple steps.  Multiple adds suggest that
	re-ordering is possible whereas a strbuf_set at the beginning
	suggests that it isn't.  This is confusing.

Using strbuf_set before a sequence of adds can be confusing.  But using
strbuf_add when nothing important was being added to can also be
confusing.  strbuf_set can be used to make these cases more clear.

  struct strbuf mybuf = STRBUF_INIT;

  strbuf_add(&mybuf, ...);  /* Was something there before? */

  strbuf_set(&mybuf, ...);  /* Replace everything. */

Several single line replacements were made for this reason.

Additional files have also been converted compared to version 1 [1].

[1]: http://marc.info/?l=git&m=140230874124060&w=2

Jeremiah Mahler (19):
  add strbuf_set operations
  sha1_name: simplify via strbuf_set()
  fast-import: simplify via strbuf_set()
  builtin/remote: simplify via strbuf_set()
  branch: simplify via strbuf_set()
  builtin/branch: simplify via strbuf_set()
  builtin/checkout: simplify via strbuf_set()
  builtin/mailinfo: simplify via strbuf_set()
  builtin/tag: simplify via strbuf_set()
  date: simplify via strbuf_set()
  diffcore-order: simplify via strbuf_set()
  http-backend: simplify via strbuf_set()
  http: simplify via strbuf_set()
  ident: simplify via strbuf_set()
  remote-curl: simplify via strbuf_set()
  submodule: simplify via strbuf_set()
  transport: simplify via strbuf_set()
  vcs-svn/svndump: simplify via strbuf_set()
  wt-status: simplify via strbuf_set()

 Documentation/technical/api-strbuf.txt | 18 +++++++++++
 branch.c                               |  6 ++--
 builtin/branch.c                       |  3 +-
 builtin/checkout.c                     | 18 ++++-------
 builtin/mailinfo.c                     | 18 ++++-------
 builtin/remote.c                       | 59 ++++++++++++----------------------
 builtin/tag.c                          |  3 +-
 date.c                                 |  3 +-
 diffcore-order.c                       |  3 +-
 fast-import.c                          |  6 ++--
 http-backend.c                         |  6 ++--
 http.c                                 |  3 +-
 ident.c                                |  6 ++--
 remote-curl.c                          |  3 +-
 sha1_name.c                            | 15 +++------
 strbuf.c                               | 21 ++++++++++++
 strbuf.h                               | 14 ++++++++
 submodule.c                            |  5 ++-
 transport.c                            |  3 +-
 vcs-svn/svndump.c                      |  3 +-
 wt-status.c                            |  3 +-
 21 files changed, 110 insertions(+), 109 deletions(-)

-- 
2.0.0.592.gf55b190
