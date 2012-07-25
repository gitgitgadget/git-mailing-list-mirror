From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 6/7] Remove dead code which contains bad gettext block
Date: Wed, 25 Jul 2012 22:44:06 +0800
Message-ID: <c44188f93823a8028086d8abf5c59250b877c25c.1343227045.git.worldhello.net@gmail.com>
References: <cover.1343227045.git.worldhello.net@gmail.com>
 <9f7ba1a0ce85184cc410bf7c2e8c3133f46f0237.1343227045.git.worldhello.net@gmail.com>
 <051a48c40cd144e36c4cd5798376d56bdc4705bf.1343227045.git.worldhello.net@gmail.com>
 <0aa19c8238587fc04616b67bc6dfa9c926fcfb5f.1343227045.git.worldhello.net@gmail.com>
 <6326c11afd7b4077f2aba27101fd9acc8e2f8b6a.1343227045.git.worldhello.net@gmail.com>
 <7483bb4c75600ac3ffd4f740040a4256ff70821f.1343227045.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 16:45:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su2qC-0000I2-B4
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 16:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933367Ab2GYOpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 10:45:22 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63906 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933322Ab2GYOpU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 10:45:20 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1516221pbb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 07:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=rexwCjI/DvU1sbG7RICGK7Y3vCs79rPZ840DkrXEEPQ=;
        b=0DkRLx9+XQi63czxv9DJGm/QfNdnYoCSwclVWvdwN7JQh1hmiwU4nZVONoOLUzg4n+
         eckHz05JCt9uL6f+oEaYRG/X2+i0hz1gwb3srhR4T8hClkOdVxSG+s4rBKqb7BydgmFx
         Gys8WJts6VBJfrRIfTYdjyeMq0PMPyFpdNy7o8PIsBQWWp/GfXUA3+ekW0qKz0RDGyFs
         hY97BlfxHbgXAdDmxO3B2dvVaQ6pKPCcMg59tSCopMCC29SUjnSS1NPaX0hX6C62asGa
         GlQq7uxe0DjQsIiWM3GRUVdnRgQQHNH36chEKwEm5HuVdpkXYnRFvTfwggzfMxYANldY
         diCg==
Received: by 10.68.189.162 with SMTP id gj2mr26939453pbc.153.1343227519840;
        Wed, 25 Jul 2012 07:45:19 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id op10sm14492740pbc.75.2012.07.25.07.45.12
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 07:45:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <7483bb4c75600ac3ffd4f740040a4256ff70821f.1343227045.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343227045.git.worldhello.net@gmail.com>
References: <cover.1343227045.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202156>

Found this dead code when I examine gettext messages in shell scripts
start with dash ('-' or '--'). An error will be raised for this case,
like:

    $ gettext "-d option is no longer supported.  Do not use."
    gettext: missing arguments

Indead, this code has been left as dead for a long time, as Jonathan
points out:

    The git am -d/--dotest option has errored out with a message
    since e72c7406 (am: remove support for -d .dotest, 2008-03-04).
    The error message about lack of support was eliminated along
    with other cleanups (probably by mistake) a year later by
    removing the option from the option table in 98ef23b3 (git-am:
    minor cleanups, 2009-01-28).

    But the code to handle -d and --dotest stayed around even though
    ever since then it could not be tripped.  Remove this dead code.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Reviewed-by: Stefano Lattarini <stefano.lattarini@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-am.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 25d0e..bd962 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -413,9 +413,6 @@ it will be removed. Please do not use it anymore."
 		abort=t ;;
 	--rebasing)
 		rebasing=t threeway=t ;;
-	-d|--dotest)
-		die "$(gettext "-d option is no longer supported.  Do not use.")"
-		;;
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
 	--whitespace|--directory|--exclude|--include)
-- 
1.7.12.rc0.16.gf4916ac
