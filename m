From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 03/23] refs.c: add a new refs.c file to hold all common refs code
Date: Tue, 19 Aug 2014 09:30:27 -0700
Message-ID: <1408465847-30384-4-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:32:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmKe-0002zZ-T1
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbaHSQbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:51 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:44095 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbaHSQax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:53 -0400
Received: by mail-oa0-f73.google.com with SMTP id g18so1478144oah.2
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ktf/lU8jEKX6zJ/KsMX8lB10LcHfGuS4OUA4TrnjNok=;
        b=EEkHv5EoG4bT/4ubK8IJA7mfWnrtG+6eITtcpDZaQKA02IBXCkFOWFseMK7vW3X3pS
         PKAZ2s6WFkzX2Qz0bSzs/pqdHL3SdoTQI/RseeReKe4lc70iG+sjoZihRE5hle+p33JF
         61jVEqrRWtCI49YTMWBaLhWRnf39D6qRUD8ECiw+sJh9J/WAhacpLpsp+t3eZ3dfsmVs
         Wdh7HbwZxOadT4REyZhvejO5Ow6C82Ht//6F9LqTJ0kgVfp2U6UeABfDmVEw4q6bxPJi
         r18XPXpTEJ3EgmKGIMQkXSzlrQYt6IUlgU8cSKMFtjIHfgNG1mFkNjR/1Qx6x430HXkz
         Bs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ktf/lU8jEKX6zJ/KsMX8lB10LcHfGuS4OUA4TrnjNok=;
        b=dhyXZAsF2OCdDEAHALVftWsh2gfL+qLAXLYXnKaqD2phkC28rKmFu52+MNan5WRCVp
         szWgcExotuh/x6F5nCS8TF30jhc6vpu664WuRujaEUa7a4mmaf0wKgmiW0YcUw74IN5w
         qGUmm6FsmtVLfMfM24NltcAvjXT3Xc7coHbWuBsfCiLbZ6ZqYmLXgtiXHq2qUeUQsO8i
         veqP6LImqk2Dl5GjK2LRQJ8TQ0T2OJyqDWjxetl9OKbz91B6L8oAIQCNnUC7cHFkJ/D7
         3jAlSF4fS5u7H1yG7oC7hL8gPNqLn7tsqDYTSkAlaoeDcmHk3WDiP3E9A1qHpBYM4kmt
         CV9A==
X-Gm-Message-State: ALoCoQmWf4LGUYzI6aROSPnLo1ZiKF0gyrnqJlEtvBEw6hpwkN4H60j1l5CmfF/+qS5wb7vHHzeS
X-Received: by 10.42.38.15 with SMTP id a15mr1501254ice.30.1408465853028;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si329348yhk.4.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B89635A4406;
	Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6074BE0F01; Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255494>

Create a new erfs.c file that will be used to hold all the refs
code that is backend agnostic and will be shared across all backends.

The reason we renamed everything to refs-be-files.c in the previous patch
and now start moving the common code back to the new refs.c file
instead of the other way around is the etive volumes of code.

With the ref_cache, packed refs and loose ref handling that are all
part of the files based implementation the backend specific part
of the old refs.c file is several times larger than the backend agnostic
part. Therefore it makes more sense to first rename everything to be
part of the files based backend and then move the parts that can be used
as common code back to refs.c.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 Makefile | 1 +
 refs.c   | 3 +++
 2 files changed, 4 insertions(+)
 create mode 100644 refs.c

diff --git a/Makefile b/Makefile
index e010ad1..937d22a 100644
--- a/Makefile
+++ b/Makefile
@@ -857,6 +857,7 @@ LIB_OBJS += quote.o
 LIB_OBJS += reachable.o
 LIB_OBJS += read-cache.o
 LIB_OBJS += reflog-walk.o
+LIB_OBJS += refs.o
 LIB_OBJS += refs-be-files.o
 LIB_OBJS += remote.o
 LIB_OBJS += replace_object.o
diff --git a/refs.c b/refs.c
new file mode 100644
index 0000000..77492ff
--- /dev/null
+++ b/refs.c
@@ -0,0 +1,3 @@
+/*
+ * Common refs code for all backends.
+ */
-- 
2.0.1.552.g1af257a
