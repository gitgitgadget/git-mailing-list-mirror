From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/4] Better "gc --aggressive"
Date: Sun, 16 Mar 2014 20:34:59 +0700
Message-ID: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 14:34:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPBCw-0005gN-7d
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 14:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbaCPNe0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Mar 2014 09:34:26 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:48735 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbaCPNeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 09:34:25 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so4609524pad.7
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 06:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=xFUZLpqZ4k/xd9gzIsTS/n3cze/ExFQQ+6Wpm/VIhXc=;
        b=U4usPkPHxAHq0tBzwTKY43xTotU+UWh0vG7BOUdP8PxDmNiA7LCABKvncmNmYp+cLL
         bqwDxwUpS+ieUKF1+7tRoXEg94GNA3SooB8pSJRuCQRTNbjydDnwoQyw2fSjFswv1eBB
         1YkUcb3nsCvyX/fYWVS5avdg42ilCCFnNTl+POGZ5rIntVcDLxy+J3E83rdOfjq+TvzK
         lgOalvFFIXQuXslTd2DvLZexpIWj4u5tFRmGepc90ORbfbexjVZIzGcispcIC+CTIpuL
         TLSmbQ35NCNiOKYYqnqS62XcCTwoHEgyfn6PC67by+bQcC/7SP8lfQZ8u+WXYmNrfud2
         qjHw==
X-Received: by 10.68.93.3 with SMTP id cq3mr2263697pbb.145.1394976864610;
        Sun, 16 Mar 2014 06:34:24 -0700 (PDT)
Received: from lanh ([115.73.203.48])
        by mx.google.com with ESMTPSA id z3sm56698086pas.15.2014.03.16.06.34.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Mar 2014 06:34:23 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Mar 2014 20:35:06 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244194>

See [1] for the discussion that led to this series. It attempts to
pack the repo with two different depths: old history tightly packed
(smaller but also takes longer time to access) and recent history on
the opposite.

=46irst draft, probably still some bugs lurking in pack_old_history().
It would be great if people could try it out on large repos and report
back the results (pack size between the old and new aggressive, gc
time, git log and blame speed...)

[1] http://thread.gmane.org/gmane.comp.version-control.git/242277

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  environment.c: fix constness for odb_pack_keep()
  pack-objects: support --keep
  gc --aggressive: make --depth configurable
  gc --aggressive: three phase repacking

 Documentation/config.txt           |  24 ++++++++
 Documentation/git-gc.txt           |   3 +
 Documentation/git-pack-objects.txt |   4 ++
 builtin/gc.c                       | 113 +++++++++++++++++++++++++++++=
+++++++-
 builtin/pack-objects.c             |  26 +++++++++
 environment.c                      |   2 +-
 git-compat-util.h                  |   2 +-
 7 files changed, 169 insertions(+), 5 deletions(-)

--=20
1.9.0.40.gaa8c3ea
