From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 00/11] Untracked cache improvements
Date: Wed, 20 Jan 2016 10:59:33 +0100
Message-ID: <1453283984-8979-1-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Wed Jan 20 11:06:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLpeW-0007o9-HJ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 11:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933648AbcATKGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2016 05:06:07 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36839 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934365AbcATKGB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 05:06:01 -0500
Received: by mail-wm0-f44.google.com with SMTP id l65so172181158wmf.1
        for <git@vger.kernel.org>; Wed, 20 Jan 2016 02:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=jXeohH7y6vcmcuujH+NrqjSuOznHZErieKNBDFq9zvw=;
        b=dObQL8NVOuTChgR9yN6+tL0N2D3F9Uye4lC/ntsD8+9j0D4/ytfk43K5xtsMXOnOPa
         JPd4Qd0qOea/+qeZ6L1nzFC8fVBBDl8hgK8H1sNa8j6BY8nZtfkCZ0S3WS4Zq84GkE+W
         kgGH0Yhcm8ND79YnMqpFZjtFwGbxJtV3HI7dFpyWCdhsBZgI5i2dL/n55DQzpCWR2ckr
         0VXfLQixm84MdgQ5q84YIPbyH9qfATGOsqDNLJhjFX9D4tUFA40pb21OSkPHl8gt8il/
         SltqDCDaqrN8Qa9nD7tiFX5MCbYxrpIyCcSC9gKqp2z8rtKfR2bP75XqyjM/C/Rx0HBA
         70fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=jXeohH7y6vcmcuujH+NrqjSuOznHZErieKNBDFq9zvw=;
        b=UsvKdik1UZ7M0DWGkvxAsyHOfJxsT2hhPha1V4EZRnOUKtbaKSx7QyBYXM+tQuCN/G
         MR0+FT4HbQWkZztD/Y9v+RNXeRW1Couq4iJTRCsv5hGYp7kc/3v20yXk9Xuj+zdLLV5n
         SsxWfPPOju8ZayB8Ns1LHtTZpxd7eizdOFDUIzlpsBpXUEA3QwDgN6MRL5V+9KvwoDNm
         4T28RiAHdGQRE1o3vuOVB+F1PWtWdj1hdAX5aAs0ewnp9N2/2KOQn35LhOYEUHzJfrgw
         giNwCRelIPjMDbkeSV3EyToBl25j5GM4ns9O+UA/nGy3J4SN1XxSWImsKMjxHIPoGuf3
         1VnA==
X-Gm-Message-State: ALoCoQkbWBfscWvY0GpSNBiJinsLq//WW+42NtS/wI+ZtUzObomE8VOIb85NoUWXBkVg0z/62zxvlU3rboyTZ+vRckhuj3Ngcg==
X-Received: by 10.194.21.101 with SMTP id u5mr41414343wje.53.1453284360280;
        Wed, 20 Jan 2016 02:06:00 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id x6sm32305613wje.38.2016.01.20.02.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 02:05:58 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g6be5eef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284435>

Here is a new version of a patch series to improve the untracked cache
feature.

This v6 implements core.untrackedCache as a tristate config
variable. When it's `true`, Git commands, especially `git status`,
should always add the untracked cache and use it, and when `false`,
Git commands should remove it. The default is `keep` in which case the
untracked cache is neither removed nor added, and used if it is there.

Patch 1/11 is a small bugfix that has not changed.

Patch 2/11 to 4/11 add some small features that are missing. There are
no changes since v5.

Patchs 5/11 to 7/11 are some refactoring to prepare for the following
patchs. Also no changes here.

Patch 8/11 deals with the "ident" field in "struct untracked_cache". I
rewrote a bit the commit message following some of Torsten's
suggestions.

Patch 9/11 adds core.untrackedCache and only has commit message
changes and a bit of document changes thanks to Junio compared to v5.

Patch 10/11 is a hack that is needed to have test-dump-untracked-cache
work like it used to. I added some comments in the code following
Junio's suggestion.

Patch 11/11, which contains tests, has been changed to improve the
name of a file that contains the expected output.

So the changes compared to v5 are mostly small updates.

The patch series is also available there:

https://github.com/chriscool/git/tree/uc-notifs65

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
 read-cache.c                           | 14 ++++++
 t/t7063-status-untracked-cache.sh      | 89 +++++++++++++++++++++++++++++++---
 test-dump-untracked-cache.c            |  4 ++
 12 files changed, 296 insertions(+), 54 deletions(-)

-- 
2.7.0.36.g6be5eef
