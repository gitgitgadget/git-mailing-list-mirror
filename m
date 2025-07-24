Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C1372632
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353942; cv=none; b=MdCMTfDAmCuz4ZWht2ZVcy/s2gqcNF0A/pHeKt3v2VTzryS5I1lNBPt7ZHXj3NadZDo7blsSMo0PKDpAG7TR1swhzan/YN7lIvgs6Sv0UCsDJoP1h32b/ye/YGwI8WWnheOX5zVq2SgFbNhwBhfiOpyRd2slCLWv5yim9JMHEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353942; c=relaxed/simple;
	bh=/Ma4sCyHdr/4R1dcu0q5cAETwRJYWuV1KMUHcxvctp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYjfx2uYGuIkfnlWXLMJkFVi+QmQi0FOWtWH/AXwd5Y/MHIa3KqsLoWi1utt2to3ZJxLg4tq3yYCjyjDaufxZ8Oxq69IkgHS1vj30f2FFWY4Ba3C7b76Q5NsJAu1dp0em73x4ItMw54FpG1Y92zLnxfeur/xownSracBG3lpGVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Lqw5wUFD; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Lqw5wUFD"
Received: (qmail 17061 invoked by uid 109); 24 Jul 2025 10:45:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/Ma4sCyHdr/4R1dcu0q5cAETwRJYWuV1KMUHcxvctp0=; b=Lqw5wUFDnhqZ1hgyOvhsCq29fiomPuNuTz2eyh9MIj/JOxBEZVc/0o3hGa/PMfqgJ4IkFpxeXMIyVAs/2OHtjlUZbjViyMeuXkLi93bzO9lL6mmNcX41HKhJ+REdtt+E4vrpeDbFGOtSAnc9Xl8AYs7U3hgWZ3CPF72JUpDrQjRK8w6zfWvSb4xdIjWj2E+5qD8HzHctmwDzM+mhKNMz50Yj6cj14OrIK+bhM30jjufFM3Iz5lPR7a6Fqmu/MmA4iwn7nJtziFSyjO3dndLdqDpSE9r84ip/bntovmPHuIcwjMMFoSQVrlKzdQ7Ch19I6szHdj6HpSjHBofiAhNTug==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jul 2025 10:45:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1548 invoked by uid 111); 24 Jul 2025 10:45:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Jul 2025 06:45:42 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 24 Jul 2025 06:45:36 -0400
From: Jeff King <peff@peff.net>
To: Han Jiang <jhcarl0814@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Git Mailing List <git@vger.kernel.org>
Subject: Re: `git remote rename` does not work when
 `refs/remotes/server/HEAD` is unborn (when right after `git remote add -m`)
Message-ID: <20250724104536.GA1316505@coredump.intra.peff.net>
References: <CANrWfmQWa=RJnm7d3C7ogRX6Tth2eeuGwvwrNmzS2gr+eP0OpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANrWfmQWa=RJnm7d3C7ogRX6Tth2eeuGwvwrNmzS2gr+eP0OpA@mail.gmail.com>

On Thu, Jul 24, 2025 at 09:59:45PM +1200, Han Jiang wrote:

> What did you expect to happen? (Expected behavior)
> 
> `git symbolic-ref 'refs/remotes/server/HEAD'` outputs
> "refs/remotes/server/master";
> `git symbolic-ref 'refs/remotes/server2/HEAD'` outputs
> "refs/remotes/server2/master".
> 
> What happened instead? (Actual behavior)
> 
> `git symbolic-ref 'refs/remotes/server/HEAD'` outputs
> "refs/remotes/server/master";
> `git symbolic-ref 'refs/remotes/server2/HEAD'` outputs "fatal: ref
> refs/remotes/server2/HEAD is not a symbolic ref".
> `git symbolic-ref 'refs/remotes/server/HEAD'` outputs
> "refs/remotes/server/master".

Thanks for the report. I can reproduce the issue easily here. Probably a
simpler reproduction is just:

  git init
  git remote add -m whatever server1 /does/not/need/to/exist
  git remote rename server1 server2
  git symbolic-ref refs/remotes/server2/HEAD

The problem is that the branch-renaming code in git-remote is not
prepared to handle symrefs that don't resolve. This seems to make it
work:

diff --git a/builtin/remote.c b/builtin/remote.c
index 5dd6cbbaee..478ea3a80c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -630,7 +630,9 @@ static int read_remote_branches(const char *refname, const char *referent UNUSED
 	if (starts_with(refname, buf.buf)) {
 		item = string_list_append(rename->remote_branches, refname);
 		symref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						 refname, RESOLVE_REF_READING,
+						 refname,
+						 RESOLVE_REF_READING |
+						 RESOLVE_REF_NO_RECURSE,
 						 NULL, &flag);
 		if (symref && (flag & REF_ISSYMREF)) {
 			item->util = xstrdup(symref);
@@ -835,8 +837,8 @@ static int mv(int argc, const char **argv, const char *prefix,
 	 * First remove symrefs, then rename the rest, finally create
 	 * the new symrefs.
 	 */
-	refs_for_each_ref(get_main_ref_store(the_repository),
-			  read_remote_branches, &rename);
+	refs_for_each_rawref(get_main_ref_store(the_repository),
+			     read_remote_branches, &rename);
 	if (show_progress) {
 		/*
 		 * Count symrefs twice, since "renaming" them is done by

That is, we need two fixes:

  1. When iterating over the refs, we need to cover _all_ refs, not just
     those that fully resolve (there's a related bug here: we'll
     silently ignore an actual broken or corrupt ref, whereas I think
     the right thing would probably be to try copying it and then
     complain loudly if we don't have the object).

  2. When resolving each one, we shouldn't recurse. We're doing a
     shallow copy, not a deep one.

Reading this code, though, I can't help but think that the recent "git
refs migrate" command had to deal with all of these problems. I wonder
if we could reuse its code. +cc pks for wisdom.

-Peff

PS I think there's a related bug. If we have a real upstream repo and
   try to "git fetch" with HEAD pointing to the unborn state, it will be
   overwritten! I think this is the remote.*.followRemoteHEAD logic
   being overly zealous in "create" mode. It should probably leave an
   existing value alone, even if it points to an unborn branch.
