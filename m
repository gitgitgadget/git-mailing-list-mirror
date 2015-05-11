From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 1/4] t/lib-httpd: load mod_unixd
Date: Mon, 11 May 2015 13:54:17 +0200
Message-ID: <e0e9ff212442929cf5e29a8105ae280785a070f5.1431344881.git.git@drmicha.warpmail.net>
References: <0727016B-E495-4577-A174-E0EA85910BD3@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 13:54:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrmI2-000497-Gs
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 13:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854AbbEKLy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 07:54:26 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36417 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753462AbbEKLyX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 07:54:23 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 42915209B5
	for <git@vger.kernel.org>; Mon, 11 May 2015 07:54:23 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 11 May 2015 07:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:date:from:in-reply-to:in-reply-to:message-id:references
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=VD0OI
	iM463LnjYyeeuoXz2I/Y2E=; b=Vh6kuanWmRe6FBW8Te/RxtyWwF/GK7POhXpJ+
	TtMlkNJqWOAaP1NyMpS0UNl2gPwL0+e78AMzxHsaVAL4g+emECBjhuBDNV9LTci+
	TYCBD7zsgioOq+oEefShlW6FKVWuXFOAMOQsI/eY1eic2LcbQeC7KLIvANVFw0Jh
	hhz7Aw=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:in-reply-to
	:message-id:references:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=VD0OIiM463LnjYyeeuoXz2I/Y2E=; b=ThUQQ
	hz9cJrexNXg7CCReeGZ+1FDwNmh+NNe568A0S/9kprOmpTLZ2npfwNn5zE82GZcs
	aVzM+YlGF2kl7bLlJ8CvLgrjWkkEtUugsyoM+aQgA0XQW2K2pSteWHCZohl0bEOM
	X5wdcb3R5Nc9ksJXLNkx22P0T5IWsPTIgYNngA=
X-Sasl-enc: QHAno06g2KnTNJq+fq6DBiOo7BGsVDSCejX4KktPdwW/ 1431345262
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B9E7268011D;
	Mon, 11 May 2015 07:54:22 -0400 (EDT)
X-Mailer: git-send-email 2.4.0.rc3.332.g886447c
In-Reply-To: <0727016B-E495-4577-A174-E0EA85910BD3@gmail.com>
In-Reply-To: <cover.1431344881.git.git@drmicha.warpmail.net>
References: <cover.1431344881.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268770>

In contrast to apache 2.2, apache 2.4 does not load mod_unixd in its
default configuration (because there are choices). Thus, with the
current config, apache 2.4.10 will not be started and the httpd tests
will not run on distros with default apache config (RedHat type).

Enable mod_unixd to make the httpd tests run. This does not affect
distros negatively which have that config already in their default
(Debian type). httpd tests will run on these before and after this patch.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/lib-httpd/apache.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 0b81a00..7b8e21c 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -64,6 +64,9 @@ LockFile accept.lock
 <IfModule !mod_mpm_prefork.c>
 	LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
 </IfModule>
+<IfModule !mod_unixd.c>
+	LoadModule unixd_module modules/mod_unixd.so
+</IfModule>
 </IfVersion>
 
 PassEnv GIT_VALGRIND
-- 
2.4.0.rc3.332.g886447c
