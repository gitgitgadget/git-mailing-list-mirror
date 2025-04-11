Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A37635961
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386551; cv=none; b=hz7YXeatVk6qphd3Ecsxk4m/bPJyxjoyoEnL7XUhS1YwPr54QMD30x42yjTEt0BsFCIDrN60txcWocRpDHaw6AgIy67UxEWXK7kzs2J/XibeyO0eT7dq2rqraxQXr9xe3JD0lmcRETrKCtBCQ+2aZiROc8MGOTczoX7LEovln5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386551; c=relaxed/simple;
	bh=626ij5TEk0hEgsAAVQyGrpUdzSBX1nlrZFOT2miyX7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhHPsiSjfIHIsLz8rRBvQicg128CGSFA4C1NHhAIW4SJq7sbiab3dQs6D6RPb8QIJ1s6HsqJMox8fgxoO2XYfokCJ/fqS19NVioTrt3KYW2M61nkyDA3ZqclMRlh8UXHVJ20OpWyAjflw5V86ebDfVz/DuQkos+/D1Cj2S8CZos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-137.bstnma.fios.verizon.net [173.48.82.137])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53BFmdFi002968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 11:48:40 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 874C12E00E9; Fri, 11 Apr 2025 11:48:39 -0400 (EDT)
Date: Fri, 11 Apr 2025 11:48:39 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
Cc: Nico Williams <nico@cryptonector.com>,
        Martin von Zweigbergk <martinvonz@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Edwin Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>,
        remo@buenzli.dev,
        "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
Message-ID: <20250411154839.GC648081@mit.edu>
References: <xmqq4iyzn0vn.fsf@gitster.g>
 <Z/RFQY433muaCW44@ubby>
 <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby>
 <xmqqv7rdqkla.fsf@gitster.g>
 <Z/a+AVopz+HLa1eL@ubby>
 <20250410134426.GB13132@mit.edu>
 <xmqqy0w8ng5r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy0w8ng5r.fsf@gitster.g>

On Thu, Apr 10, 2025 at 09:18:56AM -0700, Junio C Hamano wrote:
> Thanks to the "cover for iteration N is a direct response for
> iteration N-1" and "cover is marked as [PATCH 0/$n]" conventions,

Even if the cover for iteration N isn't a reply-to the cover for
interation N-1, b4 will search based on the subject line for a cover
letter with higher version number, and this mostly works.

My one (admittedly minor) pain point is where someone replies to a
patch series with something like "you should really also fix FOO", and
then someone replies with a single patch (without a cover letter,
possibly created with git; possibly not) that addresses issue FOO.

This can confuse "b4 am -c" into thinking that the patch to address
FOO was in fact a newer version of the patch being reviewed.  It's not
a big deal; I can deal with this manually.  But having a patch set ID
would help with this.

The other things that would help with having an official patch set ID
would be to allow patchwork to automatically supercede an older
version of the patch series (possibly with a link to the older version
of the patch series in the Web UI).

I'd also love if lore.kernel.org and maybe b4 also had an automatic
way to get at the older versions of the patch series, and the patch
set ID would help with the automation.  Admittedly it's not strictly
speaking necessary, since b4 is already using the cover letter subject
line to search newer versions of the patch series.  The number of
messages it would need to search to find older versions would be
greater, though.

Cheers,

					- Ted
