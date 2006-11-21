X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: [PATCH] setlinebuf() vs HP-UX
Date: Tue, 21 Nov 2006 23:19:28 +0100
Organization: NextSoft
Message-ID: <200611212319.28385.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 21 Nov 2006 22:20:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32045>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmdy4-0006r3-Dt for gcvg-git@gmane.org; Tue, 21 Nov
 2006 23:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756662AbWKUWTt convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006 17:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756462AbWKUWTt
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 17:19:49 -0500
Received: from holub.nextsoft.cz ([195.122.198.235]:18356 "EHLO
 holub.nextsoft.cz") by vger.kernel.org with ESMTP id S1756662AbWKUWTs convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006
 17:19:48 -0500
Received: by holub.nextsoft.cz (Postfix, from userid 111) id 982E974F; Tue,
 21 Nov 2006 23:19:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by holub.nextsoft.cz
 (Postfix) with ESMTP id 0F1EB74B for <git@vger.kernel.org>; Tue, 21 Nov 2006
 23:19:45 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1]) by localhost
 (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id
 27239-06 for <git@vger.kernel.org>; Tue, 21 Nov 2006 23:19:44 +0100 (CET)
Received: from michal.rokos.cz (unknown [88.83.237.35]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (Client did not present a
 certificate) by holub.nextsoft.cz (Postfix) with ESMTP id 80BD0745 for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 23:19:41 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

it seems that HP-UX doesn't have setlinebuf() defined.
This tiny patch makes GIT compile again on HP-UX 11i.

Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>

diff --git a/builtin-archive.c b/builtin-archive.c
index 2df1a84..a8a1f07 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -249,7 +249,7 @@ int cmd_archive(int argc, const char **a
 	if (remote)
 		return run_remote_archiver(remote, argc, argv);
=20
-	setlinebuf(stderr);
+	setvbuf(stderr, NULL, _IOLBF, BUFSIZ);
=20
 	memset(&ar, 0, sizeof(ar));
 	tree_idx =3D parse_archive_args(argc, argv, &ar);

--=20
Michal Rokos

NextSoft s.r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
phone:  +420 267 224 311
fax:    +420 267 224 307
mobile: +420 736 646 591
