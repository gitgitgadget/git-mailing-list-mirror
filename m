From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [[PATCH v3] 1/2] [submodule] handle multibyte characters in name
Date: Fri, 14 Jun 2013 10:23:52 -0700
Message-ID: <7va9msppw7.fsf@alter.siamese.dyndns.org>
References: <1371225365-4219-1-git-send-email-iveqy@iveqy.com>
	<1371225365-4219-2-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jens.lehmann@web.de
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 19:24:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnXjJ-0003uj-3U
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 19:24:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840Ab3FNRX6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 13:23:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36735 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985Ab3FNRX4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jun 2013 13:23:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46FEB27085;
	Fri, 14 Jun 2013 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=g2T9IYKW9EDS
	tlJn498EWmm1WR4=; b=e1asM5bw44jmNVU17iBkCZnU8oOGGQQgGfAZUbhQkai2
	fpd98LXzqqFODlYF54BWhkQ8wuqh+USSHSUs3RKkFi9/+3qpEEjfY24xAZNxKLFY
	Bbf39A+SogX2PsxmVSUB33Hqu9Qr3pT/Two5Snqj3IHH2SkYxQ2/nraPh4m1k9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QL2G6D
	aT7B6Pnn50YVb/O6zETYcZP1ZUBw4pA0tpzA2IPWWdnFvcyg55J1QzW7URnF5yzb
	OaD5D48xhas7jb3EHyWEYgVsKFcndZ9J1ne+bswXt+nhQUPtuMTp7cA5ndQ0Gs9h
	7agppb1Gw+Vs4x/Nbw9nb7BAvfdGWY4FVMIic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1336727082;
	Fri, 14 Jun 2013 17:23:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 499F22707D;
	Fri, 14 Jun 2013 17:23:54 +0000 (UTC)
In-Reply-To: <1371225365-4219-2-git-send-email-iveqy@iveqy.com> (Fredrik
	Gustafsson's message of "Fri, 14 Jun 2013 17:56:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30235D74-D517-11E2-9015-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227901>

=46redrik Gustafsson <iveqy@iveqy.com> writes:

> ... The
> correct approach to solve the problem for all pathnames may be to use
> "ls-files -z" and tell the Perl script that reads its output to read =
NUL
> separated records by using $/ =3D "\0".

I've tentatively queued the attached without 2/2; the scriptlet is
small enough not to matter in an eventual rewrite, so it shouldn't
make a difference either way.

-- >8 --
=46rom: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH] handle multibyte characters in name

Many "git submodule" operations do not work on a submodule at a path wh=
ose
name is not in ASCII.

This is because "git ls-files" is used to find which paths are bound to
submodules to the current working tree, and the output is C-quoted by d=
efault
for non ASCII pathnames.

Tell "git ls-files" to not C-quote its output, which is easier than unw=
rapping
C-quote ourselves.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-submodule.sh           |  3 ++-
 t/t7400-submodule-basic.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..48bdf84 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -113,7 +113,7 @@ resolve_relative_url ()
 module_list()
 {
 	(
-		git ls-files --error-unmatch --stage -- "$@" ||
+		git ls-files -z --error-unmatch --stage -- "$@" ||
 		echo "unmatched pathspec exists"
 	) |
 	perl -e '
@@ -121,6 +121,7 @@ module_list()
 	my ($null_sha1) =3D ("0" x 40);
 	my @out =3D ();
 	my $unmatched =3D 0;
+	$/ =3D "\0";
 	while (<STDIN>) {
 		if (/^unmatched pathspec/) {
 			$unmatched =3D 1;
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index ff26535..d5743ee 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -868,4 +868,16 @@ test_expect_success 'submodule deinit fails when s=
ubmodule has a .git directory
 	test -n "$(git config --get-regexp "submodule\.example\.")"
 '
=20
+test_expect_success 'submodule with strange name works "=C3=A5 =C3=A4=C3=
=B6"' '
+	mkdir "=C3=A5 =C3=A4=C3=B6" &&
+	(
+		cd "=C3=A5 =C3=A4=C3=B6" &&
+		git init &&
+		touch sub
+		git add sub
+		git commit -m "init sub"
+	)
+	git submodule add "/=C3=A5 =C3=A4=C3=B6" &&
+	test -n "$(git submodule | grep "=C3=A5 =C3=A4=C3=B6")"
+'
 test_done
--=20
1.8.3.1-538-gb4d04a7
