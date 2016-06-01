From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git gc and worktrees
Date: Wed, 1 Jun 2016 10:57:08 +0200
Message-ID: <574EA364.60408@alum.mit.edu>
References: <574D382A.8030809@kdbg.org>
 <CACsJy8BHU0YtgvjuefRPuMPLhvoOPLVMhR4YzH8=wVFeOie+Xw@mail.gmail.com>
 <20160531221415.GA3824@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 10:57:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b81xy-0000Wy-1K
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 10:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757869AbcFAI5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 04:57:17 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:64833 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757792AbcFAI5N (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 04:57:13 -0400
X-AuditID: 1207440c-c3fff70000000b85-d1-574ea3673dff
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 30.19.02949.763AE475; Wed,  1 Jun 2016 04:57:12 -0400 (EDT)
Received: from [192.168.69.130] (p508EAFFA.dip0.t-ipconnect.de [80.142.175.250])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u518v8ps014241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 1 Jun 2016 04:57:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <20160531221415.GA3824@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqJux2C/c4NAHZov5m04wWnRd6Way
	eDL3LrNF95S3jBY/WnqYHVg9ds66y+7x8FUXu8ez3j2MHgue32f3+LxJLoA1itsmKbGkLDgz
	PU/fLoE7Y+nup+wFHbwVHybyNzDe4upi5OSQEDCROH9+J3MXIxeHkMBWRoneRbPYIJzzTBLn
	f55gAakSFlCUmLb0EiuILSJgK/F093+oonmMEnfaX7N3MXJwMAtUSaw+bwdSwyagK7Gop5kJ
	xOYV0JSY8+M0M4jNIqAicaf7JJgtKhAicX7dVlaIGkGJkzOfgO3iFLCSeHt6IVgNs4C6xJ95
	l6BseYntb+cwT2Dkn4WkZRaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXUy80s
	0UtNKd3ECAlmnh2M39bJHGIU4GBU4uFVuOgbLsSaWFZcmXuIUZKDSUmUNzXPL1yILyk/pTIj
	sTgjvqg0J7X4EKMEB7OSCK/gZKAcb0piZVVqUT5MSpqDRUmcV3WJup+QQHpiSWp2ampBahFM
	VoaDQ0mCd8sioEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UETGFwNjEiTFA7SX
	aTHI3uKCxFygKETrKUZdjiP7761lEmLJy89LlRLnvbcQqEgApCijNA9uBSx1vWIUB/pYmNce
	5BIeYNqDm/QKaAkT0JL4DB+QJSWJCCmpBsY8O/ljr546Wsstb33R9FDFOdom9GFWpuDMtufB
	mSwPtnre912QJ6KqGfAgYY4RG39w+J8nCx9VrG6/b3fMqJ/nWVL4pgNHZ02M4X8e 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296068>

On 06/01/2016 12:14 AM, Jeff King wrote:
> [...]
> Michael (cc'd) noted to me off-list recently that there may be some
> special cases there regarding reflogs in other worktrees (i.e., that we
> don't always include them for our reachability checks). I don't know the
> details, though.

That's correct. `for_each_reflog()` does its work by walking the
directory tree under `$GIT_DIR/logs`. So when run in the main
repository, it never looks at the per-worktree reflogs. Therefore,
objects that are only reachable from per-worktree reflogs can end up
getting pruned.

This is closely tangled up with my ref-iterators patch series (which is
why I noticed it), especially with

    [PATCH 13/13] for_each_reflog(): reimplement using iterators

[1].

I think reference stores are going to need two distinct types of
reference iteration: one to iterate over the *logical* reference space
of a single repo or worktree, and one to find all *local* references
and/or reachability roots (e.g., when run within a linked repo). The
current approach, where subtrees of the reference namespace are pasted
ad-hoc into each other partly by manhandling the ref_cache and partly
via the hack in `git_path()` is not, I think, a very good long-term design.

I'd prefer the elementary operation on a low-level reference store to be
iterating over all of the references that are stored locally, and to use
`merge_ref_iterator` for pasting together the parts of low-level
reference stores that are needed to form a logical view of the
references in a linked repo.

Michael

[1]
http://thread.gmane.org/gmane.comp.version-control.git/295860/focus=295866
