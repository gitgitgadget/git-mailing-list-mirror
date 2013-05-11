From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] test-bzr: Do not use unportable sed "\+"
Date: Sat, 11 May 2013 22:35:08 +0200
Message-ID: <518EAB7C.3010508@web.de>
References: <201305111525.53130.tboegi@web.de> <7vwqr5wdqm.fsf@alter.siamese.dyndns.org> <7vobchwbax.fsf@alter.siamese.dyndns.org> <518EA351.8000603@web.de> <7v8v3lwa5p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	felipe.contreras@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 11 22:35:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbGW1-00058k-VP
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 22:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267Ab3EKUfc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 May 2013 16:35:32 -0400
Received: from mout.web.de ([212.227.17.12]:63964 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754256Ab3EKUfb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 16:35:31 -0400
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0M7blv-1UMdm71vjL-00xN1m; Sat, 11 May 2013 22:35:16 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7v8v3lwa5p.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:G5oL0DhwM111sE+hraNPhiwcZe8jGmOvGWULoyYgJ7r
 vblk0Wf+JTsg8syDXuenrvwpJv4RTi3DLUGE/kbblwnIAioExQ
 mely7CL74VdBv8sZedlnTwaosDdx/3vEyAKu6zilmCiTqRcxnT
 P/vc55LaAMzu1H5ES+L5whhda53mvG79zsMiGMzWIIHqZFuo5R
 1DTffjEt9u44zTMM81QAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224010>

On 11.05.13 22:09, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> I did,
>> the interesting thing is that the test passes with and without your =
patch.
>> (After enabling  GIT_TEST_LONG and GIT_TEST_HTTPD in both cases)
>=20
> Strange.  Do you see differences between the produced packed-refs
> file?

The original version seems to look like this:
:1 666527db455708922859283c673094002092910b
:2 1e2acf73c6db881cfb1d56d67662e3d9260be2cf
[snip]

The "fixed POSIX version" follows that style:
666527db455708922859283c673094002092910b refs/tags/blablablablablablabl=
ablablablablablablablablablablablablablablablablablablablablablablabla-=
1
1e2acf73c6db881cfb1d56d67662e3d9260be2cf refs/tags/blablablablablablabl=
ablablablablablablablablablablablablablablablablablablablablablablabla-=
2
[snip]

(Just to verify the changes:)
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index b23efbb..68965f0 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -210,8 +210,11 @@ test_expect_success EXPENSIVE 'create 50,000 tags =
in the repo' '
        # now assign tags to all the dangling commits we created above
        tag=3D$("$PERL_PATH" -e "print \"bla\" x 30") &&
        sed -e "s/^:\(.\+\) \(.\+\)$/\2 refs\/tags\/$tag-\1/" <marks >>=
packed-refs
+       sed -e "s|^:\([^ ]*\) \(.*\)$|\2 refs/tags/$tag-\1|" <marks >pa=
cked-refs.junio
+       sed -e "s/^:\(.\+\) \(.\+\)$/\2 refs\/tags\/$tag-\1/" <marks >p=
acked-refs.orig
        )
 '
+       exit 0
