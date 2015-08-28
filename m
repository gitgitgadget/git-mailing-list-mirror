From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/9] Progress with git submodule
Date: Thu, 27 Aug 2015 18:14:46 -0700
Message-ID: <1440724495-708-1-git-send-email-sbeller@google.com>
Cc: peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 28 03:15:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV8GZ-0000wZ-3U
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 03:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbbH1BPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 21:15:04 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36212 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbbH1BPB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 21:15:01 -0400
Received: by pacgr6 with SMTP id gr6so6672913pac.3
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 18:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fiEgY6bP9TuCdftKXMWEMLyqtyqbMDbqQ8XY2rs4bbk=;
        b=UhScAO3f6bCG+xmpjEvhMOzuiYWCP02izYRPmRZoVWLjd16tZv5RLroqcxEM/YUPL/
         I778mvW91Vz2or4JCKIiQTcWb12Jwc1Zt2Jj2hH7+dU9UOdzU8lUuG9Pmw9Bzi+aMOui
         JsmY09l4zTHxcItkD8BN3Av5pSuaCZ7ELQesvMIvg6UQ1qX4mFe+jXa7tMucd9bV/Qbb
         O3W2RbOVSJzKC3NuL4Ol6/rXSKeMlso7sGIF+AFHEzisL8bjSJnzajPydrtE8ii8Isin
         bTtqdcvMNL6AwamJrJzITApXALg5L5yX9e9ueKZ5zDwh3k8cgabDw4rvQzAg9AA3KZhU
         JGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fiEgY6bP9TuCdftKXMWEMLyqtyqbMDbqQ8XY2rs4bbk=;
        b=AwnYRo948NiHRK8NnRra0iZdw7OnzQHPrnGFsGrg1vkKcB4qJT0bO8Ams8F9zV67mB
         6w1OvzfKNpggSCprmTR/4WSOre1nILitqCp0qMGGwI1FVWhMnXvrxcSGpwAtRyrme1Jb
         Tc6f5QqPLNkaqDR8mI9KGa7pggfGa6jMH+KYO5ho+0v2boQgZvJM+9tAPZ5ljcN4HOsd
         BWcaaTVApbBNntBBCj71jGgdfNFpdYj6tpQ1e8GVPr5PAXQ0b0IX0NZYvkbHKzKCfl6K
         ouSnpbD97KB/tYXxef9gKFOvHVvRLU9KsLqMgPPX+0CqmNHAhlyBOzh8yIl0IlLUpVa2
         w3LQ==
X-Gm-Message-State: ALoCoQnANXLryF/HmtKa2w1ogd6KG2arHkDNd/lICai4UmLpYHuuWguk7thUogQTVNNZz2bNLo4O
X-Received: by 10.68.205.232 with SMTP id lj8mr11088339pbc.116.1440724499333;
        Thu, 27 Aug 2015 18:14:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bce4:8b21:c71b:de7e])
        by smtp.gmail.com with ESMTPSA id u1sm3729401pbz.56.2015.08.27.18.14.58
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 27 Aug 2015 18:14:58 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.264.g5e52b0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276696>

This series replaces origin/sb/submodule-helper and is based on
5a1ba6b48a62bf55f9c8305d9850c3a8d22365c5, (Merge 'hv/submodule-config' to
'sb/submodule-helper', which includes jk/git-path and hv/submodule-config)

What changed?
* The help text of the submodule--helper was adapted to our standard,
  and removed long line, outdated docs, thanks Dscho!
  
* The run-command API was extended to be able to sync the output from
  various commands running at the same time.
  (In the previous series this was a one-shot only solution cooked for
   git submodule foreach_parallel)
   
* `git fetch recurse-submodules` will fetch the submodules in parallel!

Any feedback welcome,
specially on patch 4..7

Thanks,
Stefan

Stefan Beller (9):
  submodule: implement `module_list` as a builtin helper
  submodule: implement `module_name` as a builtin helper
  submodule: implement `module_clone` as a builtin helper
  thread-utils: add a threaded task queue
  run-command: add synced output
  submodule: helper to run foreach in parallel
  fetch: fetch submodules in parallel
  index-pack: Use the new worker pool
  pack-objects: Use new worker pool

 .gitignore                      |   1 +
 Documentation/fetch-options.txt |   7 +
 Makefile                        |   1 +
 builtin.h                       |   1 +
 builtin/fetch.c                 |   6 +-
 builtin/index-pack.c            |  23 +--
 builtin/pack-objects.c          | 175 ++++++-----------
 builtin/pull.c                  |   6 +
 builtin/submodule--helper.c     | 417 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                | 177 +++--------------
 git.c                           |   1 +
 run-command.c                   |  99 ++++++++--
 run-command.h                   |  21 ++
 submodule.c                     | 100 ++++++++--
 submodule.h                     |   2 +-
 t/t7407-submodule-foreach.sh    |  11 ++
 thread-utils.c                  | 192 ++++++++++++++++++
 thread-utils.h                  |  35 ++++
 18 files changed, 960 insertions(+), 315 deletions(-)
 create mode 100644 builtin/submodule--helper.c

-- 
2.5.0.264.g5e52b0d
