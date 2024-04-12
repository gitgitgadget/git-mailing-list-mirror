Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0664914B06E
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712942388; cv=none; b=L2Z4shEnkC7OF17F5j/8yDTullvLrdlrwlNLuKqdIkfwov69F/1Uhcor3fFzOnx+cmbgcWjKfxXSgPhn93468sTLMCVotMCxy8onoNDB07ThXSrEsCk+0uXOSHBsDuX9PvPmyqhzHNqAVB9diyXrYn0E1WqL6c22r7u6ITw1/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712942388; c=relaxed/simple;
	bh=TDQCWdV9mtFldNyvcnGikugg+qHRMAM/Lk/i0fFIXz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kelf/3AEVqoLj7tE8MVG/GPXmI4Y8v9djRUPWD0K94bDtdQNWkkVjAytnL67tHXBEzcnsm1uAKrakaIMjX3JthYrMjPutBbHw52ug4fTlJn8EQICHrpz+NT9f4qyLLPzMRBlKg21NQkkYmcifA6tweiRtJ9EAGhzTwhDim6sR+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amyspark.me; spf=pass smtp.mailfrom=amyspark.me; dkim=pass (2048-bit key) header.d=amyspark.me header.i=@amyspark.me header.b=oHRU+LrT; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amyspark.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amyspark.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amyspark.me header.i=@amyspark.me header.b="oHRU+LrT"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D8B1F60002;
	Fri, 12 Apr 2024 17:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amyspark.me; s=gm1;
	t=1712942383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tC21EiTd1BDNkCytWtXkmnrJBQ/Aaf98kFJsDqaxTSw=;
	b=oHRU+LrTfDt/MEk7eVlmxECVk8KWpnNfGgo0iLegLFWTO/1O6kDx2QGhzdajgix4sqJzxG
	SW2VGH6HzBNzzoGq5CziayeoyGcdgOK6yTGup0ouhG3srm7mqau1rfbaRM0X/e6tKXniey
	aHDjhMcbu38FukKZw8Hm7wNj8Ja094MC5bNsRdE6fM1rH0GresQQ/2nyVDlv5JW3wOYPtO
	cZXxBGlXMWJGidfxrOp87gCOb9LcRcszWMu9z2i4x1jg9+JZfFX5BAeAwXY3CmkSDfdRNE
	+RQNGdkHfaaUNSW0ahMNyGwdbTwx70kDw8dVnCpTwfzbg0AUiXq/BOQ3CbRy8A==
Message-ID: <1011527c-f50a-46ea-b68e-29dec7845003@amyspark.me>
Date: Fri, 12 Apr 2024 14:19:33 -0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [BUG] Clones from local repositories do not work correctly under
 Windows
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
References: <44020a6a-707f-4505-adde-e79cda63d711@amyspark.me>
 <2f069d1f-aa4a-4259-9cc5-dcf912f59a17@kdbg.org>
 <e25bbce7-8338-430b-865f-690fe3c94fb6@amyspark.me>
 <01cf64db-2ff5-4be5-8968-d280ab0ffc50@kdbg.org>
Content-Language: en-US
From: "L. E. Segovia" <amy@amyspark.me>
In-Reply-To: <01cf64db-2ff5-4be5-8968-d280ab0ffc50@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: amy@amyspark.me

Hi Johannes,

Indeed there are two -- one lives under the MSYS2 prefix, the other
under Program Files. However, Cargo seems to access the Git data
directly, so I believe you're right -- it's not able to understand the
path syntax.

As for MSYS2, so far my testing points to an inability to chain back to
the original clone. Given the mixup of installs, it's best to focus on
fixing that.

Thanks for the explanation!

amyspark

On 12/04/2024 13:16, Johannes Sixt wrote:
> Am 12.04.24 um 15:05 schrieb L. E. Segovia:
>> Under a MSYS2 shell, follow these steps (feel free to replace the choice
>> of remote repo with any other supporting a Rust crate):
>>
>> 1. `cd` to a directory of your choice (let's call it `dirA`).
>> 2. `git clone https://gitlab.gnome.org/GNOME/librsvg.git .`
>> 3. `git checkout -b cerbero_build`.
>> 4. `cd ..`
>> 5. `git clone <full path to dirA> -s -b cerbero_build dirB`
>> 6. `cd dirB`
>> 7. `git status`
>>
>> Now switch to any other shell of your choice, such as Git Bash, CMD, or
>> PowerShell, and try issuing commands such as `git status`. It will
>> result in a wall of "error: unable to normalize..."
> 
> Thanks, that is much more helpful. Here are my assumption, my
> explanation of the symptoms, and the conclusion (which is basically "if
> it hurts, don't do it"):
> 
> I assume that you have two installations of Git. One installation is
> used when you use the git command from the MSYS2 shell; it is the MSYS2
> version. The other installation is Git for Windows or equivalent that is
> used by all the other shells.
> 
> When you clone a repository with -s, a .git/objects/info/alternates file
> is initialized that contains the path to the original repository. You
> can see its contents with `git count-objects -v`. I tested the
> reproduction recipe with my own build (which is a MinGW build, much like
> Git for Windows), and it looks like this:
> 
> C:\Temp\repoclone>git count-objects -v
> count: 0
> size: 0
> in-pack: 0
> packs: 0
> size-pack: 0
> prune-packable: 0
> garbage: 0
> size-garbage: 0
> alternate: C:/Temp/repoorig/.git/objects
> 
> See the last line? It begins with a drive letter. When you call the
> command with the MSYS2 version, it will look more like this:
> 
> alternate: /c/Temp/repoorig/.git/objects
> 
> This is the MSYS2/Cygwin absolute path with a "drive letter".
> Unfortunately, this kind of path is unintelligible for Git for Windows.
> It expects absolute paths to begin with drive letter-colon or a
> double-slash or double-backslash. For this reason, it reports "unable to
> normalize alternate object path".
> 
> The conclusion is: Do not use two different flavors of Git on a
> repository that is set up with a link to an alternate repository.
> 
> BTW, I did not do the followup test with `git am`. (Actually, I did, but
> there were no errors.) So, I cannot tell why your MSYS2 version suddenly
> also reports the "unable to normalize" error.
> 
> -- Hannes
> 

-- 
amyspark 🌸 https://www.amyspark.me

