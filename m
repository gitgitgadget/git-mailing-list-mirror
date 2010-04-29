From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git cherry(pick) dumps core
Date: Thu, 29 Apr 2010 14:49:36 -0500
Message-ID: <20100429194936.GA31941@progeny.tock>
References: <s2m76c5b8581004281238jf7179fffna7d757fee6ab4f10@mail.gmail.com>
 <r2s302ed1461004281249xd1b65e41l43fa7b639db7c97d@mail.gmail.com>
 <h2v76c5b8581004281259yfaca7abfz5a455ff8fd6cdc6b@mail.gmail.com>
 <o2j2cfc40321004281539j28fe44e0r5d029061e3e08b90@mail.gmail.com>
 <20100428233758.GA1654@progeny.tock>
 <20100429191150.GA10526@inner.home.ulmdo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 30 19:03:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7tcn-0004GS-17
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 19:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758212Ab0D3Q7w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Apr 2010 12:59:52 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:43416 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757740Ab0D3Q7q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 12:59:46 -0400
Received: by bwz19 with SMTP id 19so260149bwz.21
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 09:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=St0DSs3RSpM9Yq+cRAwDlbd2HZl8a9bwjUKoHM5vmj0=;
        b=IDowYwDI8W7qpKMFC4QtssAdaJriQtQXGUFjmDmQfwGFKmPDn3hIPj0C2iA6ixB5cQ
         9M7k16C3xjiAc2b40U27Q5oXjAFs+TWxQe+5ZLEGyo2tw+Iug8ETuf2sYGdTC9Yu9/YS
         WF0QCv+rzpzvXVP3BVHDKMtvhWiHm6A/oZga4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Ndna0dLBQrOoBUmL+RcWnAjIQyyd5e/9+OMSPwIpdJPvrCUjhT8vWQUBhCqa/fSwsZ
         HwOMjII1WNl2GpgN3E2NI9Qkt0UzqbVT2JUExlMWcmMe6dfpgYG8BQQy8qpCR13FQVyI
         tuMplsiPfGuLrrWnwK7p9XYqdoWsKjjo82wQY=
Received: by 10.204.132.131 with SMTP id b3mr6056237bkt.179.1272570577072;
        Thu, 29 Apr 2010 12:49:37 -0700 (PDT)
Received: from progeny.tock (c-76-28-252-211.hsd1.wa.comcast.net [76.28.252.211])
        by mx.google.com with ESMTPS id l1sm203400bkl.2.2010.04.29.12.49.32
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 Apr 2010 12:49:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100429191150.GA10526@inner.home.ulmdo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146032>

Hi Andreas,

Andreas Krey wrote:

> I just have a case of git cherry-pick dieing with a core dump.
> The directly offending lines are get_message() in buildin/revert.c:
>=20
> 	if ((out->reencoded_message =3D reencode_string(raw_message,
> 					git_commit_encoding, encoding)))
> 		out->message =3D out->reencoded_message;
>=20
> 	abbrev =3D find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
> 	abbrev_len =3D strlen(abbrev);
>=20
> 	/* Find beginning and end of commit subject. */
> 	p =3D out->message;
> 	while (*p && (*p !=3D '\n' || p[1] !=3D '\n'))
>=20
> and out->message is null at that point.
>=20
> It looks like reencode_string is returning NULL,
> and get_message can't quite cope with that.

Thanks for the report.  What encoding were you using?  (You can check
with =E2=80=98git cat-file commit <revision you were trying to cherry-p=
ick>=E2=80=99.)

The code you mention was just wrong, sorry.  If the local iconv
doesn=E2=80=99t understand some recording, the correct behavior is to p=
ass the
message through, not to segfault.

With this change, cherry-pick would treat the old message as UTF-8
(or whatever the current [i18n] commitencoding setting specifies,
if present).  If the message happens to contain an illegal byte
sequence, the cherry-pick will not segfault but it will still fail.

In other words, this patch should fix the segfault, but it does not
fix the underlying problem which was there before.

diff --git a/builtin/revert.c b/builtin/revert.c
index bbaa937..9f8ceab 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -114,6 +114,8 @@ static int get_message(const char *raw_message, str=
uct commit_message *out)
 	if ((out->reencoded_message =3D reencode_string(raw_message,
 					git_commit_encoding, encoding)))
 		out->message =3D out->reencoded_message;
+	else
+		out->message =3D raw_message;
=20
 	abbrev =3D find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
 	abbrev_len =3D strlen(abbrev);
