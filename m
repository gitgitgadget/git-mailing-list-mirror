Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983522C35D
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015590; cv=none; b=c9BjrwniITwjUGDs5nZt0AGynMIkbXpqoqG0A97jmFmGhIFh5k3EExlYjZHI7Q5QkSVoCdmarteNhEbdU/CdDkrVmpHh7HjhkoGui/aPjyHYfuhlaSr3svVGgffiZmL2kd3nxg37YWErHzr9adTl4Q3MMT2xyYClvmJlRHAMXDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015590; c=relaxed/simple;
	bh=YGUstbTVM8DtF4DT0vlUoVnzIjPZYFg32vkOs3rceFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1ujPk7Qf8H3OIUgGmqk+CjPP70Cub38y8Hz3pGboEu1czG4tJim3Hgy6YLf8f3u9ALLC51jwMqrcnLggswX+lDiGldmKDnpqpuYPDqBoaEKD0VImzxwd+oknhw1OLYAxjRxebbdQ+Dzl1w5dCiQui9lG3ccKfbvpu1iZAlq8GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QpCZzdcz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QpCZzdcz"
Received: (qmail 17200 invoked by uid 109); 8 Jul 2025 22:59:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YGUstbTVM8DtF4DT0vlUoVnzIjPZYFg32vkOs3rceFE=; b=QpCZzdczk/YPgbWu046Xeof5DDRHSJqcXJZm7qLCZMI0kmN1JvEKWyWGIIVnth7cczMfpurZRJEKaSFCEjIoYEXbWGneGNVZJjFotQlM7/DMlCNtsrfhmfdpUR+tq25e4x8niL66LWncD8ava1hZSqabGT71FyCV/Pr1p2GuIi3lAxu5PAvAJZSc1VbdawzhTMXwf0fzcxWZhP7AvVI37SZnzGkLwmC9uQysqXgBa5HLQt+coWMbdeI0WqdZmRF9gZf8tFehrRt24qT6NOF6T3+XStfQ0CutAFdV+YZufxc1rw49ng3vGGZMNLGMSqz6UsQqy9fLKrAR2pINeurIBg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jul 2025 22:59:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30564 invoked by uid 111); 8 Jul 2025 22:59:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jul 2025 18:59:49 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 8 Jul 2025 18:59:46 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Per Cederqvist <ceder@lysator.liu.se>,
	git@vger.kernel.org
Subject: Re: [PATCH] remote: detect collisions in remote names
Message-ID: <20250708225946.GC1180568@coredump.intra.peff.net>
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
 <20250705165750.GA1951664@coredump.intra.peff.net>
 <20250705185842.GA2496172@coredump.intra.peff.net>
 <aGuP3Q5xykmRNp0m@pks.im>
 <20250707202801.GA3115893@coredump.intra.peff.net>
 <xmqqtt3n3e7g.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtt3n3e7g.fsf@gitster.g>

On Mon, Jul 07, 2025 at 02:04:19PM -0700, Junio C Hamano wrote:

> > IMHO we should probably avoid the underscore pattern. It's OK here, but
> > it runs close to violating the reserved names rules (a global variable
> > variable _name is bad, and _Name anywhere is bad).
> 
> "name_" is available.  In fact I think it is a very common pattern
> in this codebase to name an incoming parameter with trailing "_",
> and assign it to a local variable with the right name and with the
> right type at the top of the function.

Yeah, that is legal and is a pattern we use (though I admit that I find
any underscores kind of ugly and easy to miss). I was curious how often
each pattern appeared:

  ["v" prefix: vdata, va, etc]
  $ git grep 'void \*v' '*.c' | wc -l
  51

  [leading underscore: _data, _a, etc]
  $ git grep 'void \*_' '*.c' | wc -l
  52

  [trailing underscore: mostly a_, b_ in comparators]
  $ git grep 'void \*[a-zA-Z0-9]_' '*.c'  | wc -l
  30

  [just calling it "data"]
  $ git grep 'void \*data' '*.c' | wc -l
  314

The last one is cheating a little because it catches function pointer
declarations, too, but grepping for "= data;" returns over a hundred
hits, too.

So that was mostly for fun, and I think any is OK. ;) But here is the
patch again with the void pointer just called "data".

Although I think we're all a bit lukewarm on the concept, I feel like it
won't hurt anything, isn't too much code, and disables a potential (if
somewhat rare) footgun. So probably worth doing?

-- >8 --
Subject: [PATCH] remote: detect collisions in remote names

When two remotes collide in the destinations of their fetch refspecs,
the results can be confusing. For example, in this silly example:

  git config remote.one.url [...]
  git config remote.one.fetch +refs/heads/*:refs/remotes/collide/*
  git config remote.two.url [...]
  git config remote.two.fetch +refs/heads/*:refs/remotes/collide/*
  git fetch --all

we may try to write to the same ref twice (once for each remote we're
fetching). There's also a more subtle version of this. If you have
remotes "outer/inner" and "outer", then the ref "inner/branch" on the
second remote will conflict with just "branch" on the former (they both
want to write to "refs/remotes/outer/inner/branch").

We probably don't want to forbid this kind of overlap completely. While
the results can be confusing, there are legitimate reasons to have
multiple refs write into the same namespace (e.g., if one is a "backup"
of the other that is rarely fetched from).

But it may be worth limiting the porcelain "git remote" command to avoid
this confusion. The example above cannot be done with "git remote",
because it always[1] matches the refspecs to the remote name, and you
can only have one instance of each remote name. But you can still
trigger the more subtle variant like this:

  git remote add outer [...]
  git remote add outer/inner [...]

So let's detect that kind of name collision (in both directions) and
forbid it. You can still do whatever you like by manipulating the config
directly, but this should prevent the most obvious foot-gun.

[1] Almost always. With the --mirror option, the resulting refspec will
    just write into "refs/*"; the remote name does not appear in the ref
    namespace at all.

    Our new "names must not overlap" rule is not necessary for that
    case, but it seems reasonable to enforce it consistently. We already
    require all remote names to be valid in the ref namespace, even
    though we won't ever use them in that context for --mirror remotes.

    Likewise, our new rule doesn't help with overlap here. Any two
    mirror remotes will always overlap (in fact, any mirror remote along
    with any other single one, since refs/remotes/ is a subset of the
    mirrored refs). I'm not sure this is worth worrying about, but if it
    is, we'd want an additional rule like "mirror remotes must be the
    only remote".

Signed-off-by: Jeff King <peff@peff.net>
---
Subject: [PATCH] remote: detect collisions in remote names

When two remotes collide in the destinations of their fetch refspecs,
the results can be confusing. For example, in this silly example:

  git config remote.one.url [...]
  git config remote.one.fetch +refs/heads/*:refs/remotes/collide/*
  git config remote.two.url [...]
  git config remote.two.fetch +refs/heads/*:refs/remotes/collide/*
  git fetch --all

we may try to write to the same ref twice (once for each remote we're
fetching). There's also a more subtle version of this. If you have
remotes "outer/inner" and "outer", then the ref "inner/branch" on the
second remote will conflict with just "branch" on the former (they both
want to write to "refs/remotes/outer/inner/branch").

We probably don't want to forbid this kind of overlap completely. While
the results can be confusing, there are legitimate reasons to have
multiple refs write into the same namespace (e.g., if one is a "backup"
of the other that is rarely fetched from).

But it may be worth limiting the porcelain "git remote" command to avoid
this confusion. The example above cannot be done with "git remote",
because it always[1] matches the refspecs to the remote name, and you
can only have one instance of each remote name. But you can still
trigger the more subtle variant like this:

  git remote add outer [...]
  git remote add outer/inner [...]

So let's detect that kind of name collision (in both directions) and
forbid it. You can still do whatever you like by manipulating the config
directly, but this should prevent the most obvious foot-gun.

[1] Almost always. With the --mirror option, the resulting refspec will
    just write into "refs/*"; the remote name does not appear in the ref
    namespace at all.

    Our new "names must not overlap" rule is not necessary for that
    case, but it seems reasonable to enforce it consistently. We already
    require all remote names to be valid in the ref namespace, even
    though we won't ever use them in that context for --mirror remotes.

    Likewise, our new rule doesn't help with overlap here. Any two
    mirror remotes will always overlap (in fact, any mirror remote along
    with any other single one, since refs/remotes/ is a subset of the
    mirrored refs). I'm not sure this is worth worrying about, but if it
    is, we'd want an additional rule like "mirror remotes must be the
    only remote".

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/remote.c  | 17 +++++++++++++++++
 t/t5505-remote.sh | 14 ++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index 0d6755bcb7..a770df669c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -157,6 +157,21 @@ static int parse_mirror_opt(const struct option *opt, const char *arg, int not)
 	return 0;
 }
 
+static int check_remote_collision(struct remote *remote, void *data)
+{
+	const char *name = data;
+	const char *p;
+
+	if (skip_prefix(name, remote->name, &p) && *p == '/')
+		die(_("remote name '%s' is a subset of existing remote '%s'"),
+		    name, remote->name);
+	if (skip_prefix(remote->name, name, &p) && *p == '/')
+		die(_("remote name '%s' is a superset of existing remote '%s'"),
+		    name, remote->name);
+
+	return 0;
+}
+
 static int add(int argc, const char **argv, const char *prefix,
 	       struct repository *repo UNUSED)
 {
@@ -208,6 +223,8 @@ static int add(int argc, const char **argv, const char *prefix,
 	if (!valid_remote_name(name))
 		die(_("'%s' is not a valid remote name"), name);
 
+	for_each_remote(check_remote_collision, (void *)name);
+
 	strbuf_addf(&buf, "remote.%s.url", name);
 	git_config_set(buf.buf, url);
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index bef0250e89..2701eef85e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1644,4 +1644,18 @@ test_expect_success 'empty config clears remote.*.pushurl list' '
 	test_cmp expect actual
 '
 
+test_expect_success 'forbid adding subset of existing remote' '
+	test_when_finished "git remote rm outer" &&
+	git remote add outer url &&
+	test_must_fail git remote add outer/inner url 2>err &&
+	test_grep ".outer/inner. is a subset of existing remote .outer." err
+'
+
+test_expect_success 'forbid adding superset of existing remote' '
+	test_when_finished "git remote rm outer/inner" &&
+	git remote add outer/inner url &&
+	test_must_fail git remote add outer url 2>err &&
+	test_grep ".outer. is a superset of existing remote .outer/inner." err
+'
+
 test_done
-- 
2.50.1.488.g2a977559af

