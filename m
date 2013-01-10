From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] t0008: avoid brace expansion
Date: Thu, 10 Jan 2013 22:24:52 +0100
Message-ID: <50EF31A4.3000205@lsrfire.ath.cx>
References: <50EC8025.8000707@lsrfire.ath.cx> <7vr4lvcstt.fsf@alter.siamese.dyndns.org> <50EC8BE7.2010508@lsrfire.ath.cx> <7vboczcq5a.fsf@alter.siamese.dyndns.org> <50EE01F8.1070109@lsrfire.ath.cx> <CAOkDyE_EuuV04KxkkLuHMV+VbDWsDMN1q3YShLtKaimaXH40Sg@mail.gmail.com> <7vsj693n6o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Adam Spiers <git@adamspiers.org>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:25:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtPcn-0001Ui-95
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 22:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972Ab3AJVY7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jan 2013 16:24:59 -0500
Received: from india601.server4you.de ([85.25.151.105]:37363 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050Ab3AJVY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 16:24:58 -0500
Received: from [192.168.2.105] (p4FFD8614.dip.t-dialin.net [79.253.134.20])
	by india601.server4you.de (Postfix) with ESMTPSA id 45152105;
	Thu, 10 Jan 2013 22:24:57 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7vsj693n6o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213152>

Am 10.01.2013 01:18, schrieb Junio C Hamano:
> Adam Spiers <git@adamspiers.org> writes:
>=20
>> On Wed, Jan 9, 2013 at 11:49 PM, Ren=C3=A9 Scharfe
>> <rene.scharfe@lsrfire.ath.cx> wrote:
>>> Brace expansion is not required by POSIX and not supported by dash =
nor
>>> NetBSD's sh.  Explicitly list all combinations instead.
>>
>> Good catch, thanks!
>=20
> Yeah; thanks.
>=20
> It would also be nice to avoid touch while we are at it, by the way.

Good idea!  Replacement patch:

--- >8 ---
Brace expansion is a shell feature that's not required by POSIX and not
supported by dash nor NetBSD's sh.  Explicitly list all combinations
instead.  Also avoid calling touch by creating the test files with a
redirection instead, as suggested by Junio.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t0008-ignores.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 9b0fcd6..d7df719 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -129,8 +129,13 @@ test_expect_success 'setup' '
 		one
 		ignored-*
 	EOF
-	touch {,a/}{not-ignored,ignored-{and-untracked,but-in-index}} &&
-	git add -f {,a/}ignored-but-in-index
+	for dir in . a
+	do
+		: >$dir/not-ignored &&
+		: >$dir/ignored-and-untracked &&
+		: >$dir/ignored-but-in-index
+	done &&
+	git add -f ignored-but-in-index a/ignored-but-in-index &&
 	cat <<-\EOF >a/.gitignore &&
 		two*
 		*three
--=20
1.8.0
