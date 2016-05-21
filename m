From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] Persistent submodule pathspec specification
Date: Fri, 20 May 2016 17:28:09 -0700
Message-ID: <20160521002811.24656-1-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Sat May 21 02:28:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3umN-0001EE-Ld
	for gcvg-git-2@plane.gmane.org; Sat, 21 May 2016 02:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbcEUA2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 20:28:20 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32991 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbcEUA2T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 20:28:19 -0400
Received: by mail-pa0-f44.google.com with SMTP id xk12so44068332pac.0
        for <git@vger.kernel.org>; Fri, 20 May 2016 17:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Ljxm7H9dFH3eLRgN/EC+CFIj4SGv4s5F6qpTPk69S/Q=;
        b=XR4uMJE51nk+I9IgtEZIMX4dKrXWEEY4EPb1fm+LQCWX8vCYMcw6jIHfqtYqCm2sRs
         z/ZWcmFRAQNtbWABFqDWSHJFCMGwutt/0Hem8z8wl4cF4KVND+vdYYr0XwQJISBaTJr3
         +HWbTDhYSEHpVe4Yzz5TFElJlCxwuRgUgwDf6Og024DdvVXr5ANXt0yqaXRF92lqmVLZ
         msSR7BK9sxmpVDvrVCorSssxK6j727iQ1Rs2NKAlluC1o8Cn8uSI93gQUfq14V0QsZIx
         Y8de+Ks3cjcp1R72IoxNmX2hIbL0Dx0RblXj5yboqrMsUImenZ/b2lwoMEWGZTUj+hsH
         kglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ljxm7H9dFH3eLRgN/EC+CFIj4SGv4s5F6qpTPk69S/Q=;
        b=UYLW2VVENftw3tY5rlFvIw5C7B6ygD1/h1BA8odBbrAo86sBxcYPxhTQcQuzMI1V3d
         iisXbaMU5CIq+sLTGbRP1HSIPuIxR4DTLTxXBaWW1lMQp7/xabIgPZ/o2UEAl3iE6VTE
         MaV6aFdpEnCg818cUCunwW8zTNAMY8o36Ov29OPdN/aNKtEzbVfyiMBg8moJJaTq3T3x
         PhdKkZZzv4cgV75QoNUGWTI1eBSdbf3wqOuazyb8RuSu6Yv8O+9+EpaGG1SGtLyNglpU
         BO7M6OM2nLVqk5hUugNeC89Uj4z8+sEt6lVqPkXux+qxCN7E/PWjP6Weu56yKQ51rdq3
         D0dQ==
X-Gm-Message-State: AOPr4FWxkJFMCEQuL/F+qjhMYeXOD9N22hm0tHMlUXfCEaIkf8YqZPruCI9/b/sub1W+Rzh4
X-Received: by 10.67.22.168 with SMTP id ht8mr9049727pad.50.1463790498168;
        Fri, 20 May 2016 17:28:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:104:6ffe:257d:9a11])
        by smtp.gmail.com with ESMTPSA id q186sm29697525pfq.96.2016.05.20.17.28.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 20 May 2016 17:28:17 -0700 (PDT)
X-Mailer: git-send-email 2.8.3.396.g3aebe0e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295221>

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
