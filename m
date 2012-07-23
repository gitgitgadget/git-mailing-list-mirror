From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] commit: give a hint when a commit message has been
 abandoned
Date: Mon, 23 Jul 2012 14:35:01 -0700
Message-ID: <7veho2jh4q.fsf@alter.siamese.dyndns.org>
References: <20120723184634.GA31905@sigill.intra.peff.net>
 <20120723185218.GC27588@sigill.intra.peff.net>
 <7vzk6qjj7w.fsf@alter.siamese.dyndns.org>
 <20120723205209.GA6745@sigill.intra.peff.net>
 <7vr4s2jiqk.fsf@alter.siamese.dyndns.org>
 <20120723211312.GA12533@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramana Kumar <ramana@member.fsf.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 23 23:35:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StQHZ-0004XH-1N
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 23:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137Ab2GWVfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 17:35:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38074 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753469Ab2GWVfE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 17:35:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44FF78602;
	Mon, 23 Jul 2012 17:35:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tckiSTgXUOKpq93kS1WcPg1qrpQ=; b=RW8JNX
	k2pxmAdS2VMqmco2m9W27waW+mxrD9qgbftOe4/p5isEQb/btJazJ/kn/inGvcMt
	WnnVU/IoKbLoZIPhmzyMvYIqPT623HUpgXFvAA/EOOYnRwgLTM5SRm00+kPbIkzY
	Ia1I7dPFhGd2LTtQcQp3FkV18r7R+yE2ZgHwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XPlNMBV9U8znvWTgaB6kGUgsqAD8Lluo
	ADd5Ya3JJL6jKtd2xTPOgL0I5ubtsJj/V/2wLbdY55UN9P0wjwC+G3WvU5ylcri9
	GXEUt3Gyveml5jMg8NlwANXX3jsUh6r+OOxb6G1JgGDoLQ9EFbQxiRg+YNJinr9P
	elYiQHHcoiw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 317718601;
	Mon, 23 Jul 2012 17:35:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F70E85FF; Mon, 23 Jul 2012
 17:35:02 -0400 (EDT)
In-Reply-To: <20120723211312.GA12533@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 23 Jul 2012 17:13:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42D462EC-D50E-11E1-B28C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201991>

Jeff King <peff@peff.net> writes:

> Here's a documentation patch.
>
> -- >8 --
> Subject: [PATCH] commit: document the temporary commit message file
>
> We do not document COMMIT_EDITMSG at all, but users may want
> to know about it for two reasons:
>
>   1. They may want to tell their editor to configure itself
>      for formatting a commit message.
>
>   2. If a commit is aborted by an error, the user may want
>      to recover the commit message they typed.
>
> Let's put a note in git-commit(1).
> ---
>  Documentation/git-commit.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index f400835..87297dc 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -407,6 +407,15 @@ This command can run `commit-msg`, `prepare-commit-msg`, `pre-commit`,
>  and `post-commit` hooks.  See linkgit:githooks[5] for more
>  information.
>  
> +FILES
> +-----
> +
> +`$GIT_DIR/COMMIT_EDITMSG`::
> +	This file contains the commit message of a commit in progress.
> +	If `git-commit` exits due to an error before creating a commit,
> +	any commit message that has been provided by the user (e.g., in
> +	an editor session) will be available in this file, but will be
> +	overwritten by the next invocation of `git-commit`.
>  
>  SEE ALSO
>  --------

Very sensible, modulo s/git-commit/git commit/ and lack of S-o-b.

I also wondered if something like the following might be useful, but
it probably falls into the "water under the bridge" category.

 builtin/commit.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 149e07d..83bcee4 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -768,6 +768,11 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				"with '#' will be kept; you may remove them"
 				" yourself if you want to.\n"
 				"An empty message aborts the commit.\n"));
+		status_printf(s, GIT_COLOR_NORMAL,
+			      _("The file '%s' keeps a copy of the log message\n"
+				"you edited, if you wish to inspect it later.\n"
+				"It will be wiped by the next invocation of 'git commit'.\n"),
+			      git_path("COMMIT_EDITMSG"));
 		if (only_include_assumed)
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 					"%s", only_include_assumed);
