Received: from mail.codeberg.eu (aburayama.m.codeberg.org [217.197.91.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1673733F37C
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.91.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620161; cv=none; b=IBMXBPj/NVcPE8kh54M58OPqfxx2mMSSTSMXIylnDVOwaMEDb439oDHNqinOsC3YjSjLkst7Xqg5aSuCf9Fd5ZeFvw8KulpNY8De+aXS0fPQK5JcZLGwRjGBRgxV2sN4nkxXcy9Fkgz4vnrskuAAJvhG7WzVwKQ6DRSZZAtepf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620161; c=relaxed/simple;
	bh=bTD0mC9fcnIHBWRnvhmB2aIpygnhpdlH7JQ7TIfrTpw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=TGk8wVmO2Ur6jEPqb8SnjB0lYkbK7y0RPppbXYiMrYju2sHpVXeUToojp3MHqVeQ8YC5wxt7hFMHWa9dz5T/gI88Thw0mjkE4dMOlmNrZIaRtSDsFCN6nMerRLhFlXAirqSvmLOfxcJTY5JbooXKHF1Yk4PZuSdW2UY3UtPKVSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeberg.org; spf=pass smtp.mailfrom=codeberg.org; dkim=pass (2048-bit key) header.d=codeberg.org header.i=@codeberg.org header.b=oijY47cV; dkim=permerror (0-bit key) header.d=codeberg.org header.i=@codeberg.org header.b=OwKSK1x2; arc=none smtp.client-ip=217.197.91.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codeberg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeberg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeberg.org header.i=@codeberg.org header.b="oijY47cV";
	dkim=permerror (0-bit key) header.d=codeberg.org header.i=@codeberg.org header.b="OwKSK1x2"
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=codeberg.org; c=relaxed/relaxed;
	h=Subject:From:To:Date:Message-ID; t=1767620156; bh=djlR2NTsTMO/y97MJQRTctx
	du1gufNouttDhDqF2mX4=; b=oijY47cVbGSGTGof2JY584sLF6oFBurCyK7P9MoacHT7KJiMtP
	57+X84M58fj1kdB79yMYcbVuPdjFCc00FX990oIbob60kICerKmMAAMUBjs8OfoFCHCgZ4NKzTp
	2qCbNRsRISgyx6igSNkEjyWtTELIdXYhE4jEjMlc4J5ThEmuF60V6rzn5JsNTeDjw0JbAUrNfNR
	dGKmYLCFbK2oiGq5loxDBXNu74n5INuXJ28IpT1tFEnfMJOlChnjCfJi0M6zPolgCNGTxiNqDlE
	vuV+0sM2ARIXeFH2lYD//V4rJN91cZ/d5OOwWLcgKXan75TMCMVE3MAv1TY+8TC0R8w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=codeberg.org; c=relaxed/relaxed;
	h=Subject:From:To:Date:Message-ID; t=1767620156; bh=djlR2NTsTMO/y97MJQRTctx
	du1gufNouttDhDqF2mX4=; b=OwKSK1x2ITQ70vFWL43iVDoYTcT01curdzU9yaMA0YJrXxQ2Wn
	/rsBvXa0AO+kJ3o6ZlwUlxO6l/bIXBcbbcDg==;
Message-ID: <09870987-ae2f-44ec-b8a0-1654f598b5fd@codeberg.org>
Date: Mon, 5 Jan 2026 14:35:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Gusted <gusted@codeberg.org>
Subject: git-last-modified on bare repository
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Now trying to actually make Forgejo use git last-modified after being 
pointed to the non-yet-documented options but I quickly noticed that it 
looks like it does not work as intended on bare repositories when 
looking specifying files.

$ git clone https://codeberg.org/Gusted/math-accuracy
$ cd math-accuracy
$ git last-modified -- LICENSES
768f05837e7db2832425bc3b65d0f524e81b2769        LICENSES

And on a bare repository:

$ git clone --bare https://codeberg.org/Gusted/math-accuracy
$ cd math-accuracy.git
$ git last-modified -- LICENSE
fatal: ambiguous argument 'LICENSE': unknown revision or path not in the 
working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

Is a worktree required for this to work?

Because it was talking about revision, I quickly checked a refspec as 
input and it looks like I found another way to trigger a BUG.

$ git last-modified -- HEAD:LICENSES
BUG: builtin/last-modified.c:456: paths remaining beyond boundary in 
last-modified
[1]    202076 IOT instruction (core dumped)  git last-modified -- 
HEAD:LICENSES

On the bare and non-bare repository.

Kind Regards
Gusted
