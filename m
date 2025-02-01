Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1A422EE4
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 02:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738378457; cv=none; b=HX1GdTBmbGhPsPa0ciWDSqCNhB3cmop5YrChIoN5B9ERsrhv0bVsijG1BClCn1yJhbByoJ8lDLvuM1jZFxflwObml9Tz/5TbWr7v/eKK6xv+jrTqqLZDXuLWHOrZGWy8GHG5TznpUQgJHnv+CQJeHTyS/6kHveSNqwNfBVunAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738378457; c=relaxed/simple;
	bh=cWKOJ8BeoGlgBhsZY0lk9hSdeR6sqblU6xtI4FushlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMlmad66nbzOUOLAc+a62SX44v6IQXj1DHbruAieXP7KZR2fEFEO+3T3uxwTYfSojro9pfFyv+HdCy4S+f066iG90QjXImvuQV0JKwuY5RzyRERHt3r1jbFkQdx0pbDA8SHzCZy54jeuMA4dnO7xUBUAv5+udPJNoZBzZM5BG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eGZh+V7L; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eGZh+V7L"
Received: (qmail 10186 invoked by uid 109); 1 Feb 2025 02:54:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cWKOJ8BeoGlgBhsZY0lk9hSdeR6sqblU6xtI4FushlE=; b=eGZh+V7LkgpEfi8sr/9ao31zOj6E/tYZMf2fFD7110emNQ8U9DGbHby8K+QQbRUC/Rbms1YtAVaNHen59Pq070kMtsKahmCiefy2obY23LcQ4X4evDVeAelMYPk9T52k2RgK562bCQXaaIf3592B7vKFRL7NtfgD0MfCzSXZCUONj7QzWLSn0xluIzh5k5hM57TraJkdkU1HEKTUiwb0GNMIqb3buqy9ZVNWozsQdAjAf+fpXyiuhilgm1vE8dsCVarrnz4cfbaZ8+/8OBjTCjyftarWCXHnSyHhS93hd1jQY8268wnTQBW60dQIj2caSYUUJKmPPBHiZ1+NvzlRAw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 01 Feb 2025 02:54:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8505 invoked by uid 111); 1 Feb 2025 02:54:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jan 2025 21:54:16 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 31 Jan 2025 21:54:13 -0500
From: Jeff King <peff@peff.net>
To: M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, stolee@gmail.com,
	Johannes.Schindelin@gmx.de, rsbecker@nexbridge.com,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] credential: warn about git-credential-store [RFC]
Message-ID: <20250201025413.GB4088801@coredump.intra.peff.net>
References: <pull.1856.git.1738352886190.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1856.git.1738352886190.gitgitgadget@gmail.com>

On Fri, Jan 31, 2025 at 07:48:06PM +0000, M Hickford via GitGitGadget wrote:

> From: M Hickford <mirth.hickford@gmail.com>
> 
> git-credential-store saves secrets unencrypted on disk.
> 
> Warn the user before they type their password, suggesting alternative
> credential helpers.
> 
> An alternative could be to warn in "credential-store store". A
> disadvantage is that the user wouldn't see the warning until after they
> typed their password, which is less helpful. The warning would appear
> again every time the user authenticated, which feels too frequently.

I certainly don't disagree that "store" is relatively insecure,
but...who are we trying to help here? We do not turn on "store" by
default, so anybody who is running it would had to have explicitly
configured it as a helper. And there's a big warning already at the top
of the manpage.

If we think it's so bad that we need to spam people with a warning, then
perhaps we should just remove it entirely. Or if people aren't seeing
the warning, can we call it "git-credential-plaintext" or something that
will make it more obviously not secure?

> -	if (!c->password)
> +	if (!c->password) {
> +		if (c->helpers.nr >= 1 && starts_with(c->helpers.items[0].string, "store"))
> +			warning("git-credential-store saves passwords unencrypted on disk. For alternatives, see gitcredentials(7).");
> +

As Junio noted, this won't catch "store" as the second helper. It would
also not catch "store --file=/path/to/store" or using a shell invocation
like "!git credential-store".

This location also won't notice that "store" will be passed credentials
provided by other helpers (not just ones from the terminal).

I think you'd have to put the warning in credential-store itself to hit
it reliably. If you wanted to avoid warning excessively, it could
probably notice when the stored entry was already there. As you note, it
will already have written the password, but the warning could advise on
how to delete it (yes, it will be on disk for a moment until they delete
it, but I think we are getting at diminishing returns of advice).

Alternatively, if we force a user to acknowledge a config option, then
they can't miss it. And we can put the check wherever we like, without
writing anything. Something like:

diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index e669e99dbf..6b6dca79b1 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -119,6 +119,14 @@ static void store_credential_file(const char *fn, struct credential *c)
 static void store_credential(const struct string_list *fns, struct credential *c)
 {
 	struct string_list_item *fn;
+	int allow = 0;
+
+	git_config_get_bool("credential.allowinsecurehelpers", &allow);
+	if (!allow) {
+		warning("yikes!");
+		/* probably also advise() how to set the config */
+		return;
+	}
 
 	/*
 	 * Sanity check that what we are storing is actually sensible.

That's a breaking change for people using credential-store, but you
could perhaps ease them into it with a "warn" mode (which they could
then squelch the warning by setting the option early). And then
eventually it defaults to refusing to store.

Again, if we are going this far, I kind of wonder if we should just
remove the helper.

-Peff
