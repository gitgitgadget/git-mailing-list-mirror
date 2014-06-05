From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 0/2] Write multi-ref updates directly to packed refs
Date: Thu,  5 Jun 2014 16:26:26 -0700
Message-ID: <1402010788-8236-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 01:39:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WshG7-0002yy-Jz
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 01:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbaFEXjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 19:39:44 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:65442 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbaFEXjn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 19:39:43 -0400
Received: by mail-qa0-f73.google.com with SMTP id hw13so417647qab.4
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 16:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QYN7ko09VEM9RKU/NwvBcKhlgz/aU2pzVVIDY3kudsU=;
        b=S0NcZlyTurtZ2d9MGoTZylx4f0GUITMbP2uzmHxLZDunwkLmGzSVijYkxENfIdbR28
         StfTidGZ0PrpXjB+90fd3UkW7NTHP2W2jrD2jMLfV+1FcinSq5hDCsJnVd7n97KE3V8z
         3uB2cwMcv3nYYZasXaa9dE0qsxYD2ykLutL8ylOHBiIenjDJ5mi4/xO07V+ANPk0Vlv6
         mxf5sW3oVzShvNa3ZMg18mBB4Z2oGMXLrcxNXYkGAJtLjf7TMTEcEuJ00T1/r5mZN5Oj
         J0psRKcd4omVHDxY5AhQof0jZHbSf3SmGaN9JCJ+tiUxv9snGu/RHvupGZDFLUkdn8En
         zZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QYN7ko09VEM9RKU/NwvBcKhlgz/aU2pzVVIDY3kudsU=;
        b=ilIWTvuDc59fR/1hl91AXIx8Jm5sHzKjhiPRZoV1fOp9uHmnTinkAH44ehUBM6SbY1
         YbCLIe9oDSuHxa7t5qCLeNWNgxs3vFJ3ny6yHxUVxI5IMSXoGXNuUdXiJDxULFVsnzcr
         GLZy2dp2YeX7wycPSEz+b/cJaSYxzNUMcJgQzIjLpwpj8WVjdGPmjkO+r8X6ArE5ePpk
         D+NZ3twIFbojFS8gidVFh2K8Don6EBCaYquOngLO7vNsb2JMlVoGbF18uChdaCQ6BSm6
         uaOf+Fy/jRMfkoU2B10p3cWEEU6tYF9GDkxGh/Iy+R2l3IrUcRuNoNgRsoBWHi6Dfaky
         n9lw==
X-Gm-Message-State: ALoCoQl/pri4eS9rfCAjU7geAoQmSFeGx0liKlDedEpFnLmX4fNh1Q0TbpDZWaSL+t2dYFCeY5v6
X-Received: by 10.236.200.194 with SMTP id z42mr261200yhn.28.1402010793117;
        Thu, 05 Jun 2014 16:26:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id t4si649767yhm.0.2014.06.05.16.26.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jun 2014 16:26:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id F24CE5A4740;
	Thu,  5 Jun 2014 16:26:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 94FD5E0B87; Thu,  5 Jun 2014 16:26:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.583.g402232d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250881>

This patch adds support to the transaction system to update all non-refs as
packed refs instead of loose refs.

This series can also be found at
https://github.com/rsahlberg/git/tree/ref-transactions-req-packed-refs

This series adds support to have transaction write updates to packed refs
instead of as loose refs.
If the transaction only contains a single update to a single ref, such as the
commit case, we continue to update this as locking and writing to the loose
ref file.
But If on the other hand the transaction will update more than one ref, then
we perform all these updates inside the packed refs file and remove all the
affected loose refs files. This allows us to both perform deletes (added
previously) as well as updates-of-more-than-one-ref as one single atomic rename
operation.

Since the transactions will now by default write directly to the packed refs
file for updates to more than one ref, we no longer need to provide a
pacekd refs api to builtin/clone.c any more. So lets change clone.c to
use a transaction. This removes 4 fucntions from the refs.c API we can now
unexport and make static.

This change means that clone will now apear as one single atomic operation
to any external observer where all refs appear at once instead of one
ref becoming visible at a time.


Ronnie Sahlberg (2):
  refs.c: write updates to packed refs when a transaction has more than
    one ref
  refs.c: make the *_packed_refs functions static

 builtin/clone.c | 16 ++++++++---
 refs.c          | 82 ++++++++++++++++++++++++++++++++++++++++-----------------
 refs.h          | 28 --------------------
 3 files changed, 70 insertions(+), 56 deletions(-)

-- 
2.0.0.583.g402232d
