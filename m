From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [BUG, PATCH v2 0/3] Fix {blame,cat-file} --textconv for cases with symlinks
Date: Tue, 21 Sep 2010 00:39:43 +0400
Message-ID: <cover.1285013802.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 22:38:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxn8H-0002Dn-2n
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 22:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757555Ab0ITUiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 16:38:05 -0400
Received: from landau.phys.spbu.ru ([195.19.235.38]:39279 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364Ab0ITUiE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 16:38:04 -0400
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id BE439FF71F; Tue, 21 Sep 2010 00:38:02 +0400 (MSD)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.72)
	(envelope-from <kirr@roro3.zxlink>)
	id 1Oxn9Q-0006MC-Vq; Tue, 21 Sep 2010 00:39:49 +0400
X-Mailer: git-send-email 1.7.3.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156664>

Recently I've spot a bug in git blame --textconv, which was wrongly
calling pdftotext (my *.pdf conversion program) on a symlink.pdf, and I
was getting something like

    $ git blame -C -C regular-file.pdf
    Error: May not be a PDF file (continuing anyway)
    Error: PDF file is damaged - attempting to reconstruct xref table...
    Error: Couldn't find trailer dictionary
    Error: Couldn't read xref table
    Warning: program returned non-zero exit code #1
    fatal: unable to read files to diff

That errors come from pdftotext run on symlink.pdf being extracted to
/tmp/ with one-line plain-text content pointing to link destination.

Please apply and thanks,
Kirill

v2:

 o Incorporated suggestions by Matthieu and Jeff (details in each patch)


Kirill Smelkov (3):
  tests: Prepare --textconv tests for correctly-failing conversion
    program
  blame,cat-file: Demonstrate --textconv is wrongly running converter
    on symlinks
  blame,cat-file --textconv: Don't assume mode is ``S_IFREF | 0664''

 builtin.h                        |    2 +-
 builtin/blame.c                  |   33 ++++++++++++++-------
 builtin/cat-file.c               |    2 +-
 sha1_name.c                      |    2 +
 t/t4042-diff-textconv-caching.sh |   25 ++++++++--------
 t/t8006-blame-textconv.sh        |   58 +++++++++++++++++++++++++++++++++----
 t/t8007-cat-file-textconv.sh     |   36 ++++++++++++++++++++---
 7 files changed, 121 insertions(+), 37 deletions(-)

-- 
1.7.3.rc2
