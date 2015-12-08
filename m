From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/8] Untracked cache improvements
Date: Tue,  8 Dec 2015 18:15:08 +0100
Message-ID: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 18:15:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6LrZ-0005yi-Ce
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 18:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbbLHRPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2015 12:15:37 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36038 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbbLHRPg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2015 12:15:36 -0500
Received: by wmww144 with SMTP id w144so189558287wmw.1
        for <git@vger.kernel.org>; Tue, 08 Dec 2015 09:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ujTcA82KqXWuxfvgF0uaVrSopIuVfzwL4WmUYNlcdgc=;
        b=RFXEaBh0YHKWlcSRdhmRF3sd8Ugc3Sj0teK1rlWXx4fQqx5SOll9lB5b4EftJdUAqr
         FcymF4dVLc/oJBtd0/luIGymOUoB1fyAQy+rkQgdCMJ2c1u7B8HUbXZGTNIHI18jtwM9
         Ez/ZTaixoIvhdYOCwy8GvngtLleT751Z6YnJXXTZA/edEd1XAvpDKH6Yz737gZ66Yu4m
         KwH3a4wPYHVBDbkltJPlCRvTo/BWENX8ri1nOMi57rxfjTLvrBNsKmbXKL2pUuXcADb2
         91IuOhriI2QDqQzXN7PT+mIuDoBkDYLjVNJVDmYLKDkk8OmsnBPF2FNcUSbM4vdrvA/w
         oOAg==
X-Received: by 10.28.232.136 with SMTP id f8mr30936936wmi.1.1449594935233;
        Tue, 08 Dec 2015 09:15:35 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 200sm4332517wmn.11.2015.12.08.09.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Dec 2015 09:15:33 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.478.g9f95483.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282158>

Following the previous RFC version of this patch series and the
related discussions, here is a new version that tries to improve the
untracked cache feature.

This patch series implements core.untrackedCache as a bool config
variable. When it's true git should always try to use the untracked
cache, and when false git should never use it.

Patchs 1/8 and 3/8 add some features that are missing.

Patch 2/8, which is new, adds an enum as suggested by Duy.

Patchs 4/8, 5/8 and 6/8 are some refactoring to prepare for patch 7/8
which implements core.untrackedCache.

Patch 7/8 is the result of squashing the last 3 patches of the RFC
series. As discussed this sacrifies backward compatibility for a
simpler interface.

Patch 8/8, which is new, add some tests.

So the changes compared to the RFC version are just small bug fixes
and patchs 2/8 and 8/8.

The patch series is also available there:

https://github.com/chriscool/git/tree/uc-notifs14

Christian Couder (8):
  update-index: add untracked cache notifications
  update-index: use enum for untracked cache options
  update-index: add --test-untracked-cache
  update-index: move 'uc' var declaration
  dir: add add_untracked_cache()
  dir: add remove_untracked_cache()
  config: add core.untrackedCache
  t7063: add tests for core.untrackedCache

 Documentation/config.txt               |  7 +++++
 Documentation/git-update-index.txt     | 31 ++++++++++++++------
 builtin/update-index.c                 | 52 +++++++++++++++++++---------------
 cache.h                                |  1 +
 config.c                               |  4 +++
 contrib/completion/git-completion.bash |  1 +
 dir.c                                  | 22 +++++++++++++-
 dir.h                                  |  2 ++
 environment.c                          |  1 +
 t/t7063-status-untracked-cache.sh      | 52 ++++++++++++++++++++++++++++++----
 wt-status.c                            |  9 ++++++
 11 files changed, 145 insertions(+), 37 deletions(-)

-- 
2.6.3.478.g9f95483.dirty
