From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use "" instead of "<unknown>" for placeholders
Date: Fri, 21 Sep 2007 13:12:21 -0700
Message-ID: <7vk5qjixqy.fsf@gitster.siamese.dyndns.org>
References: <20070921101420.GD22869@mageo.cz>
	<Pine.LNX.4.64.0709211146090.28395@racer.site>
	<20070921110646.GA9072@mageo.cz>
	<Pine.LNX.4.64.0709211207070.28395@racer.site>
	<20070921140500.GB9072@mageo.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michal Vitecek <fuf@mageo.cz>
X-From: git-owner@vger.kernel.org Fri Sep 21 22:13:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYorv-0000L2-9L
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 22:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761874AbXIUUM3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Sep 2007 16:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761735AbXIUUM3
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 16:12:29 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:40631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761314AbXIUUM2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Sep 2007 16:12:28 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3EA6F1392A6;
	Fri, 21 Sep 2007 16:12:45 -0400 (EDT)
In-Reply-To: <20070921140500.GB9072@mageo.cz> (Michal Vitecek's message of
	"Fri, 21 Sep 2007 16:05:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58873>

Michal Vitecek <fuf@mageo.cz> writes:

[jc: Added Dscho back on CC: list]

>>> >> I made it because I want to use my own pretty format which curre=
ntly=20
>>> >> only allows '%s' for subject and '%b' for body. But '%b' is=20
>>> >> substituted with <undefined> if the body is "missing" which I=20
>>> >> obviously don't like :)
>>> >
>>> >Then you should fix %b not to show "<undefined>".
>>>=20
>>>  I'll do it if it is okay. Shall I do the same for the other
>>>  placeholders as well?
>>
>>Yeah.  Don't know why I did it that way.
>
>  Here comes the big patch :)

Now, this breaks t6006 which needs this patch.

Looking at this patch, I am not sure if your change is really a
desirable one --- shouldn't it be removing the line itself, not
just <unknown> token?

---
 t/t6006-rev-list-format.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index ad6d0b8..2be323c 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -79,9 +79,9 @@ EOF
=20
 test_format encoding %e <<'EOF'
 commit 131a310eb913d107dd3c09a65d1651175898735d
-<unknown>
+
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-<unknown>
+
 EOF
=20
 test_format subject %s <<'EOF'
@@ -93,9 +93,9 @@ EOF
=20
 test_format body %b <<'EOF'
 commit 131a310eb913d107dd3c09a65d1651175898735d
-<unknown>
+
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-<unknown>
+
 EOF
=20
 test_format colors %Credfoo%Cgreenbar%Cbluebaz%Cresetxyzzy <<'EOF'
@@ -121,9 +121,9 @@ test_format complex-encoding %e <<'EOF'
 commit f58db70b055c5718631e5c61528b28b12090cdea
 iso8859-1
 commit 131a310eb913d107dd3c09a65d1651175898735d
-<unknown>
+
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-<unknown>
+
 EOF
=20
 test_format complex-subject %s <<'EOF'
@@ -142,9 +142,9 @@ and it will be encoded in iso8859-1. We should ther=
efore
 include an iso8859 character: =E8=87=93bueno!
=20
 commit 131a310eb913d107dd3c09a65d1651175898735d
-<unknown>
+
 commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
-<unknown>
+
 EOF
=20
 test_done
