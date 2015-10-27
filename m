From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/9] Expose the submodule parallelism to the user
Date: Tue, 27 Oct 2015 11:15:44 -0700
Message-ID: <1445969753-418-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 19:17:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr8oH-00047S-3x
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 19:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbbJ0SRE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 14:17:04 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36030 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964988AbbJ0SQB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 14:16:01 -0400
Received: by pacfv9 with SMTP id fv9so239720252pac.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=T5eaUIDlW4prxSler9EFBIKxeztj0J3P9qrhZwoZrq4=;
        b=NcjQ46+9lY1skbwcEY/Xnbx+WDZH/wO7qPZO9n6rCFt+k2JXROW4BUIhsDexAGCBec
         zcqQrJXh/5vyzvTZ3EMFDldXq683Elq6lcQGiMVNC+1hgZDljx0+FlHHm23IqAazD2+S
         G+9ILWJ3/PP+u3+3lxuwZf3WJ98goVPxB9VFoKoqnsXcf1ZHlC4+38ueKPOiuNiI7dhd
         1tOcoDoIgLuYUZhFC50OYaU4XrBEogGo7Vay3Ob65hGO+kLCdhDdZmY8zOuJnmj/y5yd
         5kE/JbVEg+Hi3QRVxQQn0ZxHZE15/YS+LesxhNxgcYJzeE2IPmI1KwqG0RpyiUQQKt8c
         AWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T5eaUIDlW4prxSler9EFBIKxeztj0J3P9qrhZwoZrq4=;
        b=NQzUXuXAZfy8lUBdHrJ8hfxg1lSy8kqWGPDMqw8uGdlGAM3woi0q8Xa6cnUSpB7/2L
         cBqDup9Z/bQxXq1AYEG7r/3bwxjGrHf2bjyJEPM7aI4wL0CVDsL4+oMP81IYiCpjmq8I
         qSaBYOyog0YBRbfiMEsn09Fw0CScB5/MgjwBIfOqN6ihLAGvXEgnnlWpj6Zj25XcO4lx
         9Kr4odqyl+1yKZK51MUrnenrUQYId2gQ00SJd32qc7it4TnvTss10Y9NQRqp4SjEbaA9
         V3ThCOl4VPg2e/LUukRUAPoeixjg2Nc/ZX4Zek8ZLdx4zoMz1dqY7ZPzlNsuzHWc6dLU
         V+sw==
X-Gm-Message-State: ALoCoQmJeHnK7Dt5pGhQeRhFTiQR6CPKaqEllKrMy+Nr0aGAXoHk2OqpYUuIUEiQ2Bgv5ssf4u4f
X-Received: by 10.68.90.3 with SMTP id bs3mr3619733pbb.49.1445969760828;
        Tue, 27 Oct 2015 11:16:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:582c:77b:3135:2d26])
        by smtp.gmail.com with ESMTPSA id hl2sm15462011pbb.58.2015.10.27.11.15.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 11:16:00 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.283.g1a79c94.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280284>

Where does it apply?
---
This applies on 376d400f4c (run-command: fix missing output from late callbacks,
which is the latest commit in origin/sb/submodule-parallel-fetch which was
merged to origin/next)
The first patch is a duplicate of origin/sb/submodule-config-parse, so
it may make sense to drop the first patch and apply this series on top of a
merge of 376d400f4c and origin/sb/submodule-config-parse.

I realize sending refactorings in the area you'd be likely to touch as 
a separate patch (series) is not necessarily a good idea as it leads to
situations like this.

What does it do?
---
This series should finish the on going efforts of parallelizing
submodule network traffic. The patches contain tests for clone,
fetch and submodule update to use the actual parallelism both via
command line as well as a configured option. I decided to go with
"submodule.jobs" for all three for now.

Detailed breakdown of the patches
---

Patch 1 is a duplicate of origin/sb/submodule-config-parse and may make
merging with that easier.

Patch 2 adds the update strategy to the struct submodule, which is required in
patch 4.

Patch 3 adds rudimentary tracing output to the parallel processing commands.

Patch 4 rewrites parts of "git submodule update" in C, such that the cloning
is done from within the parallel processing engine. 

Patch 5 however exposes the possible parallelism of patch 4 to the user.
(doc + tests)

Patch 6 adds the parallel feature to clone, which just invokes "submodule update"
internally.

Patch 7 is a small refactoring preparing patch 8 to smoothly parse submodules.jobs.

Patch 9 teaches fetch to respect the desired parallelism both from command line
as well as the config option.

Thanks,
Stefan

Stefan Beller (9):
  submodule-config: "goto" removal in parse_config()
  submodule config: keep update strategy around
  run_processes_parallel: Add output to tracing messages
  git submodule update: have a dedicated helper for cloning
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones
  submodule config: remove name_and_item_from_var
  submodule-config: parse_config
  fetching submodules: Respect `submodule.jobs` config option

 Documentation/config.txt        |   7 ++
 Documentation/git-clone.txt     |   5 +-
 Documentation/git-submodule.txt |   6 +-
 builtin/clone.c                 |  26 ++++-
 builtin/fetch.c                 |   2 +-
 builtin/submodule--helper.c     | 243 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  54 ++++-----
 run-command.c                   |   4 +
 submodule-config.c              | 166 ++++++++++++++-------------
 submodule-config.h              |   3 +
 submodule.c                     |   5 +
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 14 files changed, 444 insertions(+), 122 deletions(-)

-- 
2.5.0.283.g1a79c94.dirty
