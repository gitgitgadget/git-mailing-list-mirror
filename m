Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D8122094
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752313690; cv=none; b=ABt9nQm517BzF2HJq+LEh6AzcLQAVxsR5X8eh1IXuokzMKXXi7E+FKELVRCK87UgB2GlSA/5fTRivFCK610qlffh8dzusJfzdyFrFtyPHwHhwkdDpQq7KOuR97AJxM6WaLAlAAcrYL215A3gxMMCbfjyJnTuJ1K82+GMqTH4lAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752313690; c=relaxed/simple;
	bh=yTfB6C9kGL3bC5tptlxMfwVa+7xhwpbXMnk1fm8b/ss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=araVavP4BI9IvL69PDs9rLeQ84RawrvBXD62cQutorutAwBJ/uxTaeO+izQ0pw7qvWS7B8i06Gzky0BSpZy9KpWYXiqBxGHDNm+zFGVDyNZDAeaJkgWnKu1wPj4rYxvURRigU+j4RBS0vnxK9NRmSMfT72xQZ64mETYyNdeodZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4bfNn73SZYz1sG7q;
	Sat, 12 Jul 2025 11:38:35 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4bfNn733nLz1qqlW;
	Sat, 12 Jul 2025 11:38:35 +0200 (CEST)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id xoB7vCjJwU_q; Sat, 12 Jul 2025 11:38:25 +0200 (CEST)
X-Auth-Info: +4PJB5rwhbGCsj/b7Fz9nvZWfMqOzpj5g8YFvCe76Isa7zFmg4sj63LlL+mP+Gqo
Received: from tiger (aftr-82-135-83-85.dynamic.mnet-online.de [82.135.83.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Sat, 12 Jul 2025 11:38:25 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ross MacArthur <ross@macarthur.io>,  git@vger.kernel.org
Subject: Re: [BUG] gpg.program: '~' not expanded to home directory
In-Reply-To: <xmqq8qkuxoh3.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	11 Jul 2025 17:05:44 -0700")
References: <CAF1X4d7N1xdZt9JkVZytbEU1=7q3X_F_nqm4EG82B8-cVa7g8Q@mail.gmail.com>
	<xmqq8qkuxoh3.fsf@gitster.g>
Date: Sat, 12 Jul 2025 11:38:24 +0200
Message-ID: <87ple521gv.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Jul 11 2025, Junio C Hamano wrote:

> I think that is correct; I do not think gpg.program is to give a
> path to the program, so comparison with core.excludesfile is
> probably not so appropriate.
>
> It gives a command line, e.g. "mysign --compat=gnupg",

gpg-interface does not use the shell to run gpg.program, so this won't
work.

$ git config gpg.program "echo --compat=gnupg"
$ git commit -m foo -S
error: cannot run echo --compat=gnupg: No such file or directory
error: gpg failed to sign the data:
(no gpg output)
fatal: failed to write commit object

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
