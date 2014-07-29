From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/8] nd/multiple-work-trees follow-ups
Date: Tue, 29 Jul 2014 20:50:23 +0700
Message-ID: <1406641831-2390-1-git-send-email-pclouds@gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 15:52:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC7pT-0005WQ-7Y
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 15:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbaG2Nwa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 09:52:30 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36051 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbaG2Nw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 09:52:29 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so12383471pad.36
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 06:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=k3MYZ/VHqT5VU1lnqp2CszUC05upuNZ8UbMn4Zb9+wI=;
        b=Ip67K+d7YMPMMQ/g8UxlLauTYq9SFQuJl30k3Is3HI+mPLDK0wtixaYgK88Qy5kmQS
         Kz5tzYQopMGQhR63KD1LXFAcBy4u4QEDlRWOLSynFtmhhgw9gJoe1aGcDbKnqs4J0gEV
         vCKrYXNsqDczDEaIssOq2QJBYhBhHtjcKSqLJbOp7uHK+1gt/PweI15lTILuTpGSEGWM
         8AhbeZjsXRUt/PqbFZGAQyar35SqrcFHiCIbd5Kubl2Cu4RvZuGgCr0jPRAJl2bJAdAn
         PB6XyIzkl94n8GBrFVH84mRUuvormClvnwMoi1LfWpw+HGS0E9g4O9MTB3SDMRDwytC1
         P2Nw==
X-Received: by 10.68.223.202 with SMTP id qw10mr2098431pbc.163.1406641949064;
        Tue, 29 Jul 2014 06:52:29 -0700 (PDT)
Received: from lanh ([115.73.243.195])
        by mx.google.com with ESMTPSA id bl12sm77930526pac.44.2014.07.29.06.52.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jul 2014 06:52:28 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Jul 2014 20:52:31 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254434>

This fixes all comments from v1. I still keep the long advice when
'git checkout' fails because another branch is locked, because it's
easy(*) to disable the advice. Two more fixes found today. The test
breakages on Windows have to wait until somebody on Windows jumps in.

(*) although I start to want an advice.nothing config that disables
all advice..

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  gitrepository-layout.txt: s/ignored/ignored if/
  checkout: no need to call check_linked_checkouts if head_ref is NULL
  prune --repos: fix uninitialized access
  checkout: no auto-detach if the ref is already checked out
  checkout --to: fix dangling pointers in remove_junk()
  environment.c: fix incorrect git_graft_file initialization
  checkout: prefix --to argument properly when cwd is moved
  checkout --to: do not touch existing target directory

 Documentation/config.txt               |  4 ++
 Documentation/gitrepository-layout.txt |  6 +--
 advice.c                               |  2 +
 advice.h                               |  1 +
 builtin/checkout.c                     | 98 +++++++++++++++++++-------=
--------
 builtin/prune.c                        | 16 +++---
 environment.c                          |  2 +-
 t/t0060-path-utils.sh                  |  1 +
 t/t2025-checkout-to.sh                 | 40 ++++++++++----
 t/t2026-prune-linked-checkouts.sh      |  2 +-
 10 files changed, 106 insertions(+), 66 deletions(-)

--=20
2.1.0.rc0.78.gc0d8480
