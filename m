From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] clone: forbid --bare --separate-git-dir <dir>
Date: Fri, 11 Jan 2013 10:09:59 +0700
Message-ID: <1357873799-17413-1-git-send-email-pclouds@gmail.com>
References: <1357465670-32766-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 04:10:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtV0U-0002Xb-3u
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 04:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237Ab3AKDJu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jan 2013 22:09:50 -0500
Received: from mail-da0-f47.google.com ([209.85.210.47]:38488 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab3AKDJt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 22:09:49 -0500
Received: by mail-da0-f47.google.com with SMTP id s35so548132dak.20
        for <git@vger.kernel.org>; Thu, 10 Jan 2013 19:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=JlWHg4MtMzW6fLOPOjYtaL5w/uAD7gOVFglJwe2v9i4=;
        b=WB0VtSy7U+qOq3bGyOY03AcQPYcZFQJcB6CmoJW7+CL9/oFBbyUj/taMHGp0l4cF6D
         gwqCVzglvplX/0wEfY5VlMkrDRUJYyigrKvu0BkhR4gXhp4I7jKIEXFhBIUh+aHOjQhg
         gkDe+zx7r9ETxKyyx9u6FRINr6Sb2gJ0RajPdaL+X2KYP0bljIcuJrGz/ZNGW2terSHC
         j0yhBhfhkD34e56H+0ybsTlNe6g/NaQ0DXHx8jBSfhPAs1J1aQqfGN5oql/VNrRAWkBz
         nY/7X+kQzBmRRtETLVYv7D6EyU33RpfvvAgQCEbX93/4w+lex36VpIo0dKWfj1FI/g75
         LmHA==
X-Received: by 10.66.85.103 with SMTP id g7mr203557399paz.45.1357873789009;
        Thu, 10 Jan 2013 19:09:49 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id a4sm2168231pax.25.2013.01.10.19.09.44
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Jan 2013 19:09:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 10:10:02 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357465670-32766-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213166>

The --separate-git-dir option was introduced to make it simple to put
the git directory somewhere outside the worktree, for example when
cloning a repository for use as a submodule.

It was not intended for use when creating a bare repository. In that
case there is no worktree and it is more natural to directly clone the
repository and create a .git file as separate steps:

        git clone --bare /path/to/repo.git bar.git
        printf 'gitdir: bar.git\n' >foo.git

=46orbid the combination, making the command easier to explain.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Just reword the commit message (or copying it from Jonathan
 actually). No comments about remove_junk_on_signal because we're less
 likely to re-enable it again.

 builtin/clone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index ec2f75b..b30189f 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -704,6 +704,8 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 		if (option_origin)
 			die(_("--bare and --origin %s options are incompatible."),
 			    option_origin);
+		if (real_git_dir)
+			die(_("--bare and --separate-git-dir are incompatible."));
 		option_no_checkout =3D 1;
 	}
=20
--=20
1.8.0.rc2.23.g1fb49df
