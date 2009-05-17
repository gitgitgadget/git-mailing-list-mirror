From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] test: checkout shouldn't say that HEAD has moved if it didn't
Date: Sun, 17 May 2009 11:43:08 +0900
Message-ID: <20090517114308.6117@nanako3.lavabit.com>
References: <20090516192531.6117@nanako3.lavabit.com>
 <20090516175444.GA1000@cumin.applehq.eu>
 <7vr5yolt1j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Cordero <theappleman@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 17 04:46:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5WOJ-0006Bz-Gd
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 04:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbZEQCn2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 May 2009 22:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbZEQCn2
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 22:43:28 -0400
Received: from karen.lavabit.com ([72.249.41.33]:35376 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbZEQCn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 22:43:27 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 1E58E11B7F4;
	Sat, 16 May 2009 21:43:28 -0500 (CDT)
Received: from 8076.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id FX0N5ADLMSVA; Sat, 16 May 2009 21:43:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=liMYSGgM409lVp2n+uol+dAAj4Fy0p4enaSLytgoS4ff5QOXw1Y8tdoSFUaQSpDlomewwPdQ59unwlRoZrKLWzWp4Ih6v9ijvQvhqEVqxsnuBy2Tgx/2s667OZFDAUfWXzwKTLbY1iPk8WV1w/2qAOAmuJMaUJu8EMOvdPct+tQ=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vr5yolt1j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119383>

Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=
=81=93 <nanako3@lavabit.com>
---

Quoting Junio C Hamano <gitster@pobox.com>:

> Daniel Cordero <theappleman@gmail.com> writes:
>
>> Previously, checkout would tell the user this message before moving =
HEAD,
>> without regard to whether the upcoming move will result in success.
>> If the move failed, this causes confusion.
>>
>> Show the message after the move, unless the move failed.
>>
>> Signed-off-by: Daniel Cordero <theappleman@gmail.com>
>
> Thanks; the patch looks obviously good.  Can we have tests?

Here is one.

 t/t7201-co.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index bdb808a..ebfd34d 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -534,4 +534,12 @@ test_expect_success 'failing checkout -b should no=
t break working tree' '
=20
 '
=20
+test_expect_success 'switch out of non-branch' '
+	git reset --hard master &&
+	git checkout master^0 &&
+	echo modified >one &&
+	test_must_fail git checkout renamer 2>error.log &&
+	! grep "^Previous HEAD" error.log
+'
+
 test_done

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
