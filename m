From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 00/10] fetch submodules in parallel and a preview on parallel "submodule update"
Date: Wed, 16 Sep 2015 18:38:58 -0700
Message-ID: <1442453948-9885-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 03:39:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcOAT-0005uk-4Z
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 03:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbbIQBjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 21:39:15 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34343 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbbIQBjN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 21:39:13 -0400
Received: by padhy16 with SMTP id hy16so4687270pad.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 18:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VefuABO5X1FFZRvK+xj3d8fLJ9X4nV/pid9RZRq5/Ok=;
        b=nDbTmbKQlHf+saHqUx59FydBCpjRIa+ZWO9EYHBvyCQd7i2y41evHnoz14vRN+0a5T
         EVq4UMGhCs97bwaYIt7ESnYoa9Te46BYemZIBdxVCi+7/14snh8Mm29Ol7eME0C+k2z7
         poC5zC/eNNut5CqsuMv3hqoUWZAxntiBQVtI1KU432bTv4pM73iHJ7tM4/N49Cc6t8kg
         wJGzhbQjR96cZ/PwrphiZR8pMuyUVsVKYPI+jJK/WRJySRfcTRgG8x3ZqhJzSmg/RIua
         JUBD1Xzk3xcxdV8/1CwBj7AQZUkWM/rr/HniKTWLX9NmhUQ5HimS/4DuFXg8OJw1P/Bi
         cFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VefuABO5X1FFZRvK+xj3d8fLJ9X4nV/pid9RZRq5/Ok=;
        b=J/He+iDogMTE0wJfGOVK8Iph9lnJ2TRDkclnKrXzzgjjaUe40+eOvn9q9aU89KfTVo
         rSZHKbNwsi4yYNYXYQgf87MjZkS1mDnLdVbt4MlbByJnXye+E2Tun+Hc9Xgh7g5qIILJ
         AXvfQa62hzcfI2mgX7H2QeRuM+27Z6gb4XUnyYA30vbAddZkHfy6hzut9o7PfkWnII23
         gFP+fZWiaWgmn8put+77Tppe5ogJI998PxvxdQidX2+rpTskOdPy3KN57MSWru2uaiCC
         LnUWwm/SUeH2PMoTYo+AtRFE7x8g0D1TGJT+lFcaEwPPBrxtT7OHqRocgbzO/YoHgauv
         YPlw==
X-Gm-Message-State: ALoCoQngpXsuulKod1MEWTOnSe1iKpIabkSloDis/+D6aifPh8weu6bAApmx5pgKZ4/4pBvIszi6
X-Received: by 10.68.181.130 with SMTP id dw2mr64767323pbc.70.1442453952902;
        Wed, 16 Sep 2015 18:39:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bde9:6711:470f:789])
        by smtp.gmail.com with ESMTPSA id ey3sm574692pbd.28.2015.09.16.18.39.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 18:39:12 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.131.gf624c3d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278093>

> I didn't say this in the previous round because it smelled like an
> RFC, but for a real submission, 2/2 may be doing too many things at
> once.  I suspect this is more or less "taste" thing, so I won't mind
> too much as long as the reviewers are OK with it.

The patch 2/2 is now broken up into the first five patches.

There are only 2 minor changes:
* If a number of tasks <= 0 is specified, use the number of cpus instead.
* Renamed the command line option in test-run-command.c to "run-command-parallel-4"
  as the 4 is hardcoded there.
  
The patch 6,7 are small cleanups (6 should add a test in a reroll)

Patches 7,8,9 are a preview of how I want to proceed in the near future:
After these functions are split out, we can add another patch on top which
rewrites the short main loop in cmd_update to be in C in submodule--helper
running in parallel.
It took me a while to get the idea how to realize parallelism with the
parallel run command structure now as opposed to the thread pool I proposed
earlier, but I think it will be straightforward from here.

Stefan

Stefan Beller (10):
  strbuf: Add strbuf_read_noblock
  run-command: factor out return value computation
  run-command: add an asynchronous parallel child processor
  fetch_populated_submodules: use new parallel job processing
  submodules: Allow parallel fetching, add tests and documentation
  git submodule update: Redirect any output to stderr
  git submodule update: pass --prefix only with a non empty prefix
  git submodule update: cmd_update_recursive
  git submodule update: cmd_update_recursive
  git submodule update: cmd_update_fetch

 Documentation/fetch-options.txt |   7 +
 builtin/fetch.c                 |   6 +-
 builtin/pull.c                  |   6 +
 git-submodule.sh                | 242 ++++++++++++++++++----------------
 run-command.c                   | 281 ++++++++++++++++++++++++++++++++++++----
 run-command.h                   |  36 +++++
 strbuf.c                        |  25 +++-
 strbuf.h                        |   6 +
 submodule.c                     | 119 ++++++++++++-----
 submodule.h                     |   2 +-
 t/t0061-run-command.sh          |  20 +++
 t/t5526-fetch-submodules.sh     |  19 +++
 test-run-command.c              |  24 ++++
 13 files changed, 620 insertions(+), 173 deletions(-)

-- 
2.6.0.rc0.131.gf624c3d
