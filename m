From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 00/11] Untracked cache improvements
Date: Fri, 15 Jan 2016 07:59:41 +0100
Message-ID: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Fri Jan 15 08:00:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJyN5-0004mG-82
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 08:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbcAOHAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 02:00:25 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36847 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbcAOHAX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 02:00:23 -0500
Received: by mail-wm0-f52.google.com with SMTP id l65so8272140wmf.1
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 23:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=SkoLAAsFXB5nV0tqkbJm0jztSPnYr5Nc7Kjw5FqtSu8=;
        b=wf8CJdfxbvsItvt/Ps6YSYIGE/OJsVra6BDd64wP6NSngMnJtzoNnVSn/qQ1TxRRN6
         T/68oXavQrUJ/RSqkpqezy5hQwKUXfFilQfNMDBYyMMwb0rkGedWWdyNwuA8qwcH5mAv
         1yveINnbyQN+j59nrdHKHtOnA2USzLiUr1Czx1jR/JsioXW5Ih4EtRQjJIlIzcHSTcOI
         VgVGuTMikCfDKdkwgbCDtPZAwktMppG6cZTxaCnZQ+i8z8unXG09gAJUGcnOiwlpync3
         TmtDWGOq4CFyhSrPUI+/+7GYaxX0vbWCdn69+miXeDijUy38ko5nu/OLptAR9yYePTCd
         84Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=SkoLAAsFXB5nV0tqkbJm0jztSPnYr5Nc7Kjw5FqtSu8=;
        b=c0Z4B0sSagbNI0GvYfYQezHr0fJCx6B/o6Vh+OVa/Me5SyQhoNP+HX1WBvnysGoyoz
         tYvBX3k5pJQRgqtzzpv9zqqwskffVFNTI0u56i9PqbLlQUUEvQ2RuxKe2rF+/xcIqcUp
         LDm9xIgdfFKRvahVaZHJqltFi5WwuH0tiwJymfX1Eq9ujd1nBEWD7tFe8ou+Frc/i3j4
         dFVw/52mfg6/vHhA/wxV+o1rNgkdGnJraIz9cchv+IEUddIbq8Xvt2WhreTyfCa3GIOT
         wIC4WBHvSXu/mKCP295M6r7ADAmTqTRY5pVm2dsLm7MjZbTvmWRQgXAwW1v9xXMxgTGU
         EBrA==
X-Gm-Message-State: ALoCoQmkS4E2NNvRV+nCjx5MKKmzrtsSZ9lLVFbxkXVoQLfKHw00bTDn9ZPfe1boEgmAMDTH0VZE92IgvGk+c+BtC375YnuWzA==
X-Received: by 10.194.176.170 with SMTP id cj10mr8089660wjc.165.1452841221817;
        Thu, 14 Jan 2016 23:00:21 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id f205sm1169733wme.4.2016.01.14.23.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jan 2016 23:00:20 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g20612a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284140>

Here is a new version of a patch series to improve the untracked cache
feature.

This v5 implements core.untrackedCache as a tristate config
variable. When it's `true`, Git commands, especially `git status`,
should always add the untracked cache and use it, and when `false`,
Git commands should remove it. The default is `keep` in which case the
untracked cache is neither removed nor added, and used if it is there.

Patch 1/11 is a small bugfix that has not changed.

Patch 2/11 to 4/11 add some small features that are missing. There are
no changes compared to v4.

Patchs 5/11 to 7/11 are some refactoring to prepare for the following
patchs. The interface of the new functions has changed as they are now
passed a "struct index_state *istate" parameter on which they will
operate instead of modifying "the_index".

Patch 8/11 deals with the "ident" field in "struct
untracked_cache". Following Torsten and Junio's suggestions, the
differences compared to v4 are the following:

	- we store only the kernel "sysname" and not the full kernel version,
	- we match the full "ident" string instead of just the beginning of the string,
	- a warning has been improved.

Patch 9/11 adds core.untrackedCache. Following Junio's suggestions, it
has been changed compared to v4 in the following ways:

  - we don't die() and we exit 0, if "git update-index
  --[no-|force-]untracked-cache" is used in a way that goes against
  the value of core.untrackedCache,

  - we add or remove the untracked cache in read_index_from() instead
    of wt_status_collect_untracked().

Patch 10/11 is a new hack that is needed to have
test-dump-untracked-cache work like it used to, now that we add or
remove the untracked cache in read_index_from(). Because
test-dump-untracked-cache indirectly calls read_index_from(), we have
to prevent it from addind or removing the untracked cache.

Patch 11/11, which contains tests, has been changed to reflect changes
in 9/11.

So the changes compared to v4 are mostly small updates, and patchs
8/11, 9/11 and 10/11.

The patch series is also available there:

https://github.com/chriscool/git/tree/uc-notifs63

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
 cache.h                                |  3 ++
 config.c                               | 23 +++++++++
 contrib/completion/git-completion.bash |  1 +
 dir.c                                  | 62 ++++++++++++++++++-----
 dir.h                                  |  3 +-
 environment.c                          |  6 +++
 read-cache.c                           | 14 ++++++
 t/t7063-status-untracked-cache.sh      | 89 +++++++++++++++++++++++++++++++---
 test-dump-untracked-cache.c            |  2 +
 12 files changed, 287 insertions(+), 54 deletions(-)

-- 
2.7.0.36.g20612a7
