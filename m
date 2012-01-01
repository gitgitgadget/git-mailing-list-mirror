From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Possible submodule or submodule documentation issue
Date: Sun, 01 Jan 2012 16:13:16 +0100
Message-ID: <4F00780C.7090801@web.de>
References: <1325013859.1987.65.camel@yos>  <4EFB725C.7030600@web.de> <1325127030.1681.35.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Bill Zaumen <bill.zaumen+git@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 01 16:13:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhN6S-0000Po-SB
	for gcvg-git-2@lo.gmane.org; Sun, 01 Jan 2012 16:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab2AAPNU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Jan 2012 10:13:20 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:50269 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588Ab2AAPNT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jan 2012 10:13:19 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate05.web.de (Postfix) with ESMTP id 7AB3C68A1F22
	for <git@vger.kernel.org>; Sun,  1 Jan 2012 16:13:17 +0100 (CET)
Received: from [192.168.178.43] ([91.3.198.21]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LqlAw-1SLdrq2dCU-00ecQf; Sun, 01 Jan 2012 16:13:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <1325127030.1681.35.camel@yos>
X-Provags-ID: V02:K0:UMx8JliztJq/Dnn9xx/JO+rTwwFnXaTrBVkrcCM8Xeg
 B1iyp5H6lFuoWzuRPC+GdMpFPEaMMGKHLQ4cK1OxNtCjdirVoz
 EkDSiK2/ML6nBU0xoqgmKd0sV2NVXhD76m2TBhMegK5Y6zjRCd
 gzARzDQ8CNhSpdh77FQE8wNsQ4YO0HkB0qgNjpMlK+FMcpmI9N
 WTvI1sJICYjqpH8Ppi+wg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187824>

Am 29.12.2011 03:50, schrieb Bill Zaumen:
> On Wed, 2011-12-28 at 20:47 +0100, Jens Lehmann wrote:
>> Am 27.12.2011 20:24, schrieb Bill Zaumen:
>> Hmm, the documentation says "the location relative to the
>> superproject=E2=80=99s origin repository", not the directory contain=
ing
>> it. This means you have to use ".." first to get out of the
>> repository itself, no?
>=20
> The problem is  that the documentation also says that "<repository>
> is the URL of the new submodule's origin repository" and the wording
> would not make sense if the superproject's origin repository was not
> also named by a URL.  The rules for resolving relative URIs (a URL is
> a specific type of URI) are given in
> http://tools.ietf.org/html/rfc3986#section-5.4
> which has some examples:  if you resolve ./g against http://a/b/c/d;p=
?q
> you get http://a/b/c/g (the rules are purely syntactic and the syntax
> does not indicate that ".../foo.git" is a directory, and even the
> slashes do not definitively indicate directories in the sense of a
> file-system directory although they often do).

Thanks for that pointer, now I understand what you expected and why.

But as this behavior is in Git since September 2007 (f31a522a2d), I
suppose changing the behavior is a no-go. So what about clarifying
the docs:
---------8<-----------
[PATCH] docs: describe behavior of relative submodule URLs

Since the relative submodule URLs have been introduced in f31a522a2d, t=
hey
do not conform to the rules for resolving relative URIs but rather to
those of relative directories.

Document that behavior.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-submodule.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submod=
ule.txt
index 6ec3fef..b729649 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -79,7 +79,12 @@ to exist in the superproject. If <path> is not given=
, the
 <repository> is the URL of the new submodule's origin repository.
 This may be either an absolute URL, or (if it begins with ./
 or ../), the location relative to the superproject's origin
-repository. If the superproject doesn't have an origin configured
+repository (Please note that to specify a repository 'foo.git'
+which is located right next to a superproject 'bar.git', you'll
+have to use '../foo.git' instead of './foo.git' - as one might expect
+when following the rules for relative URLs - because the evaluation
+of relative URLs in Git is identical to that of relative directories).
+If the superproject doesn't have an origin configured
 the superproject is its own authoritative upstream and the current
 working directory is used instead.
 +
--=20
1.7.8.GIT
