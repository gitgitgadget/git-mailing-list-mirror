From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] Deprecate "not allow as-is commit with i-t-a
 entries"
Date: Tue, 07 Feb 2012 11:55:48 -0800
Message-ID: <7v62fi1kqj.fsf@alter.siamese.dyndns.org>
References: <1328618804-31796-1-git-send-email-pclouds@gmail.com>
 <7v8vke38a1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 20:56:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rur8w-00050h-1g
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 20:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755942Ab2BGTzw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 14:55:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60180 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608Ab2BGTzv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Feb 2012 14:55:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F9EA5513;
	Tue,  7 Feb 2012 14:55:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lJ73q0AGSAfc
	xRIdnJF/W8ffdAU=; b=NvZs6XrJk56Po+Dfk0Buns52PMrSmuUOl+RIh7P+3wv9
	YtEDCBlQKBwdMbnh9eFiJ0UIKnS0YkDgUdyCFdvL42iczLvjTAQSEL2u2s4wC9S5
	3tqXoedDOiLCi4UYyn5yFwTPVwd7r+PIQE5uqT++jpi2O2h1xXTIVUsPYLkoSvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S772hL
	2HJ2UD5IyH/98PMhx7Dx8dwDMIi+jLKrr9t3DFXPBKZlynkFPaZwMF5wWXGy2G64
	H1pjnV851624RR4OPoy2WnZsnnB7QbVuwfJxKEpHHID2W19bcvfnKa91wGBV/99f
	F9E0Qvfkyo0teRqVazPYj4Ii3enxWOjstjmDM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 758595512;
	Tue,  7 Feb 2012 14:55:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E937550F; Tue,  7 Feb 2012
 14:55:49 -0500 (EST)
In-Reply-To: <7v8vke38a1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 07 Feb 2012 08:41:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BBA87734-51C5-11E1-AA1C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190206>

Junio C Hamano <gitster@pobox.com> writes:

> Ahh, thanks.
>
> But when I said "let's admit that this is just fixing an UI mistake, =
no
> configuration, no options", I really meant it.  Without the backward
> compatiblity "For now please do not fix this bug for me and keep bein=
g
> buggy until I get used to the non-buggy behaviour" fuss, which we nev=
er do
> to any bugfix.

Given that a patch to do so (with or without your 1/4 which is an
independently good change) on top of an ancient v1.7.6 codebase looks l=
ike
this, I am inclined to think this is the way to go.

I still need to review the existing documentation to see if anything ne=
eds
to be fixed up, though.

-- >8 --
=46rom: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] commit: ignore intent-to-add entries instead of refusi=
ng

Originally, "git add -N" was introduced to help users from forgetting t=
o
add new files to the index before they ran "git commit -a".  As an atte=
mpt
to help them further so that they do not forget to say "-a", "git commi=
t"
to commit the index as-is was taught to error out, reminding the user t=
hat
they may have forgotten to add the final contents of the paths before
running the command.

This turned out to be a false "safety" that is useless.  If the user ma=
de
changes to already tracked paths and paths added with "git add -N", and
then ran "git add" to register the final contents of the paths added wi=
th
"git add -N", "git commit" will happily create a commit out of the inde=
x,
without including the local changes made to the already tracked paths. =
It
was not a useful "safety" measure to prevent "forgetful" mistakes from
happening.

It turns out that this behaviour is not just a useless false "safety", =
but
actively hurts use cases of "git add -N" that were discovered later and
have become popular, namely, to tell Git to be aware of these paths add=
ed
by "git add -N", so that commands like "git status" and "git diff" woul=
d
include them in their output, even though the user is not interested in
including them in the next commit they are going to make.

=46ix this ancient UI mistake, and instead make a commit from the index
ignoring the paths added by "git add -N" without adding real contents.

Based on the work by Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy, and hel=
ped by injection of
sanity from Jonathan Nieder and others on the Git mailing list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The last hunk of t2203 is because the test assumed the previous one
   failed to make a commit and "rezrov" in HEAD does not have "xyzzy".
   Now that the previous test creates a commit and records "xyzzy" in
   "rezrov", this test will fail with "Nothing to commit" without it.

 cache-tree.c          |    6 +++---
 t/t2203-add-intent.sh |    8 +++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index f755590..ce0d0e3 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -158,7 +158,7 @@ static int verify_cache(struct cache_entry **cache,
 	funny =3D 0;
 	for (i =3D 0; i < entries; i++) {
 		struct cache_entry *ce =3D cache[i];
-		if (ce_stage(ce) || (ce->ce_flags & CE_INTENT_TO_ADD)) {
+		if (ce_stage(ce)) {
 			if (10 < ++funny) {
 				fprintf(stderr, "...\n");
 				break;
@@ -336,8 +336,8 @@ static int update_one(struct cache_tree *it,
 				mode, sha1_to_hex(sha1), entlen+baselen, path);
 		}
=20
-		if (ce->ce_flags & CE_REMOVE)
-			continue; /* entry being removed */
+		if (ce->ce_flags & (CE_REMOVE | CE_INTENT_TO_ADD))
+			continue; /* entry being removed or placeholder */
=20
 		strbuf_grow(&buffer, entlen + 100);
 		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0'=
);
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 2543529..ec35409 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -32,7 +32,7 @@ test_expect_success 'intent to add does not clobber e=
xisting paths' '
 	! grep "$empty" actual
 '
=20
-test_expect_success 'cannot commit with i-t-a entry' '
+test_expect_success 'i-t-a entry is simply ignored' '
 	test_tick &&
 	git commit -a -m initial &&
 	git reset --hard &&
@@ -41,12 +41,14 @@ test_expect_success 'cannot commit with i-t-a entry=
' '
 	echo frotz >nitfol &&
 	git add rezrov &&
 	git add -N nitfol &&
-	test_must_fail git commit -m initial
+	git commit -m second &&
+	test $(git ls-tree HEAD -- nitfol | wc -l) =3D 0 &&
+	test $(git diff --name-only HEAD -- nitfol | wc -l) =3D 1
 '
=20
 test_expect_success 'can commit with an unrelated i-t-a entry in index=
' '
 	git reset --hard &&
-	echo xyzzy >rezrov &&
+	echo bozbar >rezrov &&
 	echo frotz >nitfol &&
 	git add rezrov &&
 	git add -N nitfol &&
--=20
1.7.9.231.g87173
