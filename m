From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH] completion: fix zsh check under bash with 'set -u'
Date: Wed, 27 Oct 2010 21:08:21 -0400
Message-ID: <1288228101-23000-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 28 03:09:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBGzI-0004W4-6k
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 03:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757946Ab0J1BI7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 21:08:59 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58524 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757806Ab0J1BI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 21:08:58 -0400
Received: by qwf7 with SMTP id 7so596230qwf.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 18:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=/1KHMj8p5PXC6L5i1o5GYtlrc1qhsKL431CIoUvbtOY=;
        b=ckjZuiIA7UjSBLpLUYQm+h9gnXEKRQv5VQ6yar1OxJKA0ZpP9GwHTEei1x1OZYbiza
         68u9JvxRqr+JW01nAmMAAMa34S/QjxHZ8R3/rtWOl3Smzpgl2IKPWPBH66KVBanbtz1U
         RVA2WK0nuPbo7XB0Ose+YACBpJdKKx3PUBMds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=csNBKAfCv8kRT0RKMHVDbz1tLc3l7Tkn8rfSIgEMCcMlPm14N/izJXAbpUf/4kKUOK
         0wet3IdoW9odkWvdGCwifFsbaOFltegtbpYE3L89TRcM07KyTxhLzqzWHVAj/Sy8ITWy
         s+DoTdCFWzvIso+0R9kvAJqbrEx2pleFS7PsA=
Received: by 10.224.207.71 with SMTP id fx7mr3194548qab.309.1288228136999;
        Wed, 27 Oct 2010 18:08:56 -0700 (PDT)
Received: from localhost.localdomain (c-69-137-229-191.hsd1.dc.comcast.net [69.137.229.191])
        by mx.google.com with ESMTPS id mz11sm414074qcb.15.2010.10.27.18.08.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 18:08:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160146>

Commit 06f44c3 (completion: make compatible with zsh) broke bash
compatibility with 'set -u': a warning was generated when checking
$ZSH_VERSION.  The solution is to supply a default value, using
${ZSH_VERSION-}.  Thanks to SZEDER G=C3=A1bor for the fix.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 contrib/completion/git-completion.bash |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 64341d5..168669b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2345,7 +2345,7 @@ _git ()
 {
 	local i c=3D1 command __git_dir
=20
-	if [[ -n $ZSH_VERSION ]]; then
+	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
 	fi
@@ -2394,7 +2394,7 @@ _git ()
=20
 _gitk ()
 {
-	if [[ -n $ZSH_VERSION ]]; then
+	if [[ -n ${ZSH_VERSION-} ]]; then
 		emulate -L bash
 		setopt KSH_TYPESET
 	fi
@@ -2434,7 +2434,7 @@ complete -o bashdefault -o default -o nospace -F =
_git git.exe 2>/dev/null \
 	|| complete -o default -o nospace -F _git git.exe
 fi
=20
-if [[ -n $ZSH_VERSION ]]; then
+if [[ -n ${ZSH_VERSION-} ]]; then
 	shopt () {
 		local option
 		if [ $# -ne 2 ]; then
--=20
1.7.3.2
