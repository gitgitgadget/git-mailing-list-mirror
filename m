From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] hooks/post-receive-email: set encoding to utf-8
Date: Thu, 8 Mar 2012 05:57:54 -0600
Message-ID: <20120308115754.GA2750@burratino>
References: <20120308115119.GA2604@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, Alexey Shumkin <zapped@mail.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jon Jensen <jon@endpoint.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 12:58:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5bz0-0006Ri-NE
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 12:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757410Ab2CHL6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 06:58:05 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:44800 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756901Ab2CHL6D (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 06:58:03 -0500
Received: by obbuo6 with SMTP id uo6so560778obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 03:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6lyk43dIuAHF76ww6P/h+2t1kRscqNB7/KpG62p2GeE=;
        b=DIh0T68a41AfmmSpPPFptHAE8sL+BTMYn/MGyo2oKPfNjZOD3JEB1+iJ2e+ZaM9+LR
         H3zVlthb4rpaj64wpiXh1FgwBERAnDe7bAfL3P/8m8lE9YwVyNzSPt8OGxHKbd2uAKIw
         1gpKweBL+3QQyR8rHXC1Fy45RVd7ATI1KSUXZg0JBffKxBM6jkJM4Iej4vvWT5Gz+LA9
         bbENxCJPEToroddqY/NP28eMgtx1WUJ9Sd7noN2f2AQpOCyBKIY61cqzMdxqFf5ze+QW
         1owrXYtCyMaI4MMnPIi2MvliE4H9dZXFePMD03vrdxUW8OtrHGPsqFz6/j4MTcopLNnr
         1/2w==
Received: by 10.60.26.163 with SMTP id m3mr2261426oeg.40.1331207882428;
        Thu, 08 Mar 2012 03:58:02 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id dy7sm2281275obb.13.2012.03.08.03.58.01
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 03:58:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120308115119.GA2604@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192578>

From: Gerrit Pape <pape@smarden.org>

"git log" generates logs in UTF-8 encoding by default, but the
post-receive-email example hook does not declare any encoding in
the emails it sends.  So add a line there:

+	Content-Type: text/plain; charset=utf-8

[jn: tweaked to also set the Content-Transfer-Encoding so MTAs know
what kind of mangling might be needed when sending to a non 8-bit
clean SMTP host]

Requested-by: Alexander Gerasiov <gq@cs.msu.su>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/hooks/post-receive-email |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 01af9df1..dc184d0b 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -233,6 +233,9 @@ generate_email_header()
 	cat <<-EOF
 	To: $recipients
 	Subject: ${emailprefix}$projectdesc $refname_type $short_refname ${change_type}d. $describe
+	MIME-Version: 1.0
+	Content-Type: text/plain; charset=utf-8
+	Content-Transfer-Encoding: 8bit
 	X-Git-Refname: $refname
 	X-Git-Reftype: $refname_type
 	X-Git-Oldrev: $oldrev
-- 
1.7.9.2
