Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2532F81737
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024339; cv=none; b=ATOYVkgTNZeqDxzXQQa0aZYK+0G6vdwQWbN4t4vTm74+NBuZ5B+368Yqn5Dx+BV/XRykVbDudNZ5X3IPMaEqI950F+3DHe39i4sYvYTenqcM2Rg95CQmZaeekoeuUjv/wbp9rmTBuFve7dUQlhQP/lVHirK6PaY5P6TeEBuSMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024339; c=relaxed/simple;
	bh=k2M7mmb65oL7Sq4kkyxHjH6iglcbU2C+sOtYPARpz4k=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=fOksf2fyvkXmbKvgCepmIbfQDpW5P71pGj112ADTVEoyDjwTNYdzL6/DaBBmWD1xhbMZkt7XFgxLsnUgkXygTRsc2OLjFcpu81J6rv9BHoqeX6iobZSezDMgL+FcmzaP0H0rF/A3vQTBME+CNO41HMzq6onxiP9T6Gy4iK4DQEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 45ACwkpX1707197
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 12:58:47 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Arpit Gupta'" <argupta@axway.com>, <git@vger.kernel.org>
References: <DB9P190MB1500D7DE16D758B8710BEFC7A7C62@DB9P190MB1500.EURP190.PROD.OUTLOOK.COM>
In-Reply-To: <DB9P190MB1500D7DE16D758B8710BEFC7A7C62@DB9P190MB1500.EURP190.PROD.OUTLOOK.COM>
Subject: RE: Issue : Writing commits into the git repository takes longer than expected
Date: Mon, 10 Jun 2024 08:58:41 -0400
Organization: Nexbridge Inc.
Message-ID: <0e4b01dabb35$eee8b5a0$ccba20e0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF4DG4MFdfvRaN7TPEOZFDOPnfyRrKGUeXg
Content-Language: en-ca

On Monday, June 10, 2024 6:17 AM, Arpit Gupta wrote:
>We are maintaining the different versions of data in git repository using
jgit maven
>library. So, a commit is done on the repository containing properties such
as author
>name, date and time, action, and the file path.
>The file path refers the xml file which contains the action performed and
is stored
>inside the repository.
>
>We have a job running every 5 minutes that commits the information onto the
>repository and the XML file content is over-written every time. Usually,
the commits
>and writing of XML file takes around 4-5 seconds but sometimes the time
while
>committing as well as writing the data increases which also increase the
overall CPU
>utilization of the machine. This behavior is inconsistent with respect to
the process
>and occurs randomly but during this behavior, there is a time when the CPU
>utilization becomes high that all other running processes hangs up which
demands
>the restart of the server.
>
>Could you please suggest which areas should we look for while identifying
the cause
>of this issue? Also, does frequent commit of the content onto repository
can trigger
>this issue?
>In your view, what might be the trigger of this issue and how we can
proceed to
>resolve it?

Are your XML files single line file or is each tag on its own line? Changes
to single-line XML files can cause complete rewrites. If the file is large
enough, this can cause performance issues.

Do you have virus scans running on your repository? These can also cause
issues. Some scanners are more friendly to developers than others. Also, is
this an NFS drive? Is Git LFS involved?

If you have two commits to the same repo happening at once, this can also
cause one commit to be delayed waiting on the lock file. More info is needed
to comment further.

--Randall

