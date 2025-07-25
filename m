Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD178192D97
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431471; cv=none; b=LKQLGA7xC5Mr5m7+4f/z4zGXayJWdR0eqwc82gFFH89Fk3CcDjCxP2m41hGUwhrGf9ivuNHQaB6nRk4D6FiegHkGDXiK8JRZop1qA2mxWWWDBbK7XCxcj4A8XIurwUCtquG+LWQjYVIX/OfQXQ5tzbjl7JafFa+XH7Vfwqn+6w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431471; c=relaxed/simple;
	bh=uNki3ExMHr/o4eiO45BnUBzHbTNk3IDvxbyHsZVJj4k=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=uLInuvz2FwG3O4uyrrtGQ6Btzbei7FMOdeoc/5fsjCVE3rAT6SuQT794nBbob3Z8pIff/b8a5+Phz5XFKOnVqsUZ76f8WGtnPkyVrLfyvn+IFY3UlqtGW6XTm+jmS93oMwO2fxaIrEAZzrQuPSpQKH7/5hW4/iNRdIqR0ijSGf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 413E31764
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 01:17:41 -0700 (PDT)
Received: from [10.57.54.166] (unknown [10.57.54.166])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92DA03F5A1
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 01:17:47 -0700 (PDT)
Message-ID: <1c3a0463-36ee-4a2d-92e0-fac9c0bf77da@arm.com>
Date: Fri, 25 Jul 2025 10:17:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: git@vger.kernel.org
From: Kevin Brodsky <kevin.brodsky@arm.com>
Subject: -h prints alias information even for grep
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I've noticed a strange interaction that probably wasn't intended.

The -h flag typically means "help", and if passed to an aliased command
an extra line is printed to describe the alias. This also holds for the
grep command, if no other argument is passed.

Things get weirder if grep is passed valid arguments, because in that
case -h means something else (suppressing filename output). Of course no
help message is printed in that case, but the alias information is still
printed!

Example:

$ git g -h -A20 alias .gitconfig
'g' is aliased to 'grep'
[alias]
[...]
    g    = grep

----

It seems like that alias information line should be tied to the printing
of the help message, rather than the -h flag?

I noticed this behaviour years ago and I still do with the latest
version of Git (2.50.1).

Cheers,
Kevin
