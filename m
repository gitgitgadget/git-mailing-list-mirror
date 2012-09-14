From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 03/11] grep: show --debug output only once
Date: Fri, 14 Sep 2012 11:46:35 +0200
Message-ID: <53e193b5c4ab329baf469ff20549839fa3088d97.1347615361.git.git@drmicha.warpmail.net>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 11:47:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCSUP-00076D-1L
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 11:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509Ab2INJq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 05:46:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52781 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753518Ab2INJqu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 05:46:50 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 530FD20969;
	Fri, 14 Sep 2012 05:46:50 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 14 Sep 2012 05:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Td
	Npvw7FrLvcTpxpya8HMmNfgj8=; b=e6js4K5XMlWd6miSlmsRz5mDNnoXPrIWwY
	QcT4p/LkO8YyCl5W0ClvVU1WBL/nsJsU7bqCFEoPDUh1zb8blBfVS97ff0ymRJ0L
	i2cqyP4jMnFWOOGpJa/3CDD6lrSbrwWZeDXnp9TP2ckdabAB22DGHswVruu2i8lc
	h6/wVqp6w=
X-Sasl-enc: h+yYkjv6195PX6/fXJ06fx+fet3mwBvGQo5qyzPXcBIL 1347616009
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E7F7C8E0175;
	Fri, 14 Sep 2012 05:46:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.592.g41e7905
In-Reply-To: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1347615361.git.git@drmicha.warpmail.net>
References: <cover.1347615361.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205469>

When threaded grep is in effect, the patterns are duplicated and
recompiled for each thread. Avoid "--debug" output during the
recompilation so that the output is given once instead of "1+nthreads"
times.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/grep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/grep.c b/builtin/grep.c
index 8aea00c..a7e8df0 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -209,6 +209,7 @@ static void start_threads(struct grep_opt *opt)
 		int err;
 		struct grep_opt *o = grep_opt_dup(opt);
 		o->output = strbuf_out;
+		o->debug = 0;
 		compile_grep_patterns(o);
 		err = pthread_create(&threads[i], NULL, run, o);
 
-- 
1.7.12.592.g41e7905
