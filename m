From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 0/2] Show committer ident in some cases
Date: Fri,  2 May 2008 20:22:19 +0200
Message-ID: <1209752541-19111-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 20:23:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrzuq-0006o7-DW
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 20:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbYEBSWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 14:22:32 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765487AbYEBSWc
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 14:22:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:11240 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765484AbYEBSWb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 14:22:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1009255fgg.17
        for <git@vger.kernel.org>; Fri, 02 May 2008 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=MUvi0qmq8/5tR7a55eojvR9NXrG/msBwg0HlOhplv/E=;
        b=QSCq9lUImT9xvdIxrQkfDWZXq6J3t69wHgN0RZV322if/HpacA/qt8JzuSa3aFmi5NQFZlvCM63FpDWoZHrFRnkMaxtn6B9+gmksCm3xix6SLj02shh6vdyfDBjw+FDftYfrC0c92hLM0WHpwKyvr4BjQrNa7QohicSFUUbRdws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=AdnNfRD1ShiDl6i87rmrfyuz9Lo3cBSsWjIXVCHSewJh4Uz0ZzIozEzlpXaTcZL+HoXgxRqYTNY0tUnfEpSCwulJlnQVLe3VvH8x6AhdHU1QHufIogmCF84q/+3Dz4231ouF2pCD+Ruw3glPxgEtCGVHhF1CvIJ6y/ebgz7AlEw=
Received: by 10.86.77.5 with SMTP id z5mr3989096fga.13.1209752549299;
        Fri, 02 May 2008 11:22:29 -0700 (PDT)
Received: from localhost ( [91.13.90.240])
        by mx.google.com with ESMTPS id y6sm15746346mug.15.2008.05.02.11.22.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 May 2008 11:22:28 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.223.g2532
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81016>

Hi *,

 This patch series tries to make more evident the committer ident
used in a commit to prevent using the wrong one.

The definition of "wrong committer" could be:

1) user.{name,email} or GIT_COMMITTER_{NAME,EMAIL} is not a wrong commi=
tter.
2) automatic without a domain name (user@hostname.(none)) is a wrong co=
mmitter.
   (not handled with this patch series)
3) automatic or partially set ident:
   a) wrong committer for some users
   b) right committer for others

The different strategies are.. Show the committer:

1) always
2) when user.warn =3D yes (defaulting to yes)
3) when it is automatic
   a) always
   b) and different from parent
   c) and different from a list of valid committer idents
   d) and when user.WarnAutomatic =3D yes (defaulting to yes)

The first patch implements 3a
The second patch implements 3d

I prefer 3a.

Santi

Santi B=C3=A9jar (2):
  commit: Show committer if automatic
  user.warnautomatic: add config to control if the committer ident is
    shown

 Documentation/config.txt |    4 ++++
 builtin-commit.c         |   40 +++++++++++++++++++++++++++++++++++++-=
--
 cache.h                  |    2 ++
 config.c                 |    9 +++++++++
 environment.c            |    2 ++
 ident.c                  |    3 +++
 t/t7502-commit.sh        |   31 +++++++++++++++++++++++++++++--
 7 files changed, 86 insertions(+), 5 deletions(-)
