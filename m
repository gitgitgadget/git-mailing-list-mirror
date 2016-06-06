From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
Subject: [PATCH 1/2] git-prompt.sh: Don't error on null ${ZSH,BASH}_VERSION, $short_sha
Date: Mon,  6 Jun 2016 19:29:33 +0300
Message-ID: <1465230573-18357-1-git-send-email-ville.skytta@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 18:29:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9xPK-0007ZD-1M
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 18:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbcFFQ3i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 12:29:38 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32936 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbcFFQ3h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 12:29:37 -0400
Received: by mail-lf0-f68.google.com with SMTP id w16so13959080lfd.0
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 09:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FhgVKxhGzax/hlz4wQBdXe8sjJV7M9tDn7l8Il0zqn8=;
        b=jAcsXlkwyM+Ev69cMhRw9UtlcEzNTU7pkb8N4MhlwvCik8mZpOws0eQnw+bs6ymQxC
         1rVpr45BpTe2DOX+ekVvSyOASsJspwtIQnplsdMD+Sn7N3R/yIcUXTTVoEc1IezH+vxg
         3nNKD2ZTAbxHtxrK6IvQaPVpZcU/xKCMockGjnErGPyBQuBKAAXLgGFme/R0V7eoWs97
         sQ8hgdX1NSXOHt/Y0NIOfA5HoNjoUcgAGRmKnLmFKts7Q3C41DikdAuhJJnA0gYSK0/T
         pzXQCzM57nocP/lPv1kyYC5QH5r7FYxXPknPFcQwszx8u3vYFOjmDVC0D2Y4X74bz/G4
         A3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FhgVKxhGzax/hlz4wQBdXe8sjJV7M9tDn7l8Il0zqn8=;
        b=JAyUTKYxDznm6l5XNW2XlSyMlzg+jTEtn0+JW19O6EsaTMFS++VZQHWtNqmwNmi+EK
         6IwG5XmCvpD0YElgW+q+OxQpuSjE7EREsU3fEjSjh8HDUOWEttV1wV4Ksj8Brv49Q2yU
         S72GpuhUhMou7zr2KdB5rMNxxPbRi6SdYBXl8mdaiHtgArBk73guSt61q3gce80qV/DU
         mijsPWTkHyJgL+e7oVHI4WzWf0rez/vsySPtdEBfqgKYw+chN55B3803aDaSlGo/LHJL
         3t/KaWr7ZbNgTkeEN7iYYfNQ9R1KoqTpQizSnu0C1j8wd9LLt3BdD0j0u1MrGbrs1og9
         W11w==
X-Gm-Message-State: ALyK8tKGOejqBFvb+D2KXZ1mtC9hruwilja+aUcoMOBFvvmF7pcnyRptK+Ed9D2UC8HvDA==
X-Received: by 10.46.71.132 with SMTP id u126mr4655894lja.14.1465230575142;
        Mon, 06 Jun 2016 09:29:35 -0700 (PDT)
Received: from viper.dy.fi (dtpyyyyyyyyyyyyyb0xvy-3.rev.dnainternet.fi. [2001:14ba:8300::1:f4e2])
        by smtp.gmail.com with ESMTPSA id a7sm1129411lbs.36.2016.06.06.09.29.34
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2016 09:29:34 -0700 (PDT)
X-Mailer: git-send-email 2.5.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296528>

When the shell is in "nounset" or "set -u" mode, referencing unset or
null variables results in an error. Protect $ZSH_VERSION and
$BASH_VERSION against that, and initialize $short_sha before use.

Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
---
 contrib/completion/git-prompt.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-=
prompt.sh
index 64219e6..97eacd7 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -355,8 +355,8 @@ __git_ps1 ()
 	# incorrect.)
 	#
 	local ps1_expanded=3Dyes
-	[ -z "$ZSH_VERSION" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=3Dno
-	[ -z "$BASH_VERSION" ] || shopt -q promptvars || ps1_expanded=3Dno
+	[ -z "${ZSH_VERSION-}" ] || [[ -o PROMPT_SUBST ]] || ps1_expanded=3Dn=
o
+	[ -z "${BASH_VERSION-}" ] || shopt -q promptvars || ps1_expanded=3Dno
=20
 	local repo_info rev_parse_exit_code
 	repo_info=3D"$(git rev-parse --git-dir --is-inside-git-dir \
@@ -368,7 +368,7 @@ __git_ps1 ()
 		return $exit
 	fi
=20
-	local short_sha
+	local short_sha=3D""
 	if [ "$rev_parse_exit_code" =3D "0" ]; then
 		short_sha=3D"${repo_info##*$'\n'}"
 		repo_info=3D"${repo_info%$'\n'*}"
--=20
2.5.5
