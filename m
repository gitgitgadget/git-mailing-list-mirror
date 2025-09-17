Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759C33AEB7
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122769; cv=none; b=NXmPBH6a0I52hPOGdmI7yw3qgtYvBR3qwugX5Py5GvlurZOCJJ8HarhCxArV0nV8yjE7vy4iyF8krY25dmZxAkqSv+vrHiUrA+oE0pDXE/pKD46K0bG4AEuJFw5f70hnUpg2cEun4QHZwojkt1PUelqsR2nRuibqn2/3qEM9aRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122769; c=relaxed/simple;
	bh=KHRbsZRlhS5TATenMIrcavfCLtq0MFKZMnUo6f09q54=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IxAVwsfKQOLhdq9VTr19RdbkSgTN/Nkd0ptKPQkOIYuwQLB7oaMuQUwji+o581jj+5RUtuH/F+IafuZ+N9DMlIFcBE04Vd0gW0bglp2+6pT+rkq6LCyDmy+b6j0F4WUiaI3BLlNNEP5gapUVuvIn33OX2gJjv+wJQQVU29xHzOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=vkVAuW24; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="vkVAuW24"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=KesOoo0eFs/1V7xPi1B/ik0c1EnAR0H1ZQaSQkhPfXk=;
  b=vkVAuW24V6XCLBmVBybi77uZMvgv/OFqtiF8e+1Lhed5nDL+BsKdx6rf
   2ECH7339wmXd3bhRSx4cJYp5iiu8XoTJN91hNsOENOJ0Z4t3eYoxFVzMG
   y/HhaV0jZxlgPxYxuq6CEIZSuHV5XFFs2BqidkoTpf2/VoybAkvUwvbOF
   o=;
X-CSE-ConnectionGUID: VpE0AiRsRoGeaOaig7k8UA==
X-CSE-MsgGUID: 0wNdHGCpRRWBhg/SqHdiqQ==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=gabriel.scherer@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.18,272,1751234400"; 
   d="scan'208";a="125804980"
Received: from nv852.math.univ-paris-diderot.fr (HELO [10.0.1.102]) ([81.194.30.237])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 17:25:55 +0200
Message-ID: <a27a8191-55d7-4b60-ad90-59ab946340bd@inria.fr>
Date: Wed, 17 Sep 2025 17:25:54 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] checkout: provide hint when failing due to another
 worktree
From: Gabriel Scherer <gabriel.scherer@inria.fr>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20250913141327.2775228-1-gabriel.scherer@inria.fr>
 <20250913141327.2775228-2-gabriel.scherer@inria.fr>
 <be510685-3be1-4f71-806a-6b580bb1cf21@app.fastmail.com>
 <d44109a1-0ff5-49f8-885b-9aae195ec492@inria.fr> <xmqqikhkhzbm.fsf@gitster.g>
 <0dfe3e31-5486-446e-8af5-20669c06ea64@inria.fr>
Content-Language: en-US
In-Reply-To: <0dfe3e31-5486-446e-8af5-20669c06ea64@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear git developers,

On 15/09/2025 21:52, Gabriel Scherer wrote:
> (This gets me to wonder if a desirable behavior could be to 'detach' the other worktrees that had the same branch checked out, instead of failing on checkout. Users starting to use the other worktree again would possibly notice more quickly that something is amiss.)

After the new feedback from Junio, I wonder if I should explore this 
suggestion more actively.

For now my goal has been to make --ignore-other-worktrees more 
discoverable, for people who are willing to take the risk. (I am 
comfortable doing this as I have used this workflow for years without 
much trouble with the 'workdir' script, but clearly you want to be very 
careful in how exactly we suggest that it is a possibility.)

Would you prefer a different option to detach the branch at the other 
worktrees? This could be
   git checkout --detach-other-worktrees <branch>
for example.

I did not originally consider this as it requires more expertise in git 
internal data structures, but it may be easier than finding a way to 
advertise --ignore-other-worktrees that you are really comfortable with.

