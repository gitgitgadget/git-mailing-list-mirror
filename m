Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F023459168
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721421880; cv=none; b=gj2Us4YSvpI12aXwrF7ODhibDeMCfByy917IMn0WdhCZoJWVT7oDs0ASdkvSx1v8UqIy/9FVyRBef2w8I4mjmM7hq47+hXdXFWFw7PHD43StOg+u/pNu2ZtFNUsJqyapla6NxtLghWQF3Pz8Eioquk6RVW9oMFCrphH4KTHnPy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721421880; c=relaxed/simple;
	bh=wVBMLnaqWK1wYCETx6XF1TsYu/xdR/l70sSVuFX3mzA=;
	h=From:To:Subject:cc:Date:Message-ID:MIME-Version:Content-Type; b=G7JLGeHNw7iSRLNhKRqJodb8r2xOc4uiZHnoejULA8VpvHtRUmiIM7v3b+8YtrWX9cr9ziMbWqjS0tLWP6eSTO+k2yQa3HBa9wu1JpWBThx/AYLsiuUn1Or3isN1JKUP4/xmh8a87C8ZDU/351xijJ7txom9PZe39tyzIGZnAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XGsP/J7K; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XGsP/J7K"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B611C19FD8;
	Fri, 19 Jul 2024 16:44:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=wVBMLnaqWK1wYCETx6XF1TsYu/xdR/l70sSVuFX3mzA=; b=XGsP/J7Kf+VU
	Z5p0xyLgU7UBU4gdvrijCtT1AaV+E1dOJMBQwrxQvTJZ2p6XanfHRYPfHSh41HZl
	ibPO0D1KS+MNj6YBdm4EN3QsZNqug5wmBbGumzr5IlcJdyxpV1yUfmI48Yszu2XL
	PibfvKhdYLvwKCEf+K5Lyl+R4RmlQ3c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC75219FD7;
	Fri, 19 Jul 2024 16:44:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2541019FD6;
	Fri, 19 Jul 2024 16:44:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/2] howto-maintain: cover a whole development cycle
cc: Emily Shaffer <emilyshaffer@google.com>,
    Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>
Date: Fri, 19 Jul 2024 13:44:35 -0700
Message-ID: <xmqqikx1i024.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B679EE72-460F-11EF-B3C0-34EEED2EC81B-77302942!pb-smtp1.pobox.com

The "policy" part is more important than the "daily operation" part
in that it establishes why certain maintainer tasks exist and are
performed the way they are.

The text briefly touches the role each integration branches play in
the workflow, but does not give the whole picture of what happens in
a single development cycle using these branches.  Extend the
description to describe a whole development cycle.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * As Emily's support policy document referred to this document, I
   gave a fresh pair of eyes to see if there needs any
   modernization.  The policy employed hasn't changed even a bit,
   and we have been operating consistently for the past 10 years,
   which is a good sign.

   Cc'ed a few folks who have played interim maintainer role in the
   past.

 Documentation/howto/maintain-git.txt | 52 ++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index 013014bbef..7219faf09f 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -37,22 +37,20 @@ The Policy
 
 The policy on Integration is informally mentioned in "A Note
 from the maintainer" message, which is periodically posted to
-this mailing list after each feature release is made.
+the mailing list after each feature release is made:
 
  - Feature releases are numbered as vX.Y.0 and are meant to
    contain bugfixes and enhancements in any area, including
    functionality, performance and usability, without regression.
 
- - One release cycle for a feature release is expected to last for
-   eight to ten weeks.
-
- - Maintenance releases are numbered as vX.Y.Z and are meant
+ - Maintenance releases are numbered as vX.Y.Z (0 < Z) and are meant
    to contain only bugfixes for the corresponding vX.Y.0 feature
    release and earlier maintenance releases vX.Y.W (W < Z).
 
- - 'master' branch is used to prepare for the next feature
+ - The 'master' branch is used to prepare for the next feature
    release. In other words, at some point, the tip of 'master'
-   branch is tagged with vX.Y.0.
+   branch is tagged as vX.(Y+1).0, when vX.Y.0 is the latest
+   feature release.
 
  - 'maint' branch is used to prepare for the next maintenance
    release.  After the feature release vX.Y.0 is made, the tip
@@ -63,11 +61,13 @@ this mailing list after each feature release is made.
  - 'next' branch is used to publish changes (both enhancements
    and fixes) that (1) have worthwhile goal, (2) are in a fairly
    good shape suitable for everyday use, (3) but have not yet
-   demonstrated to be regression free.  New changes are tested
-   in 'next' before merged to 'master'.
+   demonstrated to be regression free.  Reviews from contributors on
+   the mailing list help to make the determination.  After a topic
+   is merged to 'next', it is tested for at least 7 calendar days
+   before getting merged to 'master'.
 
  - 'seen' branch is used to publish other proposed changes that do
-   not yet pass the criteria set for 'next'.
+   not yet pass the criteria set for 'next' (see above).
 
  - The tips of 'master' and 'maint' branches will not be rewound to
    allow people to build their own customization on top of them.
@@ -86,6 +86,38 @@ this mailing list after each feature release is made.
    users are encouraged to test it so that regressions and bugs
    are found before new topics are merged to 'master'.
 
+ - When a problem is found in a topic in 'next', the topic is marked
+   not to be merged to 'master'.  Follow-up patches are discussed on
+   the mailing list and applied to the topic after being reviewed and
+   then the topic is merged (again) to 'next'.  After going through
+   the usual testing in 'next', the entire (fixed) topic is merged
+   to 'master'.
+
+ - One release cycle for a feature release is expected to last for
+   eight to ten weeks.  A few "release candidate" releases are
+   expected to be tagged about a week apart before the final
+   release, and a "preview" release is tagged about a week before
+   the first release candidate gets tagged.
+
+ - After the preview release is tagged, topics that were well
+   reviewed may be merged to 'master' before spending the usual 7
+   calendar days in 'next', with the expectation that any bugs in
+   them can be caught and fixed in the release candidates before
+   the final release.
+
+ - After the first release candidate is tagged, the contributors are
+   strongly encouraged to focus on finding and fixing new regressions
+   introduced during the cycle, over addressing old bugs and any new
+   features.  Topics stop getting merged down from 'next' to 'master',
+   and new topics stop getting merged to 'next'. Unless they are fixes
+   to new regressions in the cycle, that is.
+
+ - Soon after a feature release is made, the tip of 'maint' gets
+   fast-forwarded to point at the release.  Topics that have been
+   kept in 'next' are merged down to 'master' and a new development
+   cycle starts.
+
+
 Note that before v1.9.0 release, the version numbers used to be
 structured slightly differently.  vX.Y.Z were feature releases while
 vX.Y.Z.W were maintenance releases for vX.Y.Z.
-- 
2.46.0-rc1-48-g0900f1888e

