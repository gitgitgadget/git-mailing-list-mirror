From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/6] wildmatch part 2
Date: Thu,  4 Oct 2012 14:39:46 +0700
Message-ID: <1349336392-1772-1-git-send-email-pclouds@gmail.com>
References: <7v626q3hen.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:23:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtUH-0001w8-96
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410Ab2JDHkH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 03:40:07 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37406 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab2JDHkF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 03:40:05 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so327364pbb.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=X/VeSJd6QPsin8VrIJKjNvx3JBefs9yy8v746peoy88=;
        b=YaQOCOLhyl6FkY3ieII99BX3zD+SUwBeFTWFz60ctiBL2iLn6UYH1Zvje2ikhYf7T4
         ROY5nWRqIGpFJUwL7TrkMjxkG5bmjdoo1PVrSQfVTz+2JCP96B+1C2fILGwoIkX0kYDh
         VvpwGXn3L+5xyyykGyXWys+Ui0jtJFs3mBwwHF3N6dLOyO7sJjzVcBBodi7eFolZgwUw
         8/0k1aHdMqUmIIi9+Kwlm1Gw6AGUHnlsGNSUvxRNOqielzdXyRSQC5rAyyX38oYfb1bJ
         ZZNiAP16pwWGhYSilO0Gcckkgbo2ey5oZUWFtF3pvig+TaGY8wIZypi/UQYPGNih2q0J
         J6/w==
Received: by 10.66.80.104 with SMTP id q8mr11207993pax.47.1349336405497;
        Thu, 04 Oct 2012 00:40:05 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id qb2sm3943461pbb.15.2012.10.04.00.40.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 00:40:04 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 04 Oct 2012 14:39:52 +0700
X-Mailer: git-send-email 1.7.12.1.405.gb727dc9
In-Reply-To: <7v626q3hen.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206994>

On Thu, Oct 4, 2012 at 1:01 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Perhaps the wildmatch code may not be what we want X-<.

When I imported wildmatch I was hoping to make minimum changes to it.
But wildmatch is probably the only practical way to support "**" even
if we later need to change it the way we want. Other options are base
our work on top of compat/fnmatch.c, which is an #ifdef spaghetti
mess, or write a new fnmatch()-compatible function. Both unattractive
to me.

Anyway, this is on top of nd/wildmatch, which makes "ab**cd" match
full pathname.

attr patches port .gitignore optimizations over. In long term, we
should probably have a shared matching implementation instead. I tried
that road once and failed so I won't attempt again any time soon. If
we drop wildmatch, I can split these attr patches out as a separate
series. It's a good thing to do anyway.

The last patch just reflects that current "**" is not exactly what we
want. I'm not sure if I could look into wildmatch.c and change it.
Anybody is welcome to step up, of course.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (6):
  attr: remove the union in struct match_attr
  attr: avoid strlen() on every match
  attr: avoid searching for basename on every match
  attr: more matching optimizations from .gitignore
  gitignore: do not do basename match with patterns that have '**'
  t3001: note about expected "**" behavior

 Documentation/gitignore.txt        |  10 ++--
 attr.c                             | 101 +++++++++++++++++++++++++++--=
--------
 dir.c                              |   6 +--
 dir.h                              |   2 +
 t/t0003-attributes.sh              |  16 ++++++
 t/t3001-ls-files-others-exclude.sh |  18 +++++++
 6 files changed, 118 insertions(+), 35 deletions(-)

--=20
1.7.12.1.405.gb727dc9
