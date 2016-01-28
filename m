From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 00/10] Fix icase grep on non-ascii
Date: Thu, 28 Jan 2016 18:56:13 +0700
Message-ID: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 12:56:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOlBi-0006aw-KP
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 12:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934170AbcA1L4b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 06:56:31 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34796 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbcA1L43 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 06:56:29 -0500
Received: by mail-pf0-f193.google.com with SMTP id 65so1981012pfd.1
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 03:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=K4gk9u08ufRVQkIO5glI3ZF33MbWCH2MFXVUmLrVHbQ=;
        b=StJZEtjzko4WutzyKZcOggwL0uh/9twJqWKlXxaJn1e6RjudrJ0JwPFbsV2cLNKAWs
         f5316vIBdm0E5PEb16+DWjbuBsRbycKeadaZRDOMd217Qa3cCNG6U1VJME/S3vq3clQa
         1Q+w33vTb8G7aJ2lP7qrs9PLztfrBT2Zm29tZREUHGp0DXV3AF+TOuuZ4fAapFZ3+HuP
         exCC4TLjlbQ87r/5DoTXhZWWS8qWVuJLc8jJMSG9vNpwd97npgv3RPRW3JbxeJCgIi1D
         NqrACkTdXwEQ4saiwlBL4ftgwiPsuqTWKOVuHPHxrokTzmdEFexpXKVnGqusWFkwpmui
         X2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=K4gk9u08ufRVQkIO5glI3ZF33MbWCH2MFXVUmLrVHbQ=;
        b=RlMk3TkVH5mZu78c/mWkBZAlpZ/HVahl5Y3ojMvugFr30xn0Lu+PMtfKucm3IoDHiL
         2SUNTx8taTfl+uY+X6NbL2m1M1Yw19StcQoAfKe1HRtsU3EQW2acgTfd+0qe80BJuPYu
         i6VWijrysJoJBFWb8XUxuEOIWLTX8NJIzF2PdPDw8ehO4QVExrP9Mzr4v7VqtnIChvJV
         G93uUJNxJsMmfHslRpQ6rqn99vI57wHSHSwluodvC0C0ES7SbwVyuBNfbrd1XS+BvvMX
         1Dii0dsrb+wVf9i1GckKfqq7f4mzYPicnIrs+tnU74F7jQaXN0H0ShDTSQka10VYMsFi
         C2Pw==
X-Gm-Message-State: AG10YOS9DZh7sVOsDyENv52k7CYnPAj0CHWj9YzTp/xyxi84XmHTaQ2GiSIMoFU3OMvOBw==
X-Received: by 10.98.40.131 with SMTP id o125mr3826493pfo.83.1453982189137;
        Thu, 28 Jan 2016 03:56:29 -0800 (PST)
Received: from lanh ([115.76.235.75])
        by smtp.gmail.com with ESMTPSA id k74sm15963918pfb.30.2016.01.28.03.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jan 2016 03:56:27 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 28 Jan 2016 18:56:33 +0700
X-Mailer: git-send-email 2.7.0.288.g1d8ad15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285007>

The series fixes grep choosing fast path that only works correctly for
ascii. This is a resend of v4 [1] after rebase. I think v4 just went
off radar for some reason, nothing was wrong with it (or nobody told
me about it).

[1] http://thread.gmane.org/gmane.comp.version-control.git/273381/focus=
=3D276288

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
  grep: allow -F -i combination
  grep: break down an "if" stmt in preparation for next changes
  test-regex: expose full regcomp() to the command line
  grep/icase: avoid kwsset on literal non-ascii strings
  grep/icase: avoid kwsset when -F is specified
  grep/pcre: prepare locale-dependent tables for icase matching
  gettext: add is_utf8_locale()
  grep/pcre: support utf-8
  diffcore-pickaxe: "share" regex error handling code
  diffcore-pickaxe: support case insensitive match on non-ascii

 builtin/grep.c                           |  2 +-
 diffcore-pickaxe.c                       | 27 ++++++++----
 gettext.c                                | 24 ++++++++++-
 gettext.h                                |  1 +
 grep.c                                   | 44 ++++++++++++++++++--
 grep.h                                   |  1 +
 quote.c                                  | 37 +++++++++++++++++
 quote.h                                  |  1 +
 t/t7812-grep-icase-non-ascii.sh (new +x) | 71 ++++++++++++++++++++++++=
++++++++
 t/t7813-grep-icase-iso.sh (new +x)       | 19 +++++++++
 test-regex.c                             | 56 ++++++++++++++++++++++--=
-
 11 files changed, 262 insertions(+), 21 deletions(-)
 create mode 100755 t/t7812-grep-icase-non-ascii.sh
 create mode 100755 t/t7813-grep-icase-iso.sh

--=20
2.7.0.288.g1d8ad15
