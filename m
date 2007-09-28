From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 2/4] Use parse_date_format() in revisions.c to parse the --date parameter
Date: Fri, 28 Sep 2007 15:17:31 +0100
Message-ID: <200709281517.32030.andyparkins@gmail.com>
References: <200709281516.05438.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 16:18:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbGfA-0001MF-Pt
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 16:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759397AbXI1ORi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 10:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759362AbXI1ORi
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 10:17:38 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:3222 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759384AbXI1ORh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 10:17:37 -0400
Received: by fk-out-0910.google.com with SMTP id z23so3083572fkz
        for <git@vger.kernel.org>; Fri, 28 Sep 2007 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=mFcObTKFnLGWKyArLSmI33KRQiKx3Wn2aSAVVctnS3U=;
        b=U+TqKtMehMxxu1L2vJ8OYIBegKYH9OejbAJZZ5RwonBMJIH8bbZQVcHz1xZVe9Nv6UIzwdZzzjgWk1LoFf7BIzqDWv2BsHYCtAlQtwSUpi/iIteiFr2454PHQzWi0xpirqBQ0vm/7vctWtJhw5QcA9TqKucfwDsJMRfthPMYzRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=WmZdws4dcDrYU1J0VicpJWq3/0B6oapYXs/HKU1QDxJJ0kWKEVnaFvPcCw+MYcYfCOyKMqIV7RJvXP6Cjz70Ltt+NOfkyEhhSt5po0G0m6U2+6NO404mrhia3pQZzxWSqmQarJhqiS5tEAsetuadKguN7L5IdLJ9n3qbjnvrpm8=
Received: by 10.82.181.10 with SMTP id d10mr3620408buf.1190989054335;
        Fri, 28 Sep 2007 07:17:34 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id k5sm6294012nfh.2007.09.28.07.17.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Sep 2007 07:17:33 -0700 (PDT)
In-Reply-To: <200709281516.05438.andyparkins@gmail.com>
X-TUID: 762fbb281504adc2
X-UID: 333
X-Length: 1663
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59397>

The --date parameter was previously handled in revisions.c with a list
of if(strcmp()) calls; now parse_date_format() is called instead.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 revision.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/revision.c b/revision.c
index 33d092c..75cd0c6 100644
--- a/revision.c
+++ b/revision.c
@@ -1134,22 +1134,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				continue;
 			}
 			if (!strncmp(arg, "--date=", 7)) {
-				if (!strcmp(arg + 7, "relative"))
-					revs->date_mode = DATE_RELATIVE;
-				else if (!strcmp(arg + 7, "iso8601") ||
-					 !strcmp(arg + 7, "iso"))
-					revs->date_mode = DATE_ISO8601;
-				else if (!strcmp(arg + 7, "rfc2822") ||
-					 !strcmp(arg + 7, "rfc"))
-					revs->date_mode = DATE_RFC2822;
-				else if (!strcmp(arg + 7, "short"))
-					revs->date_mode = DATE_SHORT;
-				else if (!strcmp(arg + 7, "local"))
-					revs->date_mode = DATE_LOCAL;
-				else if (!strcmp(arg + 7, "default"))
-					revs->date_mode = DATE_NORMAL;
-				else
-					die("unknown date format %s", arg);
+				revs->date_mode = parse_date_format(arg + 7);
 				continue;
 			}
 			if (!strcmp(arg, "--log-size")) {
-- 
1.5.3.2.105.gf47f2-dirty
