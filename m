From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] diff: "S_IFREG | 0644" to "(S_IFREG | 0644)" to avoid
 warning
Date: Mon, 4 Oct 2010 05:35:50 -0500
Message-ID: <20101004103550.GA4738@burratino>
References: <1286184071-28457-1-git-send-email-avarab@gmail.com>
 <AANLkTim+QH6=XJikOsZs=qt9ZFHjP7gWz0zo9n4vz+gk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Dan McMahill <dmcmahill@netbsd.org>,
	Steven Drake <sdrake@xnet.co.nz>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 12:39:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2iS8-0001JL-CF
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 12:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939Ab0JDKjX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 06:39:23 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48596 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754902Ab0JDKjW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 06:39:22 -0400
Received: by iwn5 with SMTP id 5so6758110iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 03:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MucwZnLdQ26g+f1YMdfSy4Ph3lmaux41yJRcDfBFSU8=;
        b=Za2qwJ4V88mkixVaDcSAWIKYP2qb8mqKNNdo+b5ANwl9XgPGkGNAMIUy3mY4tH+ikg
         oczYoVpqJXFW5WMsoxjK7wZX3yGSl1SwAodhBXFBOinkx4dm6uOZk2/d7FLpMPWU6a+9
         rzRulROIJpGYS11tPXw05FyEYBxUVUoZY37nc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jnwX4Dm17JvKb07GAGoQwaHbwSjyjhBJ1u4hutRfdTBnkii0UeNoCekqbI06ydgGS8
         7QPEaFUv3pZgUG7CFxd54tF21qU7tEe2jif1IuGIRSpQzAHRDCjQEoWY5PVy4D/Pnq4S
         ldftmKM2JsUczYlVViIwEYd7N6t3k7S/ev30g=
Received: by 10.231.169.210 with SMTP id a18mr10024559ibz.5.1286188758163;
        Mon, 04 Oct 2010 03:39:18 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id h8sm4820783ibk.3.2010.10.04.03.39.17
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 03:39:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTim+QH6=XJikOsZs=qt9ZFHjP7gWz0zo9n4vz+gk@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158024>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> But tests on NetBSD with /bin/sh still fail since we use cd -P, but w=
e
> have unapplied patches for that so I didn't pursue it:
>=20
>     http://article.gmane.org/gmane.comp.version-control.git/136561/ma=
tch=3D
>     http://article.gmane.org/gmane.comp.version-control.git/136562/ma=
tch=3D

Aren't these v1.7.0-rc0~76^2 and v1.7.0-rc0~76^2^?

Here's a patch for the more important of the remaining problems.  I'm
just guessing here; untested, of course.

-- 8< --
Subject: tests: use pwd -P to simulate cd -P for portability

NetBSD supports pwd -P but not cd -P.  POSIX has required both for
a while, so this should not be an issue for most Unix-like platforms.

The test harness uses cd -P to ensure $PWD and $(pwd) agree;
cd $(pwd -P) should do that, too.

If pwd -P fails on some platform, with this patch, the test harness
will die with 'FATAL: Unexpected exit with code 1'.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/test-lib.sh |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 830e5e7..184bf84 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -916,9 +916,10 @@ rm -fr "$test" || {
 }
=20
 test_create_repo "$test"
-# Use -P to resolve symlinks in our working directory so that the cwd
-# in subprocesses like git equals our $PWD (for pathname comparisons).
-cd -P "$test" || exit 1
+cd "$test" || exit 1
+# Resolve symlinks in our working directory so that the cwd in
+# subprocesses like git equals our $PWD (for pathname comparisons).
+dir=3D$(pwd -P) && cd "$dir" || exit 1
=20
 HOME=3D$(pwd)
 export HOME
--=20
1.7.2.3
