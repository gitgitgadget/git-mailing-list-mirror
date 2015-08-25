From: Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 0/5] Demonstrate new parallel threading API
Date: Tue, 25 Aug 2015 10:28:21 -0700
Message-ID: <1440523706-23041-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Tue Aug 25 19:28:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUI1X-0006ce-Ig
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 19:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755804AbbHYR2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 13:28:32 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34898 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755756AbbHYR2a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 13:28:30 -0400
Received: by pacdd16 with SMTP id dd16so130371544pac.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=cLxj1FZotCaHmPlgAz1AptOMzJMCo+y2fpNVk1CB6Ls=;
        b=mz/cEaBacdS+QKrn2PsP3CH55gYnXNhK9kakGEqbCrtCCGGqBS5+p3aiZswS/A1pUo
         w0lUs5vhAMgs+ePZC4UWOIORmv5g4z1FccJ9/2NNVvJBC2SV1V0YrhIyM8yr+tsRgzpI
         Iv45pPB9R0RSIUFOxB2qMRFChFoc4uF/8x+9FQPmz45ezUgqtkMrSvI00S9jr3OWrQn6
         sHFerIurNwEgl14zB5OBJps281hD+Y/d5Hy6Q+tlGvmuziYgUIopsQWrBufdSAX4yFml
         tqNbgQcPglDvmmWL9V3jDVoWJVsJhWvTeqA8OEQHwcq5v3SlUqAS/B4XXkYtU6bF1Uuq
         DFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cLxj1FZotCaHmPlgAz1AptOMzJMCo+y2fpNVk1CB6Ls=;
        b=eFstzaiqrLtLvftP+NdNrMlKw0VUb8VGHglZ/Ora64s7xknAqclL4sEPGbazcKJDAg
         3C21W5zNGi/2WPkCdk3soD0NAleVzUup+9g3XJls88MkzLP4+rPoDpn5CqTlx/qbHMA0
         Q8OMubCOhgS8etssTQiwSu0wWLeNZRVeNroL2qRL1NRoHV0T+s6y1kXr+MmzJrui69Yn
         sRWCZpkch0BtD8ho/z5ra1bS51kNnWHMV8NPz7t2jpA9Td9O8JoA2LBndK5YifDhbkKb
         Zn7DNpEg9RcosYhBMPwpAzUDWso7x3qiPveORmQPsrMFIrxplNzjsH8E1LBccuPZPh92
         mLgg==
X-Gm-Message-State: ALoCoQlqHwm5kRS3owxVHF6biKlAjuA/yD6IzC+QHeCz0QQFK2zjEKOurdXJLNDwT2eaKSQmFZvD
X-Received: by 10.68.169.69 with SMTP id ac5mr59116014pbc.14.1440523709985;
        Tue, 25 Aug 2015 10:28:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:ccb:1c59:dd72:7a5c])
        by smtp.gmail.com with ESMTPSA id vv2sm18814853pab.21.2015.08.25.10.28.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 25 Aug 2015 10:28:29 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.400.gff86faf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276542>

This series build on top of origin/sb/submodule-helper.
The first patch is a fixup to the last commit in the target branch
to fix a memory leak. The patch is not really part of the series, but
as I chose to build on top of that series I can fix it up as we go.

The patch 2 adds a new API to easily use a threaded work pool.

patch 3 adds the command `submodule foreach_parallel` (completely untested, RFC!)
which was the original goal of this series. But oh well, I got tricked by Peff
to prove how awesome the new API for parallel threading is, so that's shown off
in patches 4 and 5.

Note: Both patch 4 and 5 delete more lines of code than they add, improving 
readability a lot as you can focus on the actual task and not on the threading
stuff.

Any feedback welcome!
Thanks,
Stefan

Stefan Beller (5):
  FIXUP submodule: implement `module_clone` as a builtin helper
  thread-utils: add a threaded task queue
  submodule: helper to run foreach in parallel
  index-pack: Use the new worker pool
  pack-objects: Use new worker pool

 builtin/index-pack.c        |  71 ++++++-------
 builtin/pack-objects.c      | 175 +++++++++++---------------------
 builtin/submodule--helper.c | 159 +++++++++++++++++++++++++++--
 git-submodule.sh            |   9 ++
 run-command.c               |  29 +++---
 thread-utils.c              | 237 ++++++++++++++++++++++++++++++++++++++++++++
 thread-utils.h              |  40 ++++++++
 7 files changed, 545 insertions(+), 175 deletions(-)

-- 
2.5.0.400.gff86faf
