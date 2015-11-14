From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 0/9] Expose submodule parallelism to the user
Date: Fri, 13 Nov 2015 17:06:53 -0800
Message-ID: <1447463222-12589-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com, j6t@kdbg.org,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 14 02:07:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxPJk-0003nQ-7a
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 02:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbbKNBHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 20:07:16 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34463 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbbKNBHO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 20:07:14 -0500
Received: by padhx2 with SMTP id hx2so115651420pad.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 17:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=enP1DbwFGgKRlw29tFg76wQOJzmIufRBlTFU2VkNPNU=;
        b=Zzn26qE7McO2pB/lTy/eX1KMIm3iVW3lPs5sVdCvqKvaj7MjCq7BMnZ5oSGAWEYtt9
         O89dQWimu/IDLtgktZhOAcru7yMJHXZu4RH5tzPRxQDIkUAMaTZkgY7YAba04YrEWfNb
         s70yVkFDHO5PuElg/v5uoyxXAhnGAe9p9aivwqEsHafLHj4oswx7Q/q/HfRciH9HTEPE
         mig9RGm408jrQ37nTeQxXPOUSn9Clee2uihXPlBdq16AnxC+7vHeqIbEFtfdWVGyjzwE
         oL3AZte2XJZC4tWG52juvmSanLABK2vUCJG3vV7NUSSgVDWdsstRUVHEtW5b4w319JVy
         454Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=enP1DbwFGgKRlw29tFg76wQOJzmIufRBlTFU2VkNPNU=;
        b=hG3P45cyEVrNbWF+CzpP86gMGdCe8o/GTWopn2+tCekaNTZyr5a/3S1bnHoPlcNJQx
         fqija4o5Ol6sWULN4Qh8S5qK/a50Je8GTjHMWsQS1mh28mMFsX3jz4R878Tk7ybnwNOq
         pswv5Jy28yDK4gVReN1boPzgPr1vuuWRyCd6jxztrwevZVEWQweyMVumt5OzrNx7MH6s
         RTMKmeZ1EVv75rHozwIrqbJFmh+SPWtfRQrAT/FBHmjCJ4B8/nXwOL/aTTzGfOvgRNc/
         6q0H3R/+0E804jlVs1PsGXoH6m1RX6xFraWOsdRYrycvihaMOIlSANNlAoDGLBfO5yda
         cBSQ==
X-Gm-Message-State: ALoCoQmDTOcrB2PsE7M4R1cHwP0ThgtkxJLt5jx+uyCI1CGjyOoITe/arHMFYI4oVM0OYJzqJWPY
X-Received: by 10.66.124.135 with SMTP id mi7mr36904450pab.102.1447463233644;
        Fri, 13 Nov 2015 17:07:13 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:f5eb:b7b9:3afa:a95c])
        by smtp.gmail.com with ESMTPSA id bp2sm22646405pbc.46.2015.11.13.17.07.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Nov 2015 17:07:12 -0800 (PST)
X-Mailer: git-send-email 2.6.3.369.gea52ac0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281299>

This replaces sb/submodule-parallel-update.
It applies on top of d075d2604c0 (Merge branch
'rs/daemon-plug-child-leak' into sb/submodule-parallel-update,
with additionally having merged submodule-parallel-fetch,
which has applied "run-command: detect finished
children by closed pipe rather than waitpid" on top of it.
Alternatively pull from github/stefanbeller/git submodule-parallel-update

* This lets you configure submodule.fetchJobs instead of previously submodule.jobs
* no weird NONBLOCK thingies any more as that was handled by submodule-parallel-fetch
  (or the patch on top of that) 


Stefan Beller (9):
  run_processes_parallel: delimit intermixed task output
  submodule-config: keep update strategy around
  submodule-config: drop check against NULL
  submodule-config: remove name_and_item_from_var
  submodule-config: introduce parse_generic_submodule_config
  fetching submodules: respect `submodule.jobs` config option
  git submodule update: have a dedicated helper for cloning
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones

 Documentation/config.txt        |   7 ++
 Documentation/git-clone.txt     |   6 +-
 Documentation/git-submodule.txt |   7 +-
 builtin/clone.c                 |  19 +++-
 builtin/fetch.c                 |   2 +-
 builtin/submodule--helper.c     | 239 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  54 ++++-----
 run-command.c                   |   4 +
 submodule-config.c              | 109 +++++++++++-------
 submodule-config.h              |   3 +
 submodule.c                     |   5 +
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 14 files changed, 417 insertions(+), 83 deletions(-)

-- 
2.6.3.369.gea52ac0
