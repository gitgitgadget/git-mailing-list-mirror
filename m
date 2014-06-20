From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 44/48] refs.c: call lock_ref_sha1_basic directly from commit
Date: Fri, 20 Jun 2014 07:43:25 -0700
Message-ID: <1403275409-28173-45-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:44:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy03N-0001ou-Cm
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbaFTOoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:44:13 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:62131 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbaFTOnf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:35 -0400
Received: by mail-ve0-f201.google.com with SMTP id jz11so504902veb.4
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7qIYXIzQEAyODUYrOdePpNUxMKxqyBypf3rlZTRSojM=;
        b=RUU70vFFKDXhTHDa+zhL89bNL7K+lVeFQbFTM1VNvaeRwFJ3vcXBiKhNNcirTgF88j
         mTBrOc3at8UX3VIe6gtpYyZB0oiCvQDtGVInesF/FTZLSZR/D8hsBqOFfY9DcXEt3QfY
         FAnLaNq458UfsQ47KSXR76wMUUBVBEvy5tJ2cxP0P6lB+GwCOmesgl17E1NoMCT46iv8
         q5GLU1vHOoek+R6YudJNPtkeUxIuXynIa93zNOnR0uQ+95n9o4SwnYinpAYQwfvuBuNy
         C20sLdC77MnLn5kJ8QKxMqzoduA0pAB+3n+HVSudLDGdd5ZWQgCFGPADHau9DWZigesk
         0WMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7qIYXIzQEAyODUYrOdePpNUxMKxqyBypf3rlZTRSojM=;
        b=BrvYyCYY48ysbgfSQykpfLgEGPACLmXtIC+snxfRmaplo8bvF8AiXPMCArt4zyq8FX
         sTjnUmO+Xx3ozAY5V4wfsBYmjbh7Iy21iVbtQbN0IcmngOQWMAZ5cZoJKiRI4QGhWv0r
         T7SrER6gxtvNpq3OPBDPqDXXSin/qtjCdM/1Ehyaib8LoD3hzTo8EcU0qADJTIxudWDU
         53E5+0Lws8keWgI5knDSNpcwaadLuIhDGeJ5sjd0TJ7iTFp9KjYSOG4Oi4Az5Fk25z41
         3U9RLAMhQ5VkuvVYd+OkHKyY9Y1t4GHIdpuvfZ8AKcLFDqe0F9won+Oo0vkuO5P88rQm
         W2yQ==
X-Gm-Message-State: ALoCoQm6UpOMbOPDReydEypBvC2yql8p8pxuLU0YbsCCMluxGWuAuohyOxSVhIrEjzxSz2Ee1WTB
X-Received: by 10.58.37.164 with SMTP id z4mr1537169vej.28.1403275413924;
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id b39si187838yhj.0.2014.06.20.07.43.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C27405A4551;
	Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 9F4E3E114E; Fri, 20 Jun 2014 07:43:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252244>

Skip using the lock_any_ref_for_update wrapper and call lock_ref_sha1_basic
directly from the commit function.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index bccf8c3..f3fab37 100644
--- a/refs.c
+++ b/refs.c
@@ -3598,12 +3598,12 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		update->lock = lock_any_ref_for_update(update->refname,
-						       (update->have_old ?
-							update->old_sha1 :
-							NULL),
-						       update->flags,
-						       &update->type);
+		update->lock = lock_ref_sha1_basic(update->refname,
+						   (update->have_old ?
+						    update->old_sha1 :
+						    NULL),
+						   update->flags,
+						   &update->type);
 		if (!update->lock) {
 			if (err)
 				strbuf_addf(err, "Cannot lock the ref '%s'.",
-- 
2.0.0.420.g181e020.dirty
