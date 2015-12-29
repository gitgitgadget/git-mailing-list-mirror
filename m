From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 00/10] Untracked cache improvements
Date: Tue, 29 Dec 2015 08:09:24 +0100
Message-ID: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue Dec 29 08:12:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDoSa-0008Ky-2O
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbbL2HMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:12:00 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37640 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbbL2HL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:11:59 -0500
Received: by mail-wm0-f53.google.com with SMTP id f206so31405603wmf.0
        for <git@vger.kernel.org>; Mon, 28 Dec 2015 23:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=Cl1/o1tB2avK4OuYqV4oqvZ2PDc+h75MlcxGq9l99ac=;
        b=N+72tKNry2lNgVNxaxuZntJKmQPoRQnT4XOTSZKcnJFm6frZAXgmnqsyjoMpRn9ZDn
         BhOLAxzW5w+a/49JkTco+oxKuBWKG0IYSuTL3LDnFiSWX2PVS8NKBUtxdWu8C4UwK3Cw
         sf3+0sGzZjB+Dq1/9HjOZAnEQgWp+rKjKbkluNngY2+ykpdfmaXhwljBYW0zlPeQS4f1
         POYXOFVGDTWAsTWfNmHmM+sPl9MPmDZpf3Qo9RfAk0wj2teezLHOwCvLTljTMSw9pRZZ
         WJEVs0mKc9Kr6VY2kMSSBy3KO3TKrLWyLbAL8nR7be/pRQ4Egy9BW8lQusriinNkOyyI
         OChg==
X-Received: by 10.194.59.108 with SMTP id y12mr63145530wjq.33.1451373117636;
        Mon, 28 Dec 2015 23:11:57 -0800 (PST)
Received: from localhost.localdomain (243.40.126.78.rev.sfr.net. [78.126.40.243])
        by smtp.gmail.com with ESMTPSA id uw6sm59795661wjc.42.2015.12.28.23.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Dec 2015 23:11:56 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.10.g544ad6b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283080>

Here is a new version of a patch series to improve the untracked cache
feature.

This v4 implements core.untrackedCache as a tristate config
variable. When it's `true`, Git commands, especially `git status`,
should always add the untracked cache and use it, and when `false`,
Git commands should remove it. The default though is now `keep` in
which case the untracked cache is neither removed nor added, and used
if it is there.

Patch 1/10 is a small bugfix that has not changed since v3.

Patch 2/10 to 4/10 add some small features that are missing. The only
chqnge there since v3 is that we are now using `report()` to display
verbose information, thanks to Duy.

Patchs 5/10 to 7/10 are some refactoring to prepare for the following
patchs. Among them 6/10 is the result of merging two patchs from v3,
thanks to Eric.

Patch 8/10 deals with the "ident" field in "struct untracked_cache"
and is mostly the same as in v3. The difference is just a small bug
fix to prevent a crash.

Patch 9/10 adds core.untrackedCache. It has been changed compared to
v3 in the following ways:
  - the config variable is now a tristate, thanks to Junio,
  - we use `switch` to deal with different values, thanks to Torsten,
  - documentation for --test-untracked-cache is improved, thanks to
    David.

Patch 10/10, which contains tests, has been changed to reflect changes
in 9/10 and to add a few tests.

So the changes compared to v3 are mostly small updates, and patchs
6/10, 9/10 and 10/10.

The patch series is also available there:

https://github.com/chriscool/git/tree/uc-notifs40

Thanks to the reviewers and helpers.

Christian Couder (10):
  dir: free untracked cache when removing it
  update-index: use enum for untracked cache options
  update-index: add --test-untracked-cache
  update-index: add untracked cache notifications
  update-index: move 'uc' var declaration
  dir: add {new,add}_untracked_cache()
  dir: add remove_untracked_cache()
  dir: simplify untracked cache "ident" field
  config: add core.untrackedCache
  t7063: add tests for core.untrackedCache

 Documentation/config.txt               |  7 +++
 Documentation/git-update-index.txt     | 65 +++++++++++++++++++++++-----
 builtin/update-index.c                 | 62 ++++++++++++++++----------
 cache.h                                |  1 +
 config.c                               | 11 +++++
 contrib/completion/git-completion.bash |  1 +
 dir.c                                  | 70 ++++++++++++++++++++++++------
 dir.h                                  |  2 +
 environment.c                          |  1 +
 t/t7063-status-untracked-cache.sh      | 79 +++++++++++++++++++++++++++++++---
 wt-status.c                            | 13 ++++++
 11 files changed, 260 insertions(+), 52 deletions(-)

-- 
2.7.0.rc2.10.g544ad6b
