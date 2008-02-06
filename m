From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH v2] Fix parsing numeric color values
Date: Wed, 6 Feb 2008 14:16:08 +0200
Message-ID: <20080206141608.1a992041.tihirvon@gmail.com>
References: <47A89E2A.9010905@kergoth.com>
	<20080205203940.1dcff0ce.tihirvon@gmail.com>
	<b6ebd0a50802051045t4949df68u7e405ea618403a31@mail.gmail.com>
	<20080205205856.76a7cd45.tihirvon@gmail.com>
	<20080205211821.e4a15194.tihirvon@gmail.com>
	<7vzluez9q9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 13:16:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMjCu-0006zu-5Z
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 13:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762296AbYBFMQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 07:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762257AbYBFMQR
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 07:16:17 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:64025 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762225AbYBFMQP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 07:16:15 -0500
Received: by wa-out-1112.google.com with SMTP id v27so427513wah.23
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 04:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=hNjpbFQ1i/856aCV/a5tJ0e5p/PEzqHWraFmLuDwbuc=;
        b=GAJwiE9J1MCHM5Q4TTunscfpdC3yX8Pu/MSqXRSgLnVZt8bRqijgEQ6fZXXjhnQvzhHMc06fLdO/BVHaPM8wJVD+Jou1blu6PcG6wtJLVxtYSZaFrk9lRXEoFStmWjqM0UlQ8waB7eSg2e6TR53dutpgtsHZH2WdNZFldUatA4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=dkRo9HuSgXLShdn2jgbc/EsPZtu/LjNdwwJfwPGISXx4dyvvJPQCBV2I4nRpY5hEYxeqramWjdF0J6/y05a2YToxvq4Agwti/nD9/U4D4sVQzbq0b+GgcTxp5Cqe4tVf4lsL0eJIfVboDZz2nVPFYqpi7FlYOCpPuVVNRYRqRCA=
Received: by 10.114.27.20 with SMTP id a20mr3013742waa.101.1202300174505;
        Wed, 06 Feb 2008 04:16:14 -0800 (PST)
Received: from garlic.home.net ( [85.23.16.168])
        by mx.google.com with ESMTPS id d27sm5214014nfh.34.2008.02.06.04.16.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Feb 2008 04:16:13 -0800 (PST)
In-Reply-To: <7vzluez9q9.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72806>

Numeric color only worked if it was at end of line.
Noticed by Chris Larson <clarson@kergoth.com>.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 color.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/color.c b/color.c
index 7f66c29..cb70340 100644
--- a/color.c
+++ b/color.c
@@ -17,7 +17,7 @@ static int parse_color(const char *name, int len)
 			return i - 1;
 	}
 	i = strtol(name, &end, 10);
-	if (*name && !*end && i >= -1 && i <= 255)
+	if (end - name == len && i >= -1 && i <= 255)
 		return i;
 	return -2;
 }
-- 
1.5.4.1135.gae084
