From: Eric Engestrom <eric@engestrom.ch>
Subject: [PATCH] fetch: show reference pointed by new tags
Date: Sun,  6 Mar 2016 22:34:54 +0000
Message-ID: <1457303694-16153-1-git-send-email-eric@engestrom.ch>
Cc: Eric Engestrom <eric@engestrom.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 23:35:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1achGh-0007Wp-G1
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 23:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbcCFWfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 17:35:14 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33572 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbcCFWfN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 17:35:13 -0500
Received: by mail-wm0-f43.google.com with SMTP id l68so86328087wml.0
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 14:35:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wPLGBrxM0jSDwTtp757guH3KRnl6xLB1fUmSHVhJlxw=;
        b=WHddkfPWE5HX6t1Gp3+NII1SJEYrH94C65qpbL627z3wJ/lEt70VfLch/aEJUpBStu
         F3b/LvTtfPWI2Ookrcrini1Ru0eOd8zCmZUy0zKd7+y0y8ele8CwMsxOAKbrPh/xanWe
         MD2E6p4Qd/o1Vjgymn81OsysQRtH72grO/monY+ffYT52e5YHIteoq2l5C7tVUkLy+n6
         pvYIz8JfXhogOyVqT9qfF9ReKohy5xOhRIIArkSMf0g0xilibmCSd8Mk8wHNwkXcSD9x
         IpX9n4KohutDvfkrMU/ZHHIvsWah/Tucj5o4DDSB9NaEDCR7iUoMPWVqZ5wcqmTYyL6C
         gPDQ==
X-Gm-Message-State: AD7BkJLNoRjFQpzzFTMRpd4wWQbmK5QO0tkN8T0S5BD2NK/G+DKGN2jzhlSdZP25Xh83kA==
X-Received: by 10.28.148.16 with SMTP id w16mr9639752wmd.90.1457303712450;
        Sun, 06 Mar 2016 14:35:12 -0800 (PST)
Received: from Eric-XPS.localdomain (cpc87083-finc18-2-0-cust120.4-2.cable.virginm.net. [92.238.93.121])
        by smtp.gmail.com with ESMTPSA id lh1sm14848752wjb.20.2016.03.06.14.35.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 14:35:11 -0800 (PST)
X-Mailer: git-send-email 2.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288367>

Before, new tags had their names shown twice:
 * [new tag]         v4.5-rc6   -> v4.5-rc6

Instead, show the hash of the commit pointed to:
 * [new tag]         v4.5-rc6   -> fc77dbd

Signed-off-by: Eric Engestrom <eric@engestrom.ch>
---

This is my first dive into git's code, so it's likely I'm not doing things
right. The first candidate for that is the literal `7`, which should probably
be a variable, but I couldn't find what I should use instead.

I'd be happy to fix this for a v2 :]

Cheers,
  Eric


 builtin/fetch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e4639d8..93b2145 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -515,6 +515,7 @@ static int update_local_ref(struct ref *ref,
 		if (starts_with(name, "refs/tags/")) {
 			msg = "storing tag";
 			what = _("[new tag]");
+			pretty_ref = find_unique_abbrev(ref->new_oid.hash, 7);
 		} else if (starts_with(name, "refs/heads/")) {
 			msg = "storing head";
 			what = _("[new branch]");
-- 
2.7.2
