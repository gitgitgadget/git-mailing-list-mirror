From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 6/7] Remove dead code which contains bad gettext block
Date: Wed, 25 Jul 2012 22:53:12 +0800
Message-ID: <c44188f93823a8028086d8abf5c59250b877c25c.1343227806.git.worldhello.net@gmail.com>
References: <cover.1343227806.git.worldhello.net@gmail.com>
 <9f7ba1a0ce85184cc410bf7c2e8c3133f46f0237.1343227806.git.worldhello.net@gmail.com>
 <051a48c40cd144e36c4cd5798376d56bdc4705bf.1343227806.git.worldhello.net@gmail.com>
 <0aa19c8238587fc04616b67bc6dfa9c926fcfb5f.1343227806.git.worldhello.net@gmail.com>
 <6326c11afd7b4077f2aba27101fd9acc8e2f8b6a.1343227806.git.worldhello.net@gmail.com>
 <7483bb4c75600ac3ffd4f740040a4256ff70821f.1343227806.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 16:55:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su30B-0008Vz-2z
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 16:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933461Ab2GYOy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 10:54:29 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40079 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933188Ab2GYOyT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 10:54:19 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1526654pbb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=rexwCjI/DvU1sbG7RICGK7Y3vCs79rPZ840DkrXEEPQ=;
        b=xAAd6SSOquywMZ8Ely25xIfRa8qXXyNe8pFiwMCSerEk3zBNOC0kJnezixVJKwzwlG
         3VH5zb5LYNMfulu6bxS193y+9Cb3S8GGmakuKz8S3MCRZNmu+scoGWiHOvPxov92ybn2
         W4CltFn/1JYcOSYsaFtK76OO1IWL1RAb0LR2q8QPlbNnWyI+U+ymqjQbtYksRoEAe/CL
         Mrwo39qS7FvK3DMZBnC8FzIIchDnkW9jz+jbwAdUZ4oBZxdN6Wp9ZW+qsdljrR/PXaCj
         f0fonN/9dBbJpCiJT5ufd6myqnXNOl5Hp2Js/WfnfLA0Bdq7WAaKiRUORqmcpSmpMqX8
         maZA==
Received: by 10.68.219.226 with SMTP id pr2mr54173768pbc.1.1343228059513;
        Wed, 25 Jul 2012 07:54:19 -0700 (PDT)
Received: from localhost.foo.bar ([123.116.228.123])
        by mx.google.com with ESMTPS id px1sm1886775pbb.49.2012.07.25.07.54.12
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 07:54:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <7483bb4c75600ac3ffd4f740040a4256ff70821f.1343227806.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343227806.git.worldhello.net@gmail.com>
References: <cover.1343227806.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202164>

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
