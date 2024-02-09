Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5063176042
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494534; cv=none; b=QYmjCOiYAHVPlaqchH2vsFpNMs7gpoNhS50C939qK8IdjDWSmftDsJLlTO2N3yJm6s0XPMBdYwaukdA56oOVz+hbTkW5ZZqnK1nvcvnQ2sv5DluP4dmSs6OcRkQ9Rby2MvcmtQqtyVE1A69MmpWnwSM/brpASLkK8ajI2/IDkxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494534; c=relaxed/simple;
	bh=Kr2353sAfHSLzVIX2E2goPw+Gj0WoL+kAfEQqW5JCHc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=SlmmusjLdao6NHmHaRQRVAtv9frYAzFx1QWlc/9N79pzFOACLoCrLCWBNzXUF9iBA9POkJ3dx4QkTEjV3FKMq6NgQKIup0UYZBM+yCAeIzKXxNx4nChWqis19wX01bfJm+oGMWztkAat9CurYZWXYbxyRzRcP/v3MTiK2UO2mRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=aD331OsD; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="aD331OsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202308231025; t=1707493962;
	bh=jqWAYf8QqWaDo3w3AOXBAi8tl0oZ/IEcgldiGpWDjvc=;
	h=Date:To:From:Subject:From;
	b=aD331OsDjENazgyiVI2mXTWbyfi5zvwG7j6dFaMJ+LvjlD2ZpGPbUZ0dZZV6YZ/61
	 1rjhrU9NlNgVaMCPx5xnhIC5SrAZcant+lTT5Mc0W/fE1TbNNJG+SpBxtCSWZNDHwq
	 c0YKr5NEPU9KWo6Wv6gj8w1fJaK2EaoGZVB9HCSVy5jrTokvEBcV1xeWfskjsep2Ak
	 RgmTNq5gWPYI7bJGfWORIEMmdwL2LaCnKzBKxM9BTwTAD/FyuXXBjR765SVZ/MtCs0
	 47foXxRSUFQdWofwIiXkGyMiBbSUPkUV1P3dW/EryIx7R2a7M+Ww+7f+apfocEN/X2
	 1Nc/0vOE8O5eg==
Received: from [192.168.178.30] (unknown [159.48.47.80])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 902A73C0246
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 16:52:42 +0100 (CET)
Message-ID: <424f2e08-a2ad-4bb2-8a6b-136c426dc127@haller-berlin.de>
Date: Fri, 9 Feb 2024 16:52:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE, en-US
To: git@vger.kernel.org
From: Stefan Haller <lists@haller-berlin.de>
Subject: Interactive rebase: using "pick" for merge commits
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

When I do an interactive rebase, and manually enter a "pick" with the
commit hash of a merge commit, I get the following confusing error message:

error: commit fa1afe1 is a merge but no -m option was given.
hint: Could not execute the todo command
hint:
hint:     pick fa1afe1 some subject
hint:
hint: It has been rescheduled; [rest of message snipped]

This error message makes it sound like I could somehow add "-m1" after
the "pick" to make it work (which is actually what I would like to be
able to do). I had to go read the source code to find out that that's
not the case, and the error message only comes from the fact that the
code is shared with the cherry-pick and revert commands, which do have
the -m option.

Is it crazy to want pick to work like this? Should it be supported?

-Stefan
