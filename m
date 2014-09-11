From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 16/19] for-each-ref.c: improve message before aborting on
 broken ref
Date: Wed, 10 Sep 2014 20:11:13 -0700
Message-ID: <20140911031113.GT18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 05:11:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRun8-0003Rz-Dq
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbaIKDLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:11:19 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:64690 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809AbaIKDLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:11:16 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so7653710pad.28
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ISrTc0JCM43ltLYaho9mVpQYlyo3+IOHtbWVzMWa2sI=;
        b=yc7Fx41kVeqi4poMgxIFvKPJ6oK5qwLZhPfEvfuYHoQDo4eCba2G+DmkFMTB4iwIFp
         5rqF9h2mLIrxpLV8CsMYGeB212M2ePImKS2e9OXHOVJKkCcYy2encL6SrIUJYKPit0bl
         OI6vMTCuxqTlXpjn/dxLBJxjO5r6XXRYlm3CsrFFT3hM7QzUgRfQn/dzZkvkfimtbv3n
         /7f08iG6PINoJ/63RPjQoxs5wtUTPs7haF4x0e5/d/c+aYjQNlDdMyi8N8gHS4lCVXqp
         i419xiAV1LBpB7ky97mjCrxeVbn1BkLPSSBL0fCwS0qhDnDgygFkJmqsZ4FIBtEhAkbh
         lsbQ==
X-Received: by 10.70.132.37 with SMTP id or5mr9764314pdb.149.1410405075868;
        Wed, 10 Sep 2014 20:11:15 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id j9sm15904883pdr.77.2014.09.10.20.11.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:11:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256826>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Fri, 5 Sep 2014 14:35:17 -0700

Print a warning message for any badly named refs we find in the repo.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/for-each-ref.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index e193073..090390c 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -853,6 +853,12 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	struct refinfo *ref;
 	int cnt;
 
+	if ((flag & REF_ISBROKEN) &&
+	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		  warning("ignoring ref with broken name %s", refname);
+		  return 0;
+	}
+
 	if (*cb->grab_pattern) {
 		const char **pattern;
 		int namelen = strlen(refname);
-- 
2.1.0.rc2.206.gedb03e5
