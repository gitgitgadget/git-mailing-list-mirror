From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 00/10] fnmatch replacement
Date: Tue,  1 Jan 2013 09:44:01 +0700
Message-ID: <1357008251-10014-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 03:44:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tprq8-0008GY-R1
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 03:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355Ab3AACoK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2012 21:44:10 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56799 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab3AACoI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 21:44:08 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so7362661pad.19
        for <git@vger.kernel.org>; Mon, 31 Dec 2012 18:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=CeIxf7O3HFbqB+aCRhE5KxOZS6K/q8r8ykZuFW6c2CA=;
        b=H8werY21KVFalo+42znsM8Qo9yArIYuKkTwVZsx5ipNJQcWwWTjYXexCipiMNIPngq
         mybqYFhnlQpbKdL2gmyMCM0YCiooDDKPEb+f4rmsll7g4T3pOf8Ll53LKlVMOxXcQGTD
         N0I+z2TP6AncDNxFJJnojOz5BaFkYmRGu6MdH9JqN7HRyWmTtYIuWwB2+TJFmlEzqB2t
         lspRslx4+3uh/Jr5K6mwUflbKYRQYo7FukDZ2aQmYZGHPQt3nXXBM9OfJQa2dkE+IwIc
         NRM8S81at/ntAB/eFbNVBxllw8MMkK8tErcJb4FiPWsf3GbSxdlZfXIqrlJ2t9SxuwdB
         n8HA==
X-Received: by 10.68.137.234 with SMTP id ql10mr131314488pbb.158.1357008248457;
        Mon, 31 Dec 2012 18:44:08 -0800 (PST)
Received: from lanh ([115.74.57.25])
        by mx.google.com with ESMTPS id o5sm26660120pay.5.2012.12.31.18.44.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 31 Dec 2012 18:44:07 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 01 Jan 2013 09:44:12 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212383>

The first patch actually belongs to nd/wildmatch as it fixes how "**"
is only effective when it's surrounded by slashes.

Other fixes from v2 are WM_PATHNAME check is replaced by match_slash
(or "special" previously) in 8/10 and 9/10. WM_PATHNAME is only used
to set match_slash. If we rely on (the lack of) WM_PATHNAME, we may
miss "**" with WM_PATHNAME on.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
  wildmatch: fix "**" special case
  compat/fnmatch: respect NO_FNMATCH* even on glibc
  wildmatch: replace variable 'special' with better named ones
  wildmatch: rename constants and update prototype
  wildmatch: make dowild() take arbitrary flags
  wildmatch: support "no FNM_PATHNAME" mode
  test-wildmatch: add "perf" command to compare wildmatch and fnmatch
  wildmatch: make a special case for "*/" with FNM_PATHNAME
  wildmatch: advance faster in <asterisk> + <literal> patterns
  Makefile: add USE_WILDMATCH to use wildmatch as fnmatch

 Makefile                 |   6 ++
 compat/fnmatch/fnmatch.c |   3 +-
 dir.c                    |   3 +-
 git-compat-util.h        |  13 ++++
 t/t3070-wildmatch.sh     |  45 +++++++++++++-
 test-wildmatch.c         |  82 +++++++++++++++++++++++++-
 wildmatch.c              | 150 +++++++++++++++++++++++++++++----------=
--------
 wildmatch.h              |  23 +++++---
 8 files changed, 257 insertions(+), 68 deletions(-)

--=20
1.8.0.rc2.23.g1fb49df
