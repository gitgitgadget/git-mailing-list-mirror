From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Name make_*_path functions more accurately
Date: Fri, 18 Mar 2011 00:25:50 -0700
Message-ID: <7vipvgyjnl.fsf@alter.siamese.dyndns.org>
References: <1300361206-6982-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Mar 18 08:26:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0U4b-0007jO-6Z
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 08:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756379Ab1CRH0I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 03:26:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756305Ab1CRH0F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 03:26:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0A1A02490;
	Fri, 18 Mar 2011 03:27:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=goh5Ae+VwyDCTxZvAtA3GSpkT
	C8=; b=xflFVVq2g6TRB7DxPjQC25DSpTzTXrLMBtE2m6cPP52XleASgIEcgGT5p
	H3ruDQQ/BJd1KpvR26tWUqeNhoex6Effm3mMP03rGNh/PI1MZPHv19dFKlk/hHEh
	ezoBMJo3jm7CCS0kqICSc8zKwkUf7mubigsy+Q3MtiM9nq89Rk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=vN9zsfAcSy8EE5v9hi4
	rl87qdXG/eF3WjgUdvLhl7z6047YGUbhCPJXTKzWov6E4txqiF89VSNG0+UkoLNU
	U/9RyeJRGH3OmKeyxNsoCv7HIOuA+t7Vq8shgbdkWgE2nrAfK0l02iZ2o9vSMMLn
	oqFhknl3VkJbIZjnVsxAoVn0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AC908248F;
	Fri, 18 Mar 2011 03:27:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F26A02485; Fri, 18 Mar 2011
 03:27:25 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 304565C0-5131-11E0-873C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169298>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> Rename the make_*_path functions so it's clearer what they do, in
> particlar make clear what the differnce between make_absolute_path an=
d
> make_nonrelative_path is by renaming them real_path and absolute_path
> respectively. make_relative_path has an understandable name and is
> renamed to relative_path to maintain the name convention.

The approach taken by this patch is a sound one, and I like it.  The
change does not reuse any existing name for different purpose, which me=
ans
there is little chance of this change interacting other topics that may=
 be
in flight that introduce new call sites to these renamed functions in a
funny way.  A (semantic) mismerge or misapplication of the patch will b=
e
found by the compiler.

=46or example, the version of setup.c this patch is based on the versio=
n
before 05f08e4 (Merge branch 'cb/setup', 2011-02-09) was merged, and th=
e
merge introduced a new call site to make_absolute_path().  A few callsi=
tes
to make_nonrelative_path() in wrapper.c were introduced at 70ec868 (Mer=
ge
branch 'ae/better-template-failure-report', 2011-02-09), and this patch
does not touch them.

As the result, the patch cleanly applies textually, but the resulting c=
ode
does not compile, and it is a good thing ;-).


Here is a minor fix-up necessary when queuing this on top of master

 setup.c   |    2 +-
 wrapper.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index eae853a..03cd84f 100644
--- a/setup.c
+++ b/setup.c
@@ -9,7 +9,7 @@ char *prefix_path(const char *prefix, int len, const ch=
ar *path)
 	const char *orig =3D path;
 	char *sanitized;
 	if (is_absolute_path(orig)) {
-		const char *temp =3D make_absolute_path(path);
+		const char *temp =3D real_path(path);
 		sanitized =3D xmalloc(len + strlen(temp) + 1);
 		strcpy(sanitized, temp);
 	} else {
diff --git a/wrapper.c b/wrapper.c
index 4c147d6..2829000 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -209,7 +209,7 @@ int xmkstemp(char *template)
 		if (!template[0])
 			template =3D origtemplate;
=20
-		nonrelative_template =3D make_nonrelative_path(template);
+		nonrelative_template =3D absolute_path(template);
 		errno =3D saved_errno;
 		die_errno("Unable to create temporary file '%s'",
 			nonrelative_template);
@@ -344,7 +344,7 @@ int xmkstemp_mode(char *template, int mode)
 		if (!template[0])
 			template =3D origtemplate;
=20
-		nonrelative_template =3D make_nonrelative_path(template);
+		nonrelative_template =3D absolute_path(template);
 		errno =3D saved_errno;
 		die_errno("Unable to create temporary file '%s'",
 			nonrelative_template);
