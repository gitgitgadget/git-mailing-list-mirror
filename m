From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/9] icase match on non-ascii
Date: Wed,  8 Jul 2015 17:38:30 +0700
Message-ID: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
References: <1436186551-32544-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: plamen.totev@abv.bg, l.s.r@web.de,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 12:38:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCmkB-0006dn-4W
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 12:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934876AbbGHKiG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 06:38:06 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36314 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934911AbbGHKiC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 06:38:02 -0400
Received: by pacgz10 with SMTP id gz10so56124339pac.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mk/ooDAp+R3tnbFQLrp6xBTZ14EUKPpN3ii+LM9t4yA=;
        b=N/335cKYGVDWYDjfEVdyVvRyv6+OowppNudGWVveDmqlnCc25YUJv2AVLqRi9oLhHF
         07ZlvyUVrXmSs2ZdFlTFZfhWSNSFKXwZC5nPt0hwMk5C76L2Shy+j32gqDtGwdY/qbRp
         otNBCP4YFRZXwaIQW6+Rmj4kcDnksE3SDsvw+/BV3HMPlWJNCs1kromk8kpHz9TkEb41
         AJ4+wHG170DX4HUyff2lvUTI/zsPhqIy4FkRVtOCdvoqsXMPK2bvMBgJH/troyUiqVh7
         dwfjwl22eNZanKINIeCJDPCdbwRGhHr/WiafoiXWHi85JweLjnbS3+yePtCyOQnImYGy
         bvDw==
X-Received: by 10.68.234.102 with SMTP id ud6mr7956924pbc.101.1436351882381;
        Wed, 08 Jul 2015 03:38:02 -0700 (PDT)
Received: from lanh ([115.73.45.219])
        by smtp.gmail.com with ESMTPSA id qs8sm2045468pbc.38.2015.07.08.03.37.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 03:38:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 08 Jul 2015 17:38:47 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436186551-32544-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273660>

This series fix case insensitive matching on non-ascii charsets.
"grep -i", "grep -F -i", "grep --pcre-regexp -i" and "log -i -S" are
fixed.

Side note, I almost added the third has_non_ascii() function. Maybe we
should consider merging the two existing has_non_ascii() functions
back, or rename one to something else.

Patch 5 is "funny". The patch itself is in iso-8859-1, but my name in
the commit message is in utf-8. Let's see how it goes on the apply
side. We may need to fix something in this area..

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (9):
  grep: allow -F -i combination
  grep: break down an "if" stmt in preparation for next changes
  grep/icase: avoid kwsset on literal non-ascii strings
  grep/icase: avoid kwsset when -F is specified
  grep/pcre: prepare locale-dependent tables for icase matching
  gettext: add is_utf8_locale()
  grep/pcre: support utf-8
  diffcore-pickaxe: "share" regex error handling code
  diffcore-pickaxe: support case insensitive match on non-ascii

 builtin/grep.c                           |  2 +-
 diffcore-pickaxe.c                       | 27 ++++++++++-----
 gettext.c                                |  7 +++-
 gettext.h                                |  5 +++
 grep.c                                   | 43 ++++++++++++++++++++---
 grep.h                                   |  1 +
 quote.c                                  | 37 ++++++++++++++++++++
 quote.h                                  |  1 +
 t/t7812-grep-icase-non-ascii.sh (new +x) | 58 ++++++++++++++++++++++++=
++++++++
 t/t7813-grep-icase-non-ascii.sh (new +x) | 19 +++++++++++
 10 files changed, 186 insertions(+), 14 deletions(-)
 create mode 100755 t/t7812-grep-icase-non-ascii.sh
 create mode 100755 t/t7813-grep-icase-non-ascii.sh

--=20
2.3.0.rc1.137.g477eb31
