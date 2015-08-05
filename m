From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC] gitweb: Don't pass --full-history to git-log(1)
Date: Wed,  5 Aug 2015 14:21:27 +0000
Message-ID: <1438784487-9176-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 16:21:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMzZn-00017E-O3
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 16:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbbHEOVq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2015 10:21:46 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35162 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbbHEOVp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 10:21:45 -0400
Received: by wibxm9 with SMTP id xm9so210788513wib.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=45j8VKYDgMkwBvAOPBdziGWBqSNjf4fWCZSFuw1Yt0w=;
        b=ICxEM/BA6VOx72LpM+r3bGyQ8lLQN0t8RztWMpTdbHl8bX3v77yHym75mPBAR2+bva
         BSQw5rc+YXE5WS+UmFhncOQUYRXC/mVVMTVCAOE8yklf0H2EoFuSIhcQG0ILlVexPvX+
         7n32je2F/nN/anhDeTZZvIjx8ddeUaY9oKiFyxZnI86rvh/TtGde1iS5i7Lpn3F1hCLG
         YyHsDeg5MZMIBJ42J6qA7r6PYMN9ArC0ecW8kXMKEMMHF4dLR1rpOKBEUa12cDwi7MnD
         3f27ZEe7Ee5o4TkOuz5/VjdC7Oz8uFO5dytrHGfesmWMyC8M4z64gKypywnFS3nWic+C
         Z27g==
X-Received: by 10.194.185.8 with SMTP id ey8mr20389133wjc.118.1438784504426;
        Wed, 05 Aug 2015 07:21:44 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id mc4sm7877206wic.6.2015.08.05.07.21.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Aug 2015 07:21:43 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275369>

When you look at the history for a file via "git log" we don't show
--full-history by default, but the Gitweb UI does so, which can be very
confusing for all the reasons discussed in "History Simplification" in
git-log(1) and in
http://thread.gmane.org/gmane.comp.version-control.git/89400/focus=3D90=
659

We've been doing history via --full-history since pretty much forever,
but I think this is much more usable, and on a typical project with lot=
s
of branches being merged it makes for a much less confusing view. We do
this for git log by default, why wouldn't Gitweb follow suit?

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7a5b23a..2913896 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7387,7 +7387,7 @@ sub git_log_generic {
 	}
 	my @commitlist =3D
 		parse_commits($commit_hash, 101, (100 * $page),
-		              defined $file_name ? ($file_name, "--full-history") : =
());
+		              defined $file_name ? $file_name : ());
=20
 	my $ftype;
 	if (!defined $file_hash && defined $file_name) {
--=20
2.1.3
