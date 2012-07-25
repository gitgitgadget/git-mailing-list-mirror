From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 6/7] Remove dead code which contains bad gettext block
Date: Wed, 25 Jul 2012 11:53:47 +0800
Message-ID: <6ab33ed2c1f637ecd2dfda411cf25b074b2d17ea.1343188013.git.worldhello.net@gmail.com>
References: <cover.1343188013.git.worldhello.net@gmail.com>
 <b4afad7f9c0b8ae32c04f8aa55a21c72b4ae5013.1343188013.git.worldhello.net@gmail.com>
 <915b2821410c2348817a469e7be05be497cf1d06.1343188013.git.worldhello.net@gmail.com>
 <79fe36e1c66cec02eb54c48390d59bb1714c4736.1343188013.git.worldhello.net@gmail.com>
 <aea1284d5d0d441c8c85af3961d8c9062c2412e0.1343188013.git.worldhello.net@gmail.com>
 <1493bd09efd0ba6e1d56500305d989047da245ec.1343188013.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 05:54:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StsgT-0000GU-9K
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 05:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932798Ab2GYDyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 23:54:43 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52643 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932768Ab2GYDyl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 23:54:41 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so705020pbb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 20:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=EKDyMSMPn5QWPkGe2DQ5C9dLlchEYXVcROryAtIqMY4=;
        b=vrZMCGFNYP04p7J6PJkl3OAVpCefGwk7MJ5w0+z5MXl3eiLC67Bxx9lNYDe5/Bl6di
         totQ6GE3AKCndzv99wN8rfqj4yEFLsIPUlko3MyFkpTTimauuUZuOeVq/9dA8u6oc6s4
         kI+6xeXVWnVBtTjSWDI8wdf4ffzc6d40955l5towp6e2vV5bfJ9aN7NTnRwyFyhWGrnz
         elNpVqHva7nSDyvo5iHCvwZb1ebKiZN9OckftFl7K4ouwAJhAHX6C71UlHbUdr2zUN/h
         jFv5nGJFhPsgsocB6tHSAgaCElr2/CdZXBtTMY9HK7wjWpR+zHOUcl5OjMQhcw2NcWFv
         s6UA==
Received: by 10.68.223.164 with SMTP id qv4mr49870804pbc.20.1343188481457;
        Tue, 24 Jul 2012 20:54:41 -0700 (PDT)
Received: from localhost.localdomain (li380-141.members.linode.com. [106.187.37.141])
        by mx.google.com with ESMTPS id rg10sm13463345pbc.54.2012.07.24.20.54.37
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 20:54:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc0.16.gf4916ac
In-Reply-To: <1493bd09efd0ba6e1d56500305d989047da245ec.1343188013.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1343188013.git.worldhello.net@gmail.com>
References: <cover.1343188013.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202114>

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
index 3f654..c81a2 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -413,9 +413,6 @@ it will be removed. Please do not use it anymore.")
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
