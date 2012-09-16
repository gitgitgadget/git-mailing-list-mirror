From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/5] Support matching "**" in .gitattributes and .gitignore
Date: Sun, 16 Sep 2012 22:27:40 +0700
Message-ID: <1347809265-2457-1-git-send-email-pclouds@gmail.com>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 17:28:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDGlK-0003s5-RZ
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 17:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775Ab2IPP1p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2012 11:27:45 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61205 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab2IPP1n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 11:27:43 -0400
Received: by pbbrr13 with SMTP id rr13so7881072pbb.19
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PHPQCUlMqof8O3akxjOuJDLtvnCinWz9blfvbrY4LnY=;
        b=awCyByZlvesYrDwd09mnhFqHGM1r2BAfbb1Z87EQFy68kS9tW8mfbbwkCuthnYjXzJ
         Av3muyspLQKIZZI3brd2F+bNZ/lopwC7lubOOeelzVctHQ5ajf80JvZJsHexm/prrJaJ
         t3semHBQCtyFclOxfVMZRsiWAS3w2MRWklxddKs17JD7bN5tmoes5OW+JDWnD3mxfxvG
         Z7GpmzYlJZApZtVekB3MBhKkpDvX9yeMJnhMN3iPTCIGABz7jT0l4ejKhzreO7J4Qd45
         tpXLq3AsksjgdhR1Iv3RSgfhusIe09l6ckTUzpwx6VlnpF0h8NIBkoVjAgLra9IEOw92
         cghQ==
Received: by 10.68.212.70 with SMTP id ni6mr16692231pbc.22.1347809262817;
        Sun, 16 Sep 2012 08:27:42 -0700 (PDT)
Received: from lanh ([115.74.50.93])
        by mx.google.com with ESMTPS id wn4sm5195662pbc.55.2012.09.16.08.27.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Sep 2012 08:27:42 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Sep 2012 22:27:46 +0700
X-Mailer: git-send-email 1.7.12.403.gce5cf6f.dirty
In-Reply-To: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205620>

Changes in v2:

 - Correct commit sha-1 in the 1/5 to the last GPL-2 rsync commit.
   State it is pristine import. Move wildmatch.[ch] to top dir.
 - Add tests to 5/5 (I forgot to test that the integration should run
   well, in addition to wildmatch() working in general)

Note that there might be a regression because wildmatch() does not
care about LC_CTYPE when dealing with character classes, while libc's
fnmatch might. But it's probably not worth bothering about because we
match against path names, which do not necessarily follow LC_TYPE
but the file system's encoding.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  Import wildmatch from rsync
  compat/wildmatch: remove static variable force_lower_case
  compat/wildmatch: fix case-insensitive matching
  Integrate wildmatch to git
  Support "**" in .gitignore and .gitattributes patterns using
    wildmatch()

 .gitignore                         |   1 +
 Documentation/gitignore.txt        |   3 +
 Makefile                           |   6 +
 attr.c                             |   4 +-
 dir.c                              |   5 +-
 t/t0003-attributes.sh              |  17 ++
 t/t3001-ls-files-others-exclude.sh |  11 ++
 t/t3070-wildmatch.sh               |  27 +++
 t/t3070-wildmatch/wildtest.txt     | 165 ++++++++++++++++
 test-wildmatch.c                   | 228 +++++++++++++++++++++++
 wildmatch.c                        | 373 +++++++++++++++++++++++++++++=
++++++++
 wildmatch.h                        |   6 +
 12 files changed, 844 insertions(+), 2 deletions(-)
 create mode 100755 t/t3070-wildmatch.sh
 create mode 100644 t/t3070-wildmatch/wildtest.txt
 create mode 100644 test-wildmatch.c
 create mode 100644 wildmatch.c
 create mode 100644 wildmatch.h

--=20
1.7.12.403.gce5cf6f.dirty
