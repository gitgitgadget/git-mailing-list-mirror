From: cheng renquan <crquan@gmail.com>
Subject: [PATCH] git fetch one tag only
Date: Wed, 6 Jun 2012 18:40:45 -0700
Message-ID: <CAH5vBdK_M+7Hjk=juVeP7Phqvs2+npknFD-=45OVR032k5S-0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 03:40:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScRiV-0001MK-6i
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 03:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759400Ab2FGBks convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jun 2012 21:40:48 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36060 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757765Ab2FGBkq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jun 2012 21:40:46 -0400
Received: by wgbdr13 with SMTP id dr13so79499wgb.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 18:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=urdgHO6hCuNQ/9x9wjxt9bKo7Mj8KmcMEoyhbUbCcvY=;
        b=S/C8kXPAbHvqD0Bs2NiV0rjlC7V/zlSjUT1XmXx5hBJdOLP+lvUXMIgqCtNwDS6dUa
         4t/EPz1nDkOoTVsMePd/BEOu42ENKDPEcrij7LGjo7iI4f3u7xCKhYF18PrfHC+zYQOY
         i3frFDqdmafwIpoxGorBfKirVOlNDbygDNTomdFZQc+8fpip5oHCJ4J7eQYhIM7BS7Ji
         mbpseXScuQJkG6ikdt6iOEl9YRDK+2deGfvFZdnXTZI37np4D0xjbwFrZ1W/2E0f3YOe
         Rco3ErmrywavH/X4q+byfotCjPm9ONSpVPtzF07fYDqfeTA2gw6vM9nU+E867Mev6hTL
         ad/g==
Received: by 10.216.142.167 with SMTP id i39mr270980wej.94.1339033245131; Wed,
 06 Jun 2012 18:40:45 -0700 (PDT)
Received: by 10.216.136.80 with HTTP; Wed, 6 Jun 2012 18:40:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199364>

Someone maybe like me is working in the way of following one central
git repository
while sometimes need to fetch some code or tags from a 3rd git repo,
but unfortunately the 3rd repo may contain a lot of tags not all I want
to fetch to mess up my local repo, at this time I want to fetch only on=
e tag
from the 3rd repo, but the syntax of
  `git fetch 3rd-repo the-tag-name`

really fetched the code of the-tag-name from 3rd-repo, but forgot the
tag itself;
this patch enhanced the above syntax to create the tag itself;


 builtin/fetch.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bb9a074..9a3ec4a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -439,6 +439,14 @@ static int store_updated_refs(const char
*raw_url, const char *remote_name,
 			else if (!prefixcmp(rm->name, "refs/tags/")) {
 				kind =3D "tag";
 				what =3D rm->name + 10;
+				if (!ref) {
+					unsigned char sha1[20];
+					ref =3D alloc_ref(rm->name);
+					hashcpy(ref->new_sha1, rm->old_sha1);
+					if (!get_sha1(rm->name, sha1))
+						hashcpy(ref->old_sha1, sha1);
+				}
 			}
 			else if (!prefixcmp(rm->name, "refs/remotes/")) {
 				kind =3D "remote-tracking branch";

--=20
cheng renquan (=E7=A8=8B=E4=BB=BB=E5=85=A8)
