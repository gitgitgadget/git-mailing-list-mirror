From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/5] Add a flag to push atomically
Date: Mon, 15 Dec 2014 11:56:03 -0800
Message-ID: <1418673368-20785-1-git-send-email-sbeller@google.com>
Cc: mhagger@alum.mit.edu, jrnieder@gmail.com, gitster@pobox.com,
	ronniesahlberg@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 20:56:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0bkl-0001wr-Dh
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 20:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbaLOT4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 14:56:19 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:45038 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbaLOT4S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 14:56:18 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so11427107iec.22
        for <git@vger.kernel.org>; Mon, 15 Dec 2014 11:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wd19G9VEYM7C13ytGmOPWGxr1cdoaK7GFVGNP3sZYHg=;
        b=BXOoItOY3izIC66t04YQkEB/NhJRFHAgxryG0k40itVqjW8ePzO+bcR94NVplXcac9
         hZPknrID0Xw3NoJm94C2lIIHEFnbNf0/HenWFC+NC/g7H8IJCaiDTOxrvgfhN0d2WjbV
         cMjcuznpxL24uQETi1DRY7IbNKoSDkTobbE8ABxviqTuWnmL7Mhbk3XTHotl86vpGvKz
         +xfN8GY1Z3mnf9952QKcSHEoNUIAaeyuCPSe9XGw6SYOvP3okJr7SNiymgdZ3Ya6mlVU
         7DmQ1nr8ShFP4yZfJYOJGBIK9EKAMO5eTbArnuk1VgBzM0kftTNn8MX3pBKJkKMuGIe1
         u1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wd19G9VEYM7C13ytGmOPWGxr1cdoaK7GFVGNP3sZYHg=;
        b=ItXeeDpofzDaGVLyTX/kXDRY6oMepge10AUyvYKH6gUQ69qDsVY7Y9yN6LUUaba9Lk
         +dkkvMHGsGx8pSEmpdEnxjL2SFswdI0n5nreKrBlVehG+POtfz07xGchkxZkwIFFhrsB
         BxrUP6ykubCX6I8Xg1Bifj7iJQIpv55HsL+kI4vFtg3DOVNnzMhzPH+oHSQvzfjfUTHj
         WuHYU60yeMEA+YAqhzvOuYjfRDOf68IjZ5xwG1CnC609t11bbcLZYSjhRbxVXBRBabsp
         AbuJkex2cuU59cr6kCMeRlrhNNe0HtLxUDzpHuNU+2/N3WjNYIfL+bQ36B7Kvd8PJm59
         MnbA==
X-Gm-Message-State: ALoCoQnyBx+GfL1AmeBlziKA64KSy8Y8Hfs7scmJHuvFnd2WGsTBsEfFMW30ZxWBu4+fvmLAzIVQ
X-Received: by 10.50.134.195 with SMTP id pm3mr7841937igb.0.1418673378000;
        Mon, 15 Dec 2014 11:56:18 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:ccd:69a0:9bbf:bab9])
        by mx.google.com with ESMTPSA id 137sm112866ioo.23.2014.12.15.11.56.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Dec 2014 11:56:17 -0800 (PST)
X-Mailer: git-send-email 2.2.0.33.gc2219e3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261413>

This patch series adds a flag to git push to update the remote refs atomically.

It was part of a longer patch series[1].
This series applies on top of origin/mh/reflog-expire
It can also be found at [2].

Change since picking the series up from Ronnie.
  * other anchor point (i.e. where the series applies)
  * more tests for this feature, specially testing failures
  * drop the patch to rename ref_transaction_* to transaction_*_ref
  * slight rewording of the additional documentation

[1] http://www.spinics.net/lists/git/msg241214.html
[2] https://github.com/stefanbeller/git/tree/atomic-push-v1

Ronnie Sahlberg (4):
  receive-pack.c: add protocol support to negotiate atomic-push
  send-pack.c: add an --atomic-push command line argument
  receive-pack.c: use a single transaction when atomic-push is
    negotiated
  push.c: add an --atomic-push argument

Stefan Beller (1):
  t5543-atomic-push.sh: add basic tests for atomic pushes

 Documentation/git-push.txt                        |   8 +-
 Documentation/git-send-pack.txt                   |   7 +-
 Documentation/technical/protocol-capabilities.txt |  12 +-
 builtin/push.c                                    |   2 +
 builtin/receive-pack.c                            |  79 +++++++--
 builtin/send-pack.c                               |   6 +-
 remote.h                                          |   3 +-
 send-pack.c                                       |  45 +++++-
 send-pack.h                                       |   1 +
 t/t5543-atomic-push.sh                            | 185 ++++++++++++++++++++++
 transport.c                                       |   5 +
 transport.h                                       |   1 +
 12 files changed, 327 insertions(+), 27 deletions(-)
 create mode 100755 t/t5543-atomic-push.sh

-- 
2.2.0.33.gc2219e3.dirty
