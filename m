Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453777E79E
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116018; cv=none; b=mwiBU3vr7IErFVasDgaG+KOIayZ2cupCiUDwjQ+T6ZA3lWZlUatCJ3BKlDZ9W+qjudPYXza2tchBFhEuFsirhxF41XAuSkIW+k+8wZoWBokLQgOko8G+/NWk3N89SW8SpBxdrgdsGs/bkuOqwDHqFL4rdHlrAo3gHdSomDKib8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116018; c=relaxed/simple;
	bh=buzP2BuiNMiBNAX5r5t332Ag/kg+9ssPr/s3BmflccA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZqxrAiRichNJHugR+pHeEcy/ZGycDF/l46g7StexWycYNthWHhqw63x7ktauFGIISzX5FsRwNSmdhwb7P24lLIHVAPzK+iYFGdUBtmp30QsUDSeXa2oSB9OjYIQrKF5ITP9f8M1PnRz9PWjTKI7np0tawDZkRAqa3oYAMO0cozY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=C89e+uod; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C89e+uod"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AAC9F1D9C37;
	Wed, 24 Jan 2024 12:06:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=buzP2BuiNMiBNAX5r5t332Ag/kg+9ssPr/s3Bm
	flccA=; b=C89e+uodRM205sOHy0GAWuEQYOcNJpyx5E+9X7Vu6T99gYK6hVy/iS
	/yEDOSGG5VKk1HO2MPhVIhNauqR3uIz0wtWzMmsiwDv6cQbc8dlTMtCYR9bGDulA
	6iAi0IvO44ucFpV4NVoKwWii+CdFO8I/3lvann/j2FIw9hw6UEJiE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A22711D9C36;
	Wed, 24 Jan 2024 12:06:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C6C11D9C35;
	Wed, 24 Jan 2024 12:06:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Jeff King <peff@peff.net>,  =?utf-8?B?UmHDumwgTsO6w7Fleg==?= de Arenas
 Coronado
 <raulnac@gmail.com>,  git@vger.kernel.org
Subject: Re: Fwd: Unexpected behavior of ls-files command when using
 --others --exclude-from, and a .gitignore file which resides in a
 subdirectory
In-Reply-To: <CABPp-BHcdn3+mbPJk8LZvMjPWZ4s-xdUyevrMbgbT4yQpJ_umA@mail.gmail.com>
	(Elijah Newren's message of "Tue, 23 Jan 2024 18:58:51 -0800")
References: <CAGF1KhWNaO_TUuCPo2L_HzNnR+FnB1Q4H6_xQ2owoH+SnynzEg@mail.gmail.com>
	<CAGF1KhWiYX=3R01Odj2yCNgvx=f5+HRCjRJogWf5eBikuATCcg@mail.gmail.com>
	<20240122213410.GA811766@coredump.intra.peff.net>
	<xmqq1qa9rqji.fsf@gitster.g>
	<20240122215954.GA813833@coredump.intra.peff.net>
	<CABPp-BHcdn3+mbPJk8LZvMjPWZ4s-xdUyevrMbgbT4yQpJ_umA@mail.gmail.com>
Date: Wed, 24 Jan 2024 09:06:51 -0800
Message-ID: <xmqqjznyhd90.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F88C9F50-BADA-11EE-90FB-25B3960A682E-77302942!pb-smtp2.pobox.com

Elijah Newren <newren@gmail.com> writes:

> It can also imply that a feature, design, or practice will be removed
> or discontinued entirely in the future.
> ```
>
> Since "can also imply" != "does also imply", and based on the commit
> message of 491a7575f (particularly the part that quotes dcf0c16ef1,
> both of which were prior work that informed the under discussion
> e750951e74), I thought the use of deprecated was perfectly applicable
> here.

I think we've seen confusions before, more than just once in the
past, caused by the verb "deprecate" in our docs.  People, after
reading "X is deprecated; use Y instead", always assumed that X will
eventually be removed, even in contexts where we did not mean it.

------ >8 ----------- >8 ----------- >8 ----------- >8 ------
Subject: ls-files: avoid the verb "deprecate" for individual options

When e750951e74f updated the documentation to give greater
visibility to the --exclude-standard option, it marked the
`--exclude-per-directory` option as "deprecated".  While it
technically is correct that being deprecated does not necessarily
mean it is planned to be removed later, it seems to cause confusion
to readers, especially when we merely mean

    The option Y can be used to achieve the same thing as the option
    X, so to those of you who aren't familiar with either X or Y, we
    would recommend to use Y.

This is especially true for `--exclude-standard` vs the combination
of more granular `--exclude-from` and `--exclude-per-directory`
options.  It is true that one common combination of the granular
options can be obtained by just giving the former, but that does not
necessarily mean a more granular control is not necessary.

State why we recommend looking at `--exclude-standard` when we do so
in the description of `--exclude-per-directory`, instead of saying
that the option is deprecated.  Also, spell out the recipe to emulate
what `--exclude-standard` does, so that the users can give it minute
tweaks (like "not reading the global exclusion file from core.excludes").

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-ls-files.txt | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git c/Documentation/git-ls-files.txt w/Documentation/git-ls-files.txt
index f65a8cd91d..93a0111cfb 100644
--- c/Documentation/git-ls-files.txt
+++ w/Documentation/git-ls-files.txt
@@ -119,8 +119,10 @@ OPTIONS
 
 --exclude-per-directory=<file>::
 	Read additional exclude patterns that apply only to the
-	directory and its subdirectories in <file>.  Deprecated; use
-	--exclude-standard instead.
+	directory and its subdirectories in <file>.  If you are
+	trying to emulate the way how Porcelain commands work,
+	using the `--exclude-standard` instead is easier and more
+	thorough.
 
 --exclude-standard::
 	Add the standard Git exclusions: .git/info/exclude, .gitignore
@@ -298,9 +300,8 @@ traversing the directory tree and finding files to show when the
 flags --others or --ignored are specified.  linkgit:gitignore[5]
 specifies the format of exclude patterns.
 
-Generally, you should just use --exclude-standard, but for historical
-reasons the exclude patterns can be specified from the following
-places, in order:
+These exclude patterns can be specified from the following places,
+in order:
 
   1. The command-line flag --exclude=<pattern> specifies a
      single pattern.  Patterns are ordered in the same order
@@ -322,6 +323,19 @@ top of the directory tree.  A pattern read from a file specified
 by --exclude-per-directory is relative to the directory that the
 pattern file appears in.
 
+Generally, you should be able to use `--exclude-standard` when you
+want the exclude rules applied the same way as what Porcelain
+commands do.  To emulate what `--exclude-standard` specifies, you
+can give `--exclude-per-directory=.gitignore`, and then specify:
+
+  1. The file specified by the `core.excludesfile` configuration
+     variable, if exists, or the `$XDG_CONFIG_HOME/git/ignore` file.
+
+  2. The `$GIT_DIR/info/exclude` file 
+
+via the `--exclude-from=` option.
+
+
 SEE ALSO
 --------
 linkgit:git-read-tree[1], linkgit:gitignore[5]
