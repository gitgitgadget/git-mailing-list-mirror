From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/8] support "in-tree attributes" for git-archive
Date: Wed,  8 Apr 2009 20:05:25 +1000
Message-ID: <1239185133-4181-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 12:08:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrUhx-0005bq-VN
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 12:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761779AbZDHKG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 06:06:29 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758915AbZDHKG3
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 06:06:29 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:46357 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764084AbZDHKG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 06:06:28 -0400
Received: by rv-out-0506.google.com with SMTP id b25so751452rvf.5
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 03:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=n2MExel9fsEUPhhuZFG9P7UelIokzBgRkuT38mNz9GM=;
        b=PrtXPGmDBhvf3Fwx194kFii6cYhWp0vgSx/BZ8llXMaydlvQXvhER8ki1GTdlYLJu5
         9cjC5zHG4fWyfBcjooVT3+8gFrVFFWbdKCqatLjZ6z30AFLCiwGiuEg+/Y1xGT7jRVdD
         guessvnLftzDgc/XH5cR0GIp9Zc/TXR7lqC5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=IxsXGv2j8pSfO4SfngKBFOSFpAmt9gNQsSbi+d37yh1+nQek/7EabOyIgWN9voZ+KI
         YTBRvDKWFWSCYE5tjQw1wMCrstQeqtppK/1e6/WjNlU6j21QyE/Ci8PtIbT5737I/DdD
         +lwhLztZKRBrvmV6oCH5zMVrsLIkKhvprc3/E=
Received: by 10.141.107.13 with SMTP id j13mr453817rvm.251.1239185185670;
        Wed, 08 Apr 2009 03:06:25 -0700 (PDT)
Received: from dektop ([121.91.216.142])
        by mx.google.com with ESMTPS id k2sm24987817rvb.54.2009.04.08.03.06.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Apr 2009 03:06:25 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  8 Apr 2009 20:06:07 +1000
X-Mailer: git-send-email 1.6.2.2.602.g83ee9f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116067>

This series attempts to fix "git archive" sometimes looking into
=2Egitattributes in working directory and may cause undesired effects.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  archive: add shortcuts for --format and --prefix

This one is unrelated. Just a convenient patch.

  move prune_cache() to git lib
  archive: add a failure test wrt .gitattributes  misreading
  archive: add tests for directory selection
  attr: add GIT_ATTR_INDEX "direction"
  archive: use index instead of parsing tree directly
  archive: disregard .gitattributes on working directory

Main part, which converts archive.c to load index first, then export fr=
om there.

  archive: support creating archives from index

Well, show off patch ;-)

 Documentation/git-archive.txt |    4 +-
 archive.c                     |  106 +++++++++++++++++++++++++++++++--=
--------
 archive.h                     |    1 +
 attr.c                        |    4 +-
 attr.h                        |    3 +-
 builtin-ls-files.c            |   29 +-----------
 cache.h                       |    2 +
 read-cache.c                  |   27 ++++++++++
 t/t0024-crlf-archive.sh       |   35 +++++++++++++-
 t/t5000-tar-tree.sh           |    6 ++-
 10 files changed, 158 insertions(+), 59 deletions(-)
