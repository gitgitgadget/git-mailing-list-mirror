From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 18/21] svn: learn ref-storage argument
Date: Fri,  5 Feb 2016 14:44:19 -0500
Message-ID: <1454701462-3817-19-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:45:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmJs-0001hL-KZ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbcBETpY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 14:45:24 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:34888 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314AbcBETpD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:45:03 -0500
Received: by mail-qg0-f44.google.com with SMTP id y89so2350578qge.2
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RA3oND5Z0396ZI1xBWXH4fNY+p6WqFJ7ETPrId6pd7A=;
        b=D5TLJTILDrn6y0HWLgrGSaTIO2BTagdKdSY8eyotQU2ATswR8F0e0p0vJvI8pInPoR
         wrZ/6RDd4XrPAM2utFO9oA/mUoInuBN7PdBfVDdGdQwjM3aIANU3PiG9NM0O75wkDC91
         Z2fnxbK33G6BDfohqHEi4QnC9lrALCPBFk+llw2iNgXUyoD6vJF6fx7MR6YDUtCJD5Vo
         OarlAY453YIbHzO2PmFntfuLk8zE4WMHtz6qJpZj/WN3a03aoohWbEXaFvrz4OaRAdcv
         dZEft8ugha0d7+NNwmjm4pvPTwCmNtMXNVczWa5ncZxH8Uwc4MFatd8ZJMVIShtXuDx6
         XFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=RA3oND5Z0396ZI1xBWXH4fNY+p6WqFJ7ETPrId6pd7A=;
        b=HhliJhe/hL1F7F+hMldqQnLWL0EB3MXqYKoy/pNrYY56Ot2E+HQiBzODPmzNj6U6wz
         R7ldlVT3jQ2njezLDP507kyqjaUeEqEfuzkVtET4Upbcxq5HqiMpc2bX5GTVYCoCo7xj
         Tzu8rlEdWtClPzlX9vo7gMgIfmIoyAYEJ9gtXPI9ry8PXgKbKvKNmia8BMynZJ4I3kGM
         piXTB+O4RMg5W/OjwgHKUCuBlyC+IR9W6AIWSdzG792DjVn5wgpIKl9Wm4S2849ygmYx
         A0My+EZjaH+V7yAg5GXDO6sG+Zxm7hogI5Q5EQLj6TBbXDelLR/VlytAsewHpNb/YrEd
         lvYg==
X-Gm-Message-State: AG10YORJvZqNM8/PtbGq033kwZShZPx0GskqwApWqr8og/4hp9M+QzmJ5V+y2ENxYYfEkg==
X-Received: by 10.140.181.195 with SMTP id c186mr20340899qha.4.1454701503156;
        Fri, 05 Feb 2016 11:45:03 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.45.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:45:02 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285614>

git svn learns to pass the ref-storage command-line argument (to init
and clone) through to git init.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 2 +-
 git-svn.perl                           | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index cb9c473..ba4137d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2477,7 +2477,7 @@ _git_svn ()
 			--branches=3D --stdlayout --minimize-url
 			--no-metadata --use-svm-props --use-svnsync-props
 			--rewrite-root=3D --prefix=3D --use-log-author
-			--add-author-from $remote_opts
+			--add-author-from --ref-storage=3D $remote_opts
 			"
 		local cmt_opts=3D"
 			--edit --rmdir --find-copies-harder --copy-similarity=3D
diff --git a/git-svn.perl b/git-svn.perl
index fa5f253..15d1544 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -141,7 +141,7 @@ my %fc_opts =3D ( 'follow-parent|follow!' =3D> \$Gi=
t::SVN::_follow_parent,
 		'localtime' =3D> \$Git::SVN::_localtime,
 		%remote_opts );
=20
-my ($_trunk, @_tags, @_branches, $_stdlayout);
+my ($_trunk, @_tags, @_branches, $_stdlayout, $_ref_storage);
 my %icv;
 my %init_opts =3D ( 'template=3Ds' =3D> \$_template, 'shared:s' =3D> \=
$_shared,
                   'trunk|T=3Ds' =3D> \$_trunk, 'tags|t=3Ds@' =3D> \@_t=
ags,
@@ -153,6 +153,7 @@ my %init_opts =3D ( 'template=3Ds' =3D> \$_template=
, 'shared:s' =3D> \$_shared,
 		  'use-svnsync-props' =3D> sub { $icv{useSvnsyncProps} =3D 1 },
 		  'rewrite-root=3Ds' =3D> sub { $icv{rewriteRoot} =3D $_[1] },
 		  'rewrite-uuid=3Ds' =3D> sub { $icv{rewriteUUID} =3D $_[1] },
+		  'ref-storage=3Ds' =3D> \$_ref_storage,
                   %remote_opts );
 my %cmt_opts =3D ( 'edit|e' =3D> \$_edit,
 		'rmdir' =3D> \$Git::SVN::Editor::_rmdir,
@@ -469,6 +470,9 @@ sub do_git_init_db {
 				push @init_db, "--shared";
 			}
 		}
+		if (defined $_ref_storage) {
+		    push @init_db, "--ref-storage=3D" . $_ref_storage;
+		}
 		command_noisy(@init_db);
 		$_repository =3D Git->repository(Repository =3D> ".git");
 	}
--=20
2.4.2.749.g730654d-twtrsrc
