From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 0/4] make pull.ff=true override merge.ff
Date: Wed, 13 May 2015 17:52:16 +0800
Message-ID: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>, David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:53:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsTLy-0004SS-VE
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462AbbEMJxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:53:18 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35067 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbbEMJxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:53:16 -0400
Received: by pabtp1 with SMTP id tp1so45578631pab.2
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iXwkw++6ppzwbAoYMQ33uxe5CzLcjALxlsJKEZ8Kfu4=;
        b=QWndQQp+R4gi1QKQ+cnZZvH13yL7/8EM4MyYHmwYVsibbFu3gf/AKRQ99VtH463z7e
         5NrbNFpfD/1oUjbLOsTjvh/H977j1vPfQEIkKirXCEdiCz1y2goyDBhEWDRPHnVHMaTZ
         WT4qMyU9IcbwqejyH00H2PHa1S/WDqyOwpg5u8Ov6dOcsfaToeJuLIaEuOedOGRqvvNt
         HaU6DFoCG30R/kbFz2HneO096fW3231eF53MMtgvw+RGp3YhCcVl3HxJPQDSBFIwmuM1
         NDSM+/ouxMBPNKiHl5eJryOK04uT6li7MMYAdnhsBILl7wEVH2r3zzghJRzK1LJYOi24
         VqbQ==
X-Received: by 10.68.246.133 with SMTP id xw5mr36327089pbc.116.1431510795820;
        Wed, 13 May 2015 02:53:15 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id k3sm18777927pdr.50.2015.05.13.02.52.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:52:36 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268972>

Since b814da8 (pull: add pull.ff configuration, 2014-01-15), running
git-pull with the configuration pull.ff=false or pull.ff=only is
equivalent to passing --no-ff and --ff-only to git-merge. However, if
pull.ff=true, no switch is passed to git-merge. This leads to the
confusing behavior where pull.ff=false or pull.ff=only is able to
override merge.ff, while pull.ff=true is unable to.

This patch series adds a failing test to demonstrates the above, and fixes it.

The documentation is also tweaked to clarify that pull.ff is meant to override
merge.ff.

The last patch makes pull.ff consistent with merge.ff by supporting the config
aliases of true and false (on, off, 0, 1).

Paul Tan (4):
  t7601: test for pull.ff=true overrides merge.ff=false
  pull: make pull.ff=true override merge.ff
  Documentation/config.txt: clarify that pull.ff overrides merge.ff
  pull: parse pull.ff as a bool or string

 Documentation/config.txt     | 2 +-
 git-pull.sh                  | 5 ++++-
 t/t7601-merge-pull-config.sh | 8 ++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.1.4
