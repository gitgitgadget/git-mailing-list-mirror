From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 0/5] use packed refs for ref-transactions
Date: Wed, 30 Jul 2014 14:55:36 -0700
Message-ID: <1406757341-4096-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 23:55:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCbqe-0007yM-WC
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 23:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbaG3Vzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 17:55:45 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:55181 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbaG3Vzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 17:55:43 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so251233yhl.3
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Dk4zGpBEpBA1DsAmumsZbw76yKbQGsH1e1FPqTogPCI=;
        b=XQO/5+UJEAXA9fkbzEXznUaAjdhwetYuSC49navsZPDhFWaKxbJyEf/m2SFWnXZxnL
         v9dOfV/tTHEplw6bUTIE/mLtYcoI42y6ZfeYkC8g4Xn1BZ9HEsRixgSJL1Mk5xWkv3+T
         2rw0xbpKf4UoHW8WKTwsg8Nj7eNbUAeWnlYQ2fSvR21mnRczyDot2xiLFY8/g+0CjXGo
         ytmFbQ7+GaBzYuHFzbEW3mOiY6ddQiob+hBBhPWdeANu7YZHMU8kl0vEGcw0QD8b4vMm
         +TgubEiNpnwBfY76EGRkl47O47Z12kiuHKdLhtqyMDu1iMCzsZD292Nh3q7G98WTJhm3
         GDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dk4zGpBEpBA1DsAmumsZbw76yKbQGsH1e1FPqTogPCI=;
        b=Ob+tpJeJR7dd/cMJHDk4ukw1LhoijFpruq8OaUqQU7NnlHL/Ug30xQC+9yHU44EtFy
         Nj8IL9vL2G8WoHRcMNTF1/xhRB5TJwMxhfoLAjLXTaJPCtZqxJm00/qVPy4rpUFS1M31
         dWunVsk4GG/8ZVL2jM/YuF5HLXgTZxqLxaw9D/TDI3C/zvv61c9emFrDvG5SlQ7pfgj7
         G6xqfREsiT7Xjkqg+Icy7sAJDint3Aahzdedqp6+TRQMM8AyZrgTjAH7BwKhFwgdkLhi
         XwyamL7+jhnJsBmticxREwYOl0VMguBtRarm+5hF3LFgaAMQxQjKCasr5yAjGNf4GJUQ
         eNpA==
X-Gm-Message-State: ALoCoQkWiICZ9dXi9kDTDUZoZGhg5qV87lo5XHZgzYxzUKmI1W66wFS3Umyh+pwJo84yxpcejXQG
X-Received: by 10.236.15.167 with SMTP id f27mr2489243yhf.37.1406757343059;
        Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si224351yhp.6.2014.07.30.14.55.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jul 2014 14:55:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E4DB35A4308;
	Wed, 30 Jul 2014 14:55:42 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 8397AE0726; Wed, 30 Jul 2014 14:55:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.523.g0041e8a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254524>

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

Version 2:
-- Updated to address Junio's concerns



Ronnie Sahlberg (5):
  refs.c: move reflog updates into its own function
  refs.c: write updates to packed refs when a transaction has more than
    one ref
  remote.c: use a transaction for deleting refs
  refs.c: make repack_without_refs static
  refs.c: make the *_packed_refs functions static

 builtin/clone.c       |  16 ++++--
 builtin/remote.c      |  69 ++++++++++++----------
 refs.c                | 155 ++++++++++++++++++++++++++++++++------------------
 refs.h                |  33 -----------
 t/t5516-fetch-push.sh |   2 +-
 5 files changed, 151 insertions(+), 124 deletions(-)

-- 
2.0.1.523.g0041e8a
