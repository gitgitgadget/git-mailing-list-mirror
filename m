Received: from host2.softartinc.com (host2.softartinc.com [172.233.143.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103211A4E67
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.233.143.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725308299; cv=none; b=BIU6Y6C4xAThejlswk1ORuWSVA54qxdoo5d4D9/yr2iNJs8ppUOU1s5gWDQaTwv47ppaWRWnPgIm0F4DmN7fGRDzi9FfwotmK6OGuKy0rFip2AWhgtjeqUgOTVandzpcw5fVRguR23Bvced5BuhSa2WU7Thfe6d/jI2oaoApjqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725308299; c=relaxed/simple;
	bh=l8hxUz1Rc7JRkZxZnNmvtCmSZgz1QGwPFDweGHq7m0Y=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=hr/eMEZBVaexDqybRcrdSF+2+9uW2xxbsFUVEg4zSCYsrVAJB1AIMRVOrBk1jSVkFGrGBYY11Kjr9UX1ufr2ssHb7lceQtwXvdy/cIiANqZmzxjoTJ9nbjqxCeTC5bO83yFYJxZjDRWn3eJm0mOsBB+/knmIuhEwEirrOPq2dNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyper-plaza.com; spf=pass smtp.mailfrom=hyper-plaza.com; dkim=pass (1024-bit key) header.d=hyper-plaza.com header.i=@hyper-plaza.com header.b=LvM6uAjv; arc=none smtp.client-ip=172.233.143.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyper-plaza.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyper-plaza.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hyper-plaza.com header.i=@hyper-plaza.com header.b="LvM6uAjv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=hyper-plaza.com; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:In-Reply-To:References:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l8hxUz1Rc7JRkZxZnNmvtCmSZgz1QGwPFDweGHq7m0Y=; b=LvM6uAjvTxT6e+ZSRGAvV6naCI
	U29mHKvxcj5jRqT3/DWwvEhairEVyGOhUGN5929jdzmuV4gN8NgWBoLyuRqr0eKLP52E5q+a0w5v0
	+L5Sv7BLbDq+1PGpPSSsDVPR1swxZ2X7ihnAiugHqM5SeUsDx8kqXEOBXB5em7HSugjk=;
Received: from 99-112-82-227.lightspeed.irvnca.sbcglobal.net ([99.112.82.227] helo=Apollo)
	by host2.softartinc.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <forums@hyper-plaza.com>)
	id 1slDVB-001CLI-0R
	for git@vger.kernel.org;
	Mon, 02 Sep 2024 13:18:17 -0700
From: <forums@hyper-plaza.com>
To: <git@vger.kernel.org>
References: 
In-Reply-To: 
Subject: git-http-backend errors under IIS
Date: Mon, 2 Sep 2024 13:18:16 -0700
Message-ID: <001301dafd75$3f95bdf0$bec139d0$@hyper-plaza.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adr9X+4bngDqrfUnQJmUf9EyqR6lnQAFShvA
Content-Language: en-us

I=92m getting errors trying to execute simple git clone from IIS-hosted
git-http-backend to a local folder.

Setup:
Host: fresh install of x64 Windows Server 2022 Standard on i7-11700K @
3.60GHz with 32GB RAM & 2x 1TB SSD drives, named =91zeus=92, IIS version =
10.0.
Host has the latest 64-bit git version 2.46.0.windows.1
Client: either the same machine or Hyper-V VM on the same box with 1 =
Virtual
CPU & 4GB of RAM running Windows 10 Enterprise LTSC 21H2. VM has 64-bit =
git
version 2.37.0.windows.1

IIS is configured with dedicated =91git=92 website running on port 80 =
with its
own app pool and local =91git=92 user as identity. There=92re no other =
sites on
that port and I stopped the rest of the sites anyway. The site has =
Anonymous
authentication disabled and Basic Authentication enabled with CGI
Impersonation =91True=92

Test git repository myproject.git was initialized from command window in =
the
host folder pointed to by IIS =91git=92 website using command:
git init --bare myproject.git using git version 2.46.0

Test case 1:
git clone http://zeus/myproject.git executed from the host command =
window
using test user credentials results in error:
>fatal: http://zeus/myproject.git/info/refs not valid: could not =
determine
hash algorithm; is this a git repository?<

Please note the path myproject.git/info/refs doesn=92t even exist in the =
repo,
the folder myproject.git/info/ contains single file =91exclude=92 and =
nothing
else.=20

Test case 2:
git clone http://zeus/myproject.git executed from the VM command window
using test user credentials results in error:
>fatal: unable to access 'http://zeus/myproject.git/': Header without =
colon<

If I execute the above commands with host Administrator credentials they
both succeed with correct warning (the repo was just initialized):
>warning: You appear to have cloned an empty repository.<

So far the issue sounds like some permissions problem, especially taking
into account when I tried to make test user member of the host
Administrators group both commands worked after iisreset.
Unfortunately I was unable to figure out what permission(s) are missing, =
the
user clearly passes authentication step and executes =
git-http-backend.exe as
I had different error when it was unable to.

What is really odd if I downgrade git version on the host to 2.44.0 then
everything starts working as expected for the test user as well even =
after I
removed it from Administrators group and performed iisreset, the rest =
was
the same: =A0the site / permissions / etc

I actually started from version 2.37.0 thinking may be it would make a
difference as I recalled the similar set up was working under 2.37.0 and =
to
my great surprise it worked indeed. Then I decided to =91upgrade=92 the =
version
and 2.44.0 was the latest one that worked from the versions I tried. I
believe I also tried 2.45.2 and it gave the same errors as 2.46.0 so I =
left
it at 2.44.0. I didn=92t try any other version between 2.44.0 and =
2.45.2.

Since this issue misleadingly looks like =91permission=92 one and the =
error
messages are really odd and it cost me a day to troubleshoot I decided =
to
publish it here to possibly spare someone major headache.

Please let me know if I=92m missing something obvious or if it=92s =
indeed a bug
that very well may be specific to my environment which triggers some =
racing
condition in the code.=20
If there=92s an interest in tracing this problem further I can easily
reproduce it as the system is not used for Production. The Portable =
version
2.46.0 has the same problem so switching back and forth between versions =
is
really simple, I just replace content of the git folder with another
version.

Thanks,
Michael.



