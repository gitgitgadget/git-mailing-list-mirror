From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v5 12/14] fix 'git update-index --verbose --again' output
Date: Thu, 14 Nov 2013 20:23:42 +0100
Message-ID: <5285233E.4010205@gmail.com>
References: <52851FB5.4050406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 20:23:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh2W1-0003ff-7S
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 20:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185Ab3KNTXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 14:23:42 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:63412 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449Ab3KNTXk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 14:23:40 -0500
Received: by mail-wi0-f174.google.com with SMTP id hi5so2396765wib.7
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 11:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IaZOJBcRwE6jyxN9omiOlUrwK9JvnwxKgYC/XacLBC8=;
        b=obEhSsOFb/+SRdilzAcU1jpeQHzQ5/o/C3L7mw86UrwPp1zzIs+SqFvNX1EDselkXa
         X1dpe88vLjKfpK0Ky8xjpyxF848Y0atx539J1MV22aqso8hbMFxvPfCkH6GY17wHWJME
         zZnXflw8GZu1dxSl4KOLIUL801Ir+GN7ZOYO4zahiGQUXZDFRLfNZSU+rie4z2mx+bwN
         aXTZSHsYuNg5noOK/8oZhgt4LCu2wWmyEzX2ewYDDM+hRTIcI63UM73gnMGy5QHjqHrg
         qyXIejLl/umg1ZToDrIk4rtyidJ1l6JL6WyQrb9JbhA4+Rx7kOhgYS18JvkixHHrPVYn
         RY8A==
X-Received: by 10.180.104.129 with SMTP id ge1mr4295132wib.6.1384457019778;
        Thu, 14 Nov 2013 11:23:39 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id mq4sm1625864wic.1.2013.11.14.11.23.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Nov 2013 11:23:39 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <52851FB5.4050406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237873>

'git update-index --verbose' consistently reports paths relative to the
work-tree root. The only exception is the '--again' option, which reports
paths relative to the current working directory.

Change do_reupdate to use non-prefixed paths.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 builtin/update-index.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index e3a10d7..d180d80 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -579,7 +579,7 @@ static int do_reupdate(int ac, const char **av,
 		 * or worse yet 'allow_replace', active_nr may decrease.
 		 */
 		save_nr = active_nr;
-		update_one(ce->name + prefix_length, prefix, prefix_length);
+		update_one(ce->name, NULL, 0);
 		if (save_nr != active_nr)
 			goto redo;
 	}
-- 
1.8.5.rc0.333.g5394214
