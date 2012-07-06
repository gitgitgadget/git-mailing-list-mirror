From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/9] vcs-svn: suppress a signed/unsigned comparison warning
Date: Fri, 6 Jul 2012 12:22:54 -0500
Message-ID: <20120706172254.GH31001@burratino>
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
X-From: git-owner@vger.kernel.org Fri Jul 06 19:23:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnCFF-0006Wx-Ng
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 19:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860Ab2GFRXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 13:23:00 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45252 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234Ab2GFRW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 13:22:59 -0400
Received: by yhmm54 with SMTP id m54so9631666yhm.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rCv9STj5NK3UA+MesO5if2prTk1KBWGj1p+3kNbgQo8=;
        b=w0jTyob72GKL7KwgMdlaYykNSO5EJs3O+JPDHcmzW1QQE/jVIdXvrs/+7SzDlqhe8B
         Qg0v/Hh44Bgz+Vx4zQozrKzDNavqsgTa3XekrCfPmGB5mJ7q0L25GfedNLT5lh7QfRR6
         9ThqaJT9Ijtvz2GEARa8gXZjy1dsE7fTu2nxqv+6vDobodN0HP9ojLzxGkqEFiWoRXif
         d7x2pLExGkR+9wPKkywt72rk2MA2lDJphvk3mSJEW81n1z8PRVVHRK5vjo12D/ORUK63
         2FRiSSjoRwqJt/2haqO+Ev/L/nXH9Gw3WcL37ugQnOx+5StrvVxDQC4QzJcy0I2hxH1p
         GqPg==
Received: by 10.50.156.133 with SMTP id we5mr2967308igb.62.1341595378399;
        Fri, 06 Jul 2012 10:22:58 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id wp10sm5988986igb.6.2012.07.06.10.22.57
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 10:22:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120706171040.GA31001@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201131>

From: David Barr <davidbarr@google.com>
Date: Fri, 1 Jun 2012 00:41:29 +1000

The preceding code checks that view->max_off is nonnegative and
(off + width) fits in an off_t, so this code is already safe.

Signed-off-by: David Barr <davidbarr@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Another unobjectionable piece from v2's patch 5.  The new change
description explains why it's unobjectionable to save future readers
some time.

 vcs-svn/sliding_window.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vcs-svn/sliding_window.c b/vcs-svn/sliding_window.c
index ec2707c9..f11d4909 100644
--- a/vcs-svn/sliding_window.c
+++ b/vcs-svn/sliding_window.c
@@ -54,7 +54,7 @@ int move_window(struct sliding_view *view, off_t off, size_t width)
 		return -1;
 	if (off < view->off || off + width < view->off + view->width)
 		return error("invalid delta: window slides left");
-	if (view->max_off >= 0 && view->max_off < off + width)
+	if (view->max_off >= 0 && view->max_off < off + (off_t) width)
 		return error("delta preimage ends early");
 
 	file_offset = view->off + view->buf.len;
-- 
1.7.10.4
