From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/2] Persistent submodule pathspec specification
Date: Mon, 23 May 2016 19:24:50 -0700
Message-ID: <20160524022452.12465-1-sbeller@google.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue May 24 04:25:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b521l-000617-72
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 04:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbcEXCY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 22:24:56 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33430 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbcEXCY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 22:24:56 -0400
Received: by mail-pf0-f178.google.com with SMTP id b124so1581470pfb.0
        for <git@vger.kernel.org>; Mon, 23 May 2016 19:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=VaDBlXN/FcwZqDs/KcNS18cwrQdLQynxY5s4w1heF1g=;
        b=JUrniDGtBWp7tuJJkRpnDiNxY8ycch2fawlq/AiVQgu0ZVAX9NjXreXXgiXQApXi8+
         biu2Ud7vA9KzrwhTX88F+QuhXRp7i6qqePfAewuD93ljRJoH94QzFZ8GGBKwuMlkxDnv
         ITu+Fv+FibCTo7XC+V62b0DRmsUQpQpr75aLmOzOMzxObuSN2YItcPPUxPGweaYPi3cf
         dIUpPW8E+QtxuMXrDY9cfAI4NZiYf/MRYyPGk9yh59qPGaPQ3rfGWW3J0YtOf/bB4wTi
         euxHWyuMcc9eraH8hmZ0uGQUt5QzMm96zdBajduSiyKnQpJ1HNgegDegFQjPbZQXy93V
         4+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VaDBlXN/FcwZqDs/KcNS18cwrQdLQynxY5s4w1heF1g=;
        b=hM7DwJlRUYkjkCMNyvct9eslxJ5w7Dx4juuL2Bcq4P7dFd+684OA9hUiGrq+BxM5yV
         73DYMrb0CpmPhsRQp4vMdcBMHsOrcswkHi2X2Db6CCI5SYZG71pp8SFYYm8gaQGDan60
         1p+Vh0NFqe7DMENFs0+e9tSIL6Nyl+TH+CarNv2wEUyQqKpC4cREb32y7EBIpEA/DpGt
         okUZ12ZXqrxK8GBr0w0NDzXLYhshyvo8bTXA9WuGuTnXvCuFGC70UhZVutKGajvb7VBX
         IGAh6/Y4LOgApOAqDjz518KGuSk9d91SUSO6+aI//P7SkaBDYqFrCDuV/MOkxmXL+tNz
         ZRpw==
X-Gm-Message-State: ALyK8tK8CswSghqVBHWdkLSPdzNUdMOSffirTJ12qr/fzoS9kndZdPtvX7D729yL2UnaTcIQ
X-Received: by 10.98.28.84 with SMTP id c81mr2962451pfc.131.1464056695226;
        Mon, 23 May 2016 19:24:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b01c:2aab:4009:2175])
        by smtp.gmail.com with ESMTPSA id c82sm9365438pfd.42.2016.05.23.19.24.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 23 May 2016 19:24:54 -0700 (PDT)
X-Mailer: git-send-email 2.8.3.397.g0b71a98
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295413>

Changes since v1:
 * fixed a broken && chain in a subshell for testing, as pointed out by Eric!

This was part of the former series 'submodule groups'.
However the labeling was ripped out and goes in its own series
sb/pathspec-label.

First we introduce a switch `--init-default-path` for `git submodule update`
which will read the pathspec to initialize the submodules not from the command
line but from `submodule.defaultUpdatePath`, which can be configured permanently.

The second patch utilizes this by having `clone` set that config option
and using that new option when calling to update the submodules.

Thanks,
Stefan

Stefan Beller (2):
  submodule update: add `--init-default-path` switch
  clone: add --init-submodule=<pathspec> switch

 6 files changed, 216 insertions(+), 14 deletions(-)
 Documentation/config.txt        |   5 ++
 Documentation/git-clone.txt     |  25 +++++---
 Documentation/git-submodule.txt |  11 +++-
 builtin/clone.c                 |  34 +++++++++-
 git-submodule.sh                |  21 ++++++-
 t/t7400-submodule-basic.sh      | 134 ++++++++++++++++++++++++++++++++++++++++

-- 
2.8.3.396.g0eed146
