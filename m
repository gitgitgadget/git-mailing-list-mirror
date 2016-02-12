From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv10 0/7] Expose submodule parallelism to the user
Date: Thu, 11 Feb 2016 18:03:05 -0800
Message-ID: <1455242592-19352-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>, dturner@twopensource.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 12 03:03:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU34x-0000l5-6E
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 03:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbcBLCDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 21:03:23 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36037 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbcBLCDV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 21:03:21 -0500
Received: by mail-pa0-f41.google.com with SMTP id yy13so38297177pab.3
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 18:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=oqzfivX2bf7uTwG+dfcVNl7uk1oQ4aS4ZkxVLdiiki4=;
        b=K6gvPK9Rwu5gTz2F8n4wIO8MsCwRCbNe6/Kfrfy1EANuzREaHIurLbZy0RIieSEk7G
         74NMs0oG79LMmh26V1GKWTywjWjM5POFnOLufAxucDSHAAeoMUfHa1pax9g39U9+vlIU
         1CDHvM24AkpbAFFS5bmz41X+7ZWtNS4fkkTAmDf6GP66yX1YMea3BUXtnmgW8iCxLAhl
         oHegRuFm+chxSI36khJkv9+XDUaH1dsBKHckFmqKCMAUXCeBH1Jnl7tYppghgZX/8v95
         3iuZwWJcitFXgTGVcmtr/L2NjtDvrJbYfZ2nkJCB9sNM5ONJWB6/jEbqhYYQFbKRB8rU
         bCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oqzfivX2bf7uTwG+dfcVNl7uk1oQ4aS4ZkxVLdiiki4=;
        b=IvIJK76wbgU5RBf9EfvRfdgxEE4Mw9Cia0AHZRcDTh0NNqHR0zoCr7G5MoxqzhbhjM
         jSukBe09H/+dNkC2GL4OVlao5awf85hZ+AbfNXuS73whSMY++pX8LnpEBtKN9IjzNIY4
         YCNd8Ic5dQJx0BLjGwmVIMMGdUYYY/xedYdfsLWlcndSwvrMhNqUDDYeDYgtfOH13QCi
         aZblAJqu0ikp50tcG3f2Bgip6O4RuYeeDn7fSKJv9dpdUGa1ah3vsqjE9WJ3fMg3gzfj
         1mw+0aon0FuI1Z6PcJsM5unQ/6e+wMOwpmkiW4OtxRC/xsEK3fmDViOksP1tS1Ab9gQn
         9HKw==
X-Gm-Message-State: AG10YOT3/Q8dJMajyD63kwbBhKAb35Un+AhlJUYjbwGmxMit0M9NwaoHabOSMouBGB/t/nLp
X-Received: by 10.66.55.106 with SMTP id r10mr56906484pap.133.1455242601148;
        Thu, 11 Feb 2016 18:03:21 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:994e:7471:3f:c285])
        by smtp.gmail.com with ESMTPSA id cq4sm15076243pad.28.2016.02.11.18.03.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Feb 2016 18:03:19 -0800 (PST)
X-Mailer: git-send-email 2.7.1.292.g18a4ced.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286029>


This replaces origin/sb/submodule-parallel-update
and is based on origin/master

* broke out the patch for redirecting errors to stderr in "submodule update"
  (Thanks Jonathan, Jacob)
* use git_config_int and manually check for less than 0.
  (Thanks Junio)
* use an enum consistently now for submodule update strategy
  (Thanks Junio)
* fixed the funny indentation

I haven't looked at how this integrates with Davids refs backend, I'll take a
look at the merge tomorrow

Sorry for the long turn around time,
Thanks,
Stefan


Stefan Beller (7):
  submodule-config: keep update strategy around
  submodule-config: drop check against NULL
  fetching submodules: respect `submodule.fetchJobs` config option
  submodule update: direct error message to stderr
  git submodule update: have a dedicated helper for cloning
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones

 Documentation/config.txt        |   6 +
 Documentation/git-clone.txt     |   6 +-
 Documentation/git-submodule.txt |   7 +-
 builtin/clone.c                 |  19 +++-
 builtin/fetch.c                 |   2 +-
 builtin/submodule--helper.c     | 244 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  54 ++++-----
 submodule-config.c              |  18 ++-
 submodule-config.h              |   2 +
 submodule.c                     |  35 +++++-
 submodule.h                     |  18 +++
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 14 files changed, 407 insertions(+), 49 deletions(-)

-- 
2.7.1.292.g18a4ced.dirty
