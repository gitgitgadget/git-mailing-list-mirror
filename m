From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/6] setup: save prefix (original cwd relative to toplevel)
 in startup_info
Date: Mon, 29 Nov 2010 21:10:48 -0600
Message-ID: <20101130031048.GF5326@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
 <20101022064258.GB6081@burratino>
 <7v8w1qnkr1.fsf@alter.siamese.dyndns.org>
 <20101024072032.GA23455@burratino>
 <20101024081316.GA29630@burratino>
 <20101130025223.GA5326@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 04:11:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNGcT-0003pn-MU
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 04:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250Ab0K3DK7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 22:10:59 -0500
Received: from mail-vw0-f66.google.com ([209.85.212.66]:51659 "EHLO
	mail-vw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab0K3DK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 22:10:58 -0500
Received: by vws15 with SMTP id 15so467714vws.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 19:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Z713Pbsy0bVTh2uu1hBGJUPxB588v8peYvyqCSHMpxw=;
        b=SsVIvcFfPX0yIDhGpZxZ8QX+QRaJmTpsoBUebJJlwxaXQf/sOb1gz7Sb3VPgMVGdfE
         akmxe9iEbUqS50HQbj9yZRIkvkavX3y+tGzPF6zdhz4taMvLeSMXRTZL9IU/Q9u9ZGoV
         Kr+QdHMb+5edCsWfxknJaZWytkJYqy2TaqOJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=v3zp6PQD+ZAW3tRaeZMEjM5XTP6PR29pwpAZjk+ofsBMWImRCsosqWrNf7V2hcgvPi
         ZMyKBA3gKwXTaSI8jMkKg+tVuG6IXCzQKaNXSZtbxP3zbYN3nDdw5VXotoPUlE9m29sb
         WeiVlcVEAAwnCysTPiCidVFsli2Jg7duseE9M=
Received: by 10.220.179.204 with SMTP id br12mr1987560vcb.25.1291086657642;
        Mon, 29 Nov 2010 19:10:57 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id l5sm905219vcr.14.2010.11.29.19.10.55
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 19:10:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101130025223.GA5326@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162468>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Save the path from the original cwd to the cwd at the end of the
setup procedure in the startup_info struct introduced in e37c1329
(2010-08-05).  The value cannot vary from thread to thread anyway,
since the cwd is global.

So now in your builtin command, instead of passing prefix around,
when you want to convert a user-supplied path to a cwd-relative
path, you can use startup_info->prefix directly.

Caveat: As with the return value from setup_git_directory_gently(),
startup_info->prefix would be NULL when the original cwd is not a
subdir of the toplevel.

Longer term, this would allow the prefix to be reused when several
noncooperating functions require access to the same repository (for
example, when accessing configuration before running a builtin).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Typo in v1 log message fixed (s/wiould/would/).

 cache.h |    1 +
 setup.c |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 33decd9..222d9cf 100644
--- a/cache.h
+++ b/cache.h
@@ -1117,6 +1117,7 @@ const char *split_cmdline_strerror(int cmdline_er=
rno);
 /* git.c */
 struct startup_info {
 	int have_repository;
+	const char *prefix;
 };
 extern struct startup_info *startup_info;
=20
diff --git a/setup.c b/setup.c
index a3b76de..833db12 100644
--- a/setup.c
+++ b/setup.c
@@ -512,8 +512,10 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 	const char *prefix;
=20
 	prefix =3D setup_git_directory_gently_1(nongit_ok);
-	if (startup_info)
+	if (startup_info) {
 		startup_info->have_repository =3D !nongit_ok || !*nongit_ok;
+		startup_info->prefix =3D prefix;
+	}
 	return prefix;
 }
=20
--=20
1.7.2.3
