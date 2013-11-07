From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v4 12/14] fix 'git update-index --verbose --again' output
Date: Thu, 07 Nov 2013 15:43:18 +0100
Message-ID: <527BA706.6010307@gmail.com>
References: <527BA483.6040803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 15:43:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeQno-0002dh-E1
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 15:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499Ab3KGOnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 09:43:17 -0500
Received: from mail-ee0-f48.google.com ([74.125.83.48]:61384 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab3KGOnP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 09:43:15 -0500
Received: by mail-ee0-f48.google.com with SMTP id d49so350318eek.7
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 06:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+3CNWSwQMuxkTuA62Valo7Kx1Sz0czxm4lRQCsref7U=;
        b=IT2XfxOmIu4agBxIdw9GjT7PeMT7fdKohdQpCo7gIBq9IprT0zYZW+e7ULv4YH13Mo
         0x2qCu03wG+hMWVVYPLYAB+NFXWj8HlcBRO450QwC9NyyN9gbTgJNIbYB3MYfcboegoB
         ahzjJFmm5i+AkJsuuZI+pVV5Q7zvGsbb+pqIQkIjr86Hr3z/FDvoS7+c8ZOziyi81Qvi
         eNamUeaH7we2z/sTH3faP1FhoIbVH9R25QJMoqq+COFyclvi5fzcMKMHwmLdUW4Ua1UF
         K5jeoUEEHoAkzk7mzhtOs57ukmXL/pOou9g1YwJQAju2AQLG6I7v1wLpzmGVhJWjQc0U
         5BZA==
X-Received: by 10.14.111.129 with SMTP id w1mr2300026eeg.83.1383835394932;
        Thu, 07 Nov 2013 06:43:14 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id a6sm10008046eei.10.2013.11.07.06.43.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 06:43:14 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527BA483.6040803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237407>

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
1.8.4.msysgit.0.12.g88f5ed0
