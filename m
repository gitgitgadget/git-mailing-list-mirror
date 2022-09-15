Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3768C6FA89
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 14:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiIOOxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 10:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiIOOxr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 10:53:47 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAFC6BD64
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1663253620; bh=QwmtbTbnJdosXXGu42YRMYs4D0jluRtsUq//istLdIc=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=Dxh09unEoDtDrsH5WdV3qtxXEe+Tc8eetmmYf2kc44WRVu4G5TcDvhsiFnZ0nnsjY
         cEsUpok1K3yJyNyWZjbqh7wAFX7j3N6/El2bqSou2m6/J5d2pqqzYeaUnGtwtlQ7KP
         7wApLlvkzhotac7O200qIv1QvQM3joyfyM+XgkzgmJFfRiVSabTXYDTjWAhqzSJkYR
         lDAW/+tYD2O9LjqEVI0iP3XX4FeRejZwC8v1SmsucqK5uhy2LlQJvurcCLuAjwNmAI
         HvAMUJ/4AJk5ZyT63i8WcL1Ku/LIicsGrKSFKVOvBdwN931MfUDtmGQd3iMwekJk1Y
         Ha86tjl0Faxag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.24.217]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9ZeA-1oeJt23Cvk-005o80; Thu, 15
 Sep 2022 16:53:40 +0200
Message-ID: <23a6914b-47e5-d3a9-ca95-01035b691bca@web.de>
Date:   Thu, 15 Sep 2022 16:53:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: [PATCH 4/6] revision: factor out add_parents()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tim Jaacks <tim.jaacks@garz-fricke.com>,
        Chris Torek <chris.torek@gmail.com>
References: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
In-Reply-To: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wB4hPEkvC1fC3Lk2etN0EbZbTsAX8QAPuV48tcyoOX3keduoHjm
 kLoxPbSzsusTL2E54oHu/BivJ2l2BXHxV4weypQNGc0XDhh/Nc5XrWYO/XrwgbFFtmRPsPX
 qvARnTtlVnCb/ba7h4osSLPatNN6nF36Zzz3nUJwkZq87glJRp6cRvZFpe06dluFMtzs+pw
 OdH95Tob+eNffalDKR/OA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ee4xdjItARU=:w+1gwuJkiilmSG+GWhosaQ
 BXLggvyp3vYA+SpcQRoDFFQM4pxA5SRnx0Dh0ply5ZflR7d0M1ahSwv4FyIu/p/rIzBuqbHxw
 X3W1TWhkdi0gJtK3GRuiArQvkfAQpySPGwS2nD6tDyQGDdizHvmNtJYEUlp37Uj16mjdZGeg6
 GpjmfqYA1hJvh1UH9QUBi/X6FTgk7vUC1v+/zgZp7sBkESE+ZT5N+LSyaywMUUD2IWPcAO3qf
 UgmiTZpqE0hZ1at6cG3469Mq5eKHfdDdbwrXbgLzcqA2kb/F5Nr8B7306Tw7B1fQzxEkt5bQI
 Uk4GUshvQ+YxzP/jZcl2SEZRjw2M4mPChCrS3Fe21OAvlZhsShoVdFcZtdoANXvO+XeMW/+kL
 NU1iwssA0nRmHtHthSH2qicC2Xok1xlI7A5sErjw1a0Pnpjm54IdLDqCFM0rpABbamJ2X7x/q
 jGT435XhK31HRvr4jx1XtlVJEnQt4CZ0bftBv6Q+uIBj2GMdjMTBcuV92rbbIVrDSsmPQ+rSK
 B6zrFbrPDBEG5CV91Jnb0ROMeGXRIg1SFi0au7W0f/IlLTDA9L2fEmcdeWiTp99xehHgC1nOB
 LxbF3OpQMCXXpVIQne/Te0RCoCJVSvoHVF2Doa7HgLTXCYJ351DpMc/PGQ2rSX7UoaFHiAeDP
 yezC6EwRIX04n6+pshpRSnEtLnWzSxewWWT/jjTrk6SyxPAHjbFPqZIiBx4BsQ9DOrCzs3JU+
 0LGEY/Qw8itzOpmXfq89CLMtdk86kOU0IE2n1v8buJkLNUTfjycSWpxLkkmOrGSDrvofI/CYf
 zgOv6mCineK7WPkYA6KroKzkU7ZyCKCH2WlZgK7q/UB+j+4xaSpoy5cO8XDFV749cC7ud1UOP
 TpAeq8I79p1Te2ny6JibjwI3gpvQCtP0oCXW1gWLrxghazVd5uUJmT6dYRGM0MN7c2howeSMm
 dxebz86FCizabrECLy70WuKIR7m8XZZWf1S24MKjC+N4xugwojX9+CO5UI0AKvgei/PIIelKq
 MzfcFRzbwVqM9V0mli+A0aCkUlxWslNtRweQZeoM2owX4wBYHGKQqUQ0AQVr786EvV5OaRyhP
 b/KWQcB1kW2chpCHuqVvo3UszwEmhkx59mH9/2aiE/oAJyMn33YYIShRWTBSeICzVlwSzu1Tb
 TWCrQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a function that registers all parents.  Use it in add_parents_only()
to handle the case of exclude_parent being unset early.

With that out of the way we can specialize the remaining loop can to
register only the specified parent.  And since we exit reporting success
once we got it we no longer need to check the total number of parents
beforehand.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 revision.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 14cb73e508..284393a146 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -1861,6 +1861,13 @@ static void add_parent(struct rev_info *revs, struc=
t object *parent,
 	add_pending_object(revs, parent, arg);
 }

+static void add_parents(struct rev_info *revs, struct commit_list *parent=
s,
+			const char *arg, int flags)
+{
+	for (; parents; parents =3D parents->next)
+		add_parent(revs, &parents->item->object, arg, flags);
+}
+
 static int add_parents_only(struct rev_info *revs, const char *arg_, int =
flags,
 			    int exclude_parent)
 {
@@ -1870,18 +1877,19 @@ static int add_parents_only(struct rev_info *revs,=
 const char *arg_, int flags,

 	if (!commit)
 		return 0;
-	if (exclude_parent &&
-	    exclude_parent > commit_list_count(commit->parents))
-		return 0;
+	if (!exclude_parent) {
+		add_parents(revs, commit->parents, arg_, flags);
+		return 1;
+	}
 	for (parents =3D commit->parents, parent_number =3D 1;
 	     parents;
 	     parents =3D parents->next, parent_number++) {
-		if (exclude_parent && parent_number !=3D exclude_parent)
-			continue;
-
-		add_parent(revs, &parents->item->object, arg_, flags);
+		if (parent_number =3D=3D exclude_parent) {
+			add_parent(revs, &parents->item->object, arg_, flags);
+			return 1;
+		}
 	}
-	return 1;
+	return 0;
 }

 void repo_init_revisions(struct repository *r,
=2D-
2.37.3
