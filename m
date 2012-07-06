From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/9] vcs-svn: suppress signed/unsigned comparison warnings
Date: Fri, 6 Jul 2012 12:21:21 -0500
Message-ID: <20120706172121.GG31001@burratino>
References: <7v62b4ksw2.fsf@alter.siamese.dyndns.org>
 <CAFfmPPOWZz8JF_BVKvnAVp0VUDzxPiVSqjG7ATPx3CVztDF=cw@mail.gmail.com>
 <20120607003904.GB4065@burratino>
 <7vtxynk81p.fsf@alter.siamese.dyndns.org>
 <20120706171040.GA31001@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <davidbarr@google.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 19:21:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnCDk-0003XD-ON
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 19:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010Ab2GFRV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 13:21:27 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36650 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757669Ab2GFRV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 13:21:26 -0400
Received: by yhmm54 with SMTP id m54so9629978yhm.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LteSW+gI8qZ5it4FHM8qW7H3pPvQyptNzuN7mblHkwc=;
        b=loqFBEzmZQHMXrwjbrSXAZ/gLSZMC5yyqtg0bSonGGj6/LrxRlueUdJlsBSgBULpIO
         R1IymHsiHyWqbPBwMzMMX5POW9xReaF6V04qL4DlbuqB3j2kXROQVi1JNLE1L0Yh5yKK
         YamfsPlt0eySFiFEc7GlN3V1h6rG3FjDXNoVNbhKqMqKdByq3OadZUAiXLiydub+q1fY
         4+8vlLZjWroZw7jIlGseUX6/OHFf8pGkmh7Y6PBavf8//6i6NtCPVBWGrOYxokiz2qns
         j1v80Jld51fr74+Qk46ORMWmNmAGqVYvMhzbTjU4fcWGVWGbWBLlcURxFdOLadrSVbAn
         3KZw==
Received: by 10.50.89.130 with SMTP id bo2mr3157572igb.19.1341595285624;
        Fri, 06 Jul 2012 10:21:25 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id pp4sm5985777igb.5.2012.07.06.10.21.24
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 10:21:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120706171040.GA31001@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201130>

From: David Barr <davidbarr@google.com>
Date: Fri, 1 Jun 2012 00:41:29 +1000

These are already safe because both sides of the comparison are
nonnegative.

This would normally not be important because Git is not -Wsign-compare
clean anyway, but we like to keep the vcs-svn/ lib to a higher
standard for convenience using it in other projects.

Signed-off-by: David Barr <davidbarr@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This is the easy part of what is a larger patch[1] in v2, split out
and given a new description for easier review.

[1] http://thread.gmane.org/gmane.comp.version-control.git/198909/focus=198914

 vcs-svn/fast_export.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 854b328d..1f046978 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -254,7 +254,7 @@ static int parse_ls_response(const char *response, uint32_t *mode,
 	}
 
 	/* Mode. */
-	if (response_end - response < strlen("100644") ||
+	if (response_end - response < (signed) strlen("100644") ||
 	    response[strlen("100644")] != ' ')
 		die("invalid ls response: missing mode: %s", response);
 	*mode = 0;
@@ -267,7 +267,7 @@ static int parse_ls_response(const char *response, uint32_t *mode,
 	}
 
 	/* ' blob ' or ' tree ' */
-	if (response_end - response < strlen(" blob ") ||
+	if (response_end - response < (signed) strlen(" blob ") ||
 	    (response[1] != 'b' && response[1] != 't'))
 		die("unexpected ls response: not a tree or blob: %s", response);
 	response += strlen(" blob ");
-- 
1.7.10.4
