From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/2] Multithread index-pack
Date: Mon, 12 Mar 2012 09:32:27 +0700
Message-ID: <1331519549-28090-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 12 03:33:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6v4R-0002hk-M6
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 03:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695Ab2CLCdA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 22:33:00 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35049 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754481Ab2CLCc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 22:32:58 -0400
Received: by dajr28 with SMTP id r28so4490235daj.19
        for <git@vger.kernel.org>; Sun, 11 Mar 2012 19:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=cGf+O0enpX4ckzR23kx/97wIsimKl8iX3ZiHmW6GCqM=;
        b=CqT/5wJ+9plWfrPKcxFAzhUBqHnMBaRegm9o5lHtfGeIAXHMrTZk5ydcgqxkhMlZ3Z
         95RRwZTrddp6XpwMzj48Rk/AYjwFrV1i5HWYYew4wAwgo570TusIncGBT0BFUShYha2H
         /+QJBMeRSgwEcvNxbH8bBAe27c5e95LJspIyWQMUELwLXzPrQoORd1rnR8yniagcIeR1
         b8pxjvtwJCBq2l9WbuF7Gu77lJafYaAHRjO1CZQNPgR/VMeUcsX8AFNdIJE1VtX8iAXK
         q1KkYWFSx6vzq/69wyBKS7wWLAdwyhBOSWkDiEcSPDaSGoj80pXYlvslUQ3Dw4d7MkAc
         YJDQ==
Received: by 10.68.240.41 with SMTP id vx9mr17292847pbc.10.1331519578402;
        Sun, 11 Mar 2012 19:32:58 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id f6sm9247061pbt.4.2012.03.11.19.32.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Mar 2012 19:32:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 12 Mar 2012 09:32:30 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192835>

Compared to the first version [1], this fixes thin-pack appending
problem because nr_resolved_detas is misupdated. It also makes sure no
pthread calls are called before thread data is initialized, and after
it is destroyed. This should fix the crash Ramsay observed on MinGW.

[1] http://thread.gmane.org/gmane.comp.version-control.git/191698

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  index-pack: split second pass obj handling into own function
  index-pack: support multithreaded delta resolving

 Documentation/git-index-pack.txt |   10 ++
 Makefile                         |    2 +-
 builtin/index-pack.c             |  225 ++++++++++++++++++++++++++++++=
+++-----
 3 files changed, 208 insertions(+), 29 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty
