From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 0/4] Some cleanups
Date: Wed, 30 Mar 2016 10:05:14 -0700
Message-ID: <1459357518-14913-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: sunshine@sunshineco.com, peff@peff.net, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 19:05:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJYr-00029r-Ly
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:05:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755625AbcC3RF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:05:28 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33992 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084AbcC3RFY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:05:24 -0400
Received: by mail-pf0-f173.google.com with SMTP id x3so47621893pfb.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=yOczWUGWAjvXZg9eAwn1aE/pV7cHrPohoYUpyb0/e6M=;
        b=dKOtKCmZyBzgD/6wIXVMsfWfIGUKf5RrmSpqAGm3DzChcVx8bJX21DVrAlMT7nm6el
         +Nv71cT2a5nxSXPHViaPG75MwBjOr5PtfU3HYna+7uUqrdq9mvZWmpoGdfQ5So+H1OLG
         Sq4rbd5pBCd6qe3YakpzeH6BKmK3wUe7+RtkA/pxPT9MntAQGC9f1Rvrf37Vnpjo5dLz
         Sy8AIfehIlQ5l97QdMd7oP/jdXBezCqi4yl1r1emAotnI/8KO7jkBNDiWksYXmhn8CUR
         tQPf+9KWbIa/eHsA+akmKgJuJBgpn5Pif9HbUkeHzH08h0g2ghNC4XjlQmPVmZN0AUtv
         tG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yOczWUGWAjvXZg9eAwn1aE/pV7cHrPohoYUpyb0/e6M=;
        b=FU7gEji91qW7/zxIIe79+jJjY64LgSUWGaNpnBhiww6+5kNCedW1HjS9i3T7lkMkrN
         EmfiPz7QUB8hpW790PJgTInWgCjeUxjSc3PrMLzjTwFM6Xxrm0jSnsiz2EHEn0mYjoS+
         sdgQUS25Bp5jjrfm1GR/5OBVZSE5VbewARssV7KHtyobwMQKEh3ERmW6qBlaa1y6SImd
         OiJBKrS4aRXP+nd5AtGPiLpqhWxRYUaPFFFeFkqQxDbrc9EFKtbcuNfWwCksbl+//iEi
         9KcEFyEHHozqbHSh+BDOQId6n7hx0qg5NUo6yOJbNK0yGBSLcGUac2cQDdXocq7jXAeC
         ZwpA==
X-Gm-Message-State: AD7BkJLE9Yz4d2ZIi2qxMKGZPbrlptgf7zAJgDnFUSr68x6ey+eHCohL3wptZKbNhevsOnq8
X-Received: by 10.98.18.71 with SMTP id a68mr14899086pfj.41.1459357522944;
        Wed, 30 Mar 2016 10:05:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id v74sm7282741pfa.7.2016.03.30.10.05.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 10:05:22 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.2.gb331331
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290316>

v2:
Thanks Eric, Jeff, Junio for discussion, I picked up all hints and here
is a v2.

* drop the overallocation patches (1&2)
* use git_config_get_string instead of its _const equivalent, such that
  we don't need a cast when freeing in git_config_get_notes_strategy
* Use strbuf_list_free instead of cooking our own.
* have a dedicated error exit path in bundle.c, create_bundle

v1:
One of my first patches to Git were cleanup patches, and I fell back
to my old pattern here, while thinking on how to write better commit
messages for the submodule bugfixes I currently have in flight.

Just some one liners to not leak memory or file descriptors.

They are bundled as a series, but no patch relies on any predessor.

This applies on v2.8.0.

Thanks,
Stefan

Stefan Beller (4):
  notes: don't leak memory in git_config_get_notes_strategy
  abbrev_sha1_in_line: don't leak memory
  bundle: don't leak an fd in case of early return
  credential-cache, send_request: close fd when done

 builtin/notes.c    |  5 +++--
 bundle.c           | 23 +++++++++++++++++------
 credential-cache.c |  1 +
 wt-status.c        |  4 +---
 4 files changed, 22 insertions(+), 11 deletions(-)

-- 
2.8.0.2.gb331331
