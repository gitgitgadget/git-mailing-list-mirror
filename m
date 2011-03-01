From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC 2/2] grep: make --full-tree work with pathspecs
Date: Tue,  1 Mar 2011 10:53:30 +0100
Message-ID: <3719d9a120eef618d875629662a87e715de55d4e.1298972832.git.git@drmicha.warpmail.net>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 10:57:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuMKN-0005AT-Jt
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 10:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756133Ab1CAJ5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 04:57:00 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58974 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754461Ab1CAJ47 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2011 04:56:59 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0CE5A20881;
	Tue,  1 Mar 2011 04:56:59 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 01 Mar 2011 04:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=QUnSxWrKYHic4Y55DgrkH4Wx1ns=; b=EyC6PMH/4xD5gs+PtwIzmort1uWaUugFs3d4+2k7mK+1oCFNkysd2WS0kmhv1Dei064GC4vsgs/7eJXarm+nQZrLamw/q5DTvZSZ+pbn+r1CHA75l1wNsfHWrM4DvOtKH4giFmVEsVgQ+qfCDy+5cMKUvFZxa6LnC0uP+V4Usyk=
X-Sasl-enc: s7itwaZR1/JzV+q5JDS6Nf+g+qTMKvkInAhw9rcQAgze 1298973418
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 869FA44291B;
	Tue,  1 Mar 2011 04:56:58 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.257.gb09fa
In-Reply-To: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
In-Reply-To: <cover.1298972832.git.git@drmicha.warpmail.net>
References: <cover.1298972832.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168206>

When --full-tree is given, make the pathspecs be applied relative to the
root. That way, "git grep --full-tree expr -- *.c" looks in all C files in
the repo.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/grep.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d005528..e0a75a7 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -959,7 +959,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 	if (i < argc)
-		paths = get_pathspec(prefix, argv + i);
+		paths = get_pathspec(!full_tree ? prefix : NULL, argv + i);
 	else if (prefix && !full_tree) {
 		paths = xcalloc(2, sizeof(const char *));
 		paths[0] = prefix;
-- 
1.7.4.1.257.gb09fa
