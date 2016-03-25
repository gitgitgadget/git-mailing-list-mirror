From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 0/5] submodule helper: cleanup prefix passing
Date: Fri, 25 Mar 2016 11:39:11 -0700
Message-ID: <1458931156-29125-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, Jens.Lehmann@web.de, jacob.keller@gmail.com,
	sunshine@sunshineco.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 25 19:39:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWdp-0005FI-Dw
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbcCYSjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:39:20 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33464 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbcCYSjU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:39:20 -0400
Received: by mail-pa0-f42.google.com with SMTP id fl4so51172642pad.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 11:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EdCO7on0k9VujeJ7qYVpjRpqfXFW4mM5Vew8LfxGUsg=;
        b=XMB8Fk2DVQtD63xQ4gUQNFDAKCW2qFomc0NEo+e2mRF/ugooVTcokmq17FuFlq/8ZQ
         N9Uc+ku2X5p6fMXO9MXYjq2q94wn/MXVWY1v2FsLFqUXoofiB5aG5dxNkvG5ANBsRdiP
         vYzi12qPkZVIDtSmAy+MKYV5JfJPdV1AOSYtwwqGzfgGFhIKHWqBBUPcU/p058qb85VA
         H13+ClRNIApy0iLO2xW5q6/h3j0bZy9Nj5rkZAFKJU1L9ZnqMR/KpnCI2bA5C4Kffkn1
         A3y8orB+LQgTu/vb3dViRFcKeXe0daJKEJ+hjMiuqhbTYB1BngtZd0ivZRoILJitjMj1
         FYHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EdCO7on0k9VujeJ7qYVpjRpqfXFW4mM5Vew8LfxGUsg=;
        b=hGy43qOR7Qqoua6CYIyqjxfX6w/6mTKcJ/Xe1EYEAu7sx6MZXHQE+wrtDTHjl9zrux
         /Ph6rmtp+kq/mk+qJlFSx0OzQpFh5mxEoBkfALkJriArqrKP/lJrDq52qoUxSYcjpHcx
         LtrzWaaDlIo2+xiMk7uRD/i/wxOCI5djr+6e4xD1xp5K1qNQUXhOSyiRWUxJeJrcN3AU
         DkCPpX2APRyirWmZXm+cdkayVN6Pu2RROp12ovJi4mjDxrFYrqFROEhG4vfrQG8xXOIN
         TPiLY5J75FjYNyz21DujG82e8rzui4INzSOhfXiYHGakDIK31WF6i39BFWTn4lVGivC3
         wYlg==
X-Gm-Message-State: AD7BkJJIbU9IEJ9oK8we0Jpl3rqcK3rzTi4UYBQAS/InjY4lLoaCoVFLGAvGwQEebzLpbyYv
X-Received: by 10.66.146.164 with SMTP id td4mr23108116pab.47.1458931159155;
        Fri, 25 Mar 2016 11:39:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:e4a5:c9cf:82bb:5195])
        by smtp.gmail.com with ESMTPSA id ud5sm9697574pac.11.2016.03.25.11.39.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Mar 2016 11:39:18 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.10.g52f3f33.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289938>

Thanks Junio for the in-depth discussion!
I squashed the first two commits as they are actually fixing the same underlying
issue. Setting wt_prefix=<empty> is the actual preparation for switching 
the submodule--helper to git -C instead of "--prefix$prefix".
But setting wt_prefix=empty would break existing tests, so the different
computation of the prefix (relative_path of sm_path instead of plain sm_path)
is the fix of the fix.

Eric, I picked up the git -C in the tests, which are broken into 2 patches and
have a more concise commit message each.

Jacob, thanks for your 
  Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
although I changed the code so much, that I did not put it in this series.

New in this series is the last commit, which gets rid of the prefix for
"submodule--helper clone". (It was useless to begin with; probably just
cargo-culted in because we had it in "submodule--helper list")

Thanks,
Stefan

Stefan Beller (5):
  submodule: prepare recursive path from non root directory
  submodule--helper list: lose the extra prefix option
  submodule update: add test for recursive from non root dir
  submodule sync: test syncing one submodule
  submodule--helper clone: lose the extra prefix option

 builtin/submodule--helper.c | 10 ++--------
 git-submodule.sh            | 23 +++++++++++++----------
 t/t7403-submodule-sync.sh   | 13 +++++++++----
 t/t7406-submodule-update.sh | 14 +++++++++++---
 4 files changed, 35 insertions(+), 25 deletions(-)

-- 
2.8.0.rc4.10.g52f3f33.dirty
