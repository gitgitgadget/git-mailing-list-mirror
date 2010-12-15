From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] get_sha1: handle special case $commit^{/}
Date: Wed, 15 Dec 2010 16:02:54 +0700
Message-ID: <1292403774-361-1-git-send-email-pclouds@gmail.com>
References: <AANLkTimy5MVkxDzXqzA8T4DHJmzsSAvwqVVzRvWw5KA0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 10:04:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSnHT-0000qb-LV
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 10:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578Ab0LOJEI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 04:04:08 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43168 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289Ab0LOJED (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Dec 2010 04:04:03 -0500
Received: by iwn9 with SMTP id 9so1803724iwn.19
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 01:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=BJRpMxVoZ8xQtqg/JlrsfJyF3tfDAJ3sSn9YEn6gPks=;
        b=W50O8M9W1v83NI3h31zr/kzvUUp4/NOF81uH8RfkX7On8id9Qx8/8YaLy9Vh0Vajch
         mNrA391g5anmsXr/1aAd98U+H0N3FO3tBFXhPS4SJDYLoPUX+1jXcmw31HL9OAoLD6FC
         DAmRh6Uhfzq7YBn9fKBxV6oMBycUi1iQYJBgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sHePbxSmJpkW8YpiRmWl+LuRQSGjTWGpsGlGKNJxmaOMRqYR3UGb3ADYomms1jiPoY
         kFPyY7+vzK6FwnFpTVOnm4oo4AWFzUy1RR7kd6DF6LRacj3R8AtNYUmiYrIyXfSb3MAb
         Ie7HVVuP5GvyondtJXYjHQxCYYsgd5DagUo7g=
Received: by 10.231.173.138 with SMTP id p10mr4579061ibz.48.1292403842888;
        Wed, 15 Dec 2010 01:04:02 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.209.213])
        by mx.google.com with ESMTPS id 34sm786353ibi.2.2010.12.15.01.03.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Dec 2010 01:04:02 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 15 Dec 2010 16:02:56 +0700
X-Mailer: git-send-email 1.7.3.3.476.g10a82
In-Reply-To: <AANLkTimy5MVkxDzXqzA8T4DHJmzsSAvwqVVzRvWw5KA0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163745>

Empty regex pattern should always match. But the exact behavior of
regexec() may vary. Because it always matches anyway, we can just
return 'matched' without calling regex machinery.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On top of nd/oneline-sha1-name-from-specific-ref

 sha1_name.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 1ba4bc3..c5c59ce 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -599,6 +599,13 @@ static int peel_onion(const char *name, int len, u=
nsigned char *sha1)
 		int ret;
 		struct commit_list *list =3D NULL;
=20
+		/*
+		 * $commit^{/}. Some regex implementation may reject.
+		 * We don't need regex anyway. '' pattern always matches.
+		 */
+		if (sp[1] =3D=3D '}')
+			return 0;
+
 		prefix =3D xstrndup(sp + 1, name + len - 1 - (sp + 1));
 		commit_list_insert((struct commit *)o, &list);
 		ret =3D get_sha1_oneline(prefix, sha1, list);
--=20
1.7.3.3.476.g10a82
