From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/5] gettext docs: the gettext.h C interface
Date: Fri, 10 Sep 2010 19:35:51 +0000
Message-ID: <1284147353-18000-4-git-send-email-avarab@gmail.com>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 10 21:36:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou9On-0006Xz-Gv
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 21:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621Ab0IJTgT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 15:36:19 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63050 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab0IJTgR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 15:36:17 -0400
Received: by wyf22 with SMTP id 22so3172368wyf.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Z4q0IM6WGUnFRCcdSoV55WNNwbG5EI7dOy+1oEeZvEg=;
        b=Muv7EJdyCaQ+3NPiiWubOyCx7MMTekMYtoGhnVH8NhOEhPRmzWF38sRDhiOsOJhml0
         vT3piSSgPUsmcIJMXs2opgY10dW1bHE6Atuk1lgQGLQ82VydvNFq0RVuShjGN9qHAkXk
         E4Itp5IhHCi6ic2IA4lG9Zz3bvyUKuHwKBNlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=eAp/L4GIyJM3Jl8+xS3EolMnDKSEqL+A8cZmAiUpKBGNC3xnhvJTlWpy2USUN7dSF7
         uCZHn7VQUznbN+97HE8HNtFHLyhif+V4W4pYofs43gvjHjZcAX7QexXBeXJmgCMQd1QW
         Elu+TvQPTLroSr0oW6zdRp5LC029fUDHvkq3o=
Received: by 10.227.136.69 with SMTP id q5mr192325wbt.202.1284147376054;
        Fri, 10 Sep 2010 12:36:16 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id a1sm2534921wbb.8.2010.09.10.12.36.14
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 12:36:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155962>

Change po/README's "Marking strings for translation" section so that
it covers the gettext.h C interface.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 po/README |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/po/README b/po/README
index 372cb9c..ac12637 100644
--- a/po/README
+++ b/po/README
@@ -119,3 +119,39 @@ General advice:
=20
        /* TRANSLATORS: %s will be "revert" or "cherry-pick" */
        die(_("%s: Unable to write new index file"), me);
+
+We provide wrappers for C, Shell and Perl programs. Here's how they're
+used:
+
+C:
+
+ - Include builtin.h at the top, it'll pull in in gettext.h, which
+   defines the gettext interface. Consult with the list if you need to
+   use gettext.h directly.
+
+ - The C interface is a subset of the normal GNU gettext
+   interface. We currently export these functions:
+
+   - _()
+
+    Mark and translate a string. E.g.:
+
+        printf(_("HEAD is now at %s"), hex);
+
+   - N_()
+
+    A no-op pass-through macro for marking strings inside static
+    initializations, e.g.:
+       =20
+        static const char *reset_type_names[] =3D {
+            N_("mixed"), N_("soft"), N_("hard"), N_("merge"), N_("keep=
"), NULL
+        };
+       =20
+    And then, later:
+
+        die(_("%s reset is not allowed in a bare repository"),
+               _(reset_type_names[reset_type]));
+
+    Here _() couldn't have statically determined what the translation
+    string will be, but since it was already marked for translation
+    with N_() the look-up in the message catalog will succeed.
--=20
1.7.2.3.313.gcd15
