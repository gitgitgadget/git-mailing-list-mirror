From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 00/11] Untracked cache improvements
Date: Sun, 24 Jan 2016 16:28:13 +0100
Message-ID: <1453649304-18121-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 16:29:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNMbW-0000vY-ES
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 16:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbcAXP2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 10:28:43 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34178 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbcAXP2l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 10:28:41 -0500
Received: by mail-wm0-f65.google.com with SMTP id b14so6797919wmb.1
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 07:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=rcVV7sWLZW3m74QXTfRaqUCRhl3bjWBXio3EX0KthxQ=;
        b=npPdChJN/cPwMU/jNWrIVuGSL/bNMXHRhpjTwcfSFuKbJgWnLlyebH1Y5tEEmJwM/m
         nWb/JiDMpL9+GP2+tYtqwiyejUBVrPL5iCx4L4BV5jAqMIM2U5AzPO2cF7KsNTkP/eLx
         fVzhZdtpGufqH/Et0zBf/Q2hnoSsJd56ytg4DE7jwpc2uPDEC3uya1vdMP3NBx7SYA+E
         9eA3fHiHnr6+3y4bXfaztR+lW17gxMIAV4wCW/N+AoZteeSIvHr2ur0deWe1ZuXkzpl7
         IW3XfjxmZ5LmOxH9ACrOzWrLkKNjhhTuOStwyNE4ae4SKu9CcSd3ujkEh4JY89/T33Qo
         K4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=rcVV7sWLZW3m74QXTfRaqUCRhl3bjWBXio3EX0KthxQ=;
        b=EBFjTF0HdrwqryKOwB4Rbh1l2IbvXo266j6brtz8MRYyN1s8do7Y509uM0sOd8SkX4
         iKrRdsS9bjLPKlDm4EhlkiaaOnfW5fDZStoy0K0CpjWM5ENVicKW08HanvObS7IXg+tr
         dsgnHkwqcXtroCPNfyDkiIMRpCIiYQ8pZLH21T2HAeuH4e0NmkcxKhiKnvDVCd91NALO
         tV6V2McoPphgOIFgLu5YMTfSussRQDM3NIXbUNEa+UWqDpOaSg748cXsTPdSvJXEzid3
         upvAdamlhU/PjQ/5aH9AA+rCPyvGqh+OFqy1MHuAzHlMXLzRNvp3+mOF9MM99iTZtxSy
         PFyg==
X-Gm-Message-State: AG10YORqoXWSphD/Y2XZPv7HSIMDpEB0JCDnoRIhAiqVdImQoBfUgoqgUCF6qO47lM4r7Q==
X-Received: by 10.28.218.81 with SMTP id r78mr14110229wmg.91.1453649319580;
        Sun, 24 Jan 2016 07:28:39 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id y8sm11900231wmg.9.2016.01.24.07.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Jan 2016 07:28:38 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.gd7ef666.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284651>

Here is a new version of a patch series to improve the untracked cache
feature.

This v7 implements core.untrackedCache as a tristate config
variable. When it's `true`, Git commands, especially `git status`,
should always add the untracked cache and use it, and when `false`,
Git commands should remove it. The default is `keep` in which case the
untracked cache is neither removed nor added, and used if it is there.

This v7 is mostly identical to the previous v6. One of the few changes
is that in commit messages now the "Helped-by: ..." are before the
"Signed-off-by: ..." trailers as suggested by Duy. Patches that have
other changes have these other changes described a bit below,
otherwise only the patch itself is briefly described.

Patch 1/11 is a small bugfix.

Patch 2/11 to 4/11 add some small features that are missing.

Patchs 5/11 to 7/11 are some refactoring to prepare for the following
patchs.

Patch 8/11 deals with the "ident" field in "struct untracked_cache".

Patch 9/11 adds core.untrackedCache. The commit message has been
improved thanks to Stefan. And as Duy suggested, the check to see if
we should add or remove the untracked cache is made inside
post_read_index_from() instead of read_index_from(), and
post_read_index_from() comes from the renaming of check_ce_order().

Patch 10/11 is a hack that is needed to have test-dump-untracked-cache
work like it used to.

Patch 11/11 contains tests.

So the changes compared to v6 are mostly small updates.

The patch series is also available there:

https://github.com/chriscool/git/tree/uc-notifs70

Thanks to the reviewers and helpers.

Christian Couder (11):
  dir: free untracked cache when removing it
  update-index: use enum for untracked cache options
  update-index: add --test-untracked-cache
  update-index: add untracked cache notifications
  update-index: move 'uc' var declaration
  dir: add {new,add}_untracked_cache()
  dir: add remove_untracked_cache()
  dir: simplify untracked cache "ident" field
  config: add core.untrackedCache
  test-dump-untracked-cache: don't modify the untracked cache
  t7063: add tests for core.untrackedCache

 Documentation/config.txt               |  9 ++++
 Documentation/git-update-index.txt     | 67 +++++++++++++++++++++----
 builtin/update-index.c                 | 62 ++++++++++++++---------
 cache.h                                |  8 +++
 config.c                               | 24 +++++++++
 contrib/completion/git-completion.bash |  1 +
 dir.c                                  | 62 ++++++++++++++++++-----
 dir.h                                  |  3 +-
 environment.c                          |  7 +++
 read-cache.c                           | 20 ++++++--
 t/t7063-status-untracked-cache.sh      | 89 +++++++++++++++++++++++++++++++---
 test-dump-untracked-cache.c            |  4 ++
 12 files changed, 299 insertions(+), 57 deletions(-)

-- 
2.7.0.181.gd7ef666.dirty
