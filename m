From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/7] cat-file: disable object/refname ambiguity check
 for batch mode
Date: Fri, 12 Jul 2013 12:30:07 +0200
Message-ID: <51DFDAAF.60808@alum.mit.edu>
References: <20130712061533.GA11297@sigill.intra.peff.net> <20130712062004.GA15572@sigill.intra.peff.net> <51DFC2B2.3080300@alum.mit.edu> <20130712092212.GA4859@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 12 12:30:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxacD-0000mA-J1
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 12:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757514Ab3GLKaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 06:30:12 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:44364 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757244Ab3GLKaK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jul 2013 06:30:10 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-45-51dfdab18bb6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 45.D3.17335.1BADFD15; Fri, 12 Jul 2013 06:30:09 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r6CAU7Gd002088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 12 Jul 2013 06:30:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130712092212.GA4859@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqLvx1v1Ag46LuhZdV7qZLLqnvGW0
	+NHSw+zA7LFz1l12j2e9exg9Pm+SC2CO4rZJSiwpC85Mz9O3S+DOmL3pM1NBu1jF3e5bbA2M
	BwW7GDk5JARMJDqezWSGsMUkLtxbz9bFyMUhJHCZUeLztwZmCOcak8SRg3sYQap4BTQlpkxf
	ywZiswioSjQvnQ0WZxPQlVjU08zUxcjBISoQJnHltypEuaDEyZlPWEBsEQFZie+HN4KVMwtk
	SBx/PQcsLiwQJfFpwyqoxdsZJfYsnwt2EaeAlcT0w6cZQWYyC6hLrJ8nBNErL7H97RzmCYwC
	s5CsmIVQNQtJ1QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFusZ6uZkleqkppZsYIaHLt4Ox
	fb3MIUYBDkYlHl6JY/cChVgTy4orcw8xSnIwKYnysl2+HyjEl5SfUpmRWJwRX1Sak1p8iFGC
	g1lJhPemGVCONyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBW3ATqFGw
	KDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFKfxxcBIBUnxAO39dwNkb3FBYi5QFKL1
	FKMux4EfW94zCrHk5eelSonzNoDsEAApyijNg1sBS1SvGMWBPhbm7QCp4gEmObhJr4CWMAEt
	ub0KbElJIkJKqoGx7ErB7Ghjxxs7J0UvWSqwuYPvysn1hedeV99cF3RjwdYwD43+S09c3zpm
	N6U9XH9a5HpE9l6zzxc6T1XdPSXB8P35tC1OBxeKSLhosdacNY97PyvRfBvvJNvw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230192>

On 07/12/2013 11:22 AM, Jeff King wrote:
> Yet another option is to consider what the check is doing, and
> accomplish the same thing in a different way. The real pain is that we
> are individually trying to resolve each object by hitting the filesystem
> (and doing lots of silly checks on the refname format, when we know it
> must be valid).
> 
> We don't actually care in this case if the ref list is up to date (we
> are not trying to update or read a ref, but only know if it exists, and
> raciness is OK). IOW, could we replace the dwim_ref call for the warning
> with something that directly queries the ref cache?

I think it would be quite practical to add an API something like

    struct ref_snapshot *get_ref_snapshot(const char *prefix)
    void release_ref_snapshot(struct ref_snapshot *)
    int lookup_ref(struct ref_snapshot *, const char *refname,
                   unsigned char *sha1, int *flags)

where prefix is the part of the refs tree that you want included in the
snapshot (e.g., "refs/heads") and ref_snapshot is probably opaque
outside of the refs module.

Symbolic refs, which are currently not stored in the ref_cache, would
have to be added because otherwise we would have to do all of the
lookups anyway.

I think this would be a good step to take for many reasons, including
because it would be another useful step in the direction of ref
transactions.

But with particular respect to "git cat-file", I see problems:

1. get_ref_snapshot() would have to read all loose and packed refs
within the specified subtree, because loose refs have to be read before
packed refs.  So the call would be expensive if there are a lot of loose
refs.  And DWIM wouldn't know in advance where the references might be,
so it would have to set prefix="".  If many refs are looked up, then it
would presumably be worth it.  But if only a couple of lookups are done
and there are a lot of loose refs, then using a cache would probably
slow things down.

The slowdown could be ameliorated by adding some more intelligence, for
example only populating the loose refs cache after a certain number of
lookups have already been done.

2. A "git cat-file --batch" process can be long-lived.  What guarantees
would users expect regarding its lookup results?  Currently, its ref
lookups reflect the state of the repo at the moment the commit
identifier is written into the pipe.  Using a cache like this would mean
that ref lookups would always reflect the snapshot taken at the start of
the "git cat-file" run, regardless of whether the script using it might
have added or modified some references since then.  I think this would
have to be considered a regression.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
