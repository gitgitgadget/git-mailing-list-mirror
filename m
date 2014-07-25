From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 0/5] use packed refs for ref-transactions
Date: Fri, 25 Jul 2014 10:55:21 -0700
Message-ID: <1406310926-4080-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 19:55:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAjia-0002DY-Fi
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 19:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760748AbaGYRzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 13:55:33 -0400
Received: from mail-oi0-f73.google.com ([209.85.218.73]:35433 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254AbaGYRza (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 13:55:30 -0400
Received: by mail-oi0-f73.google.com with SMTP id u20so1021694oif.0
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 10:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=f1jMeF28SMh+0IDd6FXWGZAEuYQeVf6tjXcL36VJGmA=;
        b=CkmihmjyYjO4iDw2hOeDKqWClt5PsjMlF9Lobjv3gnv8MVFTNzX/IpynfAX7fsUmLg
         eoZOVEvn9RcbA7fq6o0WsApi4CgXhFwHUnQQOqNagw3WgXvxP+XV2m1NGW6mnm1pFAW2
         S2fS9CEE24KOHbpkXNKcIBFLv/5tL4t9D1d3fdsHHfUz2OKbnxPRcQRYY7jJmM6UIXeT
         tT+qZ3C6NYDsW3ydMki7WsWZ9qcuK2HwVKmG7ASoOj1h9lIwCSLjOTkZ59OJ1aWLN60m
         rd5KsaXitTvEuBCF5UkdZU8pqd0t55aRzZ1CYFBeSvHiNWH9FNm3RmsyUPOc+296WxQx
         6Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f1jMeF28SMh+0IDd6FXWGZAEuYQeVf6tjXcL36VJGmA=;
        b=b/ULR/3UyLJmfU10SOZ1vLf5bWwVaElmazU+XYAyxIanZUbXVDZOlPomhW4pJocamI
         +nxS3jAuqjQZSWegO7TtBCG0yVjrZ35OiKP0J4sa68+BDYTilHxoaK+Em2Z4x+buznId
         bSNRDUGt1JOE/p5A0YhMTzWYL6Obs8G7prCe1stpkmgVO5EoflkieUubgVlmWsCyfEtW
         buOcOj41cu9mGquRf2Zd6CQcsj7yJeag68T6fXkbzZT3j0AnuTjhGLr407VpiW8CZwtY
         G8n63WRmBKxWTAbPGlzsxidYTNG4iQJR8HSXyGluEbWeu/TBb6ERcy53N+G1ZUbvZtAk
         6bhA==
X-Gm-Message-State: ALoCoQl5KcMPGrJQNINIZwv/8m9IEeB0icJ2PD/2aIWmGVViDIlKiPaRVeETulHs500XZ61NJejk
X-Received: by 10.42.121.72 with SMTP id i8mr9636729icr.10.1406310929777;
        Fri, 25 Jul 2014 10:55:29 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y4si185099igf.1.2014.07.25.10.55.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Jul 2014 10:55:29 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 546DF31C43A;
	Fri, 25 Jul 2014 10:55:29 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D3E64E0A75; Fri, 25 Jul 2014 10:55:28 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.518.g4f5a8ad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254246>

This is a small patch series that continues ontop of the 
ref-transactions-rename series I posted earlier today.

This series expands the use of the packed refs file to make multi-ref
updates much more atomic. Additionally it allows us to continue pushing
external caller to use transactions instead of accessing (packed) refs
directly which allows us to remove a whole bunch of refs functions
from the public api.

After this series there is no real need any more to expose that packed
refs even exist to external callers.


This series is built ontop of the previous series that was posted earlier
today as :
  [PATCH 0/5] ref-transactions-rename


Ronnie Sahlberg (5):
  refs.c: move reflog updates into its own function
  refs.c: write updates to packed refs when a transaction has more than
    one ref
  remote.c: use a transaction for deleting refs
  refs.c: make repack_without_refs static
  refs.c: make the *_packed_refs functions static

 builtin/clone.c       |  16 ++++--
 builtin/remote.c      |  70 +++++++++++++----------
 refs.c                | 153 +++++++++++++++++++++++++++++++++-----------------
 refs.h                |  33 -----------
 t/t5516-fetch-push.sh |   2 +-
 5 files changed, 153 insertions(+), 121 deletions(-)

-- 
2.0.1.518.g4f5a8ad
