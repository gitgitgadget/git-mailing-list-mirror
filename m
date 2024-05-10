Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2036617BB4
	for <git@vger.kernel.org>; Fri, 10 May 2024 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715360138; cv=none; b=D0gPGHJtrwAjwd6LCDBeZunJFTwEPXfF4OeZ81mIBK4G9/92zrT87sMA/6m1liNX4lMMyKOiSCZNnE872WG7mCszscwI7nk+14Sx4lAv23djwfFGDX4nz7hfuUYWIl17nhcfpWhxUZ9w3LfLu8X0WUDD85LbRXsyNMpSTbpik+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715360138; c=relaxed/simple;
	bh=22N++pI1whTujaeVFuwUEWFQAT7+70g/OmI0BvOaG0w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDN8CP6d91ekcEn0uNetQbcmDO2Nub8EvphdzM4b/M//LS+UHctm60A91WwjxUpNtYnJQ5cjoBO//pcGjCFlhadnlj1HngcO1NPZhr3oM1Xr/YXTPbJa/N2rvpn+S3ptciNkDpjlqtMTfuFBVL5eqFA1ks07cI8VSOsYzziFq6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jlrzZwcX; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jlrzZwcX"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 04A9E32060;
	Fri, 10 May 2024 12:55:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=22N++pI1whTujaeVFuwUEWFQA
	T7+70g/OmI0BvOaG0w=; b=jlrzZwcX9y1Ti24QF5AcW8lHCzzu4fXSQjiKP6e64
	itYUPtn/ZVkfEbyxvFPnoHvnA3YUX7l2RQu5ULaz+9KjsS2wn5qsLOuualGnTexa
	ZLUdHxQKgSv3N1bpAkwOLsXo8wJudI0hNjscVggir4R3+ftazdClrbonSZqYTWzb
	9A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F1A123205F;
	Fri, 10 May 2024 12:55:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6AE873205E;
	Fri, 10 May 2024 12:55:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 2/2] SubmittingPatches: extend the "flow" section
Date: Fri, 10 May 2024 09:55:26 -0700
Message-ID: <20240510165526.1412338-3-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-119-g0f3415f1f8
In-Reply-To: <20240510165526.1412338-1-gitster@pobox.com>
References: <xmqqy18issfv.fsf@gitster.g>
 <20240510165526.1412338-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 1EDC80D2-0EEE-11EF-93D1-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Explain a full lifecycle of a patch series upfront, so that it is
clear when key decisions to "accept" a series is made and how a new
patch series becomes a part of a new release.

Fold the "you need to monitor the progress of your topic" section
into the primary "patch lifecycle" section, as that is one of the
things the patch submitter is responsible for.  It is not like "I
sent a patch and responded to review messages, and now it is their
problem".  They need to see their patch through the patch life
cycle.

Earlier versions of this document outlined a slightly different
patch flow in an idealized world, where the original submitter
gathered agreements from the participants of the discussion and sent
the final "we all agreed that this is the good version--please
apply" patches to the maintainer.  In practice, this almost never
happened.  Instead, describe what flow was used in practice for the
past decade that worked well for us.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 103 +++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 42 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPa=
tches
index e82c119dfa..8332073e27 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -8,53 +8,71 @@ project. There is also a link:MyFirstContribution.html[=
step-by-step tutorial]
 available which covers many of these same guidelines.
=20
 [[patch-flow]]
-=3D=3D=3D An ideal patch flow
+=3D=3D=3D A typical life cycle of a patch series
=20
-Here is an ideal patch flow for this project the current maintainer
-suggests to the contributors:
+To help us understand the reason behind various guidelines given later
+in the document, first let's understand how the life cycle of a
+typical patch series for this project goes.
=20
-. You come up with an itch.  You code it up.
-
-. Send it to the list and cc people who may need to know about
-  the change.
+. You come up with an itch.  You code it up.  You do not need any
+  pre-authorization from the project to do so.
++
+Your patches will be reviewed by other contributors on the mailing
+list, and the reviews will be done to assess the merit of various
+things, like the general idea behind your patch (including "is it
+solving a problem worth solving in the first place?"), the reason
+behind the design of the solution, and the actual implementation.
+The guidelines given here are there to help your patches by making
+them easier to understand by the reviewers.
+
+. You send the patches to the list and cc people who may need to know
+  about the change.  Your goal is *not* necessarily to convince others
+  that what you are building is good.  Your goal is to get help in
+  coming up with a solution for the "itch" that is better than what
+  you can build alone.
 +
-The people who may need to know are the ones whose code you
-are butchering.  These people happen to be the ones who are
+The people who may need to know are the ones who worked on the code
+you are touching.  These people happen to be the ones who are
 most likely to be knowledgeable enough to help you, but
-they have no obligation to help you (i.e. you ask for help,
-don't demand).  +git log -p {litdd} _$area_you_are_modifying_+ would
+they have no obligation to help you (i.e. you ask them for help,
+you don't demand).  +git log -p {litdd} _$area_you_are_modifying_+ would
 help you find out who they are.
=20
-. You get comments and suggestions for improvements.  You may
-  even get them in an "on top of your change" patch form.
-
-. Polish, refine, and re-send to the list and the people who
-  spend their time to improve your patch.  Go back to step (2).
-
-. The list forms consensus that the last round of your patch is
-  good.  Send it to the maintainer and cc the list.
-
-. A topic branch is created with the patch and is merged to `next`,
-  and cooked further and eventually graduates to `master`.
-
-In any time between the (2)-(3) cycle, the maintainer may pick it up
-from the list and queue it to `seen`, in order to make it easier for
-people to play with it without having to pick up and apply the patch to
-their trees themselves.
-
-[[patch-status]]
-=3D=3D=3D Know the status of your patch after submission
-
-* You can use Git itself to find out when your patch is merged in
-  master. `git pull --rebase` will automatically skip already-applied
-  patches, and will let you know. This works only if you rebase on top
-  of the branch in which your patch has been merged (i.e. it will not
-  tell you if your patch is merged in `seen` if you rebase on top of
-  master).
+. You get comments and suggestions for improvements.  You may even get
+  them in an "on top of your change" patch form.  You are expected to
+  respond to them with "Reply-All" on the mailing list, while taking
+  them into account while preparing an updated set of patches.
+
+. Polish, refine, and re-send your patches to the list and to the people
+  who spent their time to improve your patch.  Go back to step (2).
+
+. While the above iterations improve your patches, the maintainer may
+  pick the patches up from the list and queue them to the `seen`
+  branch, in order to make it easier for people to play with it
+  without having to pick up and apply the patches to their trees
+  themselves.  Being in `seen` has no other meaning.  Specifically, it
+  does not mean the patch was "accepted" in any way.
+
+. When the discussion reaches a consensus that the latest iteration of
+  the patches are in good enough shape, the maintainer includes the
+  topic in the "What's cooking" report that are sent out a few times a
+  week to the mailing list, marked as "Will merge to 'next'."  This
+  decision is primarily made by the maintainer with help from those
+  who participated in the review discussion.
+
+. After the patches are merged to the 'next' branch, the discussion
+  can still continue to further improve them by adding more patches on
+  top, but by the time a topic gets merged to 'next', it is expected
+  that everybody agrees that the scope and the basic direction of the
+  topic are appropriate, so such an incremental updates are limited to
+  small corrections and polishing.  After a topic cooks for some time
+  (like 7 calendar days) in 'next' without needing further tweaks on
+  top, it gets merged to the 'master' branch and wait to become part
+  of the next major release.
+
+In the following sections, many techniques and conventions are listed
+to help your patches get reviewed effectively in such a life cycle.
=20
-* Read the Git mailing list, the maintainer regularly posts messages
-  entitled "What's cooking in git.git" giving
-  the status of various proposed changes.
=20
 [[choose-starting-point]]
 =3D=3D=3D Choose a starting point.
@@ -241,8 +259,9 @@ reasons:
   which case, they can explain why they extend your code to cover
   files, too).
=20
-The goal of your log message is to convey the _why_ behind your
-change to help future developers.
+The goal of your log message is to convey the _why_ behind your change
+to help future developers.  The reviewers will also make sure that
+your proposed log message will serve this purpose well.
=20
 The first line of the commit message should be a short description (50
 characters is the soft limit, see DISCUSSION in linkgit:git-commit[1]),
--=20
2.45.0-119-g0f3415f1f8

