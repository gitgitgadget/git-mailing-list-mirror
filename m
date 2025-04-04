Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD31EA7DD
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 00:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725125; cv=none; b=WAUP/gs2CZelOA7l3fHt+HlsLwf1CYAvRc8ZS08woHua/GP5i5iHNtQdBXNnrpCEzWjTXgzdkeOGj1kJbchdpQhrIHz52S+bfd3dZj/Z1XiKQLVfZdfzuO0d89rhK72riv0S2q66/m3/m8JuDq1B9MQsNv4d3ZoPIv033yJoxFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725125; c=relaxed/simple;
	bh=ltzSa3nic74+3jO1oj7WfH/jF8x0umSyjm0IZOsu/Rs=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=lmof9HEt+wVE6TnEShY5Hu2ZIYDUnLEfeL8EmiHsbhRzSCu8iBs3VxnabpjefWa6wnhvQRjqIPfccttDhL8F1B4cetPuRM27ALmiFSEkNtfZQQlRcn7mwLtOuAy58C4i57FijZv8z18dFreCRWi3azsY5n24/qeD58yt7uw7Yuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZTJlH0f2lz9t5t;
	Fri,  4 Apr 2025 02:05:15 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Apr 2025 02:05:13 +0200
Message-Id: <D8XEYQ9TRB10.L5S89IAC2LZ9@buenzli.dev>
To: "Nico Williams" <nico@cryptonector.com>
Cc: "Elijah Newren" <newren@gmail.com>, "Martin von Zweigbergk"
 <martinvonz@google.com>, "Git Mailing List" <git@vger.kernel.org>, "Edwin
 Kempin" <ekempin@google.com>, "Scott Chacon" <scott@gitbutler.com>,
 "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
From: "Remo Senekowitsch" <remo@buenzli.dev>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com> <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com> <Z+7PDi5y4wXJBK4r@ubby> <D8XC02N85O7W.2LQY7B8Q2Z98G@buenzli.dev> <Z+8GoNrdaJlmNpGm@ubby>
In-Reply-To: <Z+8GoNrdaJlmNpGm@ubby>
X-Rspamd-Queue-Id: 4ZTJlH0f2lz9t5t

On Fri Apr 4, 2025 at 12:07 AM CEST, Nico Williams wrote:
> On Thu, Apr 03, 2025 at 11:45:55PM +0200, Remo Senekowitsch wrote:
>
> Regardless, all operations that "alter" a commit, such as by cherry-
> picking or rebasing it onto some other commit, should have the same
> defaults and options for preserving/dropping metadata such as "change
> ID".
>
> If I cherry-pick a commit then I absolutely want its "change ID" to be
> preserved by default.  If I want to drop that I can always ask for that
> or amend the commit to remove it.  I will want the same behavior for
> rebase and cherry-pick.  Having to remember different defaults and
> options for the two would be a cognitive load I do not need.

Yeah, that's a very valid argument. In Jujutsus CLI, there is a very
clear separation between "rebase" and "duplicate", so there's no risk
of confusion if one preserves the change-id and the other doesn't. In
Git, the saparation between rebase and cherry-pick is less clear-cut.
Making them behave the same way can be seen as simpler.

>>                 [...]. The ways rebase and cherry-pick are most often
>> used are semantically very different from each other. (interactive)
>
> How do you know this is "most often" so? [...]

I haven't conducted a study, this is my impression from talking to peers
and reading chatter from other Git users online. Maybe the impression is
wrong.

>> rebase is often used to amend commits that already have descendants. In
>> that case, it makes sense for the change-id to be preserved. cherry-pick
>> on the other hand is often used to create a dublicate of a patch at a
>> different location in the commit tree, e.g. for backporting purposes.
>
> That's not how I use rebase.  I rebase to:
>
>  - catch up with upstream changes
>  - reorder commits
>  - combine commits
>  - split commits
>  - edit commit metadata
>  - edit commit contents

Yeah, I was (over-)simplifying. rebase is the swiss-army knife of git
commands. But for all of these operations, it holds that the previous
version of the patch(es) won't be reachable in the commit tree anymore
after the rebase is complete. (assuming potential descendant branches
are also rebased, which is usually the case) So rebase doesn't generally
cause duplicate change-ids, which is what I wanted to get at.

> [...] The whole point of a "change ID" is to let the user notice that
> some set of commits all share the same origin, such as all being a fix
> to the same bug each in a different release (backports).  If you're
> backporting bug fixes you'll really want the change IDs to be preserved.
>
> When would you not want to preserve a change ID on cherry-pick?  I can't
> say I would ever have wanted to do that had Git had change IDs from day
> 1, and I've been using Git for more than twenty years.

That's not exactly how Jujutsu thinks about the change-id, but it's a
useful piece of information. Gerrit does indeed use its change-id to
track cherry-picks. I am in favor of measures to track that metadata
(although duplicating change-ids is not my preferred option for that).

Let's assume the change-id represents the origin of a patch. What should
happen if a patch is split in two? Should they have the same change-id,
because they ultimately have the same origin? Maybe.

I don't attach too much semantic meaning to the change-id. It's a
normally unique identifier for a change that persists as the change
evolves. That's useful. The more commits with the same change-id as
others there are, the less useful the concept becomes.

>> doesn't preserve the change-id for that reason. So if cherry-pick
>
> I have _never_ used cherry-pick to cause there to be duplicate commits
> in the same branch.  Therefore calling it "duplicate" seems terribly
> wrong to me.

Well, obviously not in the same branch. I meant duplicate among all
visible commits (reachable from any branch). That's the issue we're
discussing w.r.t. change-ids not always being unique identifiers for
a single commit. What would you like me to call that siuation instead
of duplicate?

Can you maybe give some examples of how you use cherry-pick? I'd be
interested in your use cases to maybe better understand where you're
coming from. I myself almost never use cherry-pick, simply because I'm
not involved in any backporting. I've seen cherry-pick used to get a
bugfix from another branch onto your own, in order to avoid having to
wait for the other branch to be merged. But that practice has always
rubbed me the wrong way. I feel like the correct thing to do in that
situation is to extract the bugfix to a separate dependency-free branch
and make the two feature branches depend on it. That way, both feature
branches can more easily track changes in the bugfix by rebasing. If the
bugfix was cherry-picked, it's much harder to keep the two versions in
sync. (And finally, the latter approach probably makes the bugfix land
faster.) So yeah, interested to hear your use-cases for cherry-pick.

Remo
