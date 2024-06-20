Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB7A482ED
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 22:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921103; cv=none; b=qZJ1x8K6v7DCuiWIGuAdOgI440Kcd/7uBtsjcityKW0Dj02eYKG0F932v8pIcZf/W4z2sjMwoQPObzdJMpLuRDEmbLXeqJ9aWqG0UnrkE8gGAS57e07BjyspieKtc8+CkMJxpbT5dksmQ2cI7evxmL1MGpus36Cwaebh8Fftjy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921103; c=relaxed/simple;
	bh=l00O3vC1dsPdmrWwU9qg0CIU3XvRM3Ln93Tp5H0yLx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fg2GTHnexrqrwC7zrZux26nG9MTDbeDeHRt4q56S97Wod/VggasLJhmarVza0zydO8SfH/NqUeg8F0Uj2vxeNF7nCOwM9DJN3WlwVOXtYEKJvxiJgDNcCEZRDEmv5bXCzVwQjXs1S2vJULDzZza64k29UpJ62QKX8XWIoFSR9HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.105] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4W4vfp2fNJzRpKd;
	Fri, 21 Jun 2024 00:04:50 +0200 (CEST)
Message-ID: <0c845460-c211-48e6-af93-a0b483817420@kdbg.org>
Date: Fri, 21 Jun 2024 00:04:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix default font scaling
Content-Language: en-US
To: Serhii Tereshchenko <serg.partizan@gmail.com>
Cc: git@vger.kernel.org
References: <20240615085345.47278-1-serg.partizan@gmail.com>
 <5dd4de8a-255a-4f03-b4d8-fc160b3178e1@kdbg.org>
 <Q1B6FS.FVKOG950Y3UN@gmail.com>
 <abee589d-5bad-4376-ba91-3bd611936983@kdbg.org>
 <N75EFS.1X38FZPYSV94@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <N75EFS.1X38FZPYSV94@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.06.24 um 20:11 schrieb Serhii Tereshchenko:
> Yeah, I'm also testing this way.
> 
> No, fonts should not be independent from DPI, but now some fonts are
> scaling just like the others.
> 
> To clearly see the result, set comfortable DPI, so fonts are reasonably
> sized (if this value is close to 96, better use something larger, like
> 130 or 200 to see the effect).
> 
> When you run "git-gui" from the master branch, look at the fonts for:
> 
> - menubar and menu (explicitly set, scaled with DPI - our baseline)
> - buttons in the lower part (Commit, Rescan, etc), labels like "Current
> branch" - (unscaled, visibly smaller than menubar)
> - you can also open "Edit -> Options", and everything there will be
> smaller size as well.
> 
> After applying patch, all fonts are scaled equally (e.q. - small DPI -
> everything small, large DPI - everything big).
> 
> If, however - you see second behavior on both cases, I'm really
> interested to get more details:

I see the second behavior regardless of the patch, i.e. with small DPI
all fonts are small, with large DPI all fonts are large.

The label "Current branch" is the same size as other fonts except when I
select a different font size in Edit->Options as "Main Font".


> - What OS and Tcl/Tk are you using?
> 
> I remember few years ago it worked fine on my ArchLinux, so if other
> distros aren't updated something yet, it may still work.
> 
> On Arch we have Tcl/Tk 8.6.14.
> 
> And to go even deeper, we may compare results from `wish`:
> 
>> package require Tk 8.5
> 8.6.14
>> font configure TkDefaultFont
> -family sans-serif -size -12 -weight normal -slant roman -underline 0
> -overstrike 0
>> font actual TkDefaultFont
> -family {Nokia Sans S60} -size 9 -weight normal -slant roman -underline
> 0 -overstrike 0

I have this:

% package require Tk 8.5
8.6.12
% font configure TkDefaultFont
-family sans-serif -size -12 -weight normal -slant roman -underline 0
-overstrike 0
%
% font actual TkDefaultFont
-family Arial -size 9 -weight normal -slant roman -underline 0 -overstrike 0
%

I am using openSUSE Leap 15.5 under KDE Frameworks 5.103.0

-- Hannes

