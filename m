From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/3] Multithread index-pack
Date: Wed, 11 Apr 2012 12:49:45 +0700
Message-ID: <1334123388-6083-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 07:50:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHqS9-0003qG-NQ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 07:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152Ab2DKFul convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 01:50:41 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:35976 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab2DKFuk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 01:50:40 -0400
Received: by dake40 with SMTP id e40so706932dak.11
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 22:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=15UmdFtunAmq3Tl2P+dB6dIF6pbuGOtdPKQLDMCrWEo=;
        b=TShZc0z/JKeWj5FdpFS83WEzeA9X8+ms9pHsTM6/icNxOPM9oV/AzBE+5VuQ/D8d0k
         xm2fk/eEeYJy6S/IDyZqoyPARstGQpk/fGUa3o9bOqbc5L4MdJDe2Y+7cjWsx1oSC2qx
         uFaXNpfSkufoo3T1SWp7QhOuG5cEBD4Xcq3Ot9sjaALM8xJIYGXrWYAl6QjdIXPDLbov
         x3V40puaiF642KcOl5JPbeWwsW+Urr/ueqBbhaRzMFTntYCendpXcTtqYYo3nHFPR2aA
         v0WZuzIngkMboZPWeK6lbN3wt6nrp/4Hq4EA7ftZtzXxCRb2ftSbTFrwxHDs03/umDzg
         lsWg==
Received: by 10.68.217.132 with SMTP id oy4mr11994687pbc.162.1334123440404;
        Tue, 10 Apr 2012 22:50:40 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id gh7sm1939665pbc.8.2012.04.10.22.50.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 22:50:38 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Apr 2012 12:49:53 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195146>

This round hopefully fixes MinGW brekages for real. I also added a
perf test but not so sure if this is a correct way to do.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  index-pack: split second pass obj handling into own function
  index-pack: support multithreaded delta resolving

Ramsay Allan Jones (1):
  compat/win32/pthread.h: Add an pthread_key_delete() implementation

 Documentation/git-index-pack.txt |   10 ++
 Makefile                         |    2 +-
 builtin/index-pack.c             |  229 ++++++++++++++++++++++++++++++=
+++-----
 compat/win32/pthread.h           |    5 +
 t/perf/p5302-pack-index.sh       |   40 +++++++
 5 files changed, 257 insertions(+), 29 deletions(-)
 create mode 100755 t/perf/p5302-pack-index.sh

--=20
1.7.3.1.256.g2539c.dirty
