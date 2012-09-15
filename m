From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] Support matching "**" in .gitattributes and .gitignore
Date: Sat, 15 Sep 2012 19:01:59 +0700
Message-ID: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 14:03:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCr5Q-0003CG-ND
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 14:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306Ab2IOMCF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Sep 2012 08:02:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57287 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab2IOMCE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 08:02:04 -0400
Received: by pbbrr13 with SMTP id rr13so6891861pbb.19
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 05:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=tH27TIEKmZI4cBNl31cb/siQ0dQzhqUa3oT4TXXuga0=;
        b=cw3prRw1EozEWeXkT7l9ZMWC8VuuD5Z6uPCqJjaW1ZwrhX6SBI3LyRSyLgEnd6kS87
         vh2XV7BIYdoTNNb24zUFlJDHdc1GG85DM6i/IeaK08sRtuBCjFXh7A077Y8VEuX7Fer4
         oo7VwLVYMzx3EjWnM1logAeqNSe1UGkeARc00pSRt428hvi8uwDCl4Ltq8DnaxFVBXv0
         m2YXsuDbuxCj+VR7D3KGdIxY5t3TtJvPWSGlKxgZ2H4RXgWFgbDKH1/ewoWJYzTTk1yF
         b3a8L0nwZrJhMVzoCJ5+bZw4ejFx/HspSIGmSNVlbVovlFdt2O5Fhx0VHABVDPKQx59L
         oyPQ==
Received: by 10.68.228.100 with SMTP id sh4mr10195894pbc.45.1347710523669;
        Sat, 15 Sep 2012 05:02:03 -0700 (PDT)
Received: from lanh ([115.74.56.159])
        by mx.google.com with ESMTPS id qa4sm2838239pbb.70.2012.09.15.05.02.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Sep 2012 05:02:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 15 Sep 2012 19:02:05 +0700
X-Mailer: git-send-email 1.7.12.403.gce5cf6f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205551>

A while back I posted a proof of concept using wildmatch() from rsync.
Back then the obstacle was case-insensitive matching support. I did not
realize that there was iwildmatch() that does exactly that.

So here again a series that is probably ready for consumption. Now
patterns that contain slashes will always go through (i)wildmatch().
fnmatch() is only used for basename matching.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  Import wildmatch from rsync
  compat/wildmatch: remove static variable force_lower_case
  compat/wildmatch: fix case-insensitive matching
  Integrate wildmatch to git
  Support "**" in .gitignore and .gitattributes patterns using
    wildmatch()

 Documentation/gitignore.txt    |   3 +
 Makefile                       |   6 +
 attr.c                         |   4 +-
 compat/wildmatch.c             | 373 +++++++++++++++++++++++++++++++++=
++++++++
 compat/wildmatch.h             |   6 +
 dir.c                          |   5 +-
 t/t3070-wildmatch.sh           |  27 +++
 t/t3070-wildmatch/wildtest.txt | 165 ++++++++++++++++++
 test-wildmatch.c               | 228 +++++++++++++++++++++++++
 9 files changed, 815 insertions(+), 2 deletions(-)
 create mode 100644 compat/wildmatch.c
 create mode 100644 compat/wildmatch.h
 create mode 100755 t/t3070-wildmatch.sh
 create mode 100644 t/t3070-wildmatch/wildtest.txt
 create mode 100644 test-wildmatch.c

--=20
1.7.12.403.gce5cf6f.dirty
