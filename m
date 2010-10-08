From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 05/10] list_deps: accept -i/-w
Date: Fri,  8 Oct 2010 09:58:03 +0200
Message-ID: <724f5482452ad11bd3fb8560bacb080fa1cef0a4.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
 <0e1f993f68d36f0c3d848c2aa78f46c7130a24f1.1286524446.git.bert.wesarg@googlemail.com>
 <f8601225b41e5f03b50688c0582466879faaff26.1286524446.git.bert.wesarg@googlemail.com>
 <c013d1489409b5d6e76764aba07eca7107715691.1286524446.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Per Cederqvist <ceder@lysator.liu.se>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Oct 08 09:58:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P47qp-00020q-Kc
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 09:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245Ab0JHH6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 03:58:25 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48018 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177Ab0JHH6W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 03:58:22 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so77487bwz.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 00:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=NLLWgoFZWrtpGiaNNAPnps68FaMDgHndI947XI0LpCU=;
        b=nia4RXQmsgGHeF1G3l4mRlBSd10ptRw/Cr+nbCLlKMDptIHxKUC92i5stKDx5ZVddP
         fIz/vcQzKct6Gh+qz5XJDmfW0CnFIrMQzK8w1+uuNm7mAzBrfaer6vdG49GYdrxIRIcr
         7oc9j+Hn4rBeAckL2L08jKcJcw6nLFh+1w91k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LB8w0xiO1ImL1vD90SPloW2GQ5FrNHLPT6kPrqKVCmS/wXjKbKtzI5molX+4WSFA0A
         LhnlLXnZUxmkK06tnMYY4dwIN4EZCnJDg9gHBbfSZF2LNYTz5eoVV6t4RBd/j9fk+UZw
         4AyAoZzpscAGmrlWJbU2XMb3bHdFETAAQv/N4=
Received: by 10.204.66.206 with SMTP id o14mr1655430bki.159.1286524701585;
        Fri, 08 Oct 2010 00:58:21 -0700 (PDT)
Received: from localhost (p5B0F732C.dip.t-dialin.net [91.15.115.44])
        by mx.google.com with ESMTPS id o12sm1167319bkb.9.2010.10.08.00.58.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 00:58:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <c013d1489409b5d6e76764aba07eca7107715691.1286524446.git.bert.wesarg@googlemail.com>
In-Reply-To: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158484>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg.sh |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tg.sh b/tg.sh
index a166a70..72ee9f5 100644 tg.sh
--- a/tg.sh
+++ b/tg.sh
@@ -289,9 +289,13 @@ branch_empty()
 	[ "$(pretty_tree "$1" -b)" = "$(pretty_tree "$1" ${2-})" ]
 }
 
-# list_deps
+# list_deps [-i | -w]
+# -i/-w apply only to HEAD
 list_deps()
 {
+	head="$(git symbolic-ref HEAD)"
+	head="${head#refs/heads/}"
+
 	git for-each-ref refs/top-bases |
 		while read rev type ref; do
 			name="${ref#refs/top-bases/}"
@@ -299,7 +303,10 @@ list_deps()
 				continue;
 			fi
 
-			git cat-file blob "$name:.topdeps" | while read dep; do
+			from=$head_from
+			[ "$name" = "$head" ] ||
+				from=
+			cat_file "$name:.topdeps" $from | while read dep; do
 				dep_is_tgish=true
 				ref_exists "refs/top-bases/$dep"  ||
 					dep_is_tgish=false
-- 
1.7.1.1067.g5aeb7
