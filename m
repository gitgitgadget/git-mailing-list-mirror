From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] gettext: Make NO_GETTEXT=YesPlease the default in releases
Date: Tue, 31 Aug 2010 09:02:06 +0000
Message-ID: <1283245326-26108-1-git-send-email-avarab@gmail.com>
References: <7v39tveq0j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 31 11:02:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqMjr-0001RQ-1W
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 11:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177Ab0HaJCe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 05:02:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52528 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129Ab0HaJCc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 05:02:32 -0400
Received: by wwb28 with SMTP id 28so900585wwb.1
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 02:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=DcVkINfp87pKQDAcLwX+8zYs03VOvIAUvD9eOrG1fF4=;
        b=Qz1W8fZ9mt7jxajim7LbU+qsVsxlN6Iq6h/G1KEDz/eaq/kWBX63Yt08YEtLDm9Kpl
         oNvO9Ugjk0POqqoeijufy7+jeOkPGzfstnYcqwFHjprO4KEtXr0jwAfSMfg9J5SY2/Dn
         XzTK7RaVr5xpOQ+5gkq96/oYFEF12mPb+VESQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=HIhVZDEMZ5mnDFoOTx2sVDppteqln5rIjV9zWmkRZa01VVFI0Jhm1aaflC8gC6o5o/
         BTZrqlxP1msUzja5wRXjgvRczznThDggpFTOylFSjH3WZeFNEmjWVd1rX6jcOlYOx1TK
         9LjsyZYdKWTVgC/bfoHwULIt3+O3tZxmsWx7s=
Received: by 10.216.179.137 with SMTP id h9mr6117013wem.39.1283245336302;
        Tue, 31 Aug 2010 02:02:16 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w1sm5084448weq.25.2010.08.31.02.02.14
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 02:02:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.535.g1333f.dirty
In-Reply-To: <7v39tveq0j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154888>

Change the Git build process so that gettext is no longer built by
default as part of Git releases, and include a loud warning to
downstream distributors in INSTALL saying that they shouldn't enable
it.

We're still working out the details of the gettext infrastructure and
currently only a small portion of Git can be translated, so it's
premature to enable it by default.

However it's painful for everyone if the source changes needed for
gettext can't be made in pu without conflicting with other series that
apply to maint/master/next.

When gettext is disabled the whole functionality basically boils down
to this macro definition (or Shell and Perl equivalents) and a few
skipping tests:

    #define _(s) (s)

So it's a lot less to get right than if we were enabling it by
default.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Mon, Aug 30, 2010 at 21:42, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Now that Git has the infrastructure for translation in next I'm goin=
g
>> to start submitting patches to make the main porcelain translatable.
>>
>> This series starts that work, and fixes and also fixes up some of th=
e
>> infrastructure (like the bug discussed in "Odd encoding issue with
>> UTF-8 + gettext yields ? on non-ASCII"), and adds tests to make sure
>> it's all working.
>>
>> With it applied git-init is the one and only utility of the porcelai=
n
>> that's translatable. The series includes a translation of it into
>> Icelandic and Polish.
>>
>> I think it's ready to be applied. I tested it on Solaris, FreeBSD an=
d
>> Debian. But there's almost definitely something I'm missing in a
>> series this big, so it's an RFC.
>
> Thanks; will queue them.

Thanks!

> I however strongly suspect that we would be better off first kicking =
the
> earlier parts of i18n topic out of 'next' back to 'pu', as I am hopin=
g
> that we can declare feature freeze for 1.7.3 by the end of this week =
at
> the latest, and you can never tell if we got the "infrastructure" rig=
ht
> without playing with a real "user of the infrastructure" like this 17
> patch series, which means that the part of i18n topic that is already=
 in
> 'next' cannot be part of 1.7.3 --- it is way premature.

I definitely agree that it's premature at this point, if for no other
reason than that I'll never be able to make most of the main-porcelain
translatable by the end of the week.

However, there's another way to do this. Simply disable it by default
in releases. Which this patch implements.

I considered the possibility that we might want to disable it in
select branches when I wrote it, so it's easy to do so. And IMO a
better option due to the reasons cited in the commit message attached
to the PATCH.

> It was somewhat unfortunate and sad that your "test" series depended =
on a
> few patches from the i18n series, which means it is now taken hostage=
 to
> the latter.  I'd rather want to have the "test" series in the 1.7.3, =
and
> we need to think about a way to untangle the two topics.

Yeah I wasn't very careful about keeping the bits already in pu
separate. Untangling them shouldn't be that hard though, but hopefully
with this patch we won't have to go that route.

 INSTALL      |   17 +++++++++++++++--
 Makefile     |    4 ++++
 configure.ac |    2 +-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/INSTALL b/INSTALL
index e4e7506..aa477e2 100644
--- a/INSTALL
+++ b/INSTALL
@@ -93,8 +93,21 @@ Issues of note:
 	  history graphically, and in git-gui.  If you don't want gitk or
 	  git-gui, you can use NO_TCLTK.
=20
-	- A gettext library is used by default for localizing Git. The
-	  primary target is GNU libintl, but the Solaris gettext
+	- Git includes EXPERIMENTAL support for localization with gettext
+	  which is currently disabled by default in official Git
+	  releases.
+
+	  If you really want to build it you have to specify NO_GETTEXT=3D
+	  as a Makefile argument. If you're a downstream distributor
+	  please don't do so without consulting with the Git Mailing List
+	  first about the stability of this feature.
+
+	  It's only being included in releases so that source messages can
+	  be marked for translation without resulting in painful and
+	  inevitable merge conflicts between Git's pu branch and the
+	  rest. END WARNING.
+
+	  The primary target is GNU libintl, but the Solaris gettext
 	  implementation also works.
=20
 	  We need a gettext.h on the system for C code, gettext.sh (or
diff --git a/Makefile b/Makefile
index 9818a59..bd61a5b 100644
--- a/Makefile
+++ b/Makefile
@@ -272,6 +272,10 @@ ALL_CFLAGS =3D $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS =3D $(LDFLAGS)
 STRIP ?=3D strip
=20
+# Disable gettext by default in releases while the implementation is
+# settling
+NO_GETTEXT =3D YesPleaseForNow
+
 # Among the variables below, these:
 #   gitexecdir
 #   template_dir
diff --git a/configure.ac b/configure.ac
index 1821d89..c9b0265 100644
--- a/configure.ac
+++ b/configure.ac
@@ -806,7 +806,7 @@ AC_SUBST(HAVE_PATHS_H)
 #
 # Define NO_GETTEXT if you don't have libintl.h
 AC_CHECK_HEADER([libintl.h],
-[NO_GETTEXT=3D],
+[NO_GETTEXT=3DHaveItButYesPlease],
 [NO_GETTEXT=3DYesPlease])
 AC_SUBST(NO_GETTEXT)
 #
--=20
1.7.2.2.535.g1333f.dirty
