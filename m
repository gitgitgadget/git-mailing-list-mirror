Received: from s700.sureserver.com (s700.sureserver.com [195.42.142.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B812282F1
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 05:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.42.142.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759640630; cv=none; b=SM6+tp16WDCgIEAGrS4IJCQLwjkzqq3NSeNBhINdnRfk9UZQ1PuoAs+9NOyIo0fRziqrZB0JdO49R8/EvN5o0jqnAQGkbgRq3Z+aX+Nr0pO9qSs/oYEDf445yV0unaxIQTK3ZL3HPyN5ikf6tvQ3Wod3K5Nm3Rcu6kUMfHn+res=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759640630; c=relaxed/simple;
	bh=zplJ9Z3pQCDbs+84KGkm3D1Ms+muwIqH3BwNOEo6Cos=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type; b=U9TIwZ8zGroyda9Ux4g2VvLEiqm5+YuAO/9Z8I+OOzTMoJmUK5St674Fg59hruebEgisb91+ko3FzBasacE4Wh1Wt2TUQYaCjtw4SES/6M+HzFIIc3FZ4g7TkM4JioRAAv7E5bHFBtDZAZR8rFFNkqZwBwehhRk+HN17ZBoGlvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=robdavies.net; spf=pass smtp.mailfrom=robdavies.net; dkim=pass (1024-bit key) header.d=robdavies.net header.i=@robdavies.net header.b=IcTm1xlx; arc=none smtp.client-ip=195.42.142.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=robdavies.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=robdavies.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=robdavies.net header.i=@robdavies.net header.b="IcTm1xlx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=robdavies.net; h=
	mime-version:date:from:to:subject:message-id:content-type
	:content-transfer-encoding; s=dkim; bh=zplJ9Z3pQCDbs+84KGkm3D1Ms
	+muwIqH3BwNOEo6Cos=; b=IcTm1xlxjhjEvmqStdOw9mVjHfmB2I7k+bgzF8/5E
	b24aZdyGMlf4IBPc0GqV0eACNP0UmX6N5LtzpCa9cPRp55yAnqjRYV/tXUTIcQbo
	e4qySirPucDvt/xhb6IzHaXpuqr/dVXjT7GxXuGOrBRqOHwUean4DF7l6LIhRjKC
	gY=
Received: (qmail 58389 invoked by uid 1002); 5 Oct 2025 04:57:02 -0000
Received: from unknown (HELO mbox.s700.sureserver.com) (rob@robdavie.user@127.0.0.1)
  by 127.100.1.1 with ESMTPA; 5 Oct 2025 04:57:02 -0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 05 Oct 2025 05:57:02 +0100
From: rob@robdavies.net
To: git@vger.kernel.org
Subject: gitweb and gitweb_config.perl problem
User-Agent: Roundcube Webmail
Message-ID: <4f19f3b21d3db8d7cdb962089910839c@robdavies.net>
X-Sender: rob@robdavies.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi

I found a bug in gitweb when using gitweb_config.perl

I downloaded and installed gitweb from source, it worked at this point. 
I configured using a gitweb_config.perl file, it was at this point I got 
an error :
500 - Internal Server Error No such file or directory at gitweb.cgi line 
734.

I ran gitweb.cgi from the command line and got this error as well as the 
error above :
[Sun Oct  5 04:53:37 2025] gitweb.cgi: do "gitweb_config.perl" failed, 
'.' is no longer in @INC; did you mean do "./gitweb_config.perl"? at 
./gitweb.cgi line 732.

I then changed line 744 in gitweb.cgi from :
	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "gitweb_config.perl";
to
	our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "./gitweb_config.perl";
and it worked

I have seen this same error on
https://bugs.gentoo.org/675864

Solution :
I changed the file git/gitweb/Makefile line 14 from :
GITWEB_CONFIG = gitweb_config.perl
to
GITWEB_CONFIG = ./gitweb_config.perl

when I built it this time using :
make gitweb
make gitwebdir=~/www/www/gitweb install-gitweb

It now worked when I configured using the file gitweb_config.perl.

Kind regards,
Rob Davies

