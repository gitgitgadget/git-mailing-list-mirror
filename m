From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH 1/2] Remove useless temporary integer in builtin/push.c
Date: Sat, 31 Jul 2010 08:54:55 -0400
Message-ID: <70ee84752cb7db08c65c608a12ed321dd2c26830.1280580026.git.jaredhance@gmail.com>
References: <201007300021.34061.trast@student.ethz.ch>
 <cover.1280580026.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 31 14:55:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfBan-0005BY-2q
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 14:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab0GaMzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jul 2010 08:55:01 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55783 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab0GaMy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 08:54:59 -0400
Received: by mail-qy0-f174.google.com with SMTP id 7so4437909qyk.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 05:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Dmyg815PyYOlstn26xhQoRlmrnKTetXVDH9DTjB8dnw=;
        b=WgYs2W/G+71b2dxm8kepepuMAWF6b/1CjkjeBInwvXp/JNnyDX/8Xpu01M//jM+jnq
         oeKY/ImVxWqzuNPn9FJG5j63YX2nq/hUFw+DcfsHTnn2rfLlWZXbkoo+uOi5P0A7ODUz
         2PT0B9a2oJShu2SCS5w8pz5XwiYtDtaqK3ML8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Dthlt3Wo/tQ5xvvjy298ys/y0Y1VRsjKguVN3DcWmSzVtuNjMijY8qINkK7GV19vmE
         b/PWohX0mAnBHfTWi58PvoNA36L81qPJOIWC7Umj8qsyKljLhjeie4tIZekwr4BkpDBH
         4B80PJc5wbdILwbziW+lU5y/yQuNyGQcn/G48=
Received: by 10.220.60.203 with SMTP id q11mr2174404vch.28.1280580899346;
        Sat, 31 Jul 2010 05:54:59 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-209-27.cinci.res.rr.com [174.101.209.27])
        by mx.google.com with ESMTPS id y25sm2531447vbw.16.2010.07.31.05.54.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 05:54:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1280580026.git.jaredhance@gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152323>

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
