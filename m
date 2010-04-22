From: Jonathan Nieder <jrnieder@gmail.com>
Subject: filenames with spaces in traditional patches (Re: git-import-dsc:
 Error importing chromium-browser dsc)
Date: Thu, 22 Apr 2010 12:29:23 -0500
Message-ID: <20100422172923.GC7147@progeny.tock>
References: <20100422134812.15332.67457.reportbug@SD6-Casa.iuculano.it>
 <20100422163521.GA27711@bogon.sigxcpu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Iuculano <iuculano@debian.org>, 578752@bugs.debian.org,
	git@vger.kernel.org
To: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
X-From: git-owner@vger.kernel.org Thu Apr 22 19:29:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O50DK-0005hV-88
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 19:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363Ab0DVR3P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Apr 2010 13:29:15 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50951 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754182Ab0DVR3O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 13:29:14 -0400
Received: by wyb39 with SMTP id 39so5008985wyb.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SWkbdyfeGX1AN/b4QNP9vPgGyTn+i7JAO8gz4U0n1jk=;
        b=XmNwP6kqOO6XAR9qylyLRpyyRSldAqtbwziQSU//HhOFx47Eylj4De0VtbTx/Ffepx
         lGjXYDRMdbwRoIuPtFNouDfEtOhD4rYYQRu/O+JMgSYDQD71bqIgpKl5DX1GJJqT0ljj
         XjeV8ORUto6qEV5m5YlSE9IC33cdrVGw1QIRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=X69XX+vy4rQ8g1XIFoK/UVbLowGOG3oqViazpgLhoxq8guVbFdM0/7Cb/fjIjWhX6a
         m+OfLckvYuZkzmSolZJ3rBSioIwZZbQF390lQ2+S92hi5SfvCVGVDio2uOGPiNlTu9AO
         bINa4ZlDAFTnK9CSas25RQgqo6iXLkSpo7lBY=
Received: by 10.216.156.203 with SMTP id m53mr188251wek.209.1271957351780;
        Thu, 22 Apr 2010 10:29:11 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d16sm74221wej.21.2010.04.22.10.29.09
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Apr 2010 10:29:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100422163521.GA27711@bogon.sigxcpu.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145543>

retitle 578752 apply: handle spaces in filenames from traditional patch=
es
tags 578752 + upstream
thanks

Hi,

Guido G=C3=BCnther wrote:
> On Thu, Apr 22, 2010 at 03:48:12PM +0200, Giuseppe Iuculano wrote:

>> error: patch failed: debian/licenses/LICENSE.global:0
>> error: debian/licenses/LICENSE.global: patch does not apply
>> Error import /home/debian/chromium/chromium/chromium-browser_5.0.342=
=2E9~r43360-0ubuntu2.diff.gz: 256
[...]
> 	dget https://edge.launchpad.net/ubuntu/+archive/primary/+files/chrom=
ium-browser_5.0.342.9~r43360-0ubuntu2.dsc
[...]
> The issue is that git-apply doesn't handle the filenames containing
> spaces correctly like
>=20
>   'debian/licenses/LICENSE.global BSD-style Chromium' and
>   'debian/licenses/LICENSE.Apache (v2.0)'.

Thanks, both.  The problem is in the parse_traditional_path() function
in builtin/apply.c; it simply doesn=E2=80=99t handle paths with spaces.

Posix [1] says:

| The name and last modification time of each file shall be output in
| the following format:
|
| "---[space]%s  %s%s%s", file1, <file1 timestamp>, <file1 frac>, <file=
1 zone>
| "+++[space]%s  %s%s%s", file2, <file2 timestamp>, <file2 frac>, <file=
2 zone>
|
| Each <file> field shall be the pathname of the corresponding file
| being compared, or the single character '-' if standard input is
| being compared. However, if the pathname contains a <tab> or a
| <newline>, or if it does not consist entirely of characters taken
| from the portable character set, the behavior is
| implementation-defined.
|
| Each <timestamp> field shall be equivalent to the output from the
| following command:
|
| date '+%Y-%m-%d%H:%M:%S'
|
| without the trailing <newline>
[...]

If this is really describing the format of patches in the wild, that
means we should only look for a tab character to terminate the filename=
=2E
If someone ends up wanting to use a non-git patch to change a file with
a tab in its name, well, we can deal with that then. :)

A big downside: this does not cope with copy-and-pasted patches with
tabs transformed to spaces.  The example [2] consists mostly of
file-creation patches, so we can=E2=80=99t look to the repository for h=
ints.
Maybe the space-plus-date-plus-newline sequence should be used as a
delimiter.

Here=E2=80=99s a rough patch to give an idea of where to start.

[1] http://www.opengroup.org/onlinepubs/9699919799/utilities/diff.html#=
tag_20_34_10_07
[2] https://edge.launchpad.net/ubuntu/+archive/primary/+files/chromium-=
browser_5.0.342.9~r43360-0ubuntu2.diff.gz

-- 8< --
Subject: apply: handle traditional patches with spaces in filename

According to Posix, the --- and +++ lines of a unified diff always
include a tab after the filename.  By not treating a space as a
terminating character, we get support for filenames with spaces
automatically.

Noticed while patching a program with filenames such as
=E2=80=9CLICENSE.Apache (v2.0)=E2=80=9D.

Thanks to Giuseppe Iuculano <iuculano@debian.org> for the report
and Guido G=C3=BCnther <agx@sigxcpu.org> for the analysis.

=46ixes: http://bugs.debian.org/578752
Breaks: copy-and-pasted patches
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/apply.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 771c972..7e1c6b9 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -519,7 +519,7 @@ static int guess_p_value(const char *nameline)
=20
 	if (is_dev_null(nameline))
 		return -1;
-	name =3D find_name(nameline, NULL, 0, TERM_SPACE | TERM_TAB);
+	name =3D find_name(nameline, NULL, 0, TERM_TAB);
 	if (!name)
 		return -1;
 	cp =3D strchr(name, '/');
@@ -638,16 +638,16 @@ static void parse_traditional_patch(const char *f=
irst, const char *second, struc
 	if (is_dev_null(first)) {
 		patch->is_new =3D 1;
 		patch->is_delete =3D 0;
-		name =3D find_name(second, NULL, p_value, TERM_SPACE | TERM_TAB);
+		name =3D find_name(second, NULL, p_value, TERM_TAB);
 		patch->new_name =3D name;
 	} else if (is_dev_null(second)) {
 		patch->is_new =3D 0;
 		patch->is_delete =3D 1;
-		name =3D find_name(first, NULL, p_value, TERM_SPACE | TERM_TAB);
+		name =3D find_name(first, NULL, p_value, TERM_TAB);
 		patch->old_name =3D name;
 	} else {
-		name =3D find_name(first, NULL, p_value, TERM_SPACE | TERM_TAB);
-		name =3D find_name(second, name, p_value, TERM_SPACE | TERM_TAB);
+		name =3D find_name(first, NULL, p_value, TERM_TAB);
+		name =3D find_name(second, name, p_value, TERM_TAB);
 		if (has_epoch_timestamp(first)) {
 			patch->is_new =3D 1;
 			patch->is_delete =3D 0;
--=20
1.7.1.rc2.8.g5f4cb
