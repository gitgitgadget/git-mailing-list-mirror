From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 08/19] git-mergetool.sh: convert test -a/-o to && and ||
Date: Tue, 20 May 2014 06:50:21 -0700
Message-ID: <1400593832-6510-9-git-send-email-gitter.spiros@gmail.com>
References: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Cc: jrnieder@gmail.com, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 15:51:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmkS6-0000jn-LU
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 15:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbaETNv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 09:51:28 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:44100 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbaETNur (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 09:50:47 -0400
Received: by mail-pd0-f172.google.com with SMTP id x10so342904pdj.3
        for <git@vger.kernel.org>; Tue, 20 May 2014 06:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9MoCYttWB0nzHqs1sjg7/WtvIAPrzFEBjEvjjbcpZGk=;
        b=pE3mKdzGbhGoorFD5rJEVG0jZcTd0bM2nyCdg5/iryVGeE0iHfrCNo9UmaNFY/Sud/
         b/lmzTJ8IAdIeFtdU5y04FYL47E+ZRS/n//eAFSe+LCLASQgr7BzeFApw+77sgP0j/5U
         GZHidBPyOpkhUREefjCNHusHn/7bMg7RPXA+KKSU8yORSnNDSTodFL7aNdq0VvbY7F/V
         t+J2O+3nr1NP+X2ufjAH5LHprAumIBsGONaKa8Fqar7CN1CUyvZknepgmTgchtkOPaSS
         Di6Fb6QfPxYMOt38sCqnToqDs5gws/rnwWmSoK7YhhpMoWafkrWtjmD1LG/dzsC4RDSC
         CDaQ==
X-Received: by 10.68.178.194 with SMTP id da2mr50462620pbc.151.1400593847025;
        Tue, 20 May 2014 06:50:47 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id oe4sm3317286pbb.33.2014.05.20.06.50.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 06:50:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1400593832-6510-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249678>

The interaction with unary operators and operator precedence
for && and || are better known than -a and -o, and for that
reason we prefer them. Replace all existing instances
of -a and -o to save readers from the burden of thinking
about such things.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 git-mergetool.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 332528f..88e853f 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -205,7 +205,7 @@ checkout_staged_file () {
 		"$(git checkout-index --temp --stage="$1" "$2" 2>/dev/null)" \
 		: '\([^	]*\)	')
 
-	if test $? -eq 0 -a -n "$tmpfile"
+	if test $? -eq 0 && test -n "$tmpfile"
 	then
 		mv -- "$(git rev-parse --show-cdup)$tmpfile" "$3"
 	else
@@ -256,7 +256,7 @@ merge_file () {
 	checkout_staged_file 2 "$MERGED" "$LOCAL"
 	checkout_staged_file 3 "$MERGED" "$REMOTE"
 
-	if test -z "$local_mode" -o -z "$remote_mode"
+	if test -z "$local_mode" || test -z "$remote_mode"
 	then
 		echo "Deleted merge conflict for '$MERGED':"
 		describe_file "$local_mode" "local" "$LOCAL"
-- 
1.7.10.4
