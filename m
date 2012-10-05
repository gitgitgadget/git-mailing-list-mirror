From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/10] nd/wildmatch take 2
Date: Fri,  5 Oct 2012 11:40:59 +0700
Message-ID: <1349412069-627-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 09:27:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK2Jh-0003Rk-PK
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 09:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310Ab2JEH1P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Oct 2012 03:27:15 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35745 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab2JEH1O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 03:27:14 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1392847pad.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 00:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=vYQkBWmliKYYMaMM40iQ15EM9reNqVF2M1emlLoblVY=;
        b=TB4y3tuz9Gjajp+ZHfKyxO411BlPBjhMK1rp47uKYJyPqQ4h6//Ur/W0HAA5QEW6DK
         o3/3WidHXl0NwBBSphe6QlFuNJk0jhF51yBZeJjvvsc/RkkXVVpBSsn3JgflkkXoYfPZ
         ZTHtEFwc8kbeEH0UPwr0JualvKkEKivWz/UAvdwN+T8BNnJLBfxoJ2ige95NsRzx8vHW
         RoJ3S/hQlE0poOfIvlXFIjYtfNb4XQ1noLBGI/bfhlqCzrNyOxFMAEzonXdJW5YeyFz1
         3MZ2Tm1dF/UFQWHOz9EeylvWYnQJeZNOpx19IVdTC86TudIfUsHeLBygEVmQ0pdVLsjg
         vy0g==
Received: by 10.68.116.232 with SMTP id jz8mr27543385pbb.77.1349412062005;
        Thu, 04 Oct 2012 21:41:02 -0700 (PDT)
Received: from tre ([115.74.45.10])
        by mx.google.com with ESMTPS id pa6sm5422141pbc.71.2012.10.04.21.40.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 21:41:01 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 05 Oct 2012 11:41:09 +0700
X-Mailer: git-send-email 1.7.10.1.641.g9354186
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207083>

The first four patches are ignore/attr cleanups. The following imports
wildmatch, nothing new there. The last patch limits allowed syntax to
a safe subset: "abc/**", "**/def" and "abc/**/def".

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
  gitignore: make pattern parsing code a separate function
  attr: avoid strlen() on every match
  attr: avoid searching for basename on every match
  attr: more matching optimizations from .gitignore
  Import wildmatch from rsync
  wildmatch: remove static variable force_lower_case
  wildmatch: fix case-insensitive matching
  Integrate wildmatch to git
  Support "**" in .gitignore and .gitattributes patterns using
    wildmatch()
  gitignore: forbid "abc**def"

 .gitignore                         |   1 +
 Documentation/gitattributes.txt    |   2 +
 Documentation/gitignore.txt        |   5 +
 Makefile                           |   3 +
 attr.c                             |  89 ++++++++--
 dir.c                              |  82 ++++++---
 dir.h                              |   3 +-
 t/t0003-attributes.sh              |  22 +++
 t/t3001-ls-files-others-exclude.sh |  16 ++
 t/t3070-wildmatch.sh               |  27 +++
 t/t3070/wildtest.txt               | 165 +++++++++++++++++
 test-wildmatch.c                   | 208 ++++++++++++++++++++++
 wildmatch.c                        | 355 +++++++++++++++++++++++++++++=
++++++++
 wildmatch.h                        |   6 +
 14 files changed, 942 insertions(+), 42 deletions(-)
 create mode 100755 t/t3070-wildmatch.sh
 create mode 100644 t/t3070/wildtest.txt
 create mode 100644 test-wildmatch.c
 create mode 100644 wildmatch.c
 create mode 100644 wildmatch.h

--=20
1.7.12.1.405.gb727dc9
