Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S47wXs/f"
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556C2DD
	for <git@vger.kernel.org>; Tue, 21 Nov 2023 17:42:55 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a0064353af8so72784366b.0
        for <git@vger.kernel.org>; Tue, 21 Nov 2023 17:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700617374; x=1701222174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTdGJ92t8A1xKjvgP9cs12gWE7B5/XnSG5LgkHYMUcI=;
        b=S47wXs/fJdIbNH3cx5KKV4sIur9+WzE7UjFfDAilwcg0O33axUIWT1CHWdy/QPMUYx
         eiZTRX4VUx/p92mQwqrBrq0KZcmUdg/M6Xd9LBQq4qOkw0r1vL3Z96+4RHy4TDI7KxM1
         TP9rUC86y1qRaGOdkZE43E7wrDsgO/vZiPMqdNFKyoPzemFj1zqJyry0ZyNfW/YoM2kX
         wxqYDf0cP5luW+PJkdaSPUtyHm3j1Q3muRpHlekwOYJy51rnoy7/gA1fYCcmCZmwAwEW
         JcUzUIUHO/7CeoGYd+DyiQ7eGe4J5s78Y9PoG50U3R4tnGPk8D0bqxd7e5Qu64bgLP96
         yTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700617374; x=1701222174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dTdGJ92t8A1xKjvgP9cs12gWE7B5/XnSG5LgkHYMUcI=;
        b=JjRnviDy2EKWvCEegLfXEItFlXPgjn7yPeBPJUsUzo0Ggf4xUxCz0ClXO7Jv68xGoL
         kgzWm/2fnC015Y1UFtptPOxvZAmPRfHDQobg1ukxOxPlXuGyU5bFP0Sc4B621RnaLQxb
         Ib52A13T371g4W/wDzZmf/B62CsSLHuaMJ5wnlUv/bAg2ZZN4+tE4pU5OmvADqagQ0Wr
         sneU0JVJvUQnmuus35FSO69I9xSP69PeZswaGcXrATVi4Xofh0H2S1XyO6f8CVNlHpOI
         wHufoZevyM5GPo9LBpaDASo0kBdFexioYTUUCo/oA+UcEhnVr+Si4seHUxMavw4VapTT
         711Q==
X-Gm-Message-State: AOJu0YyIoVAdR7g03IeV2KI4GJITMiBqu8g9EhS9/jRNwpt0GZQkbzMe
	Zr4s8lmEKLMI4BPbgZPIQayo4dQtrCksL86amLJuNp/ESkg=
X-Google-Smtp-Source: AGHT+IGv9h+NXVkgyuEDYgFBGp6387s4//H1Sl7dDD3HT9kyN0rlFe8JGTSbfzes7W0s6+C/sXf7WLhRNT957eaBCdY=
X-Received: by 2002:a17:906:d7:b0:9f4:53d9:2d66 with SMTP id
 23-20020a17090600d700b009f453d92d66mr576678eji.5.1700617373425; Tue, 21 Nov
 2023 17:42:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <FE2AD666-88DE-4F70-8D6D-3A426689EB41@me.com>
In-Reply-To: <FE2AD666-88DE-4F70-8D6D-3A426689EB41@me.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Tue, 21 Nov 2023 17:42:42 -0800
Message-ID: <CAPx1Gvf_meaEBq9XfS9aPg0yLja-2sAW5SUg0jx6f1jNyfmWHw@mail.gmail.com>
Subject: Re: Orphan branch not well-defined?
To: Craig H Maynard <chmaynard@me.com>
Cc: Git Community <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 4:36=E2=80=AFPM Craig H Maynard <chmaynard@me.com> =
wrote:
> [git checkout and git switch treat --orphan differently]
>
> Leaving aside the question of whether or not this is a bug,

Just to answer the implied question: this is intentional.

> there doesn't appear to be any formal definition of the term "orphan bran=
ch"
> in the git documentation. Am I missing something?

Whether it's documented anywhere or not, it's not done well. This is
not surprising: It is hard to do it well!  Git uses two phrases for
this: "orphan branch" and "unborn branch". To understand them
properly, let's start at the real beginning.  Bear with me for a
moment here.

In Git, the identity of a commit -- the way that Git locates the
commit internally -- is its hash ID.  (Aside: until the SHA-256
conversion, therewas only ever one hash ID for any commit ever made
anywhere.  Now that Git supports both SHA-1 and SHA-256, there are two
possible IDs, depending on which scheme you're using.)  It's possible,
at least in theory, to use Git without ever creating a branch name:
all you have to do is memorize these random-looking hash IDs.  But
that's not how people's brains work, and it's quite impractical.  So
Git offers us branch names, like "main" or "master", "dev" or
"develop", and so on.

In Git, a branch name is just a human-readable name for one of Git's
internal hash IDs, with a special and very useful property that
distinguishes it from a tag name.  Each tag name is a human-readable
name for a hash ID too; they just lack the special property of the
branch names.  We won't get into all the properties here though, and
for the moment, we just need to know that the name stands in as a
memorable version of the ID.

As a result, a Git branch name literally cannot exist unless it
identifies one specific commit!  We call that one specific commit the
"tip commit" of that branch (which introduces a whole new confusion,
of whether a "branch" is *one commit* or *many commits*, but again we
won't get into this here).

This leaves us with a big "chicken or egg" problem
(https://en.wikipedia.org/wiki/Chicken_or_the_egg).  Suppose we've
just created a new, empty repository, which by definition has no
commits in it: it's *new*, and *empty*.  How many branch names can we
have in this new, empty repository?  We've just claimed that a branch
name must identify some specific commit, and we have no commits, so
the answer is: none.  We cannot have any branch names at all.

But -- here's the other paradox -- whenever we make a *new* commit,
it's to be *added on to the current branch*.  But we have an empty
repository, which cannot have any branch names, so how do we know what
the "current branch" even *is*?

** Unborn Branch is the better term **

Now that we understand the basic problem -- that a new repository
can't have any branches, but that we want Git to *create* a branch
when we make that very first commit -- we can see what an "orphan" or
"unborn" branch is all about.  It papers over our chicken-or-egg
problem.  We simply save the *name we want Git to create* somewhere,
then we make a new commit as usual.  When, eventually, we do make that
commit, Git says: "OK, I should add this new commit to the current
branch br1", or whatever the name is.  Git then creates the new commit
*and* creates the branch name, all as one big operation.  Now the
branch exists: it's born.

When we have a normal (not-unborn) branch and create a new commit, Git
creates the new commit as usual and then -- here's the unique property
of *branch names* that makes them so special -- *updates* the branch
name to hold the new commit's new hash ID.  Git also makes sure that
the new commit we just made links back to the commit that *was* the
tip commit of the branch, just a moment ago.  So this is how branches
"grow" as you make commits.  The *name* holds only the *last* commit
hash ID.  Each commit holds the *previous* hash ID, so that Git can
start at the end of a branch and work backwards.  The previous, or
parent, commit, has its own parent, which has another parent, all the
way back to the beginning of time.

This is also where the dual meaning of "branch" clears up somewhat: a
branch is both the tip commit *and* the whole-chain-of-commits,
starting at the tip and working backwards.  How do we know which
meaning someone means?  Sometimes it's clear from context.  Sometimes
it's not clear.  Sometimes whoever used the word isn't even aware of
the issue!

** The `--orphan` options **

That weird problematic state for a *new* repository, where no branches
can exist, yet you want to be "on" the branch you're going to create,
only exists as a problem for a new and empty repository.  But given
that Git has to solve that problem, Git can let you enter that weird
state any time.  That's what `--orphan` was originally invented for:
to go back into that state even if you have some commits.

That is, `git checkout --orphan` meant: make the current branch name
be an unborn branch, the way it is in a new and totally-empty
repository.  Then when I make my next commit, that will create a new
commit that has no parent commit.  Whether (and when and how) this is
actually useful is another question entirely, as is the reason for
switch and checkout behaving differently in terms of how they treat
the index and working tree.  But this is the heart of the option: it
means "go into the unborn branch state".

(Side note: there are other ways to solve the "new repository"
problem, and there are other ways to define "branch".  Other version
control systems sometimes use other ways.  Git's rather peculiar
definition of branch was rare, perhaps even unique, in the early days
of Git.)

Chris
