Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91F12D20C
	for <git@vger.kernel.org>; Fri, 17 May 2024 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715961643; cv=none; b=r5uV4LCcWFTzUwew2dwgrI9ILEnVoXud3Zs95Ml2BEJebHUcRiHVcRFsvyqTzClmfNUb6mcqpHZIjnOg+UjpVKy6fhRqlhbLeXkDY7jJVgXXTndSvH/VSVd4s2GwcGlNBV43Kv8Wv7D/yNc+pkBIyrmA03uwswHyIUIvbX/zSXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715961643; c=relaxed/simple;
	bh=sOFt2m+YGEp7xN7k9wsQGmSVXz5g/Oo0Jg3hhiKgAII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XTrDjA9ys2MU9PYbF4n0p3yBMrw6DEjz0WhzcKHCvZhY0AIzNZUQOtrq+b0G9yeiP6WH6wWzs2d6cuE14i42KU2oSSaYdRUcU7LbD6qhz6uEknaKuLf9mAjZP34tOguhKlKNbUDpMU+Rq1JSkJ8W539ft8DJwNOYlRfW8kmDKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FKpli5jY; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FKpli5jY"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 09BB22ECC3;
	Fri, 17 May 2024 12:00:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sOFt2m+YGEp7xN7k9wsQGmSVXz5g/Oo0Jg3hhi
	KgAII=; b=FKpli5jYGg7q6sCOF2ckAmtfZgHhjjpdpassC/OBDN33X4xabyTWTt
	yJ9okEsjSB2OM30F9WQO7HuOHPW1tqfqQdrgsaOi2uS1KrQVAGGt+DGDxLHo7wiw
	LMDhcGK6FuZthyiIZnyH8gD4LZ1xmZVMCUPyt6szl/m1c3MsSOax8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0219D2ECC2;
	Fri, 17 May 2024 12:00:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 786472ECC1;
	Fri, 17 May 2024 12:00:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Nathan Faulkner <natedogith1@gmail.com>
Cc: Ed Avis <ed.avis@qmaw.com>,  Philip Oakley <philipoakley@iee.email>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re*: git log --name-only improvement: show old file name in rename
In-Reply-To: <c239ab15-4d48-4328-8bd5-8e2d77163e03@gmail.com> (Nathan
	Faulkner's message of "Thu, 16 May 2024 19:13:34 -0400")
References: <BL0PR11MB3460BEB60550854661B5178B9D800@BL0PR11MB3460.namprd11.prod.outlook.com>
	<xmqqsgf1i46l.fsf@gitster.c.googlers.com>
	<25ca66fb-82bc-7278-90e9-5e1999593068@iee.email>
	<xmqqh7vg2p4p.fsf@gitster.c.googlers.com>
	<BL0PR11MB34608AE271344D508676D17A9D9C0@BL0PR11MB3460.namprd11.prod.outlook.com>
	<c239ab15-4d48-4328-8bd5-8e2d77163e03@gmail.com>
Date: Fri, 17 May 2024 09:00:29 -0700
Message-ID: <xmqqv83cl97m.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 96729974-1466-11EF-91B5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Nathan Faulkner <natedogith1@gmail.com> writes:

> The documentation for --name-only says "Show only names of changed
> files." I would interpret this to mean "output the names of all files
> that changed", not "output the names of all files that changed, unless
> git detected it as renamed".

Interesting observation, but we do show renamed files no?  Even when
there is no content changes?  A quick experiment tells me it does,
so "unless" is not quite correct.

    $ git mv COPYING RENAMING
    $ git diff --name-only -M HEAD
    RENAMING
    $ git diff --name-status -M HEAD
    R100	COPYING	RENAMING

I think that the source of the confusion is actually not renames or
copies but that the explanation does not say in which commit the
phrase "only names of changed files" applies to.

The answer to that question is: Show names of the changed paths in
the post-image tree, i.e. if comparing 'diff A B' (or when 'show B'
is comparing 'diff B^ B'), the names in tree B are shown.

But because that is not explicitly said, a reader can easily mislead
into thinking that we are showing the union of names of files in
both pre-image and post-image trees that were modified.

We'd need something like this, probably.

------- >8 ------------- >8 ------------- >8 -------
Subject: diff: document what --name-only shows

The "--name-only" option is about showing the name of each file in
the post-image tree that got changed and nothing else (like "was it
created?").  Unlike the "--name-status" option that tells how the
change happened (e.g., renamed with similarity), it does not give
anything else, like the name of the corresponding file in the old
tree.

Lack of the description of this fact has confused readers in the
past.  Even back when dda2d79a ([PATCH] Clean up diff option
descriptions., 2005-07-13) documented "--name-only", "git diff"
already supported the renames, so in a sense, from day one, this
should have been documented more clearly but it wasn't.

Belatedly clarify it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/Documentation/diff-options.txt w/Documentation/diff-options.txt
index 0e9456957e..b9eaea32d9 100644
--- c/Documentation/diff-options.txt
+++ w/Documentation/diff-options.txt
@@ -329,7 +329,8 @@ explained for the configuration variable `core.quotePath` (see
 linkgit:git-config[1]).
 
 --name-only::
-	Show only names of changed files. The file names are often encoded in UTF-8.
+	Show only the name in the before-tree of changed files.
+	The file names are often encoded in UTF-8.
 	For more information see the discussion about encoding in the linkgit:git-log[1]
 	manual page.
 
