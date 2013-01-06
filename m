From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] clone: forbid --bare --separate-git-dir <dir>
Date: Sun,  6 Jan 2013 16:47:50 +0700
Message-ID: <1357465670-32766-1-git-send-email-pclouds@gmail.com>
References: <20130106091642.GA10956@elie.Belkin>
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
X-From: git-owner@vger.kernel.org Sun Jan 06 10:48:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trmpv-0001CC-LV
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 10:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712Ab3AFJrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 04:47:49 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:61226 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189Ab3AFJrr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 04:47:47 -0500
Received: by mail-pb0-f41.google.com with SMTP id xa7so10029712pbc.0
        for <git@vger.kernel.org>; Sun, 06 Jan 2013 01:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=6OT57tw0A4GRe+rjF+e1YO1RnlgXGAiGjMxN720qeUw=;
        b=mq9eVECSR3wptphb1xHTqkM/uql46wtb2RZaFZitHl2WB/uh2LijUfk2WpTc+wjOfO
         9xW+5fPWWQGf06Jd3Az65LnlMQFlQB75QUqWyO31h0b2dCdozYrRx/0VGj+VJheCUNXs
         RAwLhvMCFW9vUp3qo4WAnrMTrOe8oRowJ5Z9TagesgSMeAblZq3DGBw82ahHLxjj3976
         PVNv3dte9yhjCBAsZ1FvQBm1BmnWrt6Bi1xRLK4bWCd2MiEG3069Ee9w0foXpOAd0Xwq
         EUHBwj1vdLj2RXUlnODTMTujk49g38qAE2cZFV9O3I1CKgTT8U8MVJfkGsG0k7lHRqgr
         QVFQ==
X-Received: by 10.68.197.71 with SMTP id is7mr176691278pbc.79.1357465667134;
        Sun, 06 Jan 2013 01:47:47 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id i1sm36581246pav.35.2013.01.06.01.47.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Jan 2013 01:47:46 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 16:47:54 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <20130106091642.GA10956@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212790>

--separate-git-dir was added to clone with the repository away from
standard position <worktree>/.git. It does not make sense to use it
without creating working directory.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Sun, Jan 6, 2013 at 4:16 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
 > Duy Nguyen wrote:
 >
 >>                                                               And
 >> because junk_work_tree is not set up for --bare, I guess we still n=
eed
 >> to fix "--bare --separate-git-dir" case, or forbid it because i'm n=
ot
 >> sure if that case makes sense at all.
 >
 > Forbidding it makes sense to me.  If some day we want a git command =
to
 > create a .git file, I don't think it should be spelled as "git clone
 > --bare --separate-git-dir <repo>".

 That command does not work because --separate-git-dir requires an
 argument in addition to <repo>, which is taken as the target repo.
 Still it's hard to find a use case for

 git clone --bare --separate-git-dir <real-repo> <symlink-repo>
=20
 > In the meantime,
 >
 >         printf '%s\n' 'gitdir: /path/to/repo' >repo.git
 >
 > works fine.

 Yeah. A separate clone operation following by that printf should be
 clearer.


 builtin/clone.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index ec2f75b..360e430 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -704,6 +704,12 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 		if (option_origin)
 			die(_("--bare and --origin %s options are incompatible."),
 			    option_origin);
+		if (real_git_dir)
+			/*
+			 * If you lift this restriction, remember to
+			 * clean .git in this case in remove_junk_on_signal
+			 */
+			die(_("--bare and --separate-git-dir are incompatible."));
 		option_no_checkout =3D 1;
 	}
=20
--=20
1.8.0.rc2.23.g1fb49df
