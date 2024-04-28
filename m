Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B7910A3B
	for <git@vger.kernel.org>; Sun, 28 Apr 2024 23:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714345640; cv=none; b=XZSdk2NlOgzSfkiSRyaR8a5PFrK5xn0QgZrntg2V+7TLfrtJDXYvB23bAXw9ObyYGAchOYdXRYYRtGpSgo6dgVGFylHJw+PDfrhvWfV0wzwdfpKMkpX3xugR7ixd6Tbb1ancOSAM0tNjRfEVOvspoKucdoUT6kg2+HRr1rAmF9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714345640; c=relaxed/simple;
	bh=jleAAB3ICdOYDARna3y+zWnM9ZNtCXRhvsC/ylP1J94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DTeX+7tuyoI4W+RQefO7UrkBZI4F4nQrUxb6od6oAbi2+rgcioxR0prqXl7OR1c4QL3pU7iKiz2yHRN5Xl49k2CvrQizpW+e8Ib72CdKBCa7rfNqZGZyud/cVKaDWxf9HJn04ACODvRDMfXL7ZVZxr4i3JBrtXZ/u1xpTmMDOqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=D7MFTWbi; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D7MFTWbi"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 782F630C14;
	Sun, 28 Apr 2024 19:07:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jleAAB3ICdOY
	DARna3y+zWnM9ZNtCXRhvsC/ylP1J94=; b=D7MFTWbi5Ma4h6SKPeufQhvN68+w
	hiudT6Glm7kj/9gQ1vrnMucucdecPxNT3KKqjietr1QV/e/jC6zvHNSPuvGcZrlN
	5gqJLT1glxkLYRBtJ2l00m5qmkwkSj3z2kPxx+1WmouBR/rgAI1IgesS6QjeCvpN
	+7G0mxGB6q2Y8y0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7149A30C13;
	Sun, 28 Apr 2024 19:07:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DAE6430C12;
	Sun, 28 Apr 2024 19:07:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Toru Okugawa <castor.4bit@gmail.com>,  git@vger.kernel.org
Subject: Re* Unexpected behavior with the rev-parse operation
In-Reply-To: <CAPig+cQ39Z+WjThqkxCKgOUfkZyB6PG-6RhHBYhinp-ZY4dxKA@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 28 Apr 2024 14:08:47 -0400")
References: <CANHPH1-6mbWdt_FLsrDEB_XVb4r3yTYMLLPUyDrL6tmS7jZgqQ@mail.gmail.com>
	<CAPig+cQ39Z+WjThqkxCKgOUfkZyB6PG-6RhHBYhinp-ZY4dxKA@mail.gmail.com>
Date: Sun, 28 Apr 2024 16:07:11 -0700
Message-ID: <xmqqedap2ijk.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 0CD24FA4-05B4-11EF-9D52-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Apr 15, 2024 at 9:58=E2=80=AFAM Toru Okugawa <castor.4bit@gmail=
.com> wrote:
>> I have encountered some unexpected behavior with the rev-parse operati=
on.
>> ---
>> $ ls -a
>> .  ..
>> $ git rev-parse --is-inside-work-tree
>> fatal: not a git repository (or any of the parent directories): .git
>> ...
> ... This
> means it is your responsibility, as a script writer, to suppress or
> capture the error message (whichever is appropriate for your case).
> For instance:
>
>     if test git rev-parse >/dev/null 2>&1
>     then
>         echo "in a Git directory or repository"
>     else
>         echo "not in a Git directory or repository"
>     fi

All true.  It may however need some documentation updates, though,
something along this line, perhaps?

 Documentation/git-rev-parse.txt | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git c/Documentation/git-rev-parse.txt w/Documentation/git-rev-pars=
e.txt
index f9d5a35fa0..a62d798744 100644
--- c/Documentation/git-rev-parse.txt
+++ w/Documentation/git-rev-parse.txt
@@ -18,8 +18,16 @@ Many Git porcelainish commands take a mixture of flags
 (i.e. parameters that begin with a dash '-') and parameters
 meant for the underlying 'git rev-list' command they use internally
 and flags and parameters for the other commands they use
-downstream of 'git rev-list'.  This command is used to
-distinguish between them.
+downstream of 'git rev-list'.  One purpose of this command is to
+allow calling programs to distinguish between them.
+
+There are a few other operation modes that have noting to do with
+the above "help parse command line options" added to the command.
+
+Unless otherwise specified, most of the options and operation modes
+require you to run this command inside a git repository or a working
+tree that is under control of a git repository, and will give you a
+fatal error otherwise.
=20
=20
 OPTIONS
@@ -32,11 +40,15 @@ Each of these options must appear first on the comman=
d line.
=20
 --parseopt::
 	Use 'git rev-parse' in option parsing mode (see PARSEOPT section below)=
.
+	The command in this mode can be used outside a repository or
+	a working tree controlled by a repository.
=20
 --sq-quote::
 	Use 'git rev-parse' in shell quoting mode (see SQ-QUOTE
 	section below). In contrast to the `--sq` option below, this
 	mode only does quoting. Nothing else is done to command input.
+	The command in this mode can be used outside a repository or
+	a working tree controlled by a repository.
=20
 Options for --parseopt
 ~~~~~~~~~~~~~~~~~~~~~~
