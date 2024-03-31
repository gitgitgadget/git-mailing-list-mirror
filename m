Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB9144D28
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711922935; cv=none; b=PIYOA8hk9N3Xc2KrsY5Q/fOqp2sjTp1M1kt2CZFd7QY/I4fQICuR4xh2VLIZY7oV2Tj2U87BYAhsM24EKnpJBHXt8MZQjjcGGlgbJgWs7jd7JCSXA92gvzOwpXC8Eq/enMgG9xTIXbHjp0e6yuDUhE9/JDMbsJQD98PXLIHfMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711922935; c=relaxed/simple;
	bh=+6P50BxVspzZJ8yt3vOO5hPYw3O0KP1bLUgTht7efTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AmKxcYAYemOAKmXdYRgQnWJCVg4pKMPkdU3DIms8H8vcY3liAWAsp1D7IYklP4hlQPIQXCtbwU/OKbVE7VjunQlTdsWXilWY+nDpfie3Yzy8L+tHHTB5yjMSgSSbqOrRq1/oVeDaSotVsprH+TuO0CTiedA3OPnZzplbrbGTCFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aOy8d3hE; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aOy8d3hE"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 140541E0132;
	Sun, 31 Mar 2024 18:08:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+6P50BxVspzZJ8yt3vOO5hPYw3O0KP1bLUgTht
	7efTk=; b=aOy8d3hEI8vqPa/jExoLTlUZLW9aDVh9pZLpIDh+EI0bKgLto7mbci
	yMXHgVUXiLWgYfleZq4UTYb8QrHTlyy02f4UEFm88PDIHkM5N91l8u3YEaCEeP/F
	4oSwtGLAdKgzGLAFX0vu/oOleCKfGz4eReu2fG76U5LgUvHrQ/K5w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BCF51E0130;
	Sun, 31 Mar 2024 18:08:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 126421E012F;
	Sun, 31 Mar 2024 18:08:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH 7/8] refs: add 'update-symref' command to 'update-ref'
In-Reply-To: <20240330224623.579457-8-knayak@gitlab.com> (Karthik Nayak's
	message of "Sat, 30 Mar 2024 23:46:22 +0100")
References: <20240330224623.579457-1-knayak@gitlab.com>
	<20240330224623.579457-8-knayak@gitlab.com>
Date: Sun, 31 Mar 2024 15:08:42 -0700
Message-ID: <xmqqy19yf40l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3DD6051A-EFAB-11EE-8B5A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
> index 0561808cca..2ea8bc8167 100644
> --- a/Documentation/git-update-ref.txt
> +++ b/Documentation/git-update-ref.txt
> @@ -65,6 +65,7 @@ performs all modifications together.  Specify commands of the form:

In pre-context, there is this entry.

	update SP <ref> SP <newvalue> [SP <oldvalue>] LF

Unrelated to this patch, we probably should say <new-value> and
<old-value> to follow the (recent) documentation guideline to write
multiple words concatenated with hyphen.

If we are updating these newvalue and oldvalue anyway, we may want
to update them to <new-oid> and <old-oid>, as the existing commands
on refs are about object names, and what we are adding here are not.

I would prefer to see such an update of existing documentation as a
separate preliminary clean-up patch, so that we can cleanly add the
"update-symref" that takes <new-symref-target> on top of a
cleaned-up base.

The <newvalue> ...

>  	create SP <ref> SP <newvalue> LF
>  	delete SP <ref> [SP <oldvalue>] LF
>  	verify SP <ref> [SP <oldvalue>] LF
> +	update-symref SP <ref> SP <newvalue> LF

... we are giving to "update-symref" is not an object name, but a
refname (i.e. the target of the symref at <ref> points at), so
"newvalue" -> "new-ref" or something is needed.

The semantics of this new command is not quite in line with the
existing commands.  Existing "update" and "delete" allow you to
optionally specify <old-oid> to make sure you do not overwrite
somebody else's update in the meantime.  Your "update-symref" lacks
such safety completely, which I doubt is a good idea in the context
of adding it to an existing set that has such safety features.  We
should at least offer the same "optional" safety.  That makes the
syntax more like

	update-symref SP <ref> SP <new-ref> [SP <old-ref>] LF

probably.

Existing "update" command can be used to create (by having "zero"
<old-oid>) and to delete (by having "zero" <new-oid>), but we still
have "create" and "delete" separately.  Given that we are teaching
the command to also work with symrefs by adding command(s) for
symrefs to an existing vocabulary, we should offer "create-symref"
and "delete-symref" for consistency between refs and symrefs.

It probably is a good idea to allow "update-symref" to also create
and delete a symref in similar ways with the existing "update"
allows creation and deletion of a ref.  An "zero" <old-ref> may be
an update that can happen only when the <ref> does not exist, i.e.,
creation, and an "zero" <new-ref> may be an update that makes <ref>
disappear.

"zero" value in the context of refs is a 0{40} object name (side
note: we have an explicit mention of 40 in the doc, which needs to
be updated eventually, probably outside this series).  But in the
new context of symrefs, a safe "zero" value needs to be picked
carefully.  An empty string may not work well syntactically
especially in the `-z` format, because you cannot tell if

	update-symref NUL HEAD NUL refs/heads/main NUL NUL

wants to say that <old-ref> is an empty string, or if it is missing.
As a refname cannot have a path component that begins with a dot,
a usable "zero" value for <new-ref> and <old-ref> may be a string
like ".missing", ".detached", and perhaps ".detached-f78d7...f2d4".

To summarize:

	update-symref SP HEAD SP refs/heads/main LF

forcibly sets HEAD to point at refs/heads/main without regard to the
current state of HEAD.

	update-symref SP HEAD SP .missing LF

forcibly removes HEAD symref without regard to the current state of
HEAD.

	update-symref SP HEAD SP refs/heads/main SP .missing LF

creates HEAD symref to point at the 'main' branch but fails if HEAD
already exists.

	update-symref SP HEAD SP refs/heads/main SP .detached LF
	update-symref SP HEAD SP refs/heads/main SP .detached-f78d7...f2d4 LF

creates HEAD symref to point at the 'main' branch but fails if HEAD
is not detached (or detached at the specified commit).

	update-symref SP HEAD SP refs/heads/main SP refs/heads/next LF

creates HEAD symref to point at the 'main' branch but fails if HEAD
is not pointing at the 'next' branch.

Hmm?
