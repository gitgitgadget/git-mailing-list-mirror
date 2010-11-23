From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [RFC PATCH 0/6] win32-dirent
Date: Tue, 23 Nov 2010 18:30:38 +0100
Message-ID: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org, gitster@pobox.com,
	jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 18:31:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKwiL-0003bQ-FT
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199Ab0KWRbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 12:31:20 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38329 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab0KWRbU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 12:31:20 -0500
Received: by eye27 with SMTP id 27so4809402eye.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 09:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Y7F4awx3rWET8lX8OvHzw/+Np3iOeFyykjHaR2bLJnU=;
        b=pUvr/7c6WgsiN8OlpzgLSYCNtB6dHeXQdAc11ag/+YwIi7nGs9m/1aeJQI7wtIjFXV
         XrkEhGEQKJkfdxDNF05QIp4V4J9I1BWSLAxLnEO7ilGqyzRV7JKrAaaEi6XBswlMtvrr
         QB6YKDHiQ0B8tzLbjrcPt1PXjAphpk7IWZqwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ir+/8X9rFmv+2lsNt9bmYQkYvGY0kY+tk2clcb2ktl8r08Xk5CA4ev7W498XxFLhEk
         0s3Dj9NoGS14WIG3965ygaFpwMOh1z6TI8rJhYnsY5QFtcx7kPzMHnlhFyCp36V5NhKb
         vzs6O0TFg4NlkHIlXJRKewsgJOodUeUnLYCqw=
Received: by 10.213.34.66 with SMTP id k2mr1899538ebd.90.1290533478536;
        Tue, 23 Nov 2010 09:31:18 -0800 (PST)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id v51sm6013237eeh.10.2010.11.23.09.31.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 09:31:17 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.493.ge4bf7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161984>

This series is against 'next', and fixes the problem on Windows introduced
by commit 3ba7a06 ("A loose object is not corrupt if it cannot be read due
to EMFILE").

It unifies the dirent-emulation in compat/mingw.[ch] and compat/msvc.c,
giving us a custom implementation of opendir, readdir and closedir that
does not incorrectly set errno to 0.

Erik Faye-Lund (6):
  msvc: opendir: use xmalloc
  msvc: opendir: allocate enough memory
  msvc: opendir: do not start the search
  win32: dirent: handle errors
  msvc: opendir: handle paths ending with a slash
  win32: use our own dirent.h

 Makefile                        |    7 ++-
 compat/mingw.c                  |   60 ------------------
 compat/mingw.h                  |   29 ---------
 compat/msvc.c                   |   29 ---------
 compat/vcbuild/include/dirent.h |  128 ---------------------------------------
 compat/win32/dirent.c           |  105 ++++++++++++++++++++++++++++++++
 compat/win32/dirent.h           |   24 +++++++
 7 files changed, 134 insertions(+), 248 deletions(-)
 delete mode 100644 compat/vcbuild/include/dirent.h
 create mode 100644 compat/win32/dirent.c
 create mode 100644 compat/win32/dirent.h

-- 
1.7.3.2.493.ge4bf7
