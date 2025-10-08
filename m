Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48F026158C
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949542; cv=none; b=fS4OQ/sIVx2QlEWvB3YgUet8YPhTin5MZmqEGlPe1UpPckcARxeG4cFgoPOOKnYWSLgkkjLkqWiIziMQ5X0USwlqTKKXRW0ct+IxuqZyCqlW46fk+dnLM6qT5j85qdHYrzr9NdF3uKCfsMk5N5w6csL/g2pAWYQlRqrRoo4W1/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949542; c=relaxed/simple;
	bh=pmUkaJL6W5wnnHGZsLOddrKG+Hm0EEynesxJCuBuyZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p7ITnO1DzabZsADGii1cmkOoHMlBSQjEYXDG/ZPmDoPzqa56qrvYCL61IYniW4kNm4pCanVFnfhZt+y87NA8g00TxMMyFv4SfysFpyQsPtIpZ0eJYAhakyBE8OmcwJFq5P97C6xG0ems42G/KZa5zhzpEBKv54RYAbdi0wScemY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4chhvF3J5Pz1sXw9;
	Wed,  8 Oct 2025 20:52:09 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4chhvF13twz1qqlS;
	Wed,  8 Oct 2025 20:52:09 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id QOJazFDodAFV; Wed,  8 Oct 2025 20:51:59 +0200 (CEST)
X-Auth-Info: mswc+MTe2NKiEdZQMWRItYJC+5yVrGMmxT9TNOA3PfXKPZkrYlArSxeC2nraithd
Received: from igel.home (aftr-82-135-83-177.dynamic.mnet-online.de [82.135.83.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Wed,  8 Oct 2025 20:51:59 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 72E132C19F5; Wed,  8 Oct 2025 20:51:59 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Andrew Harmon <aharmon@signalquest.com>
Cc: Junio C Hamano <gitster@pobox.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [BUG] git clone from bundle with --all does not fetch all refs
In-Reply-To: <BN0PR13MB5216EC49DD37699C766B8DD6BBE1A@BN0PR13MB5216.namprd13.prod.outlook.com>
	(Andrew Harmon's message of "Wed, 8 Oct 2025 18:17:14 +0000")
References: <BL3PR13MB5209A87037FC19CBB9B2916EBBE0A@BL3PR13MB5209.namprd13.prod.outlook.com>
	<xmqqa522icjy.fsf@gitster.g>
	<BL3PR13MB520981A726145113DCA8B910BBE0A@BL3PR13MB5209.namprd13.prod.outlook.com>
	<xmqqo6qhfgtb.fsf@gitster.g>
	<BN0PR13MB5216EC49DD37699C766B8DD6BBE1A@BN0PR13MB5216.namprd13.prod.outlook.com>
Date: Wed, 08 Oct 2025 20:51:59 +0200
Message-ID: <87ldllw7jk.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Okt 08 2025, Andrew Harmon wrote:

> As an end user, I found this very surprising. I was expecting to call:
> git clone <repo-bundle>
> and have this behave just like:
> git clone <ssh-or-https-target>

If you want that equivalency, then you need to create the bundle either
directly from <ssh-or-https-target>, or a mirror clone thereof.  By
using a regular clone as the source for the bundle you already have a
different type of repository than the one you see at the
<ssh-or-https-target>.

> echo ""
> echo "Clone the repo via SSH"
> git clone git@UBUBEAR:external_sources/matrice_sq.git matrice_sq
>
> echo ""
> echo "View available remote branches"
> (cd matrice_sq && git branch -r)

Compare the output of "git ls-remote matrice_sq" with the output of "git
ls-remote git@UBUBEAR:external_sources/matrice_sq.git"
to see the difference between the two repositories.

>
> echo ""
> echo "Pack the bundle for offline distribution"
> (cd matrice_sq && git bundle create ../matrice_sq.bundle --all)

The bundle picks up the refs from your local clone matice_sq, which is
different from the list of refs you'll see in the external source.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
