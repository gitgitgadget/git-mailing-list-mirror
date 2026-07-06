Received: from chiark.greenend.org.uk (permutation-city.chiark.greenend.org.uk [93.93.131.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A5F381E95
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350197; cv=none; b=l2aljU0NUvSZ9MLAskpN9/EAPl8+9Y+1Tx74uS1owTmEeGCl2GKXGpYJbsZwvBQhg+ovEpKyQjLxIRy8osPvOmIVVIWsndn6prJyPb/szh5W9hhV9LA9Mkbk20oPnTBkE2BE5yyOfXpjIUFpz6nP6sCMbGl3bLbG7FKRCy4Piv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350197; c=relaxed/simple;
	bh=qTtCFHmYiuw4FBNMpUW4zps6RGaHg6O0J6qGN6R4nzA=;
	h=From:MIME-Version:Content-Type:Message-ID:Date:To:Cc:Subject:
	 In-Reply-To:References; b=Vr3qwd1oHFYXoyBm3A1aq9931cRvJuIYfsufwuwHvt8jTFEYCAeZFTfzqCt4OQoYQ5zOJ4/L6Db1kiYgGhgwtgKspmNKYmW+hLv1ip0RM55UCXUIjOVvhuxat7EQckQ+OHEZc11QchQJcUi+1Kc1Ddsc8AtP+TJLqhIckZ2Z7W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk; spf=none smtp.mailfrom=chiark.greenend.org.uk; dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b=aQwg0vnt; arc=none smtp.client-ip=93.93.131.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chiark.greenend.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chiark.greenend.org.uk header.i=@chiark.greenend.org.uk header.b="aQwg0vnt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=chiark.greenend.org.uk; s=l.chiark; h=DKIM-Signature-Warning:References:
	In-Reply-To:Subject:Cc:To:Date:Message-ID:Content-Transfer-Encoding:
	Content-Type:MIME-Version:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=N6txiJQZ1AQaEgffC0FqW3xBBNwdR+fEeSXEH9VUqYo=; b=aQwg0vntMa0+
	7fOpblTM7yxuFhnjOaHJHJ0UXSBDdBlSTnPU8gSBAKevOSAmaHRT9eI28Usc5SnmtsJgg6/Dv25EJ
	5htRzGtzXCSsrXZ5443ASBnQh2XiU+lkcIg7MH7cFbtezp2HmAYACILZcqf5p2ISqnJZnAxSrTtAl
	RCVsm05Dc+C+faLse55hIYn4RTBSEcJP7QBhhGijDkBi9f0UVZu2eSIXX56O3KVUkRH7SBQXxtDBf
	HnmnOS93X7PNHyxyKHtntt/ScLi/xOKMA1TBpHSfHz7DUy9GmTRfABVZLNtE1CiTqqJaJvRkTawDk
	AQx9g/FWxVKTdRvW5+T8/w==;
Received: by chiark.greenend.org.uk (Debian Exim 4.94.2 #2) with local
	(return-path ijackson@chiark.greenend.org.uk)
	id 1wgkqm-0007Ze-67; Mon, 06 Jul 2026 16:03:12 +0100
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <27211.50096.133710.528147@chiark.greenend.org.uk>
Date: Mon, 6 Jul 2026 16:03:12 +0100
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
    Colin Stagner <ask+git@howdoi.land>,
    Johannes  Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust
 rewrite
In-Reply-To: <xmqqy0fob2kl.fsf@gitster.g>
References: <20260706115816.20267-1-ijackson@chiark.greenend.org.uk>
	<20260706115816.20267-2-ijackson@chiark.greenend.org.uk>
	<xmqqy0fob2kl.fsf@gitster.g>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
DKIM-Signature-Warning: NOTE REGARDING DKIM KEY COMPROMISE https://www.chiark.greenend.org.uk/dkim-rotate/README.txt https://www.chiark.greenend.org.uk/dkim-rotate/26/2626ff584df1644c89bafcc8f3c9745f.pem

Hi.  Thanks for the quick review.

Junio C Hamano writes ("Re: [PATCH 1/2] git-subtree: Bail out if we find output from Rust rewrite"):
> If (global) $rev is not set here, we'd check :.git-subtree/config in
> the index in order to detect the v2's configuration.  It seems to me
> that this code however wants to inspect HEAD's tree.

This was a slip.  The code in reject_if_v2_config is supposed to use
its argument (as per the usage comment I added), not a global.  I'll
fix this with a respin.

(I think it may somehow work by accident in my tests.)

> The above helper may work for one caller that passes "$rev" but not
> for the other caller that passes "HEAD", no?

HEAD is a valid revision spec for git-rev-parse, but the
function should use $1 (which in that case would be HEAD), not $rev.

> 	if git rev-parse --verify -q "$1:$config"
> 	then
> 		die "fatal: tree contains $config: has been processed with new standalone (Rust) git-subtree; use that tool instead of this one.  See https://codeberg.org/diziet/git-subtree https://crates.io/crates/git-subtree"
> 	fi
> 
> Overly long output does not look very easy to read, but I kept it
> the same as the original.

I'm not a great fan of the long error message myself, but it seemed to
be what the rest of the script was doing.  I didn't find any
multi-line calls to die, so that's why I did it this way.

I'm happy to reformat this to your taste.

Thanks,
Ian.

-- 
Ian Jackson <ijackson@chiark.greenend.org.uk>   These opinions are my own.  

Pronouns: they/he.  If I emailed you from @fyvzl.net or @evade.org.uk,
that is a private address which bypasses my fierce spamfilter.
