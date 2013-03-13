From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/5] nd/branch-show-rebase-bisect-state updates
Date: Wed, 13 Mar 2013 18:42:48 +0700
Message-ID: <1363174973-17597-1-git-send-email-pclouds@gmail.com>
References: <1362572482-20570-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 13 12:43:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFk5o-0006Au-8t
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 12:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407Ab3CMLnJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Mar 2013 07:43:09 -0400
Received: from mail-da0-f43.google.com ([209.85.210.43]:51346 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755218Ab3CMLnI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 07:43:08 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so384658dak.16
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 04:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=V7ssJpBofPPed6E4Ucd541eFxpCsNGKdNDBsr5a3ktU=;
        b=By+MuRq1LruUnSRQk+Df8FP1FjjUsu+tSXRTHbmz1dCV4OwioWruIx+fTS7Vb+xJjr
         hK8DC/O4ekrfH+P/Q9zmhnnxDmfuJUvdvPfOl/V9ifFrPUnuDLnxQYUJERzy90XbNiaV
         9aCexf3iDMTjDlorhpGj39vamwWg4s13WeCok1HAJWmad1U+epaGxLMGJjK237S0xJWC
         63BIozqsjJj1adrXlM2btYQ2hYlOvV3iiFZ9WJbTIyZCf6EBgojzQqkyl+47qjctmcLA
         rLpC0ijYOM8982cDqPiqA3vZC0Y4ojKStE3rQrolpXsT49f/LMR89U5G7Kq/j9mkDUed
         BSnQ==
X-Received: by 10.68.184.66 with SMTP id es2mr45515357pbc.217.1363174987515;
        Wed, 13 Mar 2013 04:43:07 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id kt5sm29248290pbc.30.2013.03.13.04.43.03
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Mar 2013 04:43:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Mar 2013 18:43:00 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1362572482-20570-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218047>

This round fixes the design issue of read_and_strip_branch(), makes
use of jc/reflog-reverse-walk and performs cheaper sha-1 check on
detached commits.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  wt-status: move strbuf into read_and_strip_branch()
  wt-status: split wt_status_state parsing function out
  wt-status: move wt_status_get_state() out to wt_status_print()
  status: show more info than "currently not on any branch"
  branch: show more information when HEAD is detached

 builtin/branch.c            |  26 +++++-
 t/t3203-branch-output.sh    |   6 +-
 t/t6030-bisect-porcelain.sh |   2 +-
 t/t7406-submodule-update.sh |   6 +-
 t/t7512-status-help.sh      |  52 ++++++-----
 wt-status.c                 | 204 +++++++++++++++++++++++++++++++-----=
--------
 wt-status.h                 |   7 +-
 7 files changed, 214 insertions(+), 89 deletions(-)

--=20
1.8.1.2.536.gf441e6d
