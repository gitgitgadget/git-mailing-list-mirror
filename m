From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/4] Some pathspec wildcard optimization
Date: Sun, 18 Nov 2012 16:13:05 +0700
Message-ID: <1353229989-13075-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 10:13:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta0wK-0005iL-Hp
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 10:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514Ab2KRJNE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 04:13:04 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40255 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab2KRJND (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 04:13:03 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so2823731pbc.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 01:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=c+j0rlfY1jneu9sW4EulfrtWhci1VJa9ttyFxvRUD7c=;
        b=QsM+ti36J3zztA8rltFSQET4ZuK4FR/6PegUAemXYaS2MUpGoOanrUUDU/RVAgldtP
         uvoIqXZjLVtkimix+Upe4o54bCYgE2lIthtGeEB841hojTR4YkFyjzSaSgkhwvMO8L/v
         vMn+zCjsYVG7OWTGRQJbzpKCEQi9VCbsLZNeVBSiA7UwMev1GzqdzJbc0ntlpZpDNpzJ
         aD3PdNPbBShfMTFjJJsgGJOgHvUHaEbPHP/6KgiQaPy7bixWrhgmjr9JJVQo7KbQJa4D
         bLNb64PUrOlHdrw/ozXDrMZiU0pYHnCVDQsw80ZpH/xgbChZbmQ7n/z02VEm7aVTQIWD
         5lgw==
Received: by 10.68.231.69 with SMTP id te5mr29785326pbc.81.1353229982451;
        Sun, 18 Nov 2012 01:13:02 -0800 (PST)
Received: from lanh ([115.74.37.170])
        by mx.google.com with ESMTPS id vs3sm4230929pbc.61.2012.11.18.01.12.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 01:13:01 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 18 Nov 2012 16:13:09 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209997>

This ports the "*.c" optimization from .gitignore to pathspec code.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  pathspec: save the non-wildcard length part
  pathspec: do exact comparison on the leading non-wildcard part
  pathspec: apply "*.c" optimization from exclude
  tree_entry_interesting: do basedir compare on wildcard patterns when
    possible

 builtin/ls-files.c |  2 +-
 builtin/ls-tree.c  |  2 +-
 cache.h            |  5 +++-
 dir.c              | 35 ++++++++++++++++++++++---
 dir.h              |  9 +++++++
 tree-walk.c        | 75 ++++++++++++++++++++++++++++++++++++++++++++++=
++++----
 6 files changed, 117 insertions(+), 11 deletions(-)

--=20
1.8.0.rc2.23.g1fb49df
