From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] archive: abbreviate substituted commit ids again
Date: Tue, 27 Jul 2010 13:32:36 -0500
Message-ID: <20100727183236.GC5578@burratino>
References: <19531.65276.394443.190317@winooski.ccs.neu.edu>
 <20100725130935.GA22083@LK-Perkele-V2.elisa-laajakaista.fi>
 <20100725221539.GA21813@burratino>
 <7vbp9uaii2.fsf@alter.siamese.dyndns.org>
 <20100726190448.GA32367@burratino>
 <7vzkxc7rpn.fsf@alter.siamese.dyndns.org>
 <20100727182942.GB5578@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org,
	Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 20:34:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdoyU-0003CP-8W
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 20:33:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360Ab0G0Sds convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 14:33:48 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63239 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab0G0Sdr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 14:33:47 -0400
Received: by ewy23 with SMTP id 23so1423351ewy.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 11:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=1F4Q1nvneTcRGaB+6WYew7gH1LONfyYCHLAt4jiW3OU=;
        b=rO1+aMdklwIQl4kQulVgzxYrEEQCBNJY8rBudKsBnXpcz2RpwB+JXx3PktiEnZBQcp
         tJFqnlzk9l4OHzXVQegG7hKP98vpU9RrRLzcg//6Z6B4B0rqKPVDp9vZElsZLTjkx1LQ
         j/uaetogULIgiBW3g3kHTfG6wVWrBbVaviFVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=O6GFPx0+jYJM40sB9zvUbY5OmG6qo7XXFgIROYl+uUyvKFnq9i1F4LS1OdZUMv3NFC
         0dhA10NWMNzdo/OO6gaPStz/ADU2FeNu8e/Zjp/+i6syvSfAE5IbCyBHeiCP0CX3OxpW
         kJGSrRYl6FHB1vy244R2SzUt24Ivtu4c85dhk=
Received: by 10.213.16.140 with SMTP id o12mr5140103eba.32.1280255625669;
        Tue, 27 Jul 2010 11:33:45 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id a48sm8013277eei.1.2010.07.27.11.33.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 11:33:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100727182942.GB5578@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151968>

Given a file with:

  (define archive-id "$Format:%ct|%h|a$")

and an export-subst attribute, the "%h" results in an full 40-digit
object name instead of the expected 7-digit one.

The export-subst feature requests unabbreviated object names because
that is the low-level default.  The effect was not observable until
v1.7.1.1~17^2~3 (2010-05-03), which taught log --format=3D%h to respect
the --abbrev option.

Reported-by: Eli Barzilay <eli@barzilay.org>
Tested-by: Eli Barzilay <eli@barzilay.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I carried over the tested-by; I hope that=E2=80=99s okay.  Well, I=E2=80=
=99ve tested
the new patch myself, at least. :)

 archive.c               |    1 +
 t/t5001-archive-attr.sh |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/archive.c b/archive.c
index d700af3..edd6853 100644
--- a/archive.c
+++ b/archive.c
@@ -33,6 +33,7 @@ static void format_subst(const struct commit *commit,
 	struct strbuf fmt =3D STRBUF_INIT;
 	struct pretty_print_context ctx =3D {0};
 	ctx.date_mode =3D DATE_NORMAL;
+	ctx.abbrev =3D DEFAULT_ABBREV;
=20
 	if (src =3D=3D buf->buf)
 		to_free =3D strbuf_detach(buf, NULL);
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 426b319..02d4d22 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -4,7 +4,7 @@ test_description=3D'git archive attribute tests'
=20
 . ./test-lib.sh
=20
-SUBSTFORMAT=3D%H%n
+SUBSTFORMAT=3D'%H (%h)%n'
=20
 test_expect_exists() {
 	test_expect_success " $1 exists" "test -e $1"
--=20
1.7.2.21.g04ff
