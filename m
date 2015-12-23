From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 00/11] Untracked cache improvements
Date: Wed, 23 Dec 2015 22:03:48 +0100
Message-ID: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 22:04:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBqa9-0007wX-IH
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 22:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965270AbbLWVEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 16:04:21 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34749 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934194AbbLWVEU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 16:04:20 -0500
Received: by mail-wm0-f53.google.com with SMTP id l126so160129712wml.1
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 13:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=RTqZ9sCpxLT9mxh9DWhskgYUgNXTpTdRQ6ghE7E/h2U=;
        b=FMggA1xCwNPfWK2fvlZeAmNjMdHli6TsOPBDaNuMu4wEV4eHGKShRf6BZiZMA+lQUi
         mHGPuYLEnIAcqtDPfeVEPF8nWtu53a3EwTCtu/vs949cIX5kc+nMhtENsn0yEFLyUXgi
         KJDITDnHcuKIZWppHhuf+DcKGrYXF/JCjr07z0T61nhNkxNyYAW1UvNNtuMnUx3zQ6Nv
         AFzV3PeKc+npKTywSDOwTABAUCANDkm9sRQeJr+0FAozZGJ0EUmI52eWtYX+0yiWk7vy
         uI1r7gAJBwkltWAfKfwhotr63PysoVnxOk54Qo4LKKu/cHS+fwjxtcloAioH8CPUq++q
         +FEA==
X-Received: by 10.194.94.232 with SMTP id df8mr23054613wjb.25.1450904658934;
        Wed, 23 Dec 2015 13:04:18 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id w80sm9434692wme.17.2015.12.23.13.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Dec 2015 13:04:17 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.11.g68ccdd4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282955>

Here is a new version of a patch series to improve the untracked cache
feature.

This v3 still implements core.untrackedCache as a simple bool config
variable. When it's true, Git should always try to use the untracked
cache, and when false, Git should never use it.

Patch 1/11 is a small bugfix that has been moved to the start of the
series so it might get applied independently.

Patch 2/11 to 4/11 add some small features that are missing. They
haven't been changed since the previous series.

Patchs 5/11 to 8/11 are some refactoring to prepare for the following
patchs. Among them 7/11 is new, the others haven't changed.

Patch 9/11 replaces patch 10/10 in the previous series. It deals with
the "ident" field in "struct untracked_cache". As suggested by Junio,
we keep paying attention to the location of the work tree that is
stored in this field, but otherwise things are simplified a lot.

Patch 10/11 which adds core.untrackedCache, contains a few
simplifications compared to v2.

Patch 11/11 has not been changed.

So the changes compared to v2 are mostly small updates, and patchs
7/11 and 9/11.

The patch series is also available there:

https://github.com/chriscool/git/tree/uc-notifs34

Thanks to the reviewers and helpers.

Christian Couder (11):
  dir: free untracked cache when removing it
  update-index: use enum for untracked cache options
  update-index: add --test-untracked-cache
  update-index: add untracked cache notifications
  update-index: move 'uc' var declaration
  dir: add add_untracked_cache()
  dir: add new_untracked_cache()
  dir: add remove_untracked_cache()
  dir: simplify untracked cache "ident" field
  config: add core.untrackedCache
  t7063: add tests for core.untrackedCache

 Documentation/config.txt               |  7 ++++
 Documentation/git-update-index.txt     | 61 ++++++++++++++++++++++++-----
 builtin/update-index.c                 | 54 ++++++++++++++------------
 cache.h                                |  1 +
 config.c                               |  4 ++
 contrib/completion/git-completion.bash |  1 +
 dir.c                                  | 70 ++++++++++++++++++++++++++++------
 dir.h                                  |  2 +
 environment.c                          |  1 +
 t/t7063-status-untracked-cache.sh      | 52 ++++++++++++++++++++++---
 wt-status.c                            |  5 +++
 11 files changed, 207 insertions(+), 51 deletions(-)

-- 
2.7.0.rc2.11.g68ccdd4
