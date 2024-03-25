Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4FA6CDD6
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405309; cv=none; b=D7rN83+ijwKqc/bo2udY2Q5U8uFyCUV1FvsxeQvxqQq5va1ToVZqhkgGwObm25UHj7FyiLxedC+EWQPHrsL2owjCe7DaxCXtcDZbdkDQsqpE/o0v01uxv6pbwSuoVyuUdXxL6k4Y/HQQS2z2Zse+MmbBb7l7GQeQI3g015++11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405309; c=relaxed/simple;
	bh=h0KaGFK24qisEyB2fX2tON2IfpReQkcKalGPn2DoUa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dCyeK8fM5uD254mi4b6D4CKtxqQ7ncFLZ0gsI714px42bfatXT+MOgUZL+kc0yXo8IdB8EJ0tSnqFKNleQYiVD5QBrfisvYzda0a9vEq0u6KYP09T+KLgg+pmAZjDkwh63DzzhCn0gm/8V0+D8yBzkGHDDRhYZb1KyDS8I3eruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W9r/ebcr; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W9r/ebcr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7B191E9679;
	Mon, 25 Mar 2024 18:21:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=h
	0KaGFK24qisEyB2fX2tON2IfpReQkcKalGPn2DoUa4=; b=W9r/ebcrzI/Cipzy6
	OsfRPeWIqcXqDb8LsUeQOyRghE2mBIST4fQlWg9nXR2JzViDLsMgxoTK2UxpRr6k
	ggI/NZmC7RGGZwOxl2efqXwhV+kv5aKSA+uj9yO5EtmvhjQD0l6BJrR2A8ZLfRQZ
	WaGDSYhgwCN1LO1qlxRuHfVVjA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE2811E9678;
	Mon, 25 Mar 2024 18:21:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 412321E9677;
	Mon, 25 Mar 2024 18:21:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
Cc: "Brian Lyles" <brianmlyles@gmail.com>, <phillip.wood123@gmail.com>,
  =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Subject: [PATCH v2] SubmittingPatches: release-notes entry experiment
Date: Mon, 25 Mar 2024 15:21:45 -0700
Message-ID: <xmqq8r26eyva.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 10FB23FE-EAF6-11EE-A86C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

The "What's cooking" report lists the topics in flight, with a short
paragraph descibing what they are about.

Once written, the description is automatically picked up from the
"What's cooking" report and used in the commit log message of the
merge commit when the topic is merged into integration branches.
These commit log messges of the merge commits are then propagated to
the release notes.

It has been the maintainer's task to prepare these entries in the
"What's cooking" report.  Even though the original author of a topic
may be in the best position to write the initial description of a
topic, we so far lacked a formal channel for the author to suggest
what description to use.  The usual procedure has been for the
author to see the topic described in "What's cooking" report, and
then either complain about inaccurate explanation and/or offer a
rewrite.

Let's try an experiment to optionally let the author propose the one
paragraph description when the topic is submitted.  Pick the cover
letter as the logical place to do so, and describe an experimental
workflow in the SubmittingPatches document.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * An experimental procedure for a topic author to propose the topic
   description to be used in "What's cooking" report and in the
   release notes have been added to the SubmittingPatches document.

 The above is an example that follows this protocol for a
 single-patch series.

    >> Would it be beneficial to request some specific heading, phrase, or
    >> other structured text such that this summary is obvious, or even easily
    >> extracted with some sort of script? Or is that perhaps overkill for now?
    >
    > ... the rule might end up
    > to be as simple as "When the first paragraph of the message looks
    > like an entry in the Release Notes, it is used as such".

Range-diff:
1:  83f8b69ab9 ! 1:  86b861255b SubmittingPatches: release-notes entry experiment
      ## Documentation/SubmittingPatches ##
     @@ Documentation/SubmittingPatches: an explanation of changes between each iteration can be kept in
    @@ Documentation/SubmittingPatches: an explanation of changes between each iteratio
     +paragraph summary that appears in the "What's cooking" report when it
     +is picked up to explain the topic.  If you choose to do so, please
     +write 2-5 lines of a paragraph that will fit well in our release notes
    -+(see Documentation/RelNotes/* directory for examples), and put it in
    -+the cover letter, clearly marked as such.  For a single-patch series,
    ++(see Documentation/RelNotes/* directory for examples), and make it
    ++the first paragraph of the cover letter.  For a single-patch series,
     +use the space between the three-dash line and the diffstat, as
     +described earlier.
     +

 Documentation/SubmittingPatches | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e734a3f0f1..e29a3d9a5b 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -459,6 +459,17 @@ an explanation of changes between each iteration can be kept in
 Git-notes and inserted automatically following the three-dash
 line via `git format-patch --notes`.
 
+[[a-paragraph-summary]]
+
+*This is EXPERIMENTAL*.  When sending a topic, you can propose one
+paragraph summary that appears in the "What's cooking" report when it
+is picked up to explain the topic.  If you choose to do so, please
+write 2-5 lines of a paragraph that will fit well in our release notes
+(see Documentation/RelNotes/* directory for examples), and make it
+the first paragraph of the cover letter.  For a single-patch series,
+use the space between the three-dash line and the diffstat, as
+described earlier.
+
 [[attachment]]
 Do not attach the patch as a MIME attachment, compressed or not.
 Do not let your e-mail client send quoted-printable.  Do not let
-- 
2.44.0-325-g11c821f2f2


