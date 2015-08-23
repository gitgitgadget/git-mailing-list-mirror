From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/2] gitignore, re-inclusion fix
Date: Sun, 23 Aug 2015 19:50:12 +0700
Message-ID: <1440334214-32131-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 14:51:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTUjk-0007J1-Sm
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 14:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbbHWMul convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2015 08:50:41 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36519 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbbHWMuk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 08:50:40 -0400
Received: by pawq9 with SMTP id q9so84864800paw.3
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 05:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=MBfep3wjFVcDcHckOOvE5ArbRNUuFppTLPzZ4dXH+sI=;
        b=UOqiQbGVv705nupTS52SAUMuRpzzhm29IXgLrP3feba8grHzzEdS+yLb7YNKDfjG6d
         o4B4PlZNi8ztkmIIpUpZipJ7WNyIWpZgkxvc3CeGpRmWOa0Duz5ULdRe7Dyak5tU8u3A
         uG7m0FWcBkyz1qdtxysCoXCdzuoOxDMVSAVYdtbWd1PUGiIE0wzidYInBnoA0Qjgd7JF
         f1QfFw6Od6tGndxbhifJHOGTE1eP2xgUIBYGIlLyS5oSS0SZqnIIyCGASLczMthNtEHm
         bIYg8bHeRbRAvnPNF4CpS655rqtoW0Ck8X4X/3hbjSjU1MGVsm8B7elmA3XSC3TREVJw
         P4lQ==
X-Received: by 10.66.254.65 with SMTP id ag1mr34815377pad.134.1440334239756;
        Sun, 23 Aug 2015 05:50:39 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id ft7sm13932787pdb.58.2015.08.23.05.50.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Aug 2015 05:50:39 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 23 Aug 2015 19:50:37 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276405>

This is an old problem. I attempted once [1] and then was reminded [2]
with some more comments on the original patch. Let's try again.

The problem is this .gitignore currently does not work, but it should:

/abc
!/abc/def/ghi

This patch fixes that by realizing that the last rule may re-include
something in abc/def so it does not exclude "abc" and "abc/def"
outright to give the last rule a chance to match.

[1] http://article.gmane.org/gmane.comp.version-control.git/259870
[2] http://thread.gmane.org/gmane.comp.version-control.git/265901/focus=
=3D266227

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  dir.c: make last_exclude_matching_from_list() run til the end
  dir.c: don't exclude whole dir prematurely if neg pattern may match

 Documentation/gitignore.txt        | 21 ++++++---
 dir.c                              | 89 ++++++++++++++++++++++++++++++=
+++++---
 t/t3001-ls-files-others-exclude.sh | 20 +++++++++
 3 files changed, 118 insertions(+), 12 deletions(-)

--=20
2.3.0.rc1.137.g477eb31
