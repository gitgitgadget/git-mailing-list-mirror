Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E357AC2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 21:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 791522053B
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 21:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Otwim/xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIWVFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 17:05:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:43713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgIWVFi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 17:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600895123;
        bh=facj8aiA9BHp7lk7mEa/TW2huJXIZ3XR1Cg9oB5nr1E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Otwim/xkqYsnYc6kGvTaWzH2X+f3W5mhx5xfoNXAazIQwXWYkdfUzjtK7mU8Rhwk3
         ZedwUCR/NvL+1/cDxOGs5eJnlOCjeyqubvj37J9/Gg9zzz2zm+S3wenUrDukrLF+yP
         QiCVr/bTMRYl+JsfUEV/0cqGxO3vo4hpk9JKhhTo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.22]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbBk-1kdHIj2doU-00sdAs; Wed, 23
 Sep 2020 23:05:23 +0200
Date:   Wed, 23 Sep 2020 23:05:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Miriam Rubio <mirucam@gmail.com>
Subject: Re: [PATCH] bisect: don't use invalid oid as rev when starting
In-Reply-To: <nycvar.QRO.7.76.6.2009232229000.5061@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2009232302050.5061@tvgsbejvaqbjf.bet>
References: <20200923170915.21748-1-chriscool@tuxfamily.org> <nycvar.QRO.7.76.6.2009232229000.5061@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TdfyP9heLCA6RlZwng9eJNRf5J65g9puv7JDeZvMUXoN1s7pks1
 fmrTOfZ7dbPnscuYMAp7J+RN5WkJ8c2ig/b5wftf9XkNlgo3XhIkRAV7kdZxWVT6AAEMR/R
 YQRn60iGKa5WHx8D4ar0ZXia3GGGJGzUbxlqTSj/Wh4TKZAurOIzR/Xz5pC0LynmvKlPfHm
 kVbgxvQzBa/8M94BjoO0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QZgPoGuSIiA=:eS95QjBxCDC4Qkes/gWTMS
 H7bYB3GKaEzK5BmKsO/SfE8LTyaV0tYThcEKtNWFSz2Fwo3UmHFIgIytzBztSJe1arXuvJfAh
 LqDMLXsuN+k6FTMKCWJc3MH3p0rbwUqyVTOE5Uay2iQbFDl7bEXU7vn/9hOLZ9u48ZidkPswr
 ln5yOsQaN+ecWAaWMQCI/35Dlvli7tDqaOKYBb2BbJydXVZxsw1j/+mia2HAKNMWzgEE0dCKJ
 WIYYbURlwZyW/BLoVKQIn6gibQ8VD6zvtpjlbfLVdMLJMHwcnjB4D5omeO+rBewsZA5Punh3c
 5FktRSTxzKCYucl/tzcwg/u7X9j6x/19XMWowjV5vLk58ZPxog7qwZbz7Uz7Rje/exOgIQKnO
 HcskZd8Aa5PgdhX03H6muFJ0qoNdCeiGXvz+9wVXeF4iGmPcrrShwu+EA9m1EuqJtBM1I7CwE
 egIr+SW8BZI5lnVSw1D3VAeVdMVClX2gyRtqTLGxP0hzmSxzrVK3WeU+1jLHrfm5/0cFej8Vi
 dHAvy8DvY2VSvU7t8wzo3VIVCw1Ljd+mtgiOacQFmozD+Se53tgMScN4by7Kojap0gD+b8uCh
 tLZ4LzyAytCk7HYRuImhffiTsGkbCLW1ZkcqGYcDyCjqRPRYV98sGraAsyeKGGkhLL1KWAS2x
 jIwarENWonV+Bvas0kwHYBNdOkv48faheHnvqgOjcZnpzj1Dx68mbkV6HX0F6+xxaTiSvkNkN
 5HC8C8iJlYENxbIcM/3E6RXnrJQr4JQxYZxHdrQoeHAwsHsNosRjHxp2ag53ihqYOarcakRLY
 dXlExFrmlkNE5m02/T2dSU5AAvUckrdkNYDr6Zi1Cy7rSUI5z9t3cpHfgoeYkKr3ghQGpKfH8
 ISJ0wceFUV7/yVPAMRDwIPHc3Xy00c/x9vBDRV5O9OUprQcqiokhdD21ApMHQOBIXmJg6JZcX
 /0APsaMXl5+J/OMHCHU9/iGx+lf1VyM/aOaeL6rSbZVCUV7tdfyjYMRAV6fLBtc0+VyOMp/bl
 k+a1GSR++SXIHPrjlfD7whyBUE6CJCVO19nGQqqYVUHuVoMGf6I1EmwAdiJrsSk++R6Zy2SHn
 NwB83wP2uep4xCcWTgOIVGEi46+jJUDjYvzxOq8jhh0wljsx8ncv+wmVSiVuK+HrlR0BofzJl
 eKosQGMx2175WiG4ganS+5OY/DeoYHbslIO29UBGQtCwOddPsC8eQFwN8+zCY1BN64mJenxpK
 8S1ksLTYeMn7koLZJq6MnH6GKtFvizAR+Y674WQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Wed, 23 Sep 2020, Johannes Schindelin wrote:

> On Wed, 23 Sep 2020, Christian Couder wrote:
>
> > diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> > index 7dcc1b5188..538fa6f16b 100644
> > --- a/builtin/bisect--helper.c
> > +++ b/builtin/bisect--helper.c
> > @@ -486,12 +486,16 @@ static int bisect_start(struct bisect_terms *ter=
ms, const char **argv, int argc)
> >  			return error(_("unrecognized option: '%s'"), arg);
> >  		} else {
> >  			char *commit_id =3D xstrfmt("%s^{commit}", arg);
> > -			if (get_oid(commit_id, &oid) && has_double_dash)
> > -				die(_("'%s' does not appear to be a valid "
> > -				      "revision"), arg);
> > -
> > -			string_list_append(&revs, oid_to_hex(&oid));
> > +			int res =3D get_oid(commit_id, &oid);
> >  			free(commit_id);
> > +			if (res) {
> > +				if (has_double_dash)
> > +					die(_("'%s' does not appear to be a valid "
> > +					      "revision"), arg);
> > +				break;
> > +			} else {
> > +				string_list_append(&revs, oid_to_hex(&oid));
> > +			}
>
> I would find that a lot easier to read if it was reordered thusly:
>
> 			if (!get_oidf(&oid, "%s^{commit}", arg))
> 				string_list_append(&revs, oid_to_hex(&oid));
> 			else if (!has_double_dash)
> 				break;
> 			else
> 				die(_("'%s' does not appear to be a valid "
> 				      revision"), arg);
>
> And it would actually probably make sense to replace the `get_oid()` by
> `get_oid_committish()` in the first place.

I verified that this actually works, and figured out that we can save yet
another indentation level (as well as avoid awfully long lines):

=2D- snipsnap --
=46rom f673cea53e046774847be918f4023430e56bf6cb Mon Sep 17 00:00:00 2001
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 23 Sep 2020 19:09:15 +0200
Subject: [PATCH] bisect: don't use invalid oid as rev when starting

In 06f5608c14 (bisect--helper: `bisect_start` shell function
partially in C, 2019-01-02), we changed the following shell
code:

	rev=3D$(git rev-parse -q --verify "$arg^{commit}") || {
		test $has_double_dash -eq 1 &&
		die "$(eval_gettext "'\$arg' does not appear to be a valid revision")"
		break
	}
	revs=3D"$revs $rev"

into:

	char *commit_id =3D xstrfmt("%s^{commit}", arg);
	if (get_oid(commit_id, &oid) && has_double_dash)
		die(_("'%s' does not appear to be a valid "
		      "revision"), arg);

	string_list_append(&revs, oid_to_hex(&oid));
	free(commit_id);

In case of an invalid "arg" when "has_double_dash" is false, the old
code would "break" out of the argument loop.

In the new C code though, `oid_to_hex(&oid)` is unconditonally
appended to "revs". This is wrong first because "oid" is junk as
`get_oid(commit_id, &oid)` failed and second because it doesn't break
out of the argument loop.

Not breaking out of the argument loop means that "arg" is then not
treated as a path restriction (which is wrong).

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 builtin/bisect--helper.c    | 17 ++++++-----------
 t/t6030-bisect-porcelain.sh |  7 +++++++
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 93e855271b9..d11d4c9bbb5 100644
=2D-- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -660,18 +660,13 @@ static enum bisect_error bisect_start(struct bisect_=
terms *terms, const char **a
 			terms->term_bad =3D xstrdup(arg);
 		} else if (starts_with(arg, "--")) {
 			return error(_("unrecognized option: '%s'"), arg);
-		} else {
-			char *commit_id =3D xstrfmt("%s^{commit}", arg);
-			if (get_oid(commit_id, &oid) && has_double_dash) {
-				error(_("'%s' does not appear to be a valid "
-					"revision"), arg);
-				free(commit_id);
-				return BISECT_FAILED;
-			}
-
+		} else if (!get_oid_committish(arg, &oid))
 			string_list_append(&revs, oid_to_hex(&oid));
-			free(commit_id);
-		}
+		else if (has_double_dash)
+			die(_("'%s' does not appear to be a valid "
+			      "revision"), arg);
+		else
+			break;
 	}
 	pathspec_pos =3D i;

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index b886529e596..d6b4bca482a 100755
=2D-- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -82,6 +82,13 @@ test_expect_success 'bisect fails if given any junk ins=
tead of revs' '
 	git bisect bad $HASH4
 '

+test_expect_success 'bisect start without -- uses unknown arg as pathspec=
' '
+	git bisect reset &&
+	git bisect start foo bar &&
+	grep foo ".git/BISECT_NAMES" &&
+	grep bar ".git/BISECT_NAMES"
+'
+
 test_expect_success 'bisect reset: back in the master branch' '
 	git bisect reset &&
 	echo "* master" > branch.expect &&
=2D-
2.28.0.windows.1.18.g5300e52e185

