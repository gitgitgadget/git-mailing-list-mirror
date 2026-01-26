Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503EC3EBF33
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.233.160.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769431704; cv=none; b=c5UV5OIEd+FrEajVGCB/sHOU5g/MTxdN96dDiQW14okT5ECe2n4mhw3qhLVg7qT60yI3JNpFHww8JyqjkDDtTPIw1w923sjMAe+hYTDjRqqM4WqrTk83ad2DUmnhWaYTOPF4Yw+6n+QJyMZ8gcl1wIa4sj6niBhAqFFYffPX81k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769431704; c=relaxed/simple;
	bh=e+aOvmEOiAvp5QI+pHXbnXxGC068qUR/WYMT18zWas8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=f11R65ZoU0pN3AP+JrQt1RiX7FchZD1bkGpvpadp+OenXzUlCqY4U++BRaR4ki1soOBJE5Hq+bPj35+lipwYC0Qf9nIeivYLJ8mUcjYf8Wk11SYd4YDX6IgKw6NGESe8ajA9/NlLKWHKYoQ65uF7kTkjwEqp9yBqQdcfkHu6xDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iee.email; spf=pass smtp.mailfrom=iee.email; dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b=Wk9Pu/kp; arc=none smtp.client-ip=85.233.160.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iee.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iee.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iee.email header.i=@iee.email header.b="Wk9Pu/kp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=iee.email;
	s=2025082600; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References
	:To:From:Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=eKXLG3CGJKYf/FxBH84kB+xfSBiGtcG3Seas3paH8p8=; b=Wk9Pu/
	kpNoPlVImZlb9n5SA2oUaHdH5a33Jxgzi96RNUED51lVJh7DdkP6NcdRVpx/naz2rd1yGvKC+HgAl
	TjaiANnLiTCk/byfO9fA/cLij92KQfPGSeh7Ev/OV1BlfEYJ/ekeiTMrPL2HV+52VSWtu+edpVxr5
	o5BU8xMS6Yc=;
Received: from host-78-146-7-210.as13285.net ([78.146.7.210] helo=[192.168.1.57])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <philipoakley@iee.email>)
	id 1vkM0x-0000000091V-8V0o;
	Mon, 26 Jan 2026 12:48:19 +0000
Message-ID: <92cd5477-c2fc-42c5-b678-aa95b0999b2a@iee.email>
Date: Mon, 26 Jan 2026 12:48:18 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing and omitted objects
From: Philip Oakley <philipoakley@iee.email>
To: Simon Richter <Simon.Richter@hogyros.de>, git <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>
References: <a612ea8e-a741-436d-8ed2-6ff09ba7945b@hogyros.de>
 <f6cc0420-1be6-4855-8c0f-b79c683203ee@iee.email>
Content-Language: en-GB
In-Reply-To: <f6cc0420-1be6-4855-8c0f-b79c683203ee@iee.email>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Had a bit of a think overnight. Some parts probably don't apply to this
application, see below.

On 25/01/2026 15:42, Philip Oakley wrote:
> On 21/01/2026 11:54, Simon Richter wrote:
>> Hi,
>>
>> we're having a bit of a discussion in Debian.
>>
>> The goal is to move towards git based storage for source packages, away
>> from tarballs; ideally we'd like to reuse the upstream git archive as
>> far as possible, so it is easy to check for differences.
>>
>> However, some projects are shipping files that aren't redistributable,
>> or that we want to omit for other reasons (such as vendored
>> dependencies, when there is a perfectly working common version
>> available, and we really really want to make sure these don't get used
>> accidentally).
> 
> There was a discussion about allowing objects to be 'redacted' back at
> the Git Merge 2020 (https://git-merge.com/),
> under [TOPIC 3/17] Obliterate.
> https://lore.kernel.org/git/5B2FEA46-A12F-4DE7-A184-E8856EF66248@jramsay.com.au/
>
The discussion is like still informative.

>>
>> The goal here is to allow the recipient of such a bundle to verify that
>> any files received are unmodified, and get a list of paths that were
>> removed (which may be an entire subdirectory). Ideally, they could also
>> continue working on a clone of this and generate commits on top as long
>> as the affected paths aren't touched.
>>
> That discussion on redacting objects didn't reach any actionable
> conclusion that allows objects to be omitted/redacted, while keeping the
> branch based directed graph flow. I've continued to consider options for
> deliberately creating 'counterfeit' objects (old name/oid, but
> new/limited content) which could then be 'verified' through a facsimile
> object with the same new/limited content but a properly hashed name/oid.
> I haven't shared any of that with the list.
> 
The idea of eliminating objects by OID, totally, from the repo is not
suitable for the use case. It would be an all-or-nothing response,
rather than a tailored response.


>> The minimal amount of data we'd want to archive is a single commit and
>> its tree and dependencies, plus optionally a signed tag pointing at it
>> if it exists (i.e. the same information we get if we use git-archive,
>> plus the signature on the tag, plus the option to clone from such a
>> snapshot). For the simple case where nothing is removed, this already
>> works well and covers most of the use cases, but, sadly, not all of them.
> 
> You could simply branch that special commit that will have all the
> deletions, plus a 'deletions' file diff file (assuming you want to
> highlight those deletions..), and then leave that branch as a stub, with
> a tag, and remove that old branch name such that the tag is the thing
> that retains the special commit in the hierarchy, and it's parent still
> holds within the regular git commit graph.

This may still be a useful tailoring where a separate commit is
generated which omits unwanted files/content. This is quite lightweight
in terms of repo size because of the inherent de-duplication of common
content. It's only the updated trees that need storing.

Philip

>>
>> As a side effect, this could make recovery of a broken repository that
>> is missing objects more robust.
> 
> Broken repos are scarce, more often than not being compatibility issues
> between (*nix) Git and Git-for-Windows (case sensitivity, sizeof(long),
> character limits, etc.). However redaction and overlarge files still fit
> into the 'Don't do that' category (expect the unexpected..).
> 
> There is also the distinction between the meta-data and content. The
> former also includes the data that holds together the commit graphs
> integrity (hash of hashes) and filenames, directory names and commit
> texts (point 15 of the Git Merge discussion). Being inside the hash
> verified meta data makes it "hard" to break and create exceptions.
> 
> A mechanism for marking leaf objects as 'removed'/abscissed/absconded
> would help here. It's tricky to do that safely for a commit, as it also
> carries parent information which must be retained.
> 
> For a blob (leaf) object, with its free form text, it is possible to
> have a fixed format, fixed length (hash specific) counterfeit object,
> e.g. "Git redact abcd01245.."(*) which would then also exist as a
> facsimile (i.e.has a true hash oid) object within some authenticated
> part of the graph, and the counterfeit exist in place of the 'broken'
> blob object with that self referential "abcd01245.." oid.
> 
> For trees, it becomes necessary to locate a bit of free text in the meta
> data to provide self reference, and make it appear as either the empty
> tree or empty file(blob). The true oid of such a counterfeit tree
> likewise would need a way of existing within some authenticated part of
> the wider graph. Perhaps a step too far at this stage of hand waving.
> 
>>
>> Right now, I'd like some feedback whether someone has a better idea, and
>> if such a feature could ever work or if it violates some fundamental
>> design principles.
> 
> It's a big ask. Finding one specific feature (just on) that could
> actually be made to work would provide a toe hold for discussion.
> 
> At least this is a solid desire from within the community's infrastructure..
> 
> At present there is no mechanism for assuming that a piece of blob
> *content* is "correct" but that the oid it is stored under is incorrect
> / does not match. We already have/had the `--literally` option for
> creating arbitrary content, but not it's corollary `--use-oid=abcd01245..`.
> see
> https://lore.kernel.org/git/20250516045010.GL22242@coredump.intra.peff.net/
> Peff cc'd
>>
>>    Simon
>>
> (*) I more wanted "Git redact abcd01245.hexoid Base64oid" to reduce
> accidental creation of such objects and allow double checking of the
> oid. But maybe that's too cute.  ;-)
> 

