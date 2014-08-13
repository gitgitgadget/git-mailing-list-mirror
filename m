From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 0/6] Large file improvements
Date: Wed, 13 Aug 2014 17:57:28 +0700
Message-ID: <1407927454-9268-1-git-send-email-pclouds@gmail.com>
References: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, worley@alum.mit.edu,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 12:58:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHWGa-0000pZ-1I
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 12:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbaHMK5o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2014 06:57:44 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:60516 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbaHMK5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 06:57:41 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so14253134pde.37
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=X+kxh86Lswos7k7/t347WxZacppYi/bDWsKQKXQmFN0=;
        b=oUvtcMslJ18LpT5vAdtzvWq3CgPmn48MujcITM7vkW8XTMhNAA3ivHYtJkA2l+NKWr
         cwa9INnyDmGgYYdK13HEpttg2hysvXvJclTJqytkWUOQlDTu/ubdmfjveYn1r9QhFf/b
         /ATpCiPkBpz5PQfeMGw67hypC3L42n1o3I+AsUNQPPPggnTVEuQX2DxEH5hYvKwdTQv3
         oJ1KGu2El99Kf4bnYnkR16BDDvlIaSGHHMJecE8rWns3fMl6J5lAYUuj8joy90i4fPHw
         9U2QVxk9yQPtIXXdFMq0EEFofouQiDMNnO6YtvdVI9o/d+aYvXORDODGGttUupW48XvS
         ZKGw==
X-Received: by 10.66.183.235 with SMTP id ep11mr3262074pac.113.1407927461382;
        Wed, 13 Aug 2014 03:57:41 -0700 (PDT)
Received: from lanh ([115.73.196.146])
        by mx.google.com with ESMTPSA id k8sm1724191pbq.94.2014.08.13.03.57.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Aug 2014 03:57:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Aug 2014 17:57:36 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255199>

Since v2:

 - reword the fsck patch to center around unpack_compressed_entry inste=
ad
 - make sure unpack-objects survive out of memory error because of larg=
e files
 - rename diff_filespec_population flags
 - make "git diff <tree> <tree>" work on large files

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  wrapper.c: introduce gentle xmalloc(z) that does not die()
  sha1_file.c: do not die failing to malloc in unpack_compressed_entry
  unpack-objects: continue when fail to malloc due to large objects
  diff.c: allow to pass more flags to diff_populate_filespec
  diff --stat: mark any file larger than core.bigfilethreshold binary
  diff: shortcut for diff'ing two binary SHA-1 objects

 Documentation/config.txt        |  3 +-
 Documentation/gitattributes.txt |  4 +--
 builtin/unpack-objects.c        | 42 +++++++++++++++++++++++-
 diff.c                          | 52 +++++++++++++++++++++--------
 diffcore-rename.c               |  6 ++--
 diffcore.h                      |  4 ++-
 git-compat-util.h               |  2 ++
 sha1_file.c                     |  4 ++-
 t/t1050-large.sh                | 25 ++++++++++++++
 wrapper.c                       | 73 ++++++++++++++++++++++++++++++++-=
--------
 10 files changed, 177 insertions(+), 38 deletions(-)

--=20
2.1.0.rc0.78.gc0d8480
