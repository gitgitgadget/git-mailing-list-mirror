From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Wed, 16 Jan 2013 13:02:27 -0800
Message-ID: <7va9s8x2n0.fsf@alter.siamese.dyndns.org>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
 <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
 <20130116160131.GB22400@sigill.intra.peff.net>
 <7vfw21xde5.fsf@alter.siamese.dyndns.org>
 <20130116174325.GA27525@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <max@quendi.de>, Chris Rorvick <chris@rorvick.com>,
	git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 22:02:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tva8L-0001Fj-2C
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 22:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393Ab3APVCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 16:02:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56086 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753193Ab3APVCa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 16:02:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2825B581;
	Wed, 16 Jan 2013 16:02:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Iy/rqSNixl8DOe6PK8CBEuufRvM=; b=TeOoEj
	Hf6XDiD3D0Bsw3ZtwdWl3nTZKYqWxYfEt7BmB9YyEyuQmnOmfDCAG8JJZuCfa2eF
	YG2GPI3SAeBw7MITVV82BSp6DdEh0gS3bABLIm1Yoc2pdiirxBjdkiIZUOuWJsw5
	Hfac6RVmib0sjtN3z3VzAfr8XFHIoCotbDe1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BTkcZy6cRKUlpJCchzAxsdYgnz3DGoEB
	udNc/L0mKxI5QwDm/fvtWkebNcEY0yiX9xstLDOVhQIcqbZmwv+Dl5S6WmEnABAf
	MmUucY5OfEY5T79Nmr8T6oxpJKLmI9UnqHqX56tzAFRcd8sP6XQTox7B/oVK5L18
	nO+ff9Vj1A4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5E3CB57D;
	Wed, 16 Jan 2013 16:02:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC5FBB57C; Wed, 16 Jan 2013
 16:02:28 -0500 (EST)
In-Reply-To: <20130116174325.GA27525@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 16 Jan 2013 09:43:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09744FB0-6020-11E2-A6A2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213813>

Jeff King <peff@peff.net> writes:

> I see what you are saying, but I think the ship has already sailed to
> some degree. We already implement the non-fast-forward check everywhere,
> and I cannot have a "refs/tested" hierarchy that pushes arbitrary
> commits without regard to their history. If I have such a hierarchy, I
> have to use "--force" (or more likely, mark the refspec with "+").

Yeah, actually in that example, I meant refs/tested/ would have
pointers to bare tree objects. I often rebuild 'pu' and another
private integration branch for testing, reordering the series that
are still not in 'next' and also after rewriting log messages of
some commits. It is not unusual to end up the updated 'pu' having
the identical tree as 'pu' before update, and I want to skip testing
the result (tree equality matters while commit equality does not in
such a use case).

> In my mind, the object-type checking is just making that fast-forward
> check more thorough (i.e., extending it to non-commit objects).

Yes, I agree with that point of view.

Thanks.

Here is what I am planning to queue (the patch is the same, but the
message is different on the third point). 

-- >8 --
Subject: [PATCH] push: fix "refs/tags/ hierarchy cannot be updated without --force"

When pushing to update a branch with a commit that is not a
descendant of the commit at the tip, a wrong message "already
exists" was given, instead of the correct "non-fast-forward", if we
do not have the object sitting in the destination repository at the
tip of the ref we are updating.

The primary cause of the bug is that the check in a new helper
function is_forwardable() assumed both old and new objects are
available and can be checked, which is not always the case.

The way the caller uses the result of this function is also wrong.
If the helper says "we do not want to let this push go through", the
caller unconditionally translates it into "we blocked it because the
destination already exists", which is not true at all in this case.

Fix this by doing these three things:

 * Remove unnecessary not_forwardable from "struct ref"; it is only
   used inside set_ref_status_for_push();

 * Make "refs/tags/" the only hierarchy that cannot be replaced
   without --force;

 * Remove the misguided attempt to force that everything that
   updates an existing ref has to be a commit outside "refs/tags/"
   hierarchy.

The policy last one tried to implement may later be resurrected and
extended to ensure fast-forwardness (defined as "not losing
objects", extending from the traditional "not losing commits from
the resulting history") when objects that are not commit are
involved (e.g. an annotated tag in hierarchies outside refs/tags),
but such a logic belongs to "is this a fast-forward?" check that is
done by ref_newer(); is_forwardable(), which is now removed, was not
the right place to do so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h               |  1 -
 remote.c              | 43 +++++++------------------------------------
 t/t5516-fetch-push.sh | 21 ---------------------
 3 files changed, 7 insertions(+), 58 deletions(-)

diff --git a/cache.h b/cache.h
index a32a0ea..a942bbd 100644
--- a/cache.h
+++ b/cache.h
@@ -1004,7 +1004,6 @@ struct ref {
 		requires_force:1,
 		merge:1,
 		nonfastforward:1,
-		not_forwardable:1,
 		update:1,
 		deletion:1;
 	enum {
diff --git a/remote.c b/remote.c
index aa6b719..d3a1ca2 100644
--- a/remote.c
+++ b/remote.c
@@ -1279,26 +1279,6 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	return 0;
 }
 
-static inline int is_forwardable(struct ref* ref)
-{
-	struct object *o;
-
-	if (!prefixcmp(ref->name, "refs/tags/"))
-		return 0;
-
-	/* old object must be a commit */
-	o = parse_object(ref->old_sha1);
-	if (!o || o->type != OBJ_COMMIT)
-		return 0;
-
-	/* new object must be commit-ish */
-	o = deref_tag(parse_object(ref->new_sha1), NULL, 0);
-	if (!o || o->type != OBJ_COMMIT)
-		return 0;
-
-	return 1;
-}
-
 void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 	int force_update)
 {
@@ -1320,32 +1300,23 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		}
 
 		/*
-		 * The below logic determines whether an individual
-		 * refspec A:B can be pushed.  The push will succeed
-		 * if any of the following are true:
+		 * Decide whether an individual refspec A:B can be
+		 * pushed.  The push will succeed if any of the
+		 * following are true:
 		 *
 		 * (1) the remote reference B does not exist
 		 *
 		 * (2) the remote reference B is being removed (i.e.,
 		 *     pushing :B where no source is specified)
 		 *
-		 * (3) the update meets all fast-forwarding criteria:
-		 *
-		 *     (a) the destination is not under refs/tags/
-		 *     (b) the old is a commit
-		 *     (c) the new is a descendant of the old
-		 *
-		 *     NOTE: We must actually have the old object in
-		 *     order to overwrite it in the remote reference,
-		 *     and the new object must be commit-ish.  These are
-		 *     implied by (b) and (c) respectively.
+		 * (3) the destination is not under refs/tags/, and
+		 *     if the old and new value is a commit, the new
+		 *     is a descendant of the old.
 		 *
 		 * (4) it is forced using the +A:B notation, or by
 		 *     passing the --force argument
 		 */
 
-		ref->not_forwardable = !is_forwardable(ref);
-
 		ref->update =
 			!ref->deletion &&
 			!is_null_sha1(ref->old_sha1);
@@ -1355,7 +1326,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 				!has_sha1_file(ref->old_sha1)
 				  || !ref_newer(ref->new_sha1, ref->old_sha1);
 
-			if (ref->not_forwardable) {
+			if (!prefixcmp(ref->name, "refs/tags/")) {
 				ref->requires_force = 1;
 				if (!force_ref_update) {
 					ref->status = REF_STATUS_REJECT_ALREADY_EXISTS;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 6009372..8f024a0 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -950,27 +950,6 @@ test_expect_success 'push requires --force to update lightweight tag' '
 	)
 '
 
-test_expect_success 'push requires --force to update annotated tag' '
-	mk_test heads/master &&
-	mk_child child1 &&
-	mk_child child2 &&
-	(
-		cd child1 &&
-		git tag -a -m "message 1" Tag &&
-		git push ../child2 Tag:refs/tmp/Tag &&
-		git push ../child2 Tag:refs/tmp/Tag &&
-		>file1 &&
-		git add file1 &&
-		git commit -m "file1" &&
-		git tag -f -a -m "message 2" Tag &&
-		test_must_fail git push ../child2 Tag:refs/tmp/Tag &&
-		git push --force ../child2 Tag:refs/tmp/Tag &&
-		git tag -f -a -m "message 3" Tag HEAD~ &&
-		test_must_fail git push ../child2 Tag:refs/tmp/Tag &&
-		git push --force ../child2 Tag:refs/tmp/Tag
-	)
-'
-
 test_expect_success 'push --porcelain' '
 	mk_empty &&
 	echo >.git/foo  "To testrepo" &&
-- 
1.8.1.1.426.g616047d
