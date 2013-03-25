From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/4] attr directory matching regression
Date: Mon, 25 Mar 2013 13:05:06 +0700
Message-ID: <1364191510-8900-1-git-send-email-pclouds@gmail.com>
References: <20130319175756.GA13760@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, avila.jn@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 07:05:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK0XX-0001qB-Q5
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 07:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757617Ab3CYGFY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Mar 2013 02:05:24 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:40662 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757609Ab3CYGFY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 02:05:24 -0400
Received: by mail-pa0-f53.google.com with SMTP id bh4so619919pad.26
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 23:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=E79kThwhcK/rZWJdkSAJID/MNJzqgx5/8oLu39ekeGs=;
        b=OgdvNkfr/KqYFixIDkT/Zo0+CK6sMr72VD/dyJqNGpg/RS4pEyJhm1lELWZTYg9Bg7
         d1zlUP+4CQ+ydHWHh72B1LlJ1UKI3jcqaK6qYRQzogvbEtkXtSVn3mkmmN95K2thS6/L
         CB8zpLXXDY+N/bksixcGOYdNP+QxohkvKBvOYLhQ8gMJl9sHMkVp6YsIXcG9VbSq+rRq
         Diu8OjTSF99oEMBk2ACmL7MSYL9twLkIb6iPKBNnLzj7YzESzXFnaDLmFkoa8IvTEUyX
         R6Rt6Kbn98+aJ+f8lRj1U9iyvgQ/7kC1AFbdCb7i1orYHYuNIqIPaJKj6LH69i2/K9/4
         BGPg==
X-Received: by 10.68.233.229 with SMTP id tz5mr15470504pbc.172.1364191523627;
        Sun, 24 Mar 2013 23:05:23 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id t1sm13483207pab.12.2013.03.24.23.05.18
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 23:05:22 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 25 Mar 2013 13:05:13 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <20130319175756.GA13760@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219006>

I think the fix is something like this. There is still one thing I'd
like to do: make this code not rely on NUL for terminating the
patterns. That should remove the ugly "p[len] =3D '\0'" in
prepare_attr_stack() 4/4 and and the reallocation in add_exclude() (in
current code). But let's deal with the regression first.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  wildmatch: do not require "text" to be NUL-terminated
  attr.c: fix pattern{,len} inconsistency in struct match_attr
  dir.c: make match_{base,path}name respect {basename,path}len
  attr.c: fix matching "subdir" without the trailing slash

 attr.c                          | 11 ++++++++++-
 dir.c                           | 13 ++++++++-----
 dir.h                           |  2 +-
 t/t5002-archive-attr-pattern.sh |  6 ++++++
 wildmatch.c                     | 43 ++++++++++++++++++++++++---------=
--------
 wildmatch.h                     | 11 +++++++++--
 6 files changed, 59 insertions(+), 27 deletions(-)

--=20
1.8.2.82.gc24b958
