From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 4/6] i18n win32: add git-stash eval_gettext variable prefix
Date: Wed, 25 May 2011 23:19:52 +0000
Message-ID: <1306365594-22061-5-git-send-email-avarab@gmail.com>
References: <1306365594-22061-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 01:20:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPNNF-0007w3-3f
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 01:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754488Ab1EYXUI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 19:20:08 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:48174 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab1EYXUH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 19:20:07 -0400
Received: by ewy4 with SMTP id 4so77572ewy.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 16:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=/uE6/fCzdRfbQSyBJvlN7JcvZrE9NU4s4km/nxBLT6c=;
        b=dfjd3FiMI2R8XrMsBqHEeAYK2YsXa02zU8JnGxF8aLZ0KnO0Ic2/oVeEdwC3F1UyjZ
         7AmjZaotAOIhqBrD5JhW5DRzBXeWefO9ufnbQbUrfxylrTjbmdvgu8eYt7A6WVMDpDnS
         r38yP5fhx+dSlyM5D9PWvH4SFDaH10sy9Pjrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=a6/2RUf2PeXQ5LACv+SD6qSkHqiUXAE/0gWvWZxZGFC+2+6Lz7aOVsHMppfeO48nkY
         YbdaOEVNzskDoP24f5VnbcdzYIZw2vN7ZSDpSCaTPOm3T5rOSNkSr6APmsOO1OTsjda9
         O6bFccm7NmsT77UDkvalg/xxr6oACgT3NmczM=
Received: by 10.213.34.11 with SMTP id j11mr1884070ebd.24.1306365605744;
        Wed, 25 May 2011 16:20:05 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b1sm102972eeg.19.2011.05.25.16.20.05
        (version=SSLv3 cipher=OTHER);
        Wed, 25 May 2011 16:20:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306365594-22061-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174475>

Change the eval_gettext() invocations to use the GIT_I18N_VARIABLE_
prefix for variables used in eval_gettext. On Windows environment
variables are case insensitive, so e.g. $PATH clashes with $path. By
using a sufficiently unique prefix we work around that issue.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index c72ba49..e925e27 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -153,6 +153,7 @@ save_stash () {
 			;;
 		-*)
 			option=3D"$1"
+			GIT_I18N_VARIABLE_option=3D$option
 			# TRANSLATORS: $option is an invalid option, like
 			# `--blah-blah'. The 7 spaces at the beginning of the
 			# second line correspond to "error: ". So you should line
@@ -163,8 +164,8 @@ save_stash () {
 			#    $ git stash save --blah-blah 2>&1 | head -n 2
 			#    error: unknown option for 'stash save': --blah-blah
 			#           To provide a message, use git stash save -- '--blah-bla=
h'
-			eval_gettext "$("error: unknown option for 'stash save': \$option
-       To provide a message, use git stash save -- '\$option'")"; echo
+			eval_gettext "$("error: unknown option for 'stash save': \$GIT_I18N=
_VARIABLE_option
+       To provide a message, use git stash save -- '\$GIT_I18N_VARIABL=
E_option'")"; echo
 			usage
 			;;
 		*)
@@ -306,13 +307,14 @@ parse_flags_and_rev()
 			:
 		;;
 		*)
-			die "$(eval_gettext "Too many revisions specified: \$REV")"
+			GIT_I18N_VARIABLE_REV=3D$REV
+			die "$(eval_gettext "Too many revisions specified: \$GIT_I18N_VARIA=
BLE_REV")"
 		;;
 	esac
=20
 	REV=3D$(git rev-parse --quiet --symbolic --verify $1 2>/dev/null) || =
{
-		reference=3D"$1"
-		die "$(eval_gettext "\$reference is not valid reference")"
+		GIT_I18N_VARIABLE_reference=3D"$1"
+		die "$(eval_gettext "\$GIT_I18N_VARIABLE_reference is not valid refe=
rence")"
 	}
=20
 	i_commit=3D$(git rev-parse --quiet --verify $REV^2 2>/dev/null) &&
@@ -336,8 +338,8 @@ is_stash_like()
=20
 assert_stash_like() {
 	is_stash_like "$@" || {
-		args=3D"$*"
-		die "$(eval_gettext "'\$args' is not a stash-like commit")"
+		GIT_I18N_VARIABLE_args=3D"$*"
+		die "$(eval_gettext "'\$GIT_I18N_VARIABLE_args' is not a stash-like =
commit")"
 	}
 }
=20
@@ -347,8 +349,8 @@ is_stash_ref() {
=20
 assert_stash_ref() {
 	is_stash_ref "$@" || {
-		args=3D"$*"
-		die "$(eval_gettext "'\$args' is not a stash reference")"
+		GIT_I18N_VARIABLE_args=3D"$*"
+		die "$(eval_gettext "'\$GIT_I18N_VARIABLE_args' is not a stash refer=
ence")"
 	}
 }
=20
@@ -429,9 +431,11 @@ pop_stash() {
 drop_stash () {
 	assert_stash_ref "$@"
=20
+	GIT_I18N_VARIABLE_REV=3D$REV
+	GIT_I18N_VARIABLE_s=3D$s
 	git reflog delete --updateref --rewrite "${REV}" &&
-		say "$(eval_gettext "Dropped \${REV} (\$s)")" ||
-		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
+		say "$(eval_gettext "Dropped \$GIT_I18N_VARIABLE_REV (\$GIT_I18N_VAR=
IABLE_s)")" ||
+		die "$(eval_gettext "\$GIT_I18N_VARIABLE_REV: Could not drop stash e=
ntry")"
=20
 	# clear_stash if we just dropped the last stash entry
 	git rev-parse --verify "$ref_stash@{0}" > /dev/null 2>&1 || clear_sta=
sh
--=20
1.7.5.1
