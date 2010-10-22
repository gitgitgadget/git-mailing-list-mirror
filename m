From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/7] merge -h: show usage even with corrupt index
Date: Fri, 22 Oct 2010 01:49:45 -0500
Message-ID: <20101022064945.GG6081@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 08:53:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9BVR-0004MB-FD
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 08:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914Ab0JVGxc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 02:53:32 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63042 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816Ab0JVGxc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 02:53:32 -0400
Received: by gxk23 with SMTP id 23so126810gxk.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 23:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DPG4hL4kV16KL/gMuPbf7RbQG+n9dCFSR/764GJFhEY=;
        b=bqFYz9qyE2s2OSwnflwGNg1ibyJZya1FalJBAgyJco07uWtDPq+xo0w60oGFFseGWw
         JON+sbU53ZHciuJsVIcYOIdijWsY5oPtMs7v+4I3BPL0tzchr0mwcSj7hjHd1uWWx3+7
         GmgmCcA5hGvi/bZ4rkk5SK8j0qU4ndLgxRvHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=YfCZhRNT90/QqYH3LcEbM1vIQJQiBiHQn2K/kEJ/9AsyctTwZNc15prwrieWfSnDI7
         aSflA16w07yJ5beg4iIYwkRwPa4ibbwA9yZeAp5et87L9WH9gj7FtdzS1gkskgRGbIY7
         oZ/TRO4+KAs67NICIc+L+EmPg/S7d05WcPz+k=
Received: by 10.150.205.7 with SMTP id c7mr5355020ybg.381.1287730411185;
        Thu, 21 Oct 2010 23:53:31 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id i2sm2092558yha.31.2010.10.21.23.53.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 23:53:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101022063837.GA6081@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159656>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Part of a campaign to make sure "git <command> -h" works correctly
when run from distractingly bad repositories.

[jn: with rewritten log message and tests]

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/merge.c  |    2 ++
 t/t7600-merge.sh |   11 +++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 5f65c0c..584c94f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -909,6 +909,8 @@ int cmd_merge(int argc, const char **argv, const ch=
ar *prefix)
 	const char *best_strategy =3D NULL, *wt_strategy =3D NULL;
 	struct commit_list **remotes =3D &remoteheads;
=20
+	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(builtin_merge_usage, builtin_merge_options);
 	if (read_cache_unmerged()) {
 		die_resolve_conflict("merge");
 	}
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index b4f40e4..b147a1b 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -144,6 +144,17 @@ test_expect_success 'test option parsing' '
 	test_must_fail git merge
 '
=20
+test_expect_success 'merge -h with invalid index' '
+	mkdir broken &&
+	(
+		cd broken &&
+		git init &&
+		>.git/index &&
+		test_expect_code 129 git merge -h 2>usage
+	) &&
+	grep "[Uu]sage: git merge" broken/usage
+'
+
 test_expect_success 'reject non-strategy with a git-merge-foo name' '
 	test_must_fail git merge -s index c1
 '
--=20
1.7.2.3
