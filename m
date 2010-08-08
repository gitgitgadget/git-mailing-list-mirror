From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] test-lib: Add support for multiple test
 prerequisites
Date: Sat, 7 Aug 2010 20:57:29 -0500
Message-ID: <20100808015729.GA9284@burratino>
References: <1281129565-26124-1-git-send-email-avarab@gmail.com>
 <1281129565-26124-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 03:59:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhvAR-0006ZY-IW
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 03:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646Ab0HHB64 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Aug 2010 21:58:56 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63965 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab0HHB6z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 21:58:55 -0400
Received: by ywh1 with SMTP id 1so3155290ywh.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 18:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=NZAsYwT3VS7TjjB7ahow67UIcOh6TApZsja0rjQ62kM=;
        b=NDXnakHc1AgW/7bjjSTtOnyfwWOrG49tnlU3bjuCvww9ypqw+DvcFerAuIaFdn4ulW
         JGPOaMhmU4hJJiNAbLNZxomQlo7L5cElWaU68PPKFtwp5R3GTxtacqTz2S0BOcJYbaKI
         pXqiB5Zh5Mw3+hdbKwEZWQuXhPkx89UXweT3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VYAi4JfYx2C9oC7nw2/mzwuh2Mr8Cf0XMl9ds1It4pe7xLnijrzg0j8EBmrFcTwnx1
         Y5wUcaruVd+pPmzbsTKrgNP21lab+QhJiNmbfi6QXAS+1yK87VHmu1AxsuG3x3JB99h3
         gN0Z4P8sivLJxeNkrHR4tU0D6YaEoCU3ldVoQ=
Received: by 10.100.30.1 with SMTP id d1mr15942143and.76.1281232734557;
        Sat, 07 Aug 2010 18:58:54 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id i25sm5302234anh.37.2010.08.07.18.58.53
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 18:58:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281129565-26124-2-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152875>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Change the test_have_prereq function in test-lib.sh to support a
> comma-separated list of prerequisites. This is useful for tests that
> need e.g. both POSIXPERM and SANITY.
>=20
> The implementation was stolen from Junio C Hamano and Johannes Sixt,
> the tests and documentation were not.

I think you can sell it better. :)

	From: Johannes Sixt <j6t@kdbg.org>
	Subject: test-lib: Allow tests with multiple prerequisites

	Occasionally an especially taxing test comes around that
	makes multiple assumptions on the system running it.
	Currently the test suite works around that with such hacks as

	 if
		test_have_prereq SYMLINKS &&
		test_have_prereq POSIXPERM
	 then
		test_set_prereq SYMLINKPERM
	 fi
	 test_expect_success SYMLINKPERM 'funny symlink in work tree, un-unlin=
k-able' '
		...
	 '

	or even worse, as in the test that example is based on, leaves
	out mention of the =E2=80=9Ceasier=E2=80=9D of the two assumptions.

	Maybe you would be happier to be able to write

	 test_expect_success SYMLINKS,POSIXPERM 'funny symlink' '
		...
	 '

	Based on a patch by Junio.

	[ab: added tests and documentation]

	Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>

> +++ b/t/t0000-basic.sh
> @@ -73,6 +73,23 @@ then
>  	exit 1
>  fi
> =20
> +test_set_prereq HAVETHIS
> +haveit=3Dno
> +test_expect_success HAVETHIS,HAVEIT 'test runs if prerequisites are =
satisfied' '
> +    test_have_prereq HAVEIT &&
> +    test_have_prereq HAVETHIS &&

I think the similar code above was just a way to sneak in a sanity
check for test_have_prereq().  I=E2=80=99d leave it out.

> +    haveit=3Dyes
> +'
> +donthaveit=3Dyes
> +test_expect_success HAVEIT,DONTHAVEIT 'unmet prerequisites causes te=
st to be skipped' '
> +    donthaveit=3Dno
> +'
> +if test $haveit$donthaveit !=3D yesyes
> +then
> +	say "bug in test framework: multiple prerequisite tags do not work =
reliably"
> +	exit 1
> +fi

Maybe it would be simpler to squash this in with the other similar chec=
ks.

> +++ b/t/test-lib.sh
> @@ -327,12 +327,20 @@ test_set_prereq () {
>  satisfied=3D" "
> =20
>  test_have_prereq () {
> -	case $satisfied in
> -	*" $1 "*)
> -		: yes, have it ;;
> -	*)
> -		! : nope ;;
> -	esac
> +	# prerequisites can be concatenated with ','
> +	save_IFS=3D$IFS
> +	IFS=3D,
> +	set -- $*
> +	IFS=3D$save_IFS
> +	for prerequisite
> +	do
> +		case $satisfied in
> +		*" $prerequisite "*)
> +			: yes, have it ;;
> +		*)
> +			! : nope ;;
> +		esac
> +	done

Does that work?

Except as noted above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
---
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 2887677..cdb25af 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -58,35 +58,28 @@ test_expect_failure 'pretend we have fixed a known =
breakage' '
     :
 '
 test_set_prereq HAVEIT
+test_set_prereq ONE
+test_set_prereq TWO
 haveit=3Dno
 test_expect_success HAVEIT 'test runs if prerequisite is satisfied' '
     test_have_prereq HAVEIT &&
     haveit=3Dyes
 '
+haveboth=3Dno
+test_expect_success ONE,TWO 'test runs if prerequisites are satisfied'=
 '
+    haveboth=3Dyes
+'
 donthaveit=3Dyes
 test_expect_success DONTHAVEIT 'unmet prerequisite causes test to be s=
kipped' '
     donthaveit=3Dno
 '
-if test $haveit$donthaveit !=3D yesyes
-then
-	say "bug in test framework: prerequisite tags do not work reliably"
-	exit 1
-fi
-
-test_set_prereq HAVETHIS
-haveit=3Dno
-test_expect_success HAVETHIS,HAVEIT 'test runs if prerequisites are sa=
tisfied' '
-    test_have_prereq HAVEIT &&
-    test_have_prereq HAVETHIS &&
-    haveit=3Dyes
-'
-donthaveit=3Dyes
-test_expect_success HAVEIT,DONTHAVEIT 'unmet prerequisites causes test=
 to be skipped' '
-    donthaveit=3Dno
+donthaveboth=3Dyes
+test_expect_success THREE,ONE 'one unmet prerequisite is enough' '
+    donthaveboth=3Dno
 '
-if test $haveit$donthaveit !=3D yesyes
+if test $haveit$donthaveit$haveboth$donthaveboth !=3D yesyesyesyes
 then
-	say "bug in test framework: multiple prerequisite tags do not work re=
liably"
+	say "bug in test framework: prerequisite tags do not work reliably"
 	exit 1
 fi
=20
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8701923..a3b0b22 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -338,7 +338,7 @@ test_have_prereq () {
 		*" $prerequisite "*)
 			: yes, have it ;;
 		*)
-			! : nope ;;
+			return 1
 		esac
 	done
 }
--=20
