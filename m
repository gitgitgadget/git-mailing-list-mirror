Received: from smtp.smtpout.orange.fr (smtp-70.smtpout.orange.fr [80.12.242.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C13815F9
	for <git@vger.kernel.org>; Fri, 22 May 2026 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452936; cv=none; b=nmqXdUQlkW2WxpMccCxKwtjVxAUicMFJbuWXOx/q5CXRU3emD5M4UatBtGIP7JX5JwcCNsdYaU8DZQrydlgHfZna+839B+LhtLO0T65A2LXbicKFUhTZKjdC6TfdTlpi8OAxtl0qzFDDoJsV4Tut8gJjs8oSn72p/279x7cpVJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452936; c=relaxed/simple;
	bh=4Ti/lTT7XSReQoGGCbnvYhHZ8AUFsfVjuLIQaMwkL3A=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=M3H5ei2lOg3wQfk6RborbPoJ3XYblgNqHSIbPFJE/HpkZw/cbUSCi7pzF7OO+HXH6YsDNpfn3CFzpkI9+T7sCCcMuugBSvIR4seiAk75Ffi4CgKIbRV368OKbINIJqsyU1PoT16HEH2vlKX7dmfBV2bugbYEgVncNBfAJdXQCXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=orange.fr; spf=pass smtp.mailfrom=orange.fr; dkim=pass (2048-bit key) header.d=orange.fr header.i=@orange.fr header.b=O1BqdhAy; arc=none smtp.client-ip=80.12.242.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=orange.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orange.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orange.fr header.i=@orange.fr header.b="O1BqdhAy"
Received: from [IPV6:2a01:cb00:11de:5800:d09e:5b3d:9f12:a3c]
 ([IPv6:2a01:cb00:11de:5800:d09e:5b3d:9f12:a3c])
	by smtp.orange.fr with ESMTPSA
	id QOzcwqjSEXCmEQOzdw0M1o; Fri, 22 May 2026 14:28:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orange.fr;
	s=t20230301; t=1779452925;
	bh=3MiT4wDgF3rgKMmXH6RciZ1qz7xR1PAh6NGT7ct7Cq0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=O1BqdhAyM47OvTMyuoerj+4/DL8Fer9WiQb26HMuKYCs6P4JHJ044ZcVRQVSXivuo
	 A+mKmIN5pmE+lRYG4PXeW+USTa5g7JPoEJrI6icsJKcP6Ffz54Ag9bfQrsTUE/44Hi
	 ROFb4WiUWRLT06BzeJ8oaAMiafiTlGf5UimgsgcgvX8FYzC8hfmnT+cmlviesGcUxD
	 Vo+7O4hGi1qejo7xJwOvYVQVy7jOHs0fWbTzAQTa71lLtV/dt8+sL2BgvUb3IcWk5V
	 Cr+FzAzYE4U5AWHaqFrT4vazp8mvIS2efjdBER56alJt5GWyQAR3N6p8ZUBJUDdZaA
	 KZLXwJCP3e4jg==
X-ME-Helo: [IPV6:2a01:cb00:11de:5800:d09e:5b3d:9f12:a3c]
X-ME-Auth: ZmFicmljZS5zYWx2YWlyZUBvcmFuZ2UuZnI=
X-ME-Date: Fri, 22 May 2026 14:28:45 +0200
X-ME-IP: 2a01:cb00:11de:5800:d09e:5b3d:9f12:a3c
Message-ID: <36eec9c1-1d2b-4cd1-a64c-a02936d8a2ae@orange.fr>
Date: Fri, 22 May 2026 14:28:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, fr-FR
To: git@vger.kernel.org
From: Fabrice SALVAIRE <fabrice.salvaire@orange.fr>
Subject: Why do we need to wait 1s between a git add and commit
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear all,

I wrote a Python tool to dump a wiki to a git repository, that does 
basically a succession of subprocess calls to git add and commit.

Recently, I discovered this tool doesn't work any longer and that git 
commit (2.54 on Fedora 42 / 43) crashes randomly.

I cannot explain this behavior since my code is trivial.

I had the intuition to add a sleep time of 1s just after a git call, and 
it solves the issue.

I noticed for some cases that another call to git commit were 
successful. For most cases, git fsck and gitk report issues.

It looks like the state of the git repository was not yet completed 
before the end of the git subprocess.

Cheers,

