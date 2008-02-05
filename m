From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Fix parsing numeric color values
Date: Tue, 5 Feb 2008 21:18:21 +0200
Message-ID: <20080205211821.e4a15194.tihirvon@gmail.com>
References: <47A89E2A.9010905@kergoth.com>
	<20080205203940.1dcff0ce.tihirvon@gmail.com>
	<b6ebd0a50802051045t4949df68u7e405ea618403a31@mail.gmail.com>
	<20080205205856.76a7cd45.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Chris Larson" <clarson@kergoth.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 20:19:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMTKc-0005zq-5B
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 20:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758763AbYBETSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 14:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758255AbYBETSd
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 14:18:33 -0500
Received: from wr-out-0506.google.com ([64.233.184.235]:55861 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757250AbYBETSc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 14:18:32 -0500
Received: by wr-out-0506.google.com with SMTP id c48so2239624wra.23
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 11:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=eB+IjekKrymGbDtCVIUtflS5qTxijOPYepWhGezKjZk=;
        b=M3c2yywBuUn6f/FmCHpLqJhPC8dd00jGr7/MuIvnOFcz0qEV6oLUH4uH1/kJWOrYlTYNhgLwXiUrDf9sGI677YiGZ5geUR86fTo1EIv/rHytUuM/RDn5FgmsK7PqsVXw3Ol7+DFhBwF/9Cg0HIldB2wIy40jfQk6UJiROiVbsH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=q/SNnRcFL0khrZmoC9Wkl7RdFWr4eyCdTEtAJQBoppbJTkjtuGFuP5K/DLS27vd+OIw1SoPZEbudS5T5FHHuW+00wZcHNiQybx8A1V614uuJr637ETOceADgdM0+xUpGIFd2JhUR/t9kymwBPFsb9WTFlvTC6+IlLMBsUDWF7wI=
Received: by 10.114.89.1 with SMTP id m1mr2965513wab.77.1202239108113;
        Tue, 05 Feb 2008 11:18:28 -0800 (PST)
Received: from garlic.home.net ( [85.23.16.168])
        by mx.google.com with ESMTPS id 1sm24072604nfv.3.2008.02.05.11.18.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Feb 2008 11:18:27 -0800 (PST)
In-Reply-To: <20080205205856.76a7cd45.tihirvon@gmail.com>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72680>

Fix bug reported by Chris Larson <clarson@kergoth.com>.  Numeric color
only worked if it was at end of line.
---
 color.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/color.c b/color.c
index 7f66c29..3c999c3 100644
--- a/color.c
+++ b/color.c
@@ -17,7 +17,7 @@ static int parse_color(const char *name, int len)
 			return i - 1;
 	}
 	i = strtol(name, &end, 10);
-	if (*name && !*end && i >= -1 && i <= 255)
+	if (*name && (!*end || isspace(*end)) && i >= -1 && i <= 255)
 		return i;
 	return -2;
 }
-- 
1.5.4.1134.ge34cf-dirty
