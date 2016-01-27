From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v8 00/11] Untracked cache improvements
Date: Wed, 27 Jan 2016 07:57:56 +0100
Message-ID: <1453877887-11586-1-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Jan 27 08:04:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOK9A-0002ie-VO
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 08:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbcA0HDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 02:03:43 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36053 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbcA0HDl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 02:03:41 -0500
Received: by mail-wm0-f52.google.com with SMTP id l65so132810582wmf.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 23:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=aVPZ2TZcOKAPlEPy8zJnrpJb8j1qPBpXWhP2Iz9vr2s=;
        b=hnYolc2tJD8MEPzg9l/GFUEnfY241AdpLDAuNHV0rhiPCXGCZNo3MaLvnbhhwBPcEN
         Va3lT10b5Jj7/LwwUqvVyNYNZWOOfJI9IbNqciaDzezXaHhtlgUUp+q60zHPZZg5Y+k0
         iXr3BeLLzuxyw66NJhia1PjrxuzopkH/ldoMYqul+tsvowgcvXRygt6KXqUDCdW4WP/6
         YozSON3BDoGhVgpuJikyvqA7QWSRbb4k9KUac+z8YlYk5aIR6zUzYdHgnBI+CnjtElBR
         OSxn8SHQfWPnvFrPYF8wauQa0DOfLAp68WaX7dBC1wQJ7Y4itch0oi4fkpbEhCmEpLyN
         9n7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=aVPZ2TZcOKAPlEPy8zJnrpJb8j1qPBpXWhP2Iz9vr2s=;
        b=Ktb8pVtj8GFYltFHCnzubW2/kLZXBCRlups30O2YK+g4vrWElBJ21QPjCSSRwiqDE5
         /DRbNzLDFo15pzPqEF0elRQlurhbDNsFtXgJ6rUTzf/pcuX7KptH2uAOtBYf3eQpnABG
         V5J1GCYqo5fAzMq++2WByl8FtrStXAivRGz2+fEw62mxY+ptcg4xi6kcOjHQcCVDHkR9
         UOJO+KQamkZjBJuQ/2SEnwARyyARhN6YoZvBm09yZmkoxmmVLNcqvLL0JYsVJJVyHqPF
         5HOs/fcYpr3GlvZKJ5dqINg/bcvN2l+/N8awwEYvQ+rJ1wG+YXmd36hO6grVNnhlT3v4
         o8Eg==
X-Gm-Message-State: AG10YOTJYH15D9I+0b9ud4M4w6A7q1azdNAqrq/JYDQXLsP9JXii3duvIhSENqwDGihXXg==
X-Received: by 10.28.144.10 with SMTP id s10mr27138155wmd.97.1453878219919;
        Tue, 26 Jan 2016 23:03:39 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 75sm6737569wmo.22.2016.01.26.23.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jan 2016 23:03:38 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.181.g07d31f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284878>

Here is a new version of a patch series to improve the untracked cache
feature.

This v8 implements core.untrackedCache as a tristate config
variable. When it's `true`, Git commands, especially `git status`,
should always add the untracked cache and use it, and when `false`,
Git commands should remove it. The default is `keep` in which case the
untracked cache is neither removed nor added, and used if it is there.

This v8 is mostly identical to the previous v7. Only patch 9/11, which
adds core.untrackedCache, has one change.

Patch 1/11 is a small bugfix.

Patch 2/11 to 4/11 add some small features that are missing.

Patchs 5/11 to 7/11 are some refactoring to prepare for the following
patchs.

Patch 8/11 deals with the "ident" field in "struct untracked_cache".

Patch 9/11 adds core.untrackedCache. As Junio suggested, the check to
see if we should add or remove the untracked cache is now made inside
a new tweak_untracked_cache() function which is called by the new
post_read_index_from() function after it calls check_ce_order().

Patch 10/11 is a hack that is needed to have test-dump-untracked-cache
work like it used to.

Patch 11/11 contains tests.

The patch series is also available there:

https://github.com/chriscool/git/tree/uc-notifs71

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
 read-cache.c                           | 27 ++++++++++-
 t/t7063-status-untracked-cache.sh      | 89 +++++++++++++++++++++++++++++++---
 test-dump-untracked-cache.c            |  4 ++
 12 files changed, 307 insertions(+), 56 deletions(-)

-- 
2.7.0.181.g07d31f8
