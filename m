From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH v2] t6030 (bisect): work around Mac OS X "ls"
Date: Thu, 24 Jul 2008 02:43:51 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807240233310.27074@harper.uchicago.edu>
References: <Pine.GSO.4.62.0807232014030.14945@harper.uchicago.edu>
 <200807240757.26290.chriscool@tuxfamily.org> <20080724060647.GA24587@glandium.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-1216885431=:27074"
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 09:45:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLvVs-0004dA-N2
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 09:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbYGXHoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 03:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbYGXHoX
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 03:44:23 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:39862 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbYGXHoX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 03:44:23 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6O7hpe8027931;
	Thu, 24 Jul 2008 02:43:51 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m6O7hpOB027258;
	Thu, 24 Jul 2008 02:43:51 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <20080724060647.GA24587@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89845>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-851401618-1216885431=:27074
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

t6030-bisect-porcelain.sh relies on "ls" exiting with nonzero
status when asked to list nonexistent files.  Unfortunately,
/bin/ls on Mac OS X 10.3 exits with exit code 0.  So look at
its output instead.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---

Mike Hommey wrote:

> On Thu, Jul 24, 2008 at 07:57:26AM +0200, Christian Couder wrote:
>> Le jeudi 24 juillet 2008, Jonathan Nieder a =E9crit :
>>> -=09test_must_fail ls .git/BISECT_* &&
>>> +=09echo .git/BISECT_* | test_must_fail grep BISECT_[^*] &&
>>=20
>> Perhaps the following is simpler:
>>=20
>> +=09test -z "$(ls .git/BISECT_*)" &&
>=20
> That is still a useless use of ls ;)

It is much better than what I wrote, at least.

Good night (well, good morning I guess), and thanks.

 t/t6030-bisect-porcelain.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 0626544..244fda6 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -76,7 +76,7 @@ test_expect_success 'bisect fails if given any junk inste=
ad of revs' '
 =09test_must_fail git bisect start foo $HASH1 -- &&
 =09test_must_fail git bisect start $HASH4 $HASH1 bar -- &&
 =09test -z "$(git for-each-ref "refs/bisect/*")" &&
-=09test_must_fail ls .git/BISECT_* &&
+=09test -z "$(ls .git/BISECT_* 2>/dev/null)" &&
 =09git bisect start &&
 =09test_must_fail git bisect good foo $HASH1 &&
 =09test_must_fail git bisect good $HASH1 bar &&
--=20
1.5.6.3.549.g8ca11

---559023410-851401618-1216885431=:27074--
