From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/6] Fix path bugs in submodule commands executed from sub dir
Date: Tue, 29 Mar 2016 16:02:32 -0700
Message-ID: <1459292558-5840-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 30 01:02:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al2ex-0000Sj-JK
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 01:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbcC2XCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 19:02:46 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35491 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295AbcC2XCp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 19:02:45 -0400
Received: by mail-pa0-f42.google.com with SMTP id td3so24681543pab.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 16:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2ZHsJSiXrPOmvF54JGkjEHgkxOo8cEFPSd2GyLNr/fY=;
        b=jSJkN7edYL1kqc/kfTIjSgWFxgaQnHPMfgnP50+T6AYVTvhlZk0vzkFr7fL+S43B6e
         CrNC5nTLZyS/tSPmC1gzMSuZb9LcIzknYPp34pL8neiMGIz6VO4/EQQbPd3XNhAI95vw
         enJ2U8Ox/Kkw4VvxQ/T3qJuOvB96clJqN9vnz3pZhkyGMYMYzvbPNqiJgLDdd38qbZA5
         Tyddv4x4hMqUC1s+tfCKPwhWLVKxm23os79Bqc+sNa0Qy0/9wCjeS4ZdHceTOgpo0oEC
         ONRVr57a7MquTtb7V3ZSQ/Qur9PXGsRzJlU3uFMn9buCQY4QNUkjS82PFqCKZhNl7Xb7
         F9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2ZHsJSiXrPOmvF54JGkjEHgkxOo8cEFPSd2GyLNr/fY=;
        b=KtjUuImW98AYoLDMGx4xfPfJx7HN10JoLr3GXU8mfRxZ4Sxt9+e3PUztaGYtbf/mrC
         odC3YsmQOIj1PVOQMb+WJMDAytFFt+78MrkfOidLALq98lmmw+q7W+u8Qgkc5DO82bLl
         95zZv9hGm9XsqxmIUhn+p39Tnt/wiqQ+NoU8PT3+2rcQbUTx+F2Se/N2McWjeSLwYZiA
         5OylsEVKGSNsfeB+P7GqJRUjYhHEyZH27qlq/ESqJ0efEVM7aIpbB2mYQO/gQI9wQYp0
         brPtBUboVaoD4MmR6J98BLWT9uJ89A8CjiaS48Npi8nYLBGwa3YDcrrLVAtpZ5r4spZL
         uC9w==
X-Gm-Message-State: AD7BkJLXLvS3KELy9g+nVOdlN6hOdsfAPDcUDyN7s/ooSq0fdcQLLQI8rI/h20ADW3w2cPLw
X-Received: by 10.66.249.228 with SMTP id yx4mr7583566pac.29.1459292564713;
        Tue, 29 Mar 2016 16:02:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3dd0:2ad7:f302:a06])
        by smtp.gmail.com with ESMTPSA id 87sm723942pfq.93.2016.03.29.16.02.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 16:02:44 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.6.g3d0b0ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290213>

v3:
Resending without `test_pause` in the last test.

v2:
The first 3 commits are
* Test and bugfix in one commit each
* better explained than before

The expansion of an expected test result moved to the back of the series.

There are two new commits
* one being another bugfix of the display path for `submodule update`
* another test for `submodule update` as I suspect it may break further on
  refactoring and we currently have no tests for it.

Thanks,
Stefan

Stefan Beller (6):
  submodule foreach: correct path display in recursive submodules
  submodule update --init: correct path handling in recursive submodules
  submodule status: correct path handling in recursive submodules
  t7407: make expectation as clear as possible
  submodule update: align reporting path for custom command execution
  submodule update: test recursive path reporting from subdirectory

 git-submodule.sh             | 10 +++---
 t/t7406-submodule-update.sh  | 83 ++++++++++++++++++++++++++++++++++++++++++--
 t/t7407-submodule-foreach.sh | 49 ++++++++++++++++++++++++--
 3 files changed, 133 insertions(+), 9 deletions(-)

-- 
2.8.0.4.g5639dee.dirty
