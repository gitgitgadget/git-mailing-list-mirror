From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/6] Exclude optimizations
Date: Sun, 10 Mar 2013 13:14:24 +0700
Message-ID: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 10 07:15:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEZXO-00012s-G2
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 07:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033Ab3CJGOj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Mar 2013 01:14:39 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:54692 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab3CJGOi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 01:14:38 -0500
Received: by mail-pb0-f52.google.com with SMTP id ma3so2625163pbc.25
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 22:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=AKKTe3fkIMabCfJ/1PjKCsXNjsImko0eZlJxfK0nSbQ=;
        b=GDZDsrL7rpwVbxHT22Rp3apX0rSUMGrcy3xmAzgKRlw+zAnbi/AiNuDx4gaBQ52ijh
         5O6L5yEPgP+2DVtyDKmObwAEG5skCxzUgvuQ2xkJ2V8XM1t5ozwKTmW1nAusPTnHSGA1
         8IhgU7sMdm5M4BeJlYW3sRBm8NEXAOmWlXy/SDbm8FH3cLvfZuWdL7JzkiKbEnJVeiy6
         gT3wn5C6cvRqi0hyAIRB/I4qjUeSvA+eeqDInuf8NQz8fdTBHhbWBmTtisAftY+OYvWd
         AMY7iKIPDA/z76R7P4C4Dbo/Knpq3DErfjoGVa7d1ZYNFh89qZcoZdHqpQnc/l4DqkNv
         8law==
X-Received: by 10.68.135.196 with SMTP id pu4mr10276368pbb.50.1362896078277;
        Sat, 09 Mar 2013 22:14:38 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id qt5sm793607pbb.2.2013.03.09.22.14.34
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 22:14:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Mar 2013 13:14:31 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217780>

v2 includes strncmp_equal and directory level pattern filter. user
time of "git ls-files --exclude-standard -o" on webkit.git below.
Looking pretty good.

        before      after
user    0m0.607s    0m0.365s
user    0m0.613s    0m0.366s
user    0m0.613s    0m0.374s
user    0m0.621s    0m0.374s
user    0m0.621s    0m0.377s
user    0m0.622s    0m0.381s
user    0m0.624s    0m0.381s
user    0m0.626s    0m0.383s
user    0m0.628s    0m0.384s
user    0m0.638s    0m0.384s


Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  match_pathname: avoid calling strncmp if baselen is 0
  dir.c: inline convenient *_icase helpers
  match_basename: use strncmp instead of strcmp
  match_{base,path}name: replace strncmp_icase with strnequal_icase
  dir.c: pass pathname length to last_exclude_matching
  exclude: filter patterns by directory level

 attr.c |   5 ++-
 dir.c  | 114 ++++++++++++++++++++++++++++++++++++++++++++-------------=
--------
 dir.h  |  27 +++++++++++++---
 3 files changed, 104 insertions(+), 42 deletions(-)

--=20
1.8.1.2.536.gf441e6d
