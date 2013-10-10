From: Julien Carsique <julien.carsique@gmail.com>
Subject: [PATCH] git-prompt.sh: show the upstream abbrev name
Date: Thu, 10 Oct 2013 16:40:39 +0200
Message-ID: <1381416039-16576-1-git-send-email-jcarsique@nuxeo.com>
References: <20131010135813.GF19704@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julien Carsique <julien.carsique@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	"Eduardo R . D'Avila" <erdavila@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 10 16:42:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUHRO-00051r-7L
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 16:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077Ab3JJOmA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Oct 2013 10:42:00 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:51148 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab3JJOl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 10:41:59 -0400
Received: by mail-wg0-f45.google.com with SMTP id z12so1328733wgg.24
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 07:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BsSmEDU0J+iB4Fk0Y7G9zBtVfpELcGRqj+cTIhBWEPQ=;
        b=KdKdAzbE7+5svgpUK+IleSFCrprJrHykAZE8cYtXxVEuL/3ix6U26NwSlX2Maqde1u
         a4ZwE7Buckx1R3L15StdISxbBmzQa7D4PdXGT+Gc/9nEy3oZgyZjPXzPirgF021YOnwW
         0LwHvjiL/nMfMyaInkvugMWJ48qWrBHHLAihxJZcCjP8yNLu6EHHdptXQSFGsD0Oej4l
         9/02XivM9WGUffPARYDecqpgvyw61uwebkZRAeUMcyuMNLO7JxWuwF5oR9Fzvp1RphKa
         PWzajGlm7VheMo64nW7cOVCrjfZxap6haVTJfVNfOtFAAAgLrqEkvJmd1ELauNK9oCpo
         i6fQ==
X-Received: by 10.194.239.40 with SMTP id vp8mr2542382wjc.45.1381416117931;
        Thu, 10 Oct 2013 07:41:57 -0700 (PDT)
Received: from nocebo.in.nuxeo.com ([176.57.246.10])
        by mx.google.com with ESMTPSA id ey4sm26615179wic.11.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 07:41:57 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <20131010135813.GF19704@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235865>

=46rom: Julien Carsique <julien.carsique@gmail.com>

When working with multiple remotes, it is common to switch the upstream
from a remote to another. Doing so, the prompt may not be the expected
one. Providing an option to display tracking information sounds useful.

Add a "name" option to GIT_PS1_SHOWUPSTREAM which will show the upstrea=
m
abbrev name. This option is ignored if "verbose" is false.

Signed-off-by: Julien Carsique <julien.carsique@gmail.com>
Reviewed-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-prompt.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index d6c61b2..84cd3a8 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -60,6 +60,7 @@
 # of values:
 #
 #     verbose       show number of commits ahead/behind (+/-) upstream
+#     name          if verbose, then also show the upstream abbrev nam=
e
 #     legacy        don't use the '--count' option available in recent
 #                   versions of git-rev-list
 #     git           always compare HEAD to @{upstream}
@@ -94,7 +95,7 @@ __git_ps1_show_upstream ()
 {
 	local key value
 	local svn_remote svn_url_pattern count n
-	local upstream=3Dgit legacy=3D"" verbose=3D""
+	local upstream=3Dgit legacy=3D"" verbose=3D"" name=3D""
=20
 	svn_remote=3D()
 	# get some config options from git-config
@@ -122,6 +123,7 @@ __git_ps1_show_upstream ()
 		git|svn) upstream=3D"$option" ;;
 		verbose) verbose=3D1 ;;
 		legacy)  legacy=3D1  ;;
+		name)   name=3D1 ;;
 		esac
 	done
=20
@@ -204,6 +206,9 @@ __git_ps1_show_upstream ()
 		*)	    # diverged from upstream
 			p=3D" u+${count#*	}-${count%	*}" ;;
 		esac
+		if [[ -n "$count" && -n "$name" ]]; then
+			p=3D"$p $(git rev-parse --abbrev-ref "$upstream" 2>/dev/null)"
+		fi
 	fi
=20
 }
--=20
1.8.1.2
