Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29104145FE5
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725831171; cv=none; b=fIyrEKxs7JzYZxs1pTLGw81BidEhIIRf3DjnEUzVwrGnE6NZplsELZfX0Nh93S3rdeQ3OiUiKKfGHu4bV6m0yNzaCX9JE5g1fCPtxiaBIvXCLOVo/Iyi5k9Q5pKzk3G9UGuGub65dy5ZFS9yhzk5OkU6rn+yyvpdVDhQsa2wE2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725831171; c=relaxed/simple;
	bh=Fb2iFfhNfNwyzXv5Sr4a14JJJAprZ0iwmPRZjI9xfXU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X3Tn+LLG/Ba1sMtrtxJD+dhzBxbdTrL3tSx9s6aPnBSeE7/e081pumwLIDZwWXaPwJSgPmv8oSr2d6tw7ADpPpKTK4Nz6n0v7GZJ+GBm9o3qfRdDkgrbXit/mIlH27ROKFWTAVFI2DAYMKlZ3uAcEn0LHq4RhRSqoxIReKRKuhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ibByV3IG; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ibByV3IG"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F22932299;
	Sun,  8 Sep 2024 17:32:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Fb2iFfhNfNwyzXv5Sr4a14JJJAprZ0iwmPRZjI
	9xfXU=; b=ibByV3IGU4JGIuTB9pqQMffbVQQIbGOfYuZ43vBHKNn3GQf9/j2woj
	YFi/h6i0onrhLTF6zZ8v3dzzTt2NTXRSl+lHochQE1UfptIs3rtr6J/X54MGBkDX
	uuXy41LcvHU7A8Dx31ZbaOfXKpERkzh3m9jPmhUiWvMSgrHw7uwNQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 14DBC32298;
	Sun,  8 Sep 2024 17:32:48 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 80FF232297;
	Sun,  8 Sep 2024 17:32:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Calvin Wan
 <calvinwan@google.com>,  git@vger.kernel.org,  Josh Steadmon
 <steadmon@google.com>,  spectral@google.com,  emilyshaffer@google.com,
  emrass@google.com,  rsbecker@nexbridge.com,
  sandals@crustytoothpaste.net,  Jason@zx2c4.com,  dsimic@manjaro.org
Subject: Re: [PATCH v3 2/6] libgit-sys: introduce Rust wrapper for libgit.a
In-Reply-To: <20240906230419.r4hej7qsmx7yasl7@glandium.org> (Mike Hommey's
	message of "Sat, 7 Sep 2024 08:04:19 +0900")
References: <20240906221853.257984-1-calvinwan@google.com>
	<20240906222116.270196-2-calvinwan@google.com>
	<CAPig+cQbPCWS4LVF7cdw_DD6K8dsrLTCmmhqkmGZpz1CO93vRQ@mail.gmail.com>
	<20240906230419.r4hej7qsmx7yasl7@glandium.org>
Date: Sun, 08 Sep 2024 14:32:46 -0700
Message-ID: <xmqqa5ghx24h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E458A404-6E29-11EF-B05F-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Mike Hommey <mh@glandium.org> writes:

> On Fri, Sep 06, 2024 at 06:39:17PM -0400, Eric Sunshine wrote:
>> > diff --git a/contrib/libgit-rs/libgit-sys/build.rs b/contrib/libgit-rs/libgit-sys/build.rs
>> > @@ -0,0 +1,31 @@
>> > +pub fn main() -> std::io::Result<()> {
>> > +    let crate_root = PathBuf::from(env::var_os("CARGO_MANIFEST_DIR").unwrap());
>> > +    let git_root = crate_root.join("../../..");
>> > +    let dst = PathBuf::from(env::var_os("OUT_DIR").unwrap());
>> > +
>> > +    let make_output = std::process::Command::new("make")
>> 
>> Providing a mechanism for people to override this hardcoded spelling
>> of "make" could be another item for your NEEDSWORK list; in
>> particular, I'm thinking about platforms on which GNU "make" is
>> installed as "gmake".
>
> And/or, use the `make_cmd` crate.

Thanks for helping.
