From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 23/27] svn: learn ref-storage argument
Date: Thu, 18 Feb 2016 00:17:46 -0500
Message-ID: <1455772670-21142-24-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:19:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWGzi-0001cT-GW
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424968AbcBRFTI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Feb 2016 00:19:08 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:33042 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424900AbcBRFTA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:19:00 -0500
Received: by mail-qg0-f51.google.com with SMTP id b35so29347981qge.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AJ0EwoK9i7sZSVFNr6Pz/7M5UGS93h6n/XlsGUnrqgU=;
        b=Z6CW0S42N1k2d4qx3GHtUxZ4qZ4VoeH+g4vV4W+VlGTS7867Tk08yrbVcAkKKiGc7P
         MDFiZqQpXS19UKpUoCU/XYC37UjjMgo/3rmMADGzBdzFxC1bOB4/E3RBBxoTgcMCYIHD
         F2ziUxbkdq57vCs62KxRU4vUyzF4PBluTAZOcnTqNFtsGT9cCtzxpBOZf8rqYU+o2cFu
         7JtyivsyAzhPiI6hfErCuVJ27Fh4eCIepbj0VZNlyjtgcgWTv0Q6M7OjDSsPvs0YJuov
         /6Nx8bKDV3IKA6inVtZlBAT3km8LG2z4cBF3fz1y4Q/B7Dbb8+zESGS3yKIHDjxa/GIf
         tkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=AJ0EwoK9i7sZSVFNr6Pz/7M5UGS93h6n/XlsGUnrqgU=;
        b=EHda2hl2aoxUa+qfvE6eMdYtbdfssBMMDdytepy22U12u2qG+tcgRrUf4d7w2Ns+Yz
         E8MHiL/QhlmGrp+GuMZLEUejNlond1hpfWo8CS2tRqVxMuH0egcKKIRM8FmAJ5KdOGxD
         TZg9uc2UZaRQvPy1GElTgTyygqqgDsL9NMOS/2L4w0LQN8qjc5IIAPjKdqSwgL/BZCZF
         UDVroT/eoCuwdXzCnKDifIBqr0e6Ivhi2ZbCWvvpQwWgsDSFJSIEuIOancg211IMHv+0
         tQ3fvCqnnkv7QQdPbj272YZuXhypHWHL7NFDQ53nX5cIzd6k/LHueI2gBdS4SY3MTx+P
         wWzQ==
X-Gm-Message-State: AG10YOS+CT1ZXCCrF0g73AMYL32hAD8dQPS9uyzsZTtfVvYFBXGes+fjLbS46G8LCizBrA==
X-Received: by 10.140.23.81 with SMTP id 75mr6653353qgo.35.1455772739435;
        Wed, 17 Feb 2016 21:18:59 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:58 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286587>

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
2.4.2.767.g62658d5-twtrsrc
