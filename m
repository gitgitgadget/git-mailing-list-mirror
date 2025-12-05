Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5B723D294
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764916814; cv=none; b=I7vAdrpwmX+P8WAymiODlDO6Ep+sIUM4jb9BEaQnRcpEwTfxVSdGkdBqeMmhia0iu/rG55JYi7KFXF70JOrocpQRhUeVE8Gk5NXZEHhyPc3YAVLfLP8ETMgjOQIdDOVukWgZf7BmP01rZpIvPWaMqXsgZkRdM9Pi8ZtdSHE54iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764916814; c=relaxed/simple;
	bh=A4VCQymH+0wbARSPR9T4F144vaqlmNyWm13RtDIskk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RST7gVIb0aejot96gztK7Jh5bsXhh5ObGshN0gYBFVjHZ9VSTCT6JE6bXz4nNxYkHlol/W79XTLV3qeD4hfYyDIBK68jqXd8rYs/AgFqXz6jo0fWAuVJECoT8Amef9rnZS9mQVp0XQCEpn63cJpz2jjcO5ZAai/2m4pB1FoiJDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4dN1vk4sXmzRnlJ;
	Fri,  5 Dec 2025 07:40:02 +0100 (CET)
Message-ID: <db513191-5f3d-489e-b91a-a788f70b9e8c@kdbg.org>
Date: Fri, 5 Dec 2025 07:40:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gitk: fix history window panes position
To: Junio C Hamano <gitster@pobox.com>
Cc: "tobias.boesch@miele.com" <tobias.boesch@miele.com>,
 Git Mailing List <git@vger.kernel.org>
References: <AM0PR08MB5426BC141388A69BB5087732E1D8A@AM0PR08MB5426.eurprd08.prod.outlook.com>
 <9a9441d5-fb64-4718-8765-852e66458598@kdbg.org>
 <DB8PR08MB5433FCF25C0693952E0E67BEE1A6A@DB8PR08MB5433.eurprd08.prod.outlook.com>
 <9f7af47a-ae39-4931-805d-f6e4549231ac@kdbg.org> <xmqq5xal8y5s.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqq5xal8y5s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 05.12.25 um 03:23 schrieb Junio C Hamano:
> "git am" (actually "git mailsplit" that is called from it to extract
> what can be used by "git apply") should be able to deal with
> 
>     Content-Type: text/plain; charset="utf-8"
>     Content-Transfer-Encoding: base64
> 
> so there may be something else going on.

Ah! You are absolutely right! Clearly, I wasn't fully taking in what
git-am was telling me. The problem isn't the encoding. It's the patch
text itself, in particular, the single SP needed for empty context lines
is missing.

I get this error when I apply the mbox containing the complete email:

$ git am -3 --signoff ~/Mail/ambox
warning: quoted CRLF detected
Applying: gitk: fix history window panes position
error: corrupt patch at line 40
error: could not build fake ancestor
Patch failed at 0001 gitk: fix history window panes position
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: [...]

But it is OK to copy the email body text to a file (which looks like
mbox text) and apply that, despite the missing SP:

$ git am -3 --signoff bla.patch
Applying: gitk: fix history window panes position
Using index info to reconstruct a base tree...
A       gitk-git/gitk
Falling back to patching base and 3-way merge...

Why is that?

-- Hannes

