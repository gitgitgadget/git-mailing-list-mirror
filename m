From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2] repack.c: Use move_temp_to_file() instead of rename()
Date: Mon, 27 Jan 2014 21:24:42 +0100
Message-ID: <201401272124.42978.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: tboegi@web.de,
 zwanzig12@googlemail.com,
 stefanbeller@googlemail.com,
 kusmabite@gmail.com,
 Johannes.Schindelin@gmx.de,
 msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: msysgit+bncBCUZ3EUT2ADRBE4BTOLQKGQEGVE6DUQ@googlegroups.com Mon Jan 27 21:24:53 2014
Return-path: <msysgit+bncBCUZ3EUT2ADRBE4BTOLQKGQEGVE6DUQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-bk0-f63.google.com ([209.85.214.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCUZ3EUT2ADRBE4BTOLQKGQEGVE6DUQ@googlegroups.com>)
	id 1W7sjk-0004KN-E4
	for gcvm-msysgit@m.gmane.org; Mon, 27 Jan 2014 21:24:52 +0100
Received: by mail-bk0-f63.google.com with SMTP id w16sf968081bkz.28
        for <gcvm-msysgit@m.gmane.org>; Mon, 27 Jan 2014 12:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=subject:to:cc:from:date:mime-version:message-id:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-transfer-encoding;
        bh=slG3zASh8Ch1TlRlkj6DmogOfSLJPxzJ2MYHN7RMj1k=;
        b=R6AkXs81U3Tx6SV4EqPnbnPz2lGJL0KhDQd1U+RVugyTmKtPi1v9Tb2B2YOyWYHpEh
         79LE79oTIBp6C2Nfj4dCNOM5Xx9RWIx84hPSw0aUVpyHxlfKmT8JDWlc02D8pO+SuKX8
         YRH+GcAeX0oROCZP3GDHiXwifmvtIp6BBqn+WYcEA3wYS2iFkpSGQ1r09V9qlgxMLKJ1
         7zdaucdeBFfzu0neVnZn4dFL//JhXygaOydI8LPVgRiseX5YawTYaBFdS3fChWnj96Vt
         o7L+r4nJg++bg206lG27oKr3kCPdENnQOFltJprUjyuTQc1kK7zXkhz7+Ke/pDiyB81L
         NO0w==
X-Received: by 10.180.105.137 with SMTP id gm9mr281502wib.3.1390854292194;
        Mon, 27 Jan 2014 12:24:52 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.160.146 with SMTP id xk18ls418099wib.48.gmail; Mon, 27 Jan
 2014 12:24:51 -0800 (PST)
X-Received: by 10.180.211.34 with SMTP id mz2mr13207598wic.3.1390854291145;
        Mon, 27 Jan 2014 12:24:51 -0800 (PST)
Received: from mout.web.de (mout.web.de. [212.227.15.3])
        by gmr-mx.google.com with ESMTPS id f47si1959704eem.0.2014.01.27.12.24.50
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jan 2014 12:24:51 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of tboegi@web.de designates 212.227.15.3 as permitted sender) client-ip=212.227.15.3;
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0LcPSk-1VO8bE2QDe-00juWS for <msysgit@googlegroups.com>;
 Mon, 27 Jan 2014 21:24:50 +0100
X-Provags-ID: V03:K0:/8Su9rHXs0HNpKXHx0GNJtMsOoy9FlXJ5tuwDuKhMkZwkokaDLT
 APLt1TrymzsQQWGGmUQoQ96hlljwIq2J/y8diKW709Z7eTmCgKn3k26Dy5dJg0iRdvsv5nz
 KOalF77pSPgqn22j0/kFl2+7e8vfynv+GbMSJHJ8s7oX1nSjyRVqnpbNwRSG1Ny22jEzeBv
 LCEM1jnVrPcgQj3yBh4+g==
X-Original-Sender: tboegi@web.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of tboegi@web.de designates
 212.227.15.3 as permitted sender) smtp.mail=tboegi@web.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241154>

In a1bbc6c0 a shell command "mv -f" was replaced with the rename() function=
.

Use move_temp_to_file() from sha1_file.c instead of rename().
This is in line with the handling of other Git internal tmp files,
and calls adjust_shared_perm()

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Thanks for all comments.
I haven't been able to reproduce the problem here.
Tips and information how to reproduce it are wellcome.

I think this patch makes sense to support core.sharedRepository(),
but I haven't made a test case for the pack/idx files.

Jochen, doess this patch fix your problem, or do we need
another patch on top of this?

 builtin/repack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index ba66c6e..4b6d663 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -271,7 +271,7 @@ int cmd_repack(int argc, const char **argv, const char =
*prefix)
 				if (unlink(fname_old))
 					failed =3D 1;
=20
-			if (!failed && rename(fname, fname_old)) {
+			if (!failed && move_temp_to_file(fname, fname_old)) {
 				free(fname);
 				failed =3D 1;
 				break;
@@ -288,7 +288,7 @@ int cmd_repack(int argc, const char **argv, const char =
*prefix)
 			char *fname, *fname_old;
 			fname =3D mkpathdup("%s/%s", packdir, item->string);
 			fname_old =3D mkpath("%s/old-%s", packdir, item->string);
-			if (rename(fname_old, fname))
+			if (move_temp_to_file(fname_old, fname))
 				string_list_append(&rollback_failure, fname);
 			free(fname);
 		}
@@ -324,7 +324,7 @@ int cmd_repack(int argc, const char **argv, const char =
*prefix)
 				statbuffer.st_mode &=3D ~(S_IWUSR | S_IWGRP | S_IWOTH);
 				chmod(fname_old, statbuffer.st_mode);
 			}
-			if (rename(fname_old, fname))
+			if (move_temp_to_file(fname_old, fname))
 				die_errno(_("renaming '%s' failed"), fname_old);
 			free(fname);
 			free(fname_old);
--=20
1.8.5.2

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
