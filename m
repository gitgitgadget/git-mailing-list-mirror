From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 6/6] i18n win32: add test eval_gettext variable prefix
Date: Wed, 25 May 2011 23:19:54 +0000
Message-ID: <1306365594-22061-7-git-send-email-avarab@gmail.com>
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
X-From: git-owner@vger.kernel.org Thu May 26 01:20:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPNNN-00080b-60
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 01:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755237Ab1EYXUX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 19:20:23 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:65287 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351Ab1EYXUI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 19:20:08 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so77568ewy.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 16:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=IIsICCw0YloiL6BLximqc5lY5swV5dOfKHncN9u6axY=;
        b=lJXYaqcP3ReymVlGMo+aBbM1tXmSY8hDmJDfZ/J+lrhjYa1sc7u2+0a+XTLJSilIqM
         Qw+28jCvJlUc+uScIEo0isBtEyBxBtU3bu4Nhqoy3xVo2tqxN7ZYcY1PBaFCxomSkg/q
         LRMvyX4Hj5u5C0xkfWH/3uc/DYqvRvfww0RiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kSNiLCHpoPOQ2obOnvEcISIAaebcu0uKrGLGmkbE5nlU/gv6hKFFv1vQd70eB4IwDK
         ciPIeDOyWkOlPgrVn++dVT+l7xiwAtE+zbtaqckD1EKTOJkTBf4GSEYugtIBgb4F3t6Y
         rvpZymfgC9VscSt1Tg+v2f+ctzGz36fG65gtM=
Received: by 10.213.106.193 with SMTP id y1mr1841079ebo.22.1306365607465;
        Wed, 25 May 2011 16:20:07 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b1sm102972eeg.19.2011.05.25.16.20.06
        (version=SSLv3 cipher=OTHER);
        Wed, 25 May 2011 16:20:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306365594-22061-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174478>

Change the eval_gettext() invocations to use the GIT_I18N_VARIABLE_
prefix for variables used in eval_gettext. On Windows environment
variables are case insensitive, so e.g. $PATH clashes with $path. By
using a sufficiently unique prefix we work around that issue.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t0201-gettext-fallbacks.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0201-gettext-fallbacks.sh b/t/t0201-gettext-fallbacks.s=
h
index 54d98b9..209f078 100755
--- a/t/t0201-gettext-fallbacks.sh
+++ b/t/t0201-gettext-fallbacks.sh
@@ -41,10 +41,10 @@ test_expect_success 'eval_gettext: our eval_gettext=
() fallback can interpolate v
 '
=20
 test_expect_success 'eval_gettext: our eval_gettext() fallback can int=
erpolate variables with spaces and quotes' '
-    cmdline=3D"git am" &&
+    GIT_I18N_VARIABLE_cmdline=3D"git am" &&
     export cmdline;
     printf "When you have resolved this problem run \"git am --resolve=
d\"." >expect &&
-    eval_gettext "When you have resolved this problem run \"\$cmdline =
--resolved\"." >actual
+    eval_gettext "When you have resolved this problem run \"\$GIT_I18N=
_VARIABLE_cmdline --resolved\"." >actual
     test_i18ncmp expect actual
 '
=20
--=20
1.7.5.1
