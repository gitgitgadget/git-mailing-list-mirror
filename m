From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 0/4] textconv for show and grep
Date: Wed,  6 Feb 2013 16:08:49 +0100
Message-ID: <cover.1360162813.git.git@drmicha.warpmail.net>
References: <20130205201106.GA29248@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 16:09:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U36cf-00035Z-5f
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 16:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350Ab3BFPIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 10:08:53 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36463 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754572Ab3BFPIw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2013 10:08:52 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 339C5214BB;
	Wed,  6 Feb 2013 10:08:52 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 06 Feb 2013 10:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=PHQHUkYQz7i8EhGk/9FRBax/L
	Qo=; b=leqLcjJxvMMbxXPnOih9lMhGErhazumosz5I4gEj/jwbV4ZfvGW6pcyoO
	uIvkzzRN6AKrLUSzMGLjxJvco7et/a5Ej+CA+z0h58p23eSqyuQtFwFac2OEqCHl
	LztQo+EEXJYcVpv0L+d1/HorpADrj2tKTrZ4KYSuUBsGX8aAb4=
X-Sasl-enc: YY/yBMV1NB/uhBEx9iAmEgBGb8F4iJImTDcx+x2n0nAw 1360163331
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A73624827DE;
	Wed,  6 Feb 2013 10:08:51 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.752.g32d147e
In-Reply-To: <20130205201106.GA29248@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215581>

This min series aims at completing the textconv support of user facing
commands. It is RFC for lack of documentation and tests, to check
whether we really want to go in that direction (I do).

1/4 covers the missing textconv support in the "blob case" of "git
show", which should be (and then is) analogous to "cat-file" and "diff".

2/4 remedies an oddity of "git cat-file --textconv", which errored out
when there is no textconv filter rather than giving an unfiltered blob
(like every other textconv aware command).

3/4 implements "--textconv" for "git grep" sans the blob case; the code
is all Jeff's.

4/4 adds blob support to 3/4 (the "rev:path" case).

3 and 4 can be squashed, of course.

Now I'm quite a happy differ/shower/grepper with my latin1 and OO files ;)

Jeff King (1):
  grep: allow to use textconv filters

Michael J Gruber (3):
  show: obey --textconv for blobs
  cat-file: do not die on --textconv without textconv filters
  grep: obey --textconv for the case rev:path

 builtin/cat-file.c           |   9 ++--
 builtin/grep.c               |  13 +++---
 builtin/log.c                |  24 +++++++++--
 grep.c                       | 100 +++++++++++++++++++++++++++++++++++++------
 grep.h                       |   1 +
 object.c                     |  26 ++++++++---
 object.h                     |   2 +
 t/t8007-cat-file-textconv.sh |  20 +++------
 8 files changed, 148 insertions(+), 47 deletions(-)

-- 
1.8.1.2.752.g32d147e
