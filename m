From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can't find the revelant commit with git-log
Date: Fri, 28 Jan 2011 16:02:58 -0800
Message-ID: <7v1v3wd1al.fsf@alter.siamese.dyndns.org>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>
 <m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com>
 <4D4063EC.7090509@lsrfire.ath.cx> <4D432735.8000208@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francis Moreau <francis.moro@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jan 29 01:03:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiyHg-0007c2-Od
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 01:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362Ab1A2ADN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 19:03:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab1A2ADM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 19:03:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C8A553640;
	Fri, 28 Jan 2011 19:04:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=E9SP750NkQC3RnkVy+E7d9kWM
	Fg=; b=maXfaF6wOEsgsF01WqhFiDEYX4rjhA6jlp4LhnyFEeKNBCahFHiIif4uN
	2ByxlW4uf6t3JBEuhUgU4QbC7czaEp9NXvqkclugsKg2XJnVLBg5FROgdlpN/uXD
	EBWzEbPx9GJw2uhyhvJYRO0qcDiTH383cPSjRcHjybYj6aCc+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=OFoP+IvuM34+VfrsEHh
	+H2CxytEp4ZN3b7ZqOq77NoWFLnnR2DlwlbM3tELojrMz7eX1VBpUJIm+y1/exXP
	EaVdUc7ZcMAg3mzdXwR0ccM9ORX00pnS7X6yH0fK5TiUzj/BbFAw8VAdkCpICdMP
	qA9XpgxcUzSVb+0UAypEDjPQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A0E1363B;
	Fri, 28 Jan 2011 19:03:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D93433638; Fri, 28 Jan 2011
 19:03:51 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 44925806-2B3B-11E0-A23E-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165646>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Subject: pickaxe: don't simplify history too much
>
> If pickaxe is used, turn off history simplification and make sure to =
keep
> merges with at least one interesting parent.
>
> If path specs are used, merges that have at least one parent whose fi=
les
> match those in the specified subset are edited out.  This is good in
> general, but leads to unexpectedly few results if used together with
> pickaxe.  Merges that also have an interesting parent (in terms of -S=
 or
> -G) are dropped, too.
>
> This change makes sure pickaxe takes precedence over history
> simplification.

Hmmm, I understand the _motivation_ behind the change in the second hun=
k,
in that you _might_ want to dig the side branch that did not contribute
anything to the end result when looking for a needle with either -S or =
-G,
but doesn't the same logic apply to things like --grep?

I do not think it is a good idea to unconditionally disable simplificat=
ion
for -S/G without a way for the user to countermand (even though I could=
 be
persuaded to say that the flipping the default for -S/-G/--grep might h=
ave
been a better alternative in hindsight).

The user can control this behaviour by giving or not giving --simplify
from the command line anyway, no?

As to the first hunk, I have no idea why this is a good change.

It feels as if you are fighting against what this part of the code does=
 in
try_to_simplify_commit():

	switch (rev_compare_tree(revs, p, commit)) {
	case REV_TREE_SAME:
		tree_same =3D 1;
		if (!revs->simplify_history || (p->object.flags & UNINTERESTING)) {
			/* ... */
			pp =3D &parent->next;
			continue;
		}
		parent->next =3D NULL;
		commit->parents =3D parent;
		commit->object.flags |=3D TREESAME;
		return;
	...

When we see a _single_ parent that has the same tree, we set tree_same =
and
also cull the parent list to contain only that parent.  When we are not
simplifying the history, we do not cull the parent list and will inspec=
t
other parents as well, but still we set tree_same to 1 here.  When some
other parent is found to be different, we set tree_changed to 1.  So we
have four states (same =3D (0, 1) x changed =3D (0, 1)).

The code before your addition in the first hunk says that we keep the
commit if there is no parent with the same contents (i.e. !tree_same) a=
nd
there is at least one parent with different contents (i.e. tree_changed=
).
I suspect that this logic may not be working well when we do not simpli=
fy
the merge.

Let's look at the original code before your patch again.

 1. If all the parents of a commit are the same, we will see (tree_same=
 &&
    !tree_changed), so we get TREESAME.

 2. If some but not all of the parents are the same, we will see (tree_=
same
    && tree_changed), and we end up getting TREESAME.

 3. If none of the parents is the same, (!tree_same && tree_changed) ho=
lds
    true, and we do not get TREESAME.

Perhaps the second condition needs to be tweaked for the "do not simpli=
fy
merges" case?  That is, we split 2. into two cases:

 2a. When simplifying the merges, if any of the parents is the same as =
the
     commit, we say TREESAME (the same as before);

 2b. When not simplifying, we say TREESAME only when all the parents ar=
e
     the same as the commit.  Otherwise the merge commit itself is wort=
h
     showing, i.e. !TREESAME.

But I probably am missing some corner cases you saw in your analysis...

diff --git a/revision.c b/revision.c
index 7b9eaef..0147124 100644
--- a/revision.c
+++ b/revision.c
@@ -439,7 +439,7 @@ static void try_to_simplify_commit(struct rev_info =
*revs, struct commit *commit)
 		}
 		die("bad tree compare for commit %s", sha1_to_hex(commit->object.sha=
1));
 	}
-	if (tree_changed && !tree_same)
+	if ((!revs->simplify_history && tree_changed) || !tree_same)
 		return;
 	commit->object.flags |=3D TREESAME;
 }
