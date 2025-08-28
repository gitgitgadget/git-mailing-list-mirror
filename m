Received: from disco.pogo.org.uk (disco.pogo.org.uk [93.93.128.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E013C9C4
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.128.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391125; cv=none; b=WUDztrL3LXf5JONiTSjDVIP8sW2hsXBL3mQjP33nb33fGmKhvroCpRBfjhMkvk714YUjLhEydXruJGwX01yMdc/bTL5jUvBvNhO6XZvrNCDn3yTNRjmDIdxdeTKOXQCXXd9sCkapzEq1SMxnjSFVFi7wyuOBVd5qvGDtuKBV+L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391125; c=relaxed/simple;
	bh=YUemuGetjp5B3rAbxvH4Xx6kpbSocsSVVVrQ9SZtU0I=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=DEYN7DiFjYpDJqplDs7dT8G7dEdzVYU8MDJhL+TAex6MOzLbrFfpvL4fZepl08EoFF1whuqcPhk9cmgJw0N/ji2y+Ne4vAVFCDFgirM5ksERo5fnlju3T65WGjOkM0UnygiPUAir5TKJhH29xVIzjL4f3VUPb/VWxtNWch51e4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xwax.org; spf=pass smtp.mailfrom=xwax.org; dkim=pass (1024-bit key) header.d=xwax.org header.i=@xwax.org header.b=Cj67zlLk; arc=none smtp.client-ip=93.93.128.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xwax.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xwax.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xwax.org header.i=@xwax.org header.b="Cj67zlLk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xwax.org;
	s=swing; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Cc:
	Reply-To:In-Reply-To:References:Content-Transfer-Encoding:Content-ID:
	Content-Description; bh=cD9qpED4MlMQgVhChmaZXQZpLgqqKzFayD8mDfY/iWc=; b=Cj67z
	lLkK6CVVnnQV0m0mszOXIc3+qzymVrDLSshO3gucAyRILVphuT2FhLkmHWeJxQpGBnFwktUFnOYVs
	XAquvkQ3myYnKfU7h4NAxVT5G/sQ7IbFx5XNtdOT8IV6nMCXhBXuRwzuo1NQUK7zQfIixlXHW09VV
	Pe4zFzqCD8fA=;
Received: from cpc93786-hari17-2-0-cust786.20-2.cable.virginm.net ([82.36.99.19] helo=tamla)
	by disco.pogo.org.uk with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2 (FreeBSD))
	(envelope-from <mark@xwax.org>)
	id 1urdCV-00000000I9R-2KTv
	for git@vger.kernel.org;
	Thu, 28 Aug 2025 15:02:03 +0100
Received: from localhost (tamla.localdomain [local])
	by tamla.localdomain (OpenSMTPD) with ESMTPA id aa26ffc7
	for <git@vger.kernel.org>;
	Thu, 28 Aug 2025 15:02:03 +0100 (BST)
Date: Thu, 28 Aug 2025 15:02:03 +0100 (BST)
From: Mark Hills <mark@xwax.org>
To: git@vger.kernel.org
Subject: gitk bug: Disabling "Themed widgets" breaks preferences dialogue
Message-ID: <075a1389-c5d6-18f4-ed19-13b0041dbbd0@xwax.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

I use Alpine Linux 3.22 (latest).

Recently gitk's preferences window refuses to open.

This seems to be a direct result of switching off the "Themed widgets" 
setting, which is my preferred choice.

Error message:

invalid command name "::combobox"
invalid command name "::combobox"
    while executing
"${NS}::combobox $page.wrapcomment -values {none char word} -state 
readonly  -textvariable wrapcomment"
    (procedure "prefspage_general" line 41)
    invoked from within
"prefspage_general $notebook"
    (procedure "doprefs" line 27)
    invoked from within
"doprefs"
    invoked from within
".#bar.#bar#edit invoke active"
    ("uplevel" body line 1)
    invoked from within
"uplevel #0 [list $w invoke active]"
    (procedure "tk::MenuInvoke" line 50)
    invoked from within
"tk::MenuInvoke .#bar.#bar#edit 1"
    (command bound to event)

Steps to reproduce:

  $ rm -f ~/.gitk ~/.config/git/gitk
  $ cd <git-repo>
  $ gitk
  Edit -> Preferences
  Uncheck "Use themed widgets"
  Ok
  File -> Quit
  $ gitk
  [error]
  Ok
  [empty preferences window opens]

$ cat /etc/alpine-release
3.22.1

$ apk info git tk tcl
git-2.49.1-r0 description:
Distributed version control system

git-2.49.1-r0 webpage:
https://www.git-scm.com/

git-2.49.1-r0 installed size:
6568 KiB

tcl-8.6.16-r0 description:
The Tcl scripting language

tcl-8.6.16-r0 webpage:
https://www.tcl-lang.org/

tcl-8.6.16-r0 installed size:
4244 KiB

tk-8.6.16-r0 description:
GUI toolkit for the Tcl scripting language

tk-8.6.16-r0 webpage:
https://www.tcl-lang.org/

tk-8.6.16-r0 installed size:
1926 KiB

-- 
Mark
