From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH] Remove useless temporary integer in builtin/push.c
Date: Thu, 29 Jul 2010 11:59:23 -0400
Message-ID: <70ee84752cb7db08c65c608a12ed321dd2c26830.1280419073.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 29 17:59:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeVWI-0005vH-Gi
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 17:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757897Ab0G2P7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 11:59:35 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39636 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416Ab0G2P7e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 11:59:34 -0400
Received: by gwb20 with SMTP id 20so187059gwb.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 08:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=Dmyg815PyYOlstn26xhQoRlmrnKTetXVDH9DTjB8dnw=;
        b=ElNSG4nrZC4PiXn34TPcxXWDf45HAEHQgBqBoDLVVTa/I1NAN2MI2XyKIljTOSfzrB
         oOjCbm9XDDybj8SnZNLc46anXsH2qX7AMr1i37VGtKuluqwTzguNfSGPA+Q7oT2d2qwv
         77JxTVEcO4IgBZygV5gyFV7ugck1zfiXt0gLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=bgPYtn7pJuwo/8ogpZ6sA3FoIm0e4wyuNHr2/Awa5eiQ4Ym3ffcyIy+PlC5PX1CSrG
         Iq9hDCb7vZzXR+YqQZ0x+1tB2BjOAWivi7WhCygrYtI+ba6ocOi42CoBrqio+lF5B78U
         rKxiDbNE4Ef7uc+Z4nZAp0fErl8cQ5igoog3M=
Received: by 10.150.202.9 with SMTP id z9mr1303341ybf.3.1280419172651;
        Thu, 29 Jul 2010 08:59:32 -0700 (PDT)
Received: from localhost.localdomain ([38.109.159.254])
        by mx.google.com with ESMTPS id h41sm1199069qcz.1.2010.07.29.08.59.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Jul 2010 08:59:31 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152183>

Creating a variable nr here to use throughout the function only to change
refspec_nr to nr at the end, having not used refspec_nr the entire time,
is rather pointless. Instead, simply increment refspec_nr.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 builtin/push.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index f4358b9..79d8192 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -25,10 +25,9 @@ static int refspec_nr;
 
 static void add_refspec(const char *ref)
 {
-	int nr = refspec_nr + 1;
-	refspec = xrealloc(refspec, nr * sizeof(char *));
-	refspec[nr-1] = ref;
-	refspec_nr = nr;
+	refspec_nr++;
+	refspec = xrealloc(refspec, refspec_nr * sizeof(char *));
+	refspec[refspec_nr-1] = ref;
 }
 
 static void set_refspecs(const char **refs, int nr)
-- 
1.7.2
