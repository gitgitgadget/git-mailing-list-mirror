Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619DC3EA8D
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 00:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764030512; cv=none; b=JBbMW0cBiTQPSQTUBl0D7xMFEvuZlnbnIzJLkdOkSfeK51OiuVAUvtzwdNQt/j8taaIdeYon1VH4Ed2QLr2Vk7ZaFPgGUUCFqbMsXAvKwgmb4AtJaEb2xCi/xoEuZdiV9Lv5CzvQsYXyy75gefZNn1LSp63YXq1BmvyfLSNcdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764030512; c=relaxed/simple;
	bh=z3m4V/j/H2vI+quOxOEoEkb+kZ1cLiRp3Nuq4IfyT/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3prkruXfHx9AoXgeC7DTMfjff7WazXEK3mz+aju9HSx64DBiAadMjvB50UgjK+PrwVBuOvhLZRJMtJWkJ3+t7rPxi8Qdgg6oRZoTLfO6O/6yYb17pUWifIzZvqcC2MHTtCNPuQ7+UT27sERsHM4iXBre8tcasJJ9bLBmMsEjPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QpyowTiQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QpyowTiQ"
Received: (qmail 92207 invoked by uid 109); 25 Nov 2025 00:28:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=z3m4V/j/H2vI+quOxOEoEkb+kZ1cLiRp3Nuq4IfyT/c=; b=QpyowTiQ/9D+4c6pd44ZL4HSvL7mWCW9aFAln6BB5zgvD53HZNmJxWhWNjBXRkd7ynKFrhCb8kc9qguzg9OzGeTWwkUEDSyghJYvRT75Clwu1swXoqj2d++jfgjROnHFkMIq9+YM5fzKf3SBeBZPjpeuITCRAdv+NhGfTvNFlZ+zMCOQXfW7VSDPHZ3Uzo9sBRlTC8QpdiD9oETZUNp6StBwsFjxypF1hvKI95tGu3oXHVIf8/bFU1hZDFEwrddk46s+U7kADYwlyaP7eoIFlZphR/k3BM8q7xlPgLIHUpr4BfCC31EQVHRX7ugFp3r3sCcuqdDCdLk+7w1SX6s8rw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Nov 2025 00:28:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 157554 invoked by uid 111); 25 Nov 2025 00:28:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Nov 2025 19:28:32 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Nov 2025 19:28:28 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Han Jiang <jhcarl0814@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: `git config get --type=path` results in segmentation fault on
 value starting with `:(optional)`
Message-ID: <20251125002828.GA2353309@coredump.intra.peff.net>
References: <CANrWfmQUuGKWPc6JCzeCaa9t98ag_Lyk0G_Prtd8YmqP-TiRpg@mail.gmail.com>
 <20251120075019.GA1283645@coredump.intra.peff.net>
 <xmqq1pls8xeu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1pls8xeu.fsf@gitster.g>

On Thu, Nov 20, 2025 at 08:46:17AM -0800, Junio C Hamano wrote:

> > I put a [*] above on "more or less does the right thing" because there's
> > another corner case, even for callers like commit.template. What should
> > this:
> >
> >   [commit]
> >   template = :(optional)does-exist
> >   template = :(optional)does-not-exist
> >
> > With the current code, we will ignore the second config entry entirely,
> > and the result will point to "does-exist". But that feels surprising to
> > me.
> 
> The documentation says
> 
> 	If prefixed with :(optional), the configuration variable is
> 	treated as if it does not exist, if the named path does not
> 	exist.
> 
> and when I wrote it, by "the configuration variable", I meant the
> second "template = ..." line above, not the configuration variable
> commit.template, that the machinery pretends not to exist.  So the
> result pointing at does-exist matches my expectation.

I confess that I did not read the documentation at all, and was only
going on what I'd expect ":(optional)" to do. So you can take what you
will from that. ;) It does feel to me like the user-facing behavior is
driven by ease of implementation, not what users would necessarily want.
But it probably is not worth revisiting at this point (especially
because it is kind of a corner case for the distinction to matter at
all).

(I do agree that the documentation you quoted clearly covers the current
behavior).

> > I kind of wonder if git_config_pathname() ought to be returning more
> > data to the caller, like:
> >
> >   struct config_pathname {
> > 	char *path; /* never NULL */
> > 	unsigned missing : 1;
> >   };
> >
> > That would change the interface of git_config_pathname(), but that would
> > also force us to make the appropriate changes in each caller.
> 
> The problem is that there is no mechanism for the function to say
> "success" without setting *dest to the discovered value.  We could
> introduce multiple kinds of "failure", and have callers react to the
> differences, but then it is like setting NULL in *dest and having
> callers react to it, so I am not sure how much benefit we would be
> gaining by changing its interface.

In my mind, we'd still return "0" as long as there was any string at all
(i.e., the only error is the non-bool case). And then the caller would
have to pick the results out of the struct above. I agree that setting
*dest to NULL is mostly equivalent to what I'm proposing. The main
advantages of the struct are:

  1. The caller gets to actually see what the value is. This may or may
     not be useful for stuff like format_config(). See below.

  2. The interface change is a feature, since it requires examining and
     updating each caller (enforced by the compiler).

     It looks like you already produced a patch to update the existing
     callers, and I'll assume you caught them all. It does leave any
     topics-in-flight potentially buggy, though. As somebody who used to
     maintain a long-running fork, and who has a years-long backlog of
     random topics, I do not consider "all of the branches in
     gitster/git.git" to necessarily be all topics in flight. ;)

     (I did check all of my topics and didn't have any new callers,
     though).

> On the other hand, builtin/config.c::format_config() probably needs
> a richer set of return values.  When used from collect_config(), it
> needs to be able to say "no, pretend that the key/value pair you fed
> me did not exist" in addition to "that value is bogus---you have an
> error (e.g., config_error_nonbool())".

I was thinking that we might need some way for format_config() to show
the original value (minus the ":(optional)" meta-tag). The same way that
we may show include.path both as its own config variable, and as a
mechanism that triggers an include. I.e., would somebody ask git-config
about "commit.template" not as a path, but as a string?

But the way to do that is to avoid saying "--type=path" in the first
place, and get the full string (including the optional tag). If we had
some kind of "--type=path --show-missing-paths" option, then we'd need
to be able to see the missing name (like my struct proposal above). But
we don't, and nobody is asking for it, so I think we can punt on it for
now.

I did wonder also if format_config() would need to roll back any output
for something like:

  git -c foo.bar=':(optional)/no-such-file' \
    config --type=path --get-regexp --show-scope foo.bar

which would show the key name and scope before even looking at the
value. But because we assemble it all in a strbuf, we can just throw
away the result.  And it looks like your patches handle that. It doesn't
look like the tests cover it, though.

Looks your topic isn't in 'next' yet, so possibly squash this in?

diff --git a/t/t1311-config-optional.sh b/t/t1311-config-optional.sh
index 766693387f..fbbacfc67b 100755
--- a/t/t1311-config-optional.sh
+++ b/t/t1311-config-optional.sh
@@ -18,7 +18,9 @@ test_expect_success 'var=:(optional)path-exists' '
 
 test_expect_success 'missing optional value is ignored' '
 	test_config a.path ":(optional)no-such-path" &&
-	test_must_fail git config get --path a.path >actual &&
+	# Using --show-scope ensures we skip writing not only the value
+	# but also any meta-information about the ignored key.
+	test_must_fail git config get --show-scope --path a.path >actual &&
 	test_line_count = 0 actual
 '
 

-Peff
