From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/9] icase match on non-ascii
Date: Tue, 14 Jul 2015 20:24:31 +0700
Message-ID: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
References: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, plamen.totev@abv.bg,
	l.s.r@web.de, Eric Sunshine <sunshine@sunshineco.com>,
	tboegi@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 15:24:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF0Bl-0006EN-7t
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 15:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455AbbGNNX4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2015 09:23:56 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35701 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbbGNNXz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 09:23:55 -0400
Received: by pdrg1 with SMTP id g1so6024997pdr.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9AwovbenasuRrNoX6R7NUyrscwU6OtSbLhksd8lSECE=;
        b=SK5io6mLLwzCLn6cvkdMRvtV9PxWYJ3FioEMBzx7EMe7b9HvZTevHqZOKXm9b3KABO
         q6QRIeeVa9IHfV/Bt2Gscz+bwY8YYukAA2Rt2rrQPIdO2b9V004yFQFO/OegikMKRDs/
         Antn9e0juEUkSpaoJcHFpoWpFYoDzmWpRzAXvogPRTp+jTtu6QN/c97IdLC7UfpaASkV
         Ov1hPVWtmjndfJu4qUiD68j5PdDPRe8Il3o9F7gI3E7VKd6ysY5eBMPYrr//PugnnlQ7
         Dk8hdnbzz31SOaGhL7LHy/2rv7ifnRZ1TbMq4/z9JMNHdf9UcA1ci7zTN/610e+1qSa5
         YwGg==
X-Received: by 10.70.41.78 with SMTP id d14mr81325816pdl.35.1436880235389;
        Tue, 14 Jul 2015 06:23:55 -0700 (PDT)
Received: from lanh ([115.73.59.196])
        by smtp.gmail.com with ESMTPSA id uk6sm1416691pac.27.2015.07.14.06.23.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 06:23:54 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 14 Jul 2015 20:24:46 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273952>

Compared to v2

 - fix grep/pcre on utf-8 even in case is sensitive
 - peek at $LANG and friends anyway for utf-8 detection even
   when gettext support is not built in git
 - s/quote we quote/so we quote/ in 9/9
 - rename t7813, s/non-ascii/iso/

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
 diffcore-pickaxe.c                       | 27 +++++++++----
 gettext.c                                | 24 +++++++++++-
 gettext.h                                |  1 +
 grep.c                                   | 44 +++++++++++++++++++--
 grep.h                                   |  1 +
 quote.c                                  | 37 ++++++++++++++++++
 quote.h                                  |  1 +
 t/t7812-grep-icase-non-ascii.sh (new +x) | 67 ++++++++++++++++++++++++=
++++++++
 t/t7813-grep-icase-iso.sh (new +x)       | 19 +++++++++
 10 files changed, 208 insertions(+), 15 deletions(-)
 create mode 100755 t/t7812-grep-icase-non-ascii.sh
 create mode 100755 t/t7813-grep-icase-iso.sh

--=20
2.3.0.rc1.137.g477eb31
