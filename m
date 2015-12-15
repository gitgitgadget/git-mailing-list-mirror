From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 00/10] Untracked cache improvements
Date: Tue, 15 Dec 2015 17:28:17 +0100
Message-ID: <1450196907-17805-1-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue Dec 15 17:29:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8sTF-0003cQ-Gy
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 17:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059AbbLOQ2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 11:28:55 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37659 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbbLOQ2y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 11:28:54 -0500
Received: by mail-wm0-f46.google.com with SMTP id n186so34041491wmn.0
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 08:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=wxA430sKDusRR0TyPKRTuFFiAA/wg7ZZaB2dYzDU28Y=;
        b=D/1qtxunsUNHZo+JMdBBDDqoJAlmlVjt1ZXZkt6Rus6fVODKdNx+zcl+rZczmQhFKo
         fUFHCeFozDbaakbj7cOi5uti5ukK8p72XL6iogDJCAaL75u725kBN1d6nl+5l52phSiq
         FHRFDxMW1ypyNkZU6ft8GqvWIS4DEG3zAU/Sv3hIQVYllpO9dlZ1Soliz2v0toAt2DKW
         M/WmccqrUZktvr671qP8L2CsXzX2tIn3CbOp5Rhmb7Z+2twnKeDUGBOUbxV+b2CWiusD
         NP88b9v7kVa0mU0K0qBdvlideA5sCfqFE2FV3XX/WhGWINQajFcxVlgxkU3EItZTB/5a
         nKPg==
X-Received: by 10.28.144.78 with SMTP id s75mr5616836wmd.97.1450196933374;
        Tue, 15 Dec 2015 08:28:53 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s11sm3513817wmb.14.2015.12.15.08.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Dec 2015 08:28:51 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.479.g8eb29d4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282482>

Here is a new version of a patch series to improve the untracked cache
feature.

This v2 still implements core.untrackedCache as a simple bool config
variable. When it's true, Git should always try to use the untracked
cache, and when false, Git should never use it.

Patchs 1/10 to 3/10 add some features that are missing. Patch 3/10 has
been moved after the two other patches and has been changed a bit
according to Duy's and Junio's suggestions. In patch 2/10 the enum
names have been changed as discussed with Junio.

Patchs 4/10, 5/10 and 6/10, which have not been changed, are some
refactoring to prepare for patch 8/10 which implements
core.untrackedCache.

Patch 7/10 is a small bug fix suggested by Junio.

Patch 8/10, which adds core.untrackedCache, contains many
documentation and commit message improvements, some by AEvar.

Patch 9/10 has not been changed.

Patch 10/10 is new and removes code that is now useless.

So the changes compared to v1 are mostly small updates, and patchs
7/10 and 10/10.

The patch series is also available there:

https://github.com/chriscool/git/tree/uc-notifs25

Thanks to the reviewers and helpers.

Christian Couder (10):
  update-index: use enum for untracked cache options
  update-index: add --test-untracked-cache
  update-index: add untracked cache notifications
  update-index: move 'uc' var declaration
  dir: add add_untracked_cache()
  dir: add remove_untracked_cache()
  dir: free untracked cache when removing it
  config: add core.untrackedCache
  t7063: add tests for core.untrackedCache
  dir: do not use untracked cache ident anymore

 Documentation/config.txt               |  7 ++++
 Documentation/git-update-index.txt     | 61 ++++++++++++++++++++++++++++------
 builtin/update-index.c                 | 54 +++++++++++++++++-------------
 cache.h                                |  1 +
 config.c                               |  4 +++
 contrib/completion/git-completion.bash |  1 +
 dir.c                                  | 53 +++++++++++++----------------
 dir.h                                  |  4 ++-
 environment.c                          |  1 +
 t/t7063-status-untracked-cache.sh      | 52 ++++++++++++++++++++++++++---
 wt-status.c                            |  9 +++++
 11 files changed, 178 insertions(+), 69 deletions(-)

-- 
2.6.3.479.g8eb29d4
