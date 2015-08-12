From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH jk/prune-mtime] prune: close directory earlier
 during loose-object directory traversal
Date: Wed, 12 Aug 2015 19:43:01 +0200
Message-ID: <55CB85A5.5040802@kdbg.org>
References: <55CA5EB0.1000308@kdbg.org>
 <b9cf9e2168c3b2476bb5bb134a1528be@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysGit <msysgit@googlegroups.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: msysgit+bncBCJYV6HBKQIKPC5OVYCRUBBDONH6Q@googlegroups.com Wed Aug 12 19:43:05 2015
Return-path: <msysgit+bncBCJYV6HBKQIKPC5OVYCRUBBDONH6Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f56.google.com ([209.85.215.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCJYV6HBKQIKPC5OVYCRUBBDONH6Q@googlegroups.com>)
	id 1ZPa3M-0002gw-Sl
	for gcvm-msysgit@m.gmane.org; Wed, 12 Aug 2015 19:43:05 +0200
Received: by labqg3 with SMTP id qg3sf6101576lab.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 12 Aug 2015 10:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=Ihop5vYWqNrwSPEnGcr1qf57nRSkOtki10tTGDRz/GI=;
        b=Gqeb+cKsPSHPuotWVLuJfTkYl0f63A/MKQyKfRJryGTI9aY/mHrgz0eDYd6TxvHMPg
         +3Tbobo9V/xM1qTiXt90uL7JALpxE1Ejt3m6cSxQoSqaYyjKdXutyvjxvglZ8f+ycUlY
         lT4fC+nf3tHqxoQ9ZrgxUcLz1PkZuIxAtgc8xlWhccmxHqDcD3reGasxfXFSpwTh8k6a
         ImzEDKo5l9TKC66qoIzuFMislq8lcbd4RgX+C5loRfnyGAB5SRGdZWHwlJy5b1f2Hg9I
         4EMq8M0/9rkrnTElf9Bs5jXUw3pEdPyZMvwYFdiKGYIVrWpJxRAkTjxSNeZkVg5baF0j
         +u+Q==
X-Received: by 10.152.120.103 with SMTP id lb7mr122499lab.29.1439401384667;
        Wed, 12 Aug 2015 10:43:04 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.205.33 with SMTP id ld1ls79298lac.6.gmail; Wed, 12 Aug
 2015 10:43:02 -0700 (PDT)
X-Received: by 10.113.3.8 with SMTP id bs8mr10019910lbd.23.1439401382916;
        Wed, 12 Aug 2015 10:43:02 -0700 (PDT)
Received: from bsmtp8.bon.at (bsmtp8.bon.at. [213.33.87.20])
        by gmr-mx.google.com with ESMTPS id c3si667028wiz.2.2015.08.12.10.43.02
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2015 10:43:02 -0700 (PDT)
Received-SPF: neutral (google.com: 213.33.87.20 is neither permitted nor denied by best guess record for domain of j6t@kdbg.org) client-ip=213.33.87.20;
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3mryzp1z89z5tlF;
	Wed, 12 Aug 2015 19:43:02 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 8F77452DE;
	Wed, 12 Aug 2015 19:43:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <b9cf9e2168c3b2476bb5bb134a1528be@www.dscho.org>
X-Original-Sender: j6t@kdbg.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 213.33.87.20 is neither permitted nor denied by best guess
 record for domain of j6t@kdbg.org) smtp.mailfrom=j6t@kdbg.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275787>

27e1e22d (prune: factor out loose-object directory traversal, 2014-10-16)
introduced a new function for_each_loose_file_in_objdir() with a helper
for_each_file_in_obj_subdir(). The latter calls callbacks for each file
found during a directory traversal and finally also a callback for the
directory itself.

git-prune uses the function to clean up the object directory. In
particular, in the directory callback it calls rmdir(). On Windows XP,
this rmdir call fails, because the directory is still open while the
callback is called. Close the directory before calling the callback.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 My Windows 8.1 machine does not require this fix for some unkonwn
 reason. But we still cater for Windows XP users, where this change
 is a real improvement.

 sha1_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4d1b26f..5cecc68 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3473,12 +3473,12 @@ static int for_each_file_in_obj_subdir(int subdir_nr,
 				break;
 		}
 	}
+	closedir(dir);
+
 	strbuf_setlen(path, baselen);
-
 	if (!r && subdir_cb)
 		r = subdir_cb(subdir_nr, path->buf, data);
 
-	closedir(dir);
 	return r;
 }
 
-- 
2.3.2.245.gb5bf9d3

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
