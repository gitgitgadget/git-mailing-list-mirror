From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 21/25] for-each-ref: skip and warn about broken ref names
Date: Tue, 14 Oct 2014 17:54:21 -0700
Message-ID: <20141015005421.GY32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:54:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCrF-00049U-HL
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbaJOAy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:54:26 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:55685 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932479AbaJOAyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:54:25 -0400
Received: by mail-pa0-f50.google.com with SMTP id kx10so230799pab.23
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dU6eqNkBrN/z1NFBBtcymgzJS33eboRJ9btLXlQwLhY=;
        b=dO2WbIWuhQJYrweEGujec/VOX0kMLY4Sjm1MgFa8tsapC+sPVVgVbT6YpGAqyCar35
         hfNXd1Xp5KoNBkflr6m8WzOBxVnBSmSe15JwvtpOILRXVsnox0Dbcwno+FmsvJk4HNlz
         NbAE8rcLlLC8mos6joudOqLcAf1rxPsnPawDp1erT1vBdnjYSeoQG649roxCxIpLGfuK
         KXEMr+5N3QC8iX1/DoErC67nF7epHsCRrCYsSvaZ9RYvpIO4UBqJvyRUNPt6+kcz1yj6
         YMUtw9CmQbW3bBg1JyhgmqJGAyW1lx/x9hmvWDs8ScSeqK+X4dwgPsMlZWpO+TnX1csQ
         pHBQ==
X-Received: by 10.68.235.103 with SMTP id ul7mr8715652pbc.63.1413334465064;
        Tue, 14 Oct 2014 17:54:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id i16sm15335933pdk.66.2014.10.14.17.54.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:54:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Fri, 5 Sep 2014 14:35:17 -0700

Print a warning message for any bad ref names we find in the repo and
skip them so callers don't have to deal with parsing them.

It might be useful in the future to have a flag where we would not
skip these refs for those callers that want to and are prepared (for
example by using a --format argument with %0 as a delimiter after the
ref name).

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/for-each-ref.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 492265d..3ee22b9 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -839,6 +839,11 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	struct refinfo *ref;
 	int cnt;
 
+	if (flag & REF_BAD_NAME) {
+		  warning("ignoring ref with broken name %s", refname);
+		  return 0;
+	}
+
 	if (*cb->grab_pattern) {
 		const char **pattern;
 		int namelen = strlen(refname);
-- 
2.1.0.rc2.206.gedb03e5
