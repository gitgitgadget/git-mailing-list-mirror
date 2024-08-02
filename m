Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C2A22318
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722627091; cv=none; b=MwtHLxN/ngryDCzTYW6CyxY4Pu/cIdeeQSGSlIRZhKgGmS+lUGx22kLPXQCPNSJPdqnB4YNXiLzyvkdw4nERdoPc6j5UbHCGGBOKKjHUs9wNb4Oz8J3h3MeX7NpgD9Tz3k7bBE4l9uzRGQp4I/JM1wEKYNv+aMcRhZ+uhjDvDc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722627091; c=relaxed/simple;
	bh=Z8NUGkT+df8KlVIl41BimI+5/H891/QfsPTIqIDSxrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=unKq7XHM+laD2Z5ZpF39r2XGZWqowkXZrAEoDXXC+0w1/o2W5iMu3wYieVwl62ZkYESqzRJGzvK53xgZ3/WBbqCZSiHjlrVoRj71b+DY0Ab3oFiy//1P41oJllv1ebLxnygIw/1p/HFHuCJ32ZbIXErlbdvTWQvH913DHwlk69s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZnAsBB31; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZnAsBB31"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 07FAF364A3;
	Fri,  2 Aug 2024 15:31:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Z8NUGkT+df8KlVIl41BimI+5/H891/QfsPTIqI
	DSxrA=; b=ZnAsBB31GYudyYxKDbxEzYvPqVPDtBRvI9UWKSYKUwFACnwaR56l66
	3floyfgW+JVb/wNUoLk/BBlHimM7K2yIfkAlJT421y8ar+/4+P/AykVrZMhpyjqa
	pR/jIEMJPMvGH39LESJ/1P4CuW6tIQarCnnQyDxJrRc7JLJ5iews0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F3D40364A2;
	Fri,  2 Aug 2024 15:31:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0EB21364A1;
	Fri,  2 Aug 2024 15:31:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jamie Landeg-Jones <jamie@catflap.org>
Cc: Johannes.Schindelin@gmx.de,  drankinatty@gmail.com,  msuchanek@suse.de,
  git@vger.kernel.org
Subject: Re: [SOLVED] Re: Local git server can't serve https until repos
 owned by http, can't serve ssh unless repos owned by user after 2.45.1
In-Reply-To: <202408010015.4710FGtf018148@donotpassgo.dyslexicfish.net> (Jamie
	Landeg-Jones's message of "Thu, 01 Aug 2024 01:15:16 +0100")
References: <d9a83e5b-5075-47c6-85c8-e0b550cf859b@gmail.com>
	<xmqq8qz376fb.fsf@gitster.g> <20240617211513.GM19642@kitsune.suse.cz>
	<20240625072419.GU19642@kitsune.suse.cz> <xmqqr0cl6lxl.fsf@gitster.g>
	<202407260038.46Q0ctEV083266@donotpassgo.dyslexicfish.net>
	<5747ba0d-7268-4538-9705-11650a7d6e35@gmail.com>
	<202407280346.46S3khd9005129@donotpassgo.dyslexicfish.net>
	<0ae914c6-70be-44b8-a6b8-53f0b15d5674@gmail.com>
	<202408010015.4710FGtf018148@donotpassgo.dyslexicfish.net>
Date: Fri, 02 Aug 2024 12:31:23 -0700
Message-ID: <xmqqa5hud8ms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CE5EC516-5105-11EF-AB80-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Jamie Landeg-Jones <jamie@catflap.org> writes:

> I actually have an intermediate script that is called by httpd, that itself
> execs git-http-backend, so all I needed to do was add the line
>
> export HOME=/.../git-web-user/
>
> before the exec, and it now works as expected, picking up .gitconfig from the
> .../git-web-user/ directory.

Good.

> So, in my mind, the fix is to fix the "." directory requirement, and document
> the potential need to set HOME.

Good, too.

Thanks for a success report.
