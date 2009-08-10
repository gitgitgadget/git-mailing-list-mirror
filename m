From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [RFC PATCH v2 0/4] Sparse checkout
Date: Mon, 10 Aug 2009 22:19:18 +0700
Message-ID: <1249917562-5931-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 10 17:19:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaWez-0002iC-M3
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 17:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbZHJPT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 11:19:29 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbZHJPT3
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 11:19:29 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:22103 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbZHJPT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 11:19:28 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1021748rvb.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=4rvNUCJRC5wL6OHzhe6omGkssup6XhjoHoCACmlnFaM=;
        b=k7NS31/xLtoLjddg1MxchRB0JACc4Nh6wwpNWhNrAtl2LGQ8gE8XG1zJH9m/Q9tGZB
         2yaC0vdt/RndkfyApeYMsPfYFuh0F8X+P4zCdNsAI2QgTG8Rr23V12DaFhJZDqeP4qKH
         virn4wzISWgGs6dZpS9EJXSaHcMOkqB87e/bI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=t2P4v81pKkqGfQy3Y7su8Elqbq9aNjM2TJ+bBhwMTtNgWf7kjKi4T3eAF+Z8/z3Fby
         p+Vw6KQ3NMOpyWFVczDOPXZOfsk907sUqgL+7fIz7LCa50gfF7yAjQMtsT3dIsHx4AgN
         Sf/WZENNDeMX7jCFDoeKUrUbFNhV1o8YALfn4=
Received: by 10.141.36.18 with SMTP id o18mr1506397rvj.214.1249917569855;
        Mon, 10 Aug 2009 08:19:29 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.231.150])
        by mx.google.com with ESMTPS id k41sm22648568rvb.8.2009.08.10.08.19.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 08:19:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 10 Aug 2009 22:19:23 +0700
X-Mailer: git-send-email 1.6.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125457>

Another RFC, which is more usable than the last series I sent out.
Compared to the last one, a few more patches have gone the way of
Dodo; 'git shape-workdir' has become a hook and should be easier
to write too. All you need is a few
"git update-index --[no-]assume-unchanged" in .git/hooks/sparse.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
  Prevent diff machinery from examining assume-unchanged entries on
    worktree
  gitignore: read from index if .gitignore is assume-unchanged
  unpack_trees(): add support for sparse checkout
  read-tree: add --no-sparse to turn off sparse hook

 Documentation/technical/api-directory-listing.txt |    3 +
 builtin-clean.c                                   |    5 +-
 builtin-ls-files.c                                |    4 +-
 builtin-read-tree.c                               |    4 +-
 cache.h                                           |    3 +
 diff-lib.c                                        |    5 +-
 dir.c                                             |   70 +++++++---
 t/t1009-read-tree-sparse.sh                       |   48 +++++++
 t/t3001-ls-files-others-exclude.sh                |   20 +++
 t/t4039-diff-assume-unchanged.sh                  |   31 ++++
 t/t7300-clean.sh                                  |   19 +++
 unpack-trees.c                                    |  154 +++++++++++++=
+++++++-
 unpack-trees.h                                    |    3 +
 13 files changed, 335 insertions(+), 34 deletions(-)
 create mode 100755 t/t1009-read-tree-sparse.sh
 create mode 100755 t/t4039-diff-assume-unchanged.sh
