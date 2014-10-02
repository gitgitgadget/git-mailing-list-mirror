From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/24] rename_ref: don't ask read_ref_full where the ref came
 from
Date: Wed, 1 Oct 2014 19:00:36 -0700
Message-ID: <20141002020036.GY1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <20141002014817.GS1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 04:00:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZVhD-0006sQ-5e
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125AbaJBCAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:00:39 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:54846 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbaJBCAj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:00:39 -0400
Received: by mail-pd0-f175.google.com with SMTP id v10so1186577pde.34
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8hFZ5aDjpt+lmG2l3Q9A3RfmCdLT5NJ+pUCTynFN54E=;
        b=RbvW49jTV1xzLidm4QCnaPzA1wJmUhdvv05XZxhBquega1hljwrGD4Azuuuzy1eJb9
         57kYL7ZHrzUnU481qORjYqKDcbQuTCptrYpRuk7YiHu1tXg3ChrgWdYZl9Hhkd2Q08rq
         ZXrU/hfQ9EltfZvdyZYC9bSl8N6BetMS8DjECJrwii/FtQXpxBAnS0lW9ZCcgNd1Q8m2
         Ismtyz9AyipA+XMxNkT3IAxZqGrFAjnnERzWLfLMpPQqedapOlF+8gUHXTBqs3JS0d1+
         A0/yvPO7zTjFEesnS2ShdwbbNUrPdwkF9UVMrKDnmLWlngyU4lBuD9sxEmcaQDSzVdSo
         X2KQ==
X-Received: by 10.68.241.138 with SMTP id wi10mr82986685pbc.126.1412215238755;
        Wed, 01 Oct 2014 19:00:38 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id 16sm2109801pdj.42.2014.10.01.19.00.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:00:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257777>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Wed, 30 Apr 2014 12:41:04 -0700

We call read_ref_full with a pointer to flags from rename_ref but since
we never actually use the returned flags we can just pass NULL here instead.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
---
As before.

 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 99a9b86..39571f5 100644
--- a/refs.c
+++ b/refs.c
@@ -2671,7 +2671,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, &flag) &&
+	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
-- 
2.1.0.rc2.206.gedb03e5
