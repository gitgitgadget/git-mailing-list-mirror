From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 20/24] for-each-ref.c: improve message before aborting on
 broken ref
Date: Wed, 1 Oct 2014 19:30:57 -0700
Message-ID: <20141002023057.GM1175@google.com>
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
X-From: git-owner@vger.kernel.org Thu Oct 02 04:31:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZWAc-0001tX-1y
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbaJBCbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:31:01 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:38312 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbaJBCbA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:31:00 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so1236672pdb.25
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5N7jpebm5tL3hN/XSsiGoMRQafs0njDFfNKpWlr6hxA=;
        b=OEuSwi6nfJuIc7bCGXVTtdhoiahOsrUWRj/p6STsHG5wFfSIhwoFRhLDCQGJTdh/ee
         w5DM6dOrgP06gDeIneT4rIfJd3yPf3RSVxxGivdzpVKqcs8/VKcfUfOBPDJvyyu9ycj+
         DsTdk8IyNBf8TIOu9JQWt388f+4EvCSSZ0Mdf91p02wtzY5MA8bQounSAzWrq9XPv/FE
         VPEhbn5rs72WXjvocXzUWv84nt/OmV+JR60/4sSXEaFM8SH4rP5sFt3o9yQdhSFNTlgN
         +C4icWFKNOcAB4rqA5r00Dqe+0qgubZ8o6aPseO8WVXjOQgkbkvIOfywJanMSHdKxCdB
         +WrA==
X-Received: by 10.68.68.131 with SMTP id w3mr45833834pbt.93.1412217060411;
        Wed, 01 Oct 2014 19:31:00 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ro7sm2178979pab.25.2014.10.01.19.30.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:30:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257791>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Fri, 5 Sep 2014 14:35:17 -0700

Print a warning message for any badly named refs we find in the repo.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As before.

 builtin/for-each-ref.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 20949b7..a88d681 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -853,6 +853,11 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
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
