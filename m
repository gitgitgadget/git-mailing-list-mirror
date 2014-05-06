From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 0/2] add a reflog_exists and delete_reflog abstraction
Date: Tue,  6 May 2014 15:45:51 -0700
Message-ID: <1399416353-31817-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 00:46:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Who7h-00015B-78
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 00:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754545AbaEFWqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 18:46:00 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:56016 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535AbaEFWp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 18:45:59 -0400
Received: by mail-oa0-f74.google.com with SMTP id m1so45805oag.5
        for <git@vger.kernel.org>; Tue, 06 May 2014 15:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tl98tY70fUzYsd2qzDXkq+sEv5FVL9K/sl3b9CU1EQ8=;
        b=NTzJUzRREU6Duz/Bh585qk2TDHNMw3xKDFkqD7VSHC/5cXQijx08ggV0fe0sBlQq0l
         Mf2bcQvGH+hw2TZ0S4H5POJYpl+/grcRKzbUdlAA/ULpa4YOw1QakhUIm0+HfRYtMNHo
         ArShie9aZcNq1Q+7aVXw1DCPc08bPAdHydV5ImPcQlurMPrEXRpHaKVFPidMIkdXOfXO
         /wHx0mjVGao2JonLoq7OROvG0Dt3/WaKJ85FZnchDeifN+6Qiqz0w3OtTeh2qy9UV5l3
         w5+HoDlWU6+2GMP8fo6YEFeIspNnhRhC10nnLsvHGXUT73xIOSKkXY3hXXPAOmCO+3gq
         YCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tl98tY70fUzYsd2qzDXkq+sEv5FVL9K/sl3b9CU1EQ8=;
        b=Zpd+4ejHPxuOoANqrIZczwM5o0TnQGdYO6BpfC2HuOA0zLPeF43iO1VK8eub4sMNxT
         tvrv1SRW00OVrHZDZlQHPmSCqWSfEbUo0RGKinld+UjPDhRWCM6J/M2039fnE5cH5GzM
         S/W0X5WNGLFtU6Yz27TczAJBTBxTBxvRhValr8a2ZZY1MToR3L7ylxxHQyDTW4cWMjOx
         Qh/s7N2a/NLCils0CxQkBlDI0dF3OQhr1NywP16xjbiMDLbLO9yye/nW4D405u+e3Rl4
         nGi3sXjxeYPDs1uabV965hvcoyWRqJNSyY1B4jd9W+ccs3RIltpfF/SFdT21BOKA0UhF
         7SyQ==
X-Gm-Message-State: ALoCoQlxDG87Hi0zFZtEgI4GBsuZS8R7/uN+poeW3wIJljcxoemZy0afk0WI0CxDeQye9X+cMML4
X-Received: by 10.182.128.234 with SMTP id nr10mr2702219obb.0.1399416358684;
        Tue, 06 May 2014 15:45:58 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r79si601844yhj.2.2014.05.06.15.45.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 May 2014 15:45:58 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 81BC15A4166;
	Tue,  6 May 2014 15:45:58 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 21311E0ACF; Tue,  6 May 2014 15:45:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.354.g7561c2b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248264>

This is a series adds two new functions to try to hide the reflog
implementation details from the callers in checkout.c and reflog.c.
It adds new functions to test if a reflog exists and to delete it, thus
allowing checkout.c to perform this if-test-then-delete operation without
having to know the internal implementation of reflogs (i.e. that they are files
that live under .git/logs)

Additionally we change checkout.c to use ref_exists instead of file_exists
when checking for ref existence. This fixes a bug when checkout could delete
a valid reflog file if the branch was a packed ref. The tests have been updated
to test for this bug.


Version 2:
 - Typos and fixes suggested by mhagger.
 - Break the checkout-deletes reflog bugfix out into a separate patch.


Ronnie Sahlberg (2):
  refs.c: add new functions reflog_exists and delete_reflog
  checkout.c: use ref_exists instead of file_exist

 builtin/checkout.c |  8 ++------
 builtin/reflog.c   |  2 +-
 refs.c             | 21 +++++++++++++++------
 refs.h             |  6 ++++++
 t/t1410-reflog.sh  |  8 ++++++++
 5 files changed, 32 insertions(+), 13 deletions(-)

-- 
2.0.0.rc1.354.g7561c2b.dirty
