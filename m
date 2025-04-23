Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792AF1F4604
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 00:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745367949; cv=none; b=SGATNVJ4VenvRarEDcfAHSrgffwZjvQUtneoM+t9lG1WjBZMOoNdobqHSHnbA1aICbOlfcjOB5We8WNQSpI1mZFDfjGr/NgED7u9m8k+kyHiPFF9vruE/g2+STHH1CpGvpFX7gHefPuGN66LNz8vc18P8eJvrTVknaHxn/UgCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745367949; c=relaxed/simple;
	bh=BeEgfpxnqCg37pSKlOt5uyn/TqmDarH0JDnrkhVo21E=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=pXBzFSAgUwx4sGBXBlmzvlxdbN23oi2VarM2IA0UhLV20ZBNuNkPgeWK/Tdp+d6QKhR0CtTOERfF5nz0f7jHU2nrd4GQAvM4n+rFMdzFFE+JRAkFv22lO25E9czjR9Nf3GrSobIpXaUXpDi2IC/1t/iXFXUW+hLEPhGLufqe45I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Zj0J74gwpz9thN;
	Wed, 23 Apr 2025 02:25:43 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Apr 2025 02:25:40 +0200
Message-Id: <D9DLAQTMJYU6.RJLLVMQZOICK@buenzli.dev>
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Nico Williams" <nico@cryptonector.com>, "D. Ben Knoble"
 <ben.knoble@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Junio C Hamano" <gitster@pobox.com>,
 "Martin von Zweigbergk" <martinvonz@google.com>, "Git Mailing List"
 <git@vger.kernel.org>, "Edwin Kempin" <ekempin@google.com>, "Scott Chacon"
 <scott@gitbutler.com>, "philipmetzger@bluewin.ch"
 <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com> <xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby> <20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby> <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com> <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev> <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com> <aAgWytQNqtLzg2TU@ubby>
In-Reply-To: <aAgWytQNqtLzg2TU@ubby>

On Wed Apr 23, 2025 at 12:23 AM CEST, Nico Williams wrote:
> On Tue, Apr 22, 2025 at 04:17:03PM -0400, D. Ben Knoble wrote:
>> On Wed, Apr 16, 2025 at 7:36=E2=80=AFAM Remo Senekowitsch <remo@buenzli.=
dev> wrote:
>> > On Mon Apr 14, 2025 at 9:54 PM CEST, D. Ben Knoble wrote:
>
> [Responding out of order.]
>
>> > I think it's the other way around: Building a code review UI built on
>> > git and centered around interdiffs today is _hard_, that's why we don'=
t
>> > have it yet. Adding change-ids to commits will make it much easier,
>> > paving the way for these tools to be implemented.
>>=20
>> Fair point, although GitHub's detection of force-pushes makes me think
>> it could split a PR into versions at that point, cross-link backwards
>> and forwards by one version (from the force-push detection), show
>> range-diffs between versions based on the target branch of the merge,
>> and even follow the cross-links to show an overall sequence of
>> versions.
>
> GitLab does something like this for review comments where the author
> updates the commented you get a link you can click on that shows you the
> differences between version n-1 and version n.  GitLab does this without
> change IDs.
>
> GitLab seems to figure it out -- an existence proof that it can be done.
> So maybe Junio and Theodore are quite right that similarity checks
> should be enough.

I haven't used GitLab in a while so I had to test it. I found the
feature you describe and it's nice, but it falls short in important and
somewhat predicable ways.

Firstly, it only happens when you make a comment on the whole diff.
Then it shows you an interdiff between the version you commented on and
the immediate next version. (I didn't find a way to make it show the
interdiff between the commented-on and the _latest_ version, but that
seems doable implementation wise.)

But that's not really what we're talking about here. That's taking the
interdiff between two versions _of the entire branch_ and selecting a
relevant _hunk_ from it. Neat, but completely unrelated.

If you make a comment on a _specific commit_, the feature doesn't kick
in at all. GitLab just tells you that this comment was made "on an
outdated change in commit xyz".

A truly patch-based review UI would show the interdiff between the
previous version of the specific commit that was commented on and the
next or latest version of _that specific patch_.

That requires tracking how the individual patches evolve and as far as
I can tell, GitLab makes no attempt to do so. I didn't even give it a
hard time, I kept the number of commits, the commit messages and author
timestamps the same.

So, while I must say GitLab is doing pretty well here, claiming that
they "figured out" patch-based review on top of git without change-ids
is not accurate.
