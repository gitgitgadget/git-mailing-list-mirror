Received: from mail.inka.de (quechua.inka.de [193.197.184.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4781D934D
	for <git@vger.kernel.org>; Sun,  9 Feb 2025 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.197.184.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739123774; cv=none; b=OxspbMLAuKgXaFv7KUJ4ABIp8AQFe+hs7nABba8FwoUdlf/UA7MaQkhdSvp2RMbyCmvl+k/iqFsXh4Z1EkjhELIthEH38TZFso6H/2luK0wP1f/0lOo/gNvBAnDYfr1eRJz2jrkPnWWL7nXkB4csYixJJJkybUyifbKT+cQQOd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739123774; c=relaxed/simple;
	bh=KzNmxowGagupWr63sIEk8fJISONZC61US8Mhd/sum1A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbaT/zSQRvzVLpJTOz1lRdM8xaHVQxm8lV3mB+w4XqKo7Lx0/cRLyGaO464HXlgfS7HBPnt10gWN9IHao0+7P9NxAgI1brKue2NnQZhHaluis0pPHkwkxneJs4FCqlpnnUkxOW/ZoXiaQPIG328Sk6IxfByzn5r09Z5hJCby7XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de; spf=pass smtp.mailfrom=raven.inka.de; arc=none smtp.client-ip=193.197.184.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=raven.inka.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raven.inka.de
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1thBXL-005Saj-0k; Sun, 09 Feb 2025 18:56:07 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id B1C5E60117; Sun,  9 Feb 2025 18:54:50 +0100 (CET)
Date: Sun, 9 Feb 2025 18:54:50 +0100
From: Josef Wolf <jw@raven.inka.de>
To: git@vger.kernel.org
Subject: Re: renormalize histroy with smudge/clean-filter
Message-ID: <20250209175450.GO30202@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de>
 <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
 <CABPp-BFnx2m75jsa3_kTPet97HY+xwb_6JmPiKM5+OARPy=mGA@mail.gmail.com>
 <20250207203248.GG30202@raven.inka.de>
 <CABPp-BFGUa_DRBe1WLVfCOKh53+F15KxW_c_OZAMwZCxuAQCiw@mail.gmail.com>
 <20250208205709.GH30202@raven.inka.de>
 <20250209092514.GM30202@raven.inka.de>
 <20250209111406.GA12069@tb-raspi4>
 <20250209150924.GN30202@raven.inka.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250209150924.GN30202@raven.inka.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Uh! It starts getting real wired.

After one more change to .gitattributes, one of the files marked as binary
checks out as an EMPTY file and I can't find any git command to fix the
situation:

  $ cat .gitattributes
  # Most files in ETS ProjectStore are XML with CRLF
  #
  * text=auto eol=crlf
  
  .gitignore     text
  .gitattributes text
  
  # Binary files
  #
  *.dat       -filter -text
  *.dll       -filter -text
  *.ver       -filter -text
  *.lang      -filter -text
  *.store     -filter -text  # <--- this is the problematic file
  *.ets5hash  -filter -text
  
  # Smudge/clean filter
  #
  */B     filter=etsfile
  */D     filter=etsfile
  */G     filter=etsfile
  */I     filter=etsfile
  */P     filter=etsfile
  */U     filter=etsfile
  */P-*   filter=etsfile

  $ git diff
  diff --git a/gt8/ETS/Projekte/P-0113/P-0113.store b/gt8/ETS/Projekte/P-0113/P-0113.store
  index c33a5239..e69de29b 100755
  --- a/gt8/ETS/Projekte/P-0113/P-0113.store
  +++ b/gt8/ETS/Projekte/P-0113/P-0113.store
  @@ -1 +0,0 @@
  -﻿4TamRjepVNV8F+bC4nBcBwXIymvb2IQdu0qEuMSB0o0=
  \ No newline at end of file
  $ git reset --hard
  HEAD is now at 6fba03d9 Fix .gitattributes again
  $ git diff
  diff --git a/gt8/ETS/Projekte/P-0113/P-0113.store b/gt8/ETS/Projekte/P-0113/P-0113.store
  index c33a5239..e69de29b 100755
  --- a/gt8/ETS/Projekte/P-0113/P-0113.store
  +++ b/gt8/ETS/Projekte/P-0113/P-0113.store
  @@ -1 +0,0 @@
  -﻿4TamRjepVNV8F+bC4nBcBwXIymvb2IQdu0qEuMSB0o0=
  \ No newline at end of file
  $ rm -rf P-0113/ ; git checkout P-0113/
  Updated 382 paths from the index
  $ git diff
  diff --git a/gt8/ETS/Projekte/P-0113/P-0113.store b/gt8/ETS/Projekte/P-0113/P-0113.store
  index c33a5239..e69de29b 100755
  --- a/gt8/ETS/Projekte/P-0113/P-0113.store
  +++ b/gt8/ETS/Projekte/P-0113/P-0113.store
  @@ -1 +0,0 @@
  -﻿4TamRjepVNV8F+bC4nBcBwXIymvb2IQdu0qEuMSB0o0=
  \ No newline at end of file
  $ git ls-files --eol |grep P-0113.store
  i/none  w/none  attr/-text              P-0113/P-0113.store
  i/lf    w/crlf  attr/text=auto eol=crlf P-0113/storeVersion
  $

-- 
Josef Wolf
jw@raven.inka.de
