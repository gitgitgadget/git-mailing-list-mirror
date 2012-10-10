From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 00/12] Wildmatch v4
Date: Wed, 10 Oct 2012 17:40:39 +0700
Message-ID: <1349865651-31889-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 12:41:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLtiz-0002RC-Mf
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 12:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141Ab2JJKlD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 06:41:03 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:33818 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944Ab2JJKlB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 06:41:01 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so112135dak.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=s2etVerzYv+y3aHkOjtTMvYFz6p4/U110cY8eqFD3CQ=;
        b=MtjKk0/yzQwIqEmpNNNRxlf3sibYfBIIAuf52R2g0lFunYepKhiP+zscMzykzxtJZq
         7k4MCSeVEM1NMTpcEGymrqDQHZtuWyjjsaLZBcXbNrxg8e7Y2xIWux9y6M/diVDyjDWA
         s3WWfyJUgDqmDYg4FLfhBKeUD4bF3uOO65iCdoGYrTfKK70uTWRvUv5K5/eab3FPdyV8
         YYgJcc7G/SFYRPRwt5s88ZeyPdOzATB+4IiekU/SvP/QT3T5gJqhWJeMs090wSkrO5Z2
         YO8SuHVkoGOi5f8hUwx4/JV3ok//AMWIN+e/eYTNGQfuyL0nOyh1w/mxvgwcAZsd8Luf
         7ZQA==
Received: by 10.68.248.10 with SMTP id yi10mr3319884pbc.39.1349865660825;
        Wed, 10 Oct 2012 03:41:00 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id l6sm676638pav.12.2012.10.10.03.40.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 03:41:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 17:40:52 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207385>

Really small updates. I did not want to resend it this soon but this
may fix the compile errors for Junio. Changes are

 - cleanup in wildmatch.c so #include "cache.h" is at the top of the
   file.

 - wildmatch() returns no match if it encounters "**" without
   surrounding slashes. It returns a special code so we can actually
   show a warning at higher level. I don't want to do that now
   because I want to mark the pattern "broken" in attr.c/dir.c so
   the pattern will never be used again, and the message shown only
   once. That needs nd/attr-match-optim-more, but I don't want to tie
   this series to that just yet.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (12):
  ctype: make sane_ctype[] const array
  ctype: support iscntrl, ispunct, isxdigit and isprint
  Import wildmatch from rsync
  wildmatch: remove unnecessary functions
  Integrate wildmatch to git
  wildmatch: make wildmatch's return value compatible with fnmatch
  wildmatch: remove static variable force_lower_case
  wildmatch: fix case-insensitive matching
  wildmatch: adjust "**" behavior
  wildmatch: make /**/ match zero or more directories
  Support "**" wildcard in .gitignore and .gitattributes
  t3070: disable two fnmatch tests that have different results on
    different libc

 .gitignore                         |   1 +
 Documentation/gitattributes.txt    |   6 +
 Documentation/gitignore.txt        |  19 +++
 Makefile                           |   3 +
 attr.c                             |   4 +-
 ctype.c                            |  20 +++-
 dir.c                              |   4 +-
 git-compat-util.h                  |  15 ++-
 t/t0003-attributes.sh              |  38 ++++++
 t/t3001-ls-files-others-exclude.sh |  19 +++
 t/t3070-wildmatch.sh               | 187 +++++++++++++++++++++++++++++
 test-wildmatch.c                   |  14 +++
 wildmatch.c                        | 240 +++++++++++++++++++++++++++++=
++++++++
 wildmatch.h                        |   9 ++
 14 files changed, 575 insertions(+), 4 deletions(-)
 create mode 100755 t/t3070-wildmatch.sh
 create mode 100644 test-wildmatch.c
 create mode 100644 wildmatch.c
 create mode 100644 wildmatch.h

--=20
1.7.12.1.406.g6ab07c4
