From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/4] nd/branch-show-rebase-bisect-state updates
Date: Wed,  6 Mar 2013 19:26:12 +0700
Message-ID: <1362572773-20809-1-git-send-email-pclouds@gmail.com>
References: <1362572482-20570-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 06 13:25:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDDPb-0002WJ-4D
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 13:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757912Ab3CFMZJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Mar 2013 07:25:09 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36881 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757740Ab3CFMZH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 07:25:07 -0500
Received: by mail-pb0-f46.google.com with SMTP id uo15so5909308pbc.5
        for <git@vger.kernel.org>; Wed, 06 Mar 2013 04:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=VYi+HhZrY7mgMuJJsAQGpfDTf4FOiyAm0g0dz/kvko4=;
        b=dSXe1zGJhgpXBYqmomJmx1DTVDPxMwommgC6QLQoEBIgyUdhpB6qOUL76ZctkXVy8I
         F/IPe3sxw9VlrNGw64aw+yuS8Ygc/0CDU8bIZJhRt1wHpxcUCjK5ZX//vZ4G8zlRnUcZ
         7//qt/wzhAtaiXvQRn/8tcWq1Lv8EWYIE7iIcTnMLnVxWk3KPB1G3YZiuC3jpBu8NEtJ
         ehz+S03itWs02aP9Qk55yK5Gpj+9aQzntAsEZc6RVv6o6nrpvUefuw81dDD12c0JnKtq
         ztlHTOjdHYtyMeujaNlw3ltyuatFZms/KuTewkW+w+Ui60pAsRNcOR68V1JN0b9f6wY9
         FRZg==
X-Received: by 10.68.22.73 with SMTP id b9mr45179718pbf.214.1362572707286;
        Wed, 06 Mar 2013 04:25:07 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id hs8sm31115936pbc.27.2013.03.06.04.25.03
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 06 Mar 2013 04:25:06 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 06 Mar 2013 19:26:14 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362572482-20570-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217521>

Since the previous round:

 - reflog format change is dropped
 - almost always show "HEAD detached from/at xxx" instead of
   "currently not on any branch", where "xxx" is either a ref, or an
   abbreviated sha-1

I wanted to introduce something like @{-1:to} that resolves the "to"
sha-1 in reflog, in addition to @{-1} which resolves the "from" part.
But the syntax looks ugly so I dropped it. Meanwhile people could do

git log -1 -g --grep-reflog checkout --pretty=3Dformat:%h

to retrieve the same info.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  wt-status: split wt_status_state parsing function out
  wt-status: move wt_status_get_state() out to wt_status_print()
  status: show more info than "currently not on any branch"
  branch: show more information when HEAD is detached

 builtin/branch.c            |  25 +++++++-
 t/t3203-branch-output.sh    |   6 +-
 t/t6030-bisect-porcelain.sh |   2 +-
 t/t7406-submodule-update.sh |   6 +-
 t/t7512-status-help.sh      |  52 +++++++++------
 wt-status.c                 | 152 ++++++++++++++++++++++++++++++++++--=
--------
 wt-status.h                 |   7 +-
 7 files changed, 190 insertions(+), 60 deletions(-)

--=20
1.8.1.2.536.gf441e6d
