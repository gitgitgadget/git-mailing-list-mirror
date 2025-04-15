Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94729161310
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744756235; cv=none; b=lJUfPVVlxX3wxsztmQOviPSQK70V5iE25j4l87DE8/n75EuZpvzLhANjUHsuSoS8OmwIHXwfA437cIeJe4uNqKg2jANCMTIHrIiKY9FV8ksHsmNFHCs00Ep3HPHRd7vCoPnSgD3qop6a+UjTh0V2WzjI5lySAjy84xQfUpfceYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744756235; c=relaxed/simple;
	bh=/sA7EGoatVLJSTkXWlZTG9rRpX5j+kGwmIMAgR7nwAs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=K3Sr3IdvBVY/RMwU+yPHBzATnJ5PZBOO3Wh8wlXIpKjyMunG4+kTDfdzgGxSvgRkzdQ2eZq7DpQ2m6jQVx6RO2fJbstvDlueaOFXKVLGJ5Y9CTnSPncLB/0SURqYWEtiHFPp8xnFdT2IuRzlKrht/1z4HLQrV2VwdLks4pNQGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Zcf4J4mMsz9vDQ;
	Wed, 16 Apr 2025 00:30:24 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Apr 2025 00:30:22 +0200
Message-Id: <D97KGN6TV8F7.1KKO8GYI65W59@buenzli.dev>
Cc: "Nico Williams" <nico@cryptonector.com>, "Martin von Zweigbergk"
 <martinvonz@google.com>, "Git Mailing List" <git@vger.kernel.org>, "Edwin
 Kempin" <ekempin@google.com>, "Scott Chacon" <scott@gitbutler.com>,
 "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Junio C Hamano" <gitster@pobox.com>, "Theodore Ts'o" <tytso@mit.edu>
References: <20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby>
 <xmqqv7rdqkla.fsf@gitster.g> <Z/a+AVopz+HLa1eL@ubby>
 <20250410134426.GB13132@mit.edu> <xmqqy0w8ng5r.fsf@gitster.g>
 <20250411154839.GC648081@mit.edu> <xmqqfriemw38.fsf@gitster.g>
 <20250412231318.GG13132@mit.edu> <xmqq8qo2srn5.fsf@gitster.g>
In-Reply-To: <xmqq8qo2srn5.fsf@gitster.g>

On Mon Apr 14, 2025 at 5:13 PM CEST, Junio C Hamano wrote:
> "Theodore Ts'o" <tytso@mit.edu> writes:
>
>> On Fri, Apr 11, 2025 at 10:44:43AM -0700, Junio C Hamano wrote:
>>>=20
>>> The submitting contributor must make a conscious arrangement to give
>>> a "patch set ID" shared among the messages in a single iteration,
>>> and everybody who are responding must make sure they do not add the
>>> same ID to the messages they throw at the thread in response.  Those
>>> who use format-patch and send-email can do that with convention and
>>> automation and there is no reason to rely on In-Reply-To: header
>>> (which may confuse the automated recipient of manually created
>>> follow-up messages).
>>
>> So it all depends on how the patch set ID is implemented.  Here's one
>> way that I had in mind.  The reason why I like like this over the
>> Change-ID approach is that the semantics can be very clearly defined,
>> and the only thing we rely on is the user saying "this new commit is
>> part of patch series which I'm putting together".=20
>>
>> By default when creating a new commit, the field is empty (in which
>> case the patch set ID is presumed to be the same as the commit ID), or
>> if the user gives a command-line flag say, "git commit --series"
>> which indicates that it is part of a patch series in which case the
>> patch set ID of the commit is set to the patch set ID of the current
>> commit (i.e., eventully, its parent commit).
>>
>> Whenever the commit is amended or rebased or cherry picked, if the
>> patch series ID is NULL, then it is set to the original commit ID.
>> Otherwise, the existing patch set ID is preserved.
>>
>> The patch set ID will be output by git format-patch (perhaps as "Patch
>> Series ID: sha has" immediately after the --- line.  And if it is
>> present, "git am" will import that patch series ID into git commit
>> which creates when it sucks in the e-mail.
>>
>> The net affect of this is that for new versions of git which implement
>> the Patch Set ID, all new commits are treated as patch series of
>> length 1, unless a subsequent commit is created using "git commit
>> --series".  And the Patch Set ID will be preserved across
>> cherry-picks, rebase operations, and git send-email/git apply-message
>> operations.
>>
>> So if someone replies to an existing e-mail thread with a new commit,
>> git format-patch will give it a different patch set ID, so we can
>> distinguish it from an amended  copy of a patch in the patch series.
>>
>> It also means that singleton commits, the patch ID effectively acts
>> much like the tranditonal Change-ID.  For multi-commit patch series,
>> all of the commits will have the same patch set ID.
>
> Yeah, I like that aspect the best---the case for single commit
> series falling out as a natural degenerate case of the more general
> case to support multi-commit series is a good sign that the design
> got something right ;-)
>
> I am still not sure what to think about the lack of explicit the
> evolution history of one patch set that share the same patch set ID.
>
> When we have 10 commits that share the same patch set ID, I can
> imagine that we can easily tell 3 are from one iteration, and 3 and
> 4 among the rest are from another two iterations by noticing that
> there are three strand of pearls, having 3, 3, and 4 commits on it.
> And we can identify the initial round by noticing that one of the
> commits have its name as the patch set ID, but I am not sure if we
> should be OK by not having anything but the committter timestamp to
> tell which one among the other two iterations are earlier, and we
> cannot tell anything about these two other iterations if they are
> independent rewrites of the original round.
>
> But other than that, I like something with clearly defined semantics
> (and the definition coming naturally out of the structure, not out
> of some arbitrary convention that forces to bring in some
> semantics), and what you outlined above looks reasonably clean and
> easy to use.

Doesn't a patch set ID suffer from the same kind of ambiguity the
change-id supposedly does? Patch sets can be split and merged, a commit
from one patch set can be cherry-picked into another. What patch set ID
should such a cherry-picked commit have?

And I think the argument that a change-id for a singleton patch
set naturally falls out of the patch set ID can easily be reversed.
Admittedly, I don't have the most experience with the mailing list
workflow, but a multi-commit patch set usually comes with a cover
letter, right? And people like to track their cover letter in a commit?
IIUC, b4 is designed around that too.

In that case, the cover letter has its own change-id as any other
commit, which will naturally remain stable across every version of the
patch set. It would be non-sensical to squash, split or cherry-pick the
cover letter commit. Sounds like a great candidate for the patch set ID.

So the patch set ID can just as naturally flow out from the change-id.

I can see two concrete disadvantages of the patch set ID:

* It's strictly less powerful. As explained, the change-id can do
  everything the patch set ID can via the cover letter. But the patch
  set ID cannot help you track how individual commits within the patch
  set evolved.

* It's more complicated. While many Git users work with patch sets every
  day, it's not a concept in Git iself. Git only knows about commits.
  The patch set ID would introduce a new concept into Git unnecessarily,
  while the change-id naturally extends the language Git already speaks,
  that of commits.

Remo
