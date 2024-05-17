Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57FC13DB83
	for <git@vger.kernel.org>; Fri, 17 May 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715966094; cv=none; b=nGpGOE7mFvy0kx2hYp6YjNw3nDvUYWSbXBf49q5wZoBihf0o448chIThrNC71cZGGCj8P1Ojmma5wLqJe5w6LC42ZQEi3CGjFinaX+phx6TEikc4v6cq+kdg8esky14wLJQSFJe8cWbm88Bg4paADbFzrFphujrY7A0OlS/uJrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715966094; c=relaxed/simple;
	bh=+r1eErqE+u8q4NABSYVVt8iSxffen4la3RTSn2xlXSc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X6Am7xKY642b2WyzbzyzCJ3NinUocXAsaoPSLLagoSxMjgPDhfgJu/pqs2jK6ghUYy7DlofHohSq8h6ohS/bZGdm215Y7TkqbdDqF3HriyIQWA57/cBg4ca7IepTrXIgqcHTPQCJqHUb3MLcdbfdu4oqSxEslf4X0vu1/Xqlbnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=a+iXMxxf; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a+iXMxxf"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3EA302F52F;
	Fri, 17 May 2024 13:14:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=+
	r1eErqE+u8q4NABSYVVt8iSxffen4la3RTSn2xlXSc=; b=a+iXMxxfk3oRkA2o4
	HrIHVVTnTEHpRMUCQVy1y6cTn2uQVMV/n1z04gEd3MAJSVxOmPA4Z6SIWEPHiraq
	Qx1kM79egnUBCnsuXqq7lWxg3WQ2n2+pjjEHyVIlI/+daaF72PlTHXIM7xl94Os3
	HFPeaniP44AF+J3dLGcZdgEmHI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 372FB2F52E;
	Fri, 17 May 2024 13:14:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A8C862F52D;
	Fri, 17 May 2024 13:14:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] diff: document what --name-only shows
Date: Fri, 17 May 2024 10:14:46 -0700
Message-ID: <xmqqeda0jr7d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F68C84C8-1470-11EF-82C3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

The "--name-only" option is about showing the name of each file in
the post-image tree that got changed and nothing else (like "was it
created?").  Unlike the "--name-status" option that tells how the
change happened (e.g., renamed with similarity), it does not give
anything else, like the name of the corresponding file in the old
tree.

For example, if you start from a clean checkout that has a file
whose name is COPYING, here is what you would see:

    $ git mv COPYING RENAMING
    $ git diff -M --name-only HEAD
    RENAMING
    $ git diff -M --name-status HEAD
    R100	COPYING	RENAMING

Lack of the description of this fact has confused readers in the
past.  Even back when dda2d79a ([PATCH] Clean up diff option
descriptions., 2005-07-13) documented "--name-only", "git diff"
already supported the renames, so in a sense, from day one, this
should have been documented more clearly but it wasn't.

Belatedly clarify it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * In the "how about this" patch, I incorrectly said "before tree",
   in an failed attempt to use fewer jargon, but it was misguided.
   The names are taken from the post-image (i.e. "after") tree, and
   we already use post-image in the same document.

   Also this version uses a bit of grammar trick to rephrase so that
   it is clear that we are talking about a single changed file
   having up to two names by mentioning "each changed file".  That
   way, the phrasing strongly hints that "--name-only" shows only
   the name in the post-image tree while "--name-status" may show
   both names.

 Documentation/diff-options.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7d73e976d9..0c456dfd0c 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -318,12 +318,13 @@ explained for the configuration variable `core.quotePath` (see
 linkgit:git-config[1]).
 
 --name-only::
-	Show only names of changed files. The file names are often encoded in UTF-8.
+	Show only the name of each changed file in the post-image tree.
+	The file names are often encoded in UTF-8.
 	For more information see the discussion about encoding in the linkgit:git-log[1]
 	manual page.
 
 --name-status::
-	Show only names and status of changed files. See the description
+	Show only the name(s) and status of each changed file. See the description
 	of the `--diff-filter` option on what the status letters mean.
 	Just like `--name-only` the file names are often encoded in UTF-8.
 
-- 
2.45.1-204-gd8ab1d464d

