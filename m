From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 0/7] textconv with grep and show
Date: Fri, 10 May 2013 17:08:18 +0200
Message-ID: <cover.1368197380.git.git@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 17:09:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaowi-0004Tg-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 17:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753712Ab3EJPJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 11:09:16 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60707 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753600Ab3EJPJP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 May 2013 11:09:15 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B02AC20C0E;
	Fri, 10 May 2013 11:09:12 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 10 May 2013 11:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id; s=
	smtpout; bh=PFlSoOMPThYnsqADs50jF1Aq9bw=; b=Zx7MEsVQOKIvcveZl3X3
	46sIVi09VQNSVBWX6TSmzOeO5rJyLtKYY6C/xa3V8yNaGZsmdt0DLKggQPW/JL+B
	bTBihH2mEHXUJ38kfPu2Q3uHyY13hYqz3lu9uHf6fQ6+qSguMGtA4HeAdywBKYdj
	ANHpcDmVL0OWZy7vNVPPK/w=
X-Sasl-enc: n7icmVj1I8YIUKno+dHW1XzCxm7LWT3l7QuHUTqOANY9 1368198551
Received: from localhost (unknown [213.221.117.228])
	by mail.messagingengine.com (Postfix) with ESMTPA id C0B4BC80010;
	Fri, 10 May 2013 11:09:11 -0400 (EDT)
X-Mailer: git-send-email 1.8.3.rc1.406.gf4dce7e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223862>

This is the "Git Merge edition" of the textconv series. Great
conference, the series struggles to match that.

v3 keeps all defaults as they are (no textconv for blobs by default) and
incorporates Junio's touched_flags patch. I do not need the callback but
left it in.

As for beeing able to choose textconv as a default for blobs, I'm
wondering how fine grained that needs to be: one for all, differentiate
between "show blob" and "grep", or even driver specific
(diff.driver.blobtextconv boolean).

In the latter case, it's not clear to me how "--textconv" with a "false"
config should behave.

Jeff King (1):
  grep: allow to use textconv filters

Junio C Hamano (1):
  diff_opt: track whether flags have been set explicitly

Michael J Gruber (5):
  t4030: demonstrate behavior of show with textconv
  show: honor --textconv for blobs
  cat-file: do not die on --textconv without textconv filters
  t7008: demonstrate behavior of grep with textconv
  grep: honor --textconv for the case rev:path

 Documentation/git-grep.txt           |   9 +++-
 Documentation/technical/api-diff.txt |  10 +++-
 builtin/cat-file.c                   |  18 +++----
 builtin/grep.c                       |  13 +++--
 builtin/log.c                        |  26 +++++++--
 diff.c                               |   3 ++
 diff.h                               |   8 ++-
 grep.c                               | 100 ++++++++++++++++++++++++++++++-----
 grep.h                               |   1 +
 object.c                             |  26 ++++++---
 object.h                             |   2 +
 t/t4030-diff-textconv.sh             |  24 +++++++++
 t/t7008-grep-binary.sh               |  31 +++++++++++
 t/t8007-cat-file-textconv.sh         |  20 ++-----
 14 files changed, 234 insertions(+), 57 deletions(-)

-- 
1.8.3.rc1.406.gf4dce7e
