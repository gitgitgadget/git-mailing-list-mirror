From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH 2/3] Win32: replace MSVCRT's fstat() with a
 Win32-based implementation
Date: Thu, 12 Feb 2015 00:52:06 +0100
Message-ID: <54DBEB26.6020403@gmail.com>
References: <54DBEAA5.6000205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
X-From: msysgit+bncBCH3XYXLXQDBBJGW56TAKGQEYNEF3NI@googlegroups.com Thu Feb 12 00:52:05 2015
Return-path: <msysgit+bncBCH3XYXLXQDBBJGW56TAKGQEYNEF3NI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f55.google.com ([209.85.215.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCH3XYXLXQDBBJGW56TAKGQEYNEF3NI@googlegroups.com>)
	id 1YLh4f-0007ok-Ch
	for gcvm-msysgit@m.gmane.org; Thu, 12 Feb 2015 00:52:05 +0100
Received: by labgd6 with SMTP id gd6sf1688277lab.2
        for <gcvm-msysgit@m.gmane.org>; Wed, 11 Feb 2015 15:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe;
        bh=kVOY3oH3t3pEqRjikPavbash99DV6VN6EvJomcLox4Q=;
        b=eUh73fzsV6XywWb455nSX1b3M/c5oLQc68/VOZ1yLKUFAmPGiIMbVJKlx/d74meonm
         CpOvbuuDD6jx/bDmDuoMNXFe/AWnV56C4CCIy8ZRX88o7oNYSc2Xf6WdFrPlgw9BrzL/
         V68TK1JyKkVvrFi+LHf9I8BENY7eGmkO0FbWYx183EKAR3CQtXRsV5dCbmEgTXOR990f
         +rxetQo3VQs4K4Kj53Okob8xceinXT1OF5GSoecnpjrIVlXmtfwPbKPl2x2g6vQv5Orq
         GHEr43eolstuO2hIC+wzCPQBwNoO/hTOtTeufyY9G83ckI0BAp1BlsvasYSYXKLh1V4M
         8whA==
X-Received: by 10.180.79.10 with SMTP id f10mr5080wix.8.1423698725118;
        Wed, 11 Feb 2015 15:52:05 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.102.131 with SMTP id fo3ls20689wib.39.canary; Wed, 11 Feb
 2015 15:52:04 -0800 (PST)
X-Received: by 10.181.13.236 with SMTP id fb12mr21728wid.1.1423698724424;
        Wed, 11 Feb 2015 15:52:04 -0800 (PST)
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com. [2a00:1450:400c:c05::235])
        by gmr-mx.google.com with ESMTPS id o9si35514wiw.0.2015.02.11.15.52.04
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2015 15:52:04 -0800 (PST)
Received-SPF: pass (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::235 as permitted sender) client-ip=2a00:1450:400c:c05::235;
Received: by mail-wi0-x235.google.com with SMTP id r20so367954wiv.2
        for <msysgit@googlegroups.com>; Wed, 11 Feb 2015 15:52:04 -0800 (PST)
X-Received: by 10.194.134.105 with SMTP id pj9mr1724572wjb.143.1423698724370;
        Wed, 11 Feb 2015 15:52:04 -0800 (PST)
Received: from [10.1.116.53] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id dj4sm3307900wjc.13.2015.02.11.15.52.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Feb 2015 15:52:03 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <54DBEAA5.6000205@gmail.com>
X-Original-Sender: karsten.blees@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of karsten.blees@gmail.com designates 2a00:1450:400c:c05::235
 as permitted sender) smtp.mail=karsten.blees@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263704>

fstat() is the only stat-related CRT function for which we don't have a
full replacement yet (and thus the only reason to stick with MSVCRT's
'struct stat' definition).

Fully implement fstat(), in preparation of implementing a POSIX 2013
compatible 'struct stat' with nanosecond-precision file times.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 compat/mingw.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index ba3cfb0..6d73a3d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -532,28 +532,38 @@ int mingw_fstat(int fd, struct stat *buf)
 {
 	HANDLE fh = (HANDLE)_get_osfhandle(fd);
 	BY_HANDLE_FILE_INFORMATION fdata;
+	DWORD avail;
 
 	if (fh == INVALID_HANDLE_VALUE) {
 		errno = EBADF;
 		return -1;
 	}
-	/* direct non-file handles to MS's fstat() */
-	if (GetFileType(fh) != FILE_TYPE_DISK)
-		return _fstati64(fd, buf);
 
-	if (GetFileInformationByHandle(fh, &fdata)) {
-		buf->st_ino = 0;
-		buf->st_gid = 0;
-		buf->st_uid = 0;
-		buf->st_nlink = 1;
+	/* initialize stat fields */
+	memset(buf, 0, sizeof(*buf));
+	buf->st_nlink = 1;
+
+	switch (GetFileType(fh) & ~FILE_TYPE_REMOTE) {
+	case FILE_TYPE_DISK:
+		if (!GetFileInformationByHandle(fh, &fdata))
+			break;
 		buf->st_mode = file_attr_to_st_mode(fdata.dwFileAttributes);
 		buf->st_size = fdata.nFileSizeLow |
 			(((off_t)fdata.nFileSizeHigh)<<32);
-		buf->st_dev = buf->st_rdev = 0; /* not used by Git */
 		buf->st_atime = filetime_to_time_t(&(fdata.ftLastAccessTime));
 		buf->st_mtime = filetime_to_time_t(&(fdata.ftLastWriteTime));
 		buf->st_ctime = filetime_to_time_t(&(fdata.ftCreationTime));
 		return 0;
+
+	case FILE_TYPE_CHAR:
+		buf->st_mode = _S_IFCHR;
+		return 0;
+
+	case FILE_TYPE_PIPE:
+		buf->st_mode = _S_IFIFO;
+		if (PeekNamedPipe(fh, NULL, 0, NULL, &avail, NULL))
+			buf->st_size = avail;
+		return 0;
 	}
 	errno = EBADF;
 	return -1;
-- 
2.3.0.3.ge7778af


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
