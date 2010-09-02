From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] gettext tests: remove old sanity test under NO_GETTEXT
Date: Thu,  2 Sep 2010 15:02:45 +0000
Message-ID: <1283439765-4622-1-git-send-email-avarab@gmail.com>
References: <7vpqww435o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 17:03:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrBJc-0005Lb-13
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 17:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab0IBPCw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 11:02:52 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55066 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab0IBPCv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 11:02:51 -0400
Received: by wyb35 with SMTP id 35so70873wyb.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=/Rs83ZOK31SGllPKETrQPAvihX+KBe6oZx5mSR7z44I=;
        b=ee3BoLiT1aepoIewCIGp86qqL+NigyqzuObapq07IrUU7ULd3aQs1fCIs6AJ6dM3By
         qENYa8tOtffYB4qlizaZz+8XV5E1OCofvfDOIr2HsffphHTYw/manpbPw7R+Y7zowwSQ
         UjKEse2F9f5r/mYjbp5a6zreSIzrgUIOiRR34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=YumydvtisFrirUeCdbybhhgVJKAjNEtp3AgmVEmXq3hmCu4RVS/cHpNDsyC3R5vHQt
         BL1nDLHIGKvc464wcMFMmo63PeGxQDFamceA2hnlw0pFsanbxGD4qxyej6BJVeUqcAT2
         B9hmKJL45zboHshB8WANwokBV1Pj1xtudg1FU=
Received: by 10.227.27.214 with SMTP id j22mr8556681wbc.72.1283439769993;
        Thu, 02 Sep 2010 08:02:49 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k7sm405422wej.26.2010.09.02.08.02.49
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 08:02:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.588.g61cd1
In-Reply-To: <7vpqww435o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155133>

Remove an old sanity test that checked that the share/locale dir
didn't exist if we compiled with NO_GETTEXT=3DYesPlease. This would
break if the user did:

    git clean -dxf
    make NO_GETTEXT=3D
    make NO_GETTEXT=3DYesPlease
    make test

This test was something to test very basic sanity back when I was
first developing the gettext series, but it's not needed anymore. We
don't have similar tests for other parts of git to check that we
didn't build something with a given feature disabled.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Thu, Sep 2, 2010 at 14:43, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> It's failing because you compiled without gettext, but you still hav=
e
>> an old /share/locale dir hanging around. I.e. you built from an old
>> build dir without first doing make clean.
>
> If a user did the following:
>
>    $ rm -fr /tmp/w-gettext /tmp/wo-gettext
>    $ make clean
>    $ make PREFIX=3D/tmp/w-gettext test install
>    $ make PREFIX=3D/tmp/wo-gettext NO_GETTEXT=3DNoThanks test install
>
> I think there should be something that causes stale stuff in the buil=
d
> directory:
>
>    (1) not to be installed to the final destination and;
>
>    (2) not to interfere with the running of test,
>
> somewhere in the last make procedure.  Here "stale stuff" is not
> necessarily limited to share/locale.
>
> I think you already have arranged the first to happen correctly; I se=
e
> "ifndef NO_GETTEXT" in the "install" target.

It's best just to remove the test. It was only there to test /really/
basic sanity in the past while I was still actively hacking the
Makefile.

 t/t0200-gettext-basic.sh |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/t/t0200-gettext-basic.sh b/t/t0200-gettext-basic.sh
index 3846ea8..8853d8a 100755
--- a/t/t0200-gettext-basic.sh
+++ b/t/t0200-gettext-basic.sh
@@ -39,11 +39,6 @@ test_expect_success GETTEXT 'sanity: Icelandic local=
e was compiled' '
     test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
 '
=20
-test_expect_success NO_GETTEXT "sanity: \$TEXTDOMAINDIR doesn't exists=
 with NO_GETTEXT=3DYesPlease" '
-    ! test -d "$TEXTDOMAINDIR" &&
-    test "$TEXTDOMAINDIR" =3D "$GIT_TEXTDOMAINDIR"
-'
-
 # TODO: When we have more locales, generalize this to test them
 # all. Maybe we'll need a dir->locale map for that.
 test_expect_success GETTEXT_LOCALE 'sanity: gettext("") metadata is OK=
' '
--=20
1.7.2.2.588.g61cd1
