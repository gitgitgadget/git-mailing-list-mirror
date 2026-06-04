Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D3F13B293
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583296; cv=none; b=ceJCMpKZjNjuerPlesQaGUVI6ho797ok+JaTHFvdchU8FAI+K7NyJHwKBwUHZun1jjGgCNaWFGVwCT8crnjNydfv91/GfOMnOHC5BicW37Lf1fL3DhwROS9asib9CUjuRO/eKCJu6DJcL9F+GO/uYXTBWrNSVN8+4yg1Sv1guok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583296; c=relaxed/simple;
	bh=aDs+mzyWVJBL5bsqvOvuh9J3EEaQxRM/hDubVZWDdT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAUmtKVU27xWyGeRkSPti5danRU4r6AaUylIOfmlPDqQ0EZQrrxGuVEwA/EVyI1ii6bp8iConbs+eaZ71G29xAls6bybr1PbhLkoilXSOQDoGclSBnqdROu7aby2foAWqLfWLomF++K7YU5NG60Y31YaPdoW8iTn2TEUmkXqAKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YJ1BuOgP; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YJ1BuOgP"
Received: from macsyma.thunk.org (pool-173-48-113-247.bstnma.fios.verizon.net [173.48.113.247])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 654ES5QX003922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jun 2026 10:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1780583290; bh=Qhm8xcaT226HRVOrDTYho446bWdv4HzI36DxylBwlnk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=YJ1BuOgPKTc8xKYXWH0bD0fh9OcYcPthjq1t25ZPCEVrwGG90EPlpyX/D47/gbIsF
	 BRl/x3NmeSSSWL9w0v9ZqJy53ofXd0sQBWXjxvMB4mrv5yK1P3C64AeAAo1K4h7KoU
	 b65QM59m9BrEQcAz/b58imgjEJrI4JVZ8CK2PmC/FQzYgeDrkUoGzlj7/+yEPQ8xJp
	 0xTgR0r4md62QWPj4B55pRUXWrNwRcJd/zlCmr840hk+Bz2JhDbxf9ue0ITUlrbNR3
	 WdUX7sp7ZBSr6GS14S6RMmba8lvlkXCkfflVIQV/c+K/jIfxi81jG3c0KmL6lkQDfz
	 Rs8GsxMh4mJQA==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 9006E37D39C; Thu,  4 Jun 2026 10:27:05 -0400 (EDT)
Date: Thu, 4 Jun 2026 10:27:05 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Patrick Steinhardt <ps@pks.im>
Cc: Tomasz Konojacki <me@xenu.pl>, git@vger.kernel.org
Subject: Re: Is it intended behaviour that 'git gc' ignores the
 'commitGraph.changedPaths' setting?
Message-ID: <zzxyeseps5rflyldmdlx54dkjlyu4v267wbpfb4xlrh4lahogf@3woimupgfm7v>
References: <20260604132419.F2FA.5C4F47F8@xenu.pl>
 <aiF0aN9BwBvQffGL@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiF0aN9BwBvQffGL@pks.im>

On Thu, Jun 04, 2026 at 02:49:44PM +0200, Patrick Steinhardt wrote:
> So my recommendation would be to stop using git-gc(1) altogether -- I am
> biased as I have helped implementing the new maintenance strategy, but I
> would say that git-gc(1) is nowadays a legacy tool that inches closer
> towards the end of its life. Git's default maintenance nowadays uses
> git-maintenance(1) without using git-gc(1) at all anymore.

I wonder if we should add a tunable that makes "git gc" redirect to
"git maintenance run" or some such.  For those of us who like to
launch maintenance tasks at specific times (for example, before I
disconnect from the AC mains and get on a plane), "git gc" has a major
advantage --- it has fewer characters to type, and I'm lazy.  :-)

The other things to perhaps suggest is ways that developers can set up
rules like disabling git maintenace running while on battery, etc.
This might require OS-specific mechanisms for determining whether the
laptop is running on battery --- but I note that git-maintenance is
already hooked into systemd and launchctl for Linux and MacOS,
respectively, so there's precedent for that sort of thing.

Cheers,

					- Ted
