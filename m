From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 6/7] Remove dead code which contains bad gettext block
Date: Wed, 25 Jul 2012 16:34:11 +0800
Message-ID: <b22ea7d7306745555bfd39bf4ff51f485a005a02.1343205009.git.worldhello.net@gmail.com>
References: <cover.1343205009.git.worldhello.net@gmail.com>
 <b4afad7f9c0b8ae32c04f8aa55a21c72b4ae5013.1343205009.git.worldhello.net@gmail.com>
 <a8429a6fed3eb0d83d92f798ebf8241a0eeb49c1.1343205009.git.worldhello.net@gmail.com>
 <1ddee15de2edd59f870023ea25cefb5846daeba4.1343205009.git.worldhello.net@gmail.com>
 <100127d788275535c8079288ef9720f462a176b4.1343205009.git.worldhello.net@gmail.com>
 <6d764280b65f1eeb96bed77cdbfead465f8b99e4.1343205009.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 10:35:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stx4J-0002x9-28
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 10:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932859Ab2GYIf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 04:35:27 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40839 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932802Ab2GYIfY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 04:35:24 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1062095pbb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 01:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=L//kxr/tmp+Pjcek9Y8/2wyJ+MewqomzVTTg1HZOUtg=;
        b=AwAsG7Vzy9HYIoBFMpVfh4mrqNwXb7fZGbzOtUHcic8KyqGdSBcGcJHffUGUKpXdP+
         IkEThf2O7M1IGDgGjZRzeiayva+e19+ne22KDeoiqaCQZ1efuxlPy8wI74EcOmk7LjEz
         4bfUuyHYwqxT5ns9moCLwVDuRB5cwsZkMar++nJum9cNdVwaAi5N3iirEhvM/MWfjyt7
         yRNZD2sXjUetCE7wOk/I+atSTJJfNyd4pNrmzhWPiqNUwft9vJ9k5IOL8GXyfTHvdLtk
         1Mx6tgJr/R93rdX+VBdH9JaHZ3rwPJ7TGNsmct4W5NhBVjNoiXl38Ah3OF1UUv72vFH2
         NvzA==
Received: by 10.68.190.102 with SMTP id gp6mr51825507pbc.5.1343205323971;
        Wed, 25 Jul 2012 01:35:23 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id px1sm1313386pbb.49.2012.07.25.01.35.17
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 01:35:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <6d764280b65f1eeb96bed77cdbfead465f8b99e4.1343205009.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343205009.git.worldhello.net@gmail.com>
References: <cover.1343205009.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202140>

Found this dead code when I examine gettext messages in shell scripts
start with dash ('-' or '--'). An error will be raised for this case,
like:

    $ gettext "-d option is no longer supported.  Do not use."
    gettext: missing arguments

Indead, this code has been left as dead for a long time, as Junathan
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
