Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F1171B0
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618911; cv=none; b=j+/Hdbu8/m0MusCAAJgNZfMluzuQPBEWVaxZdFdSEmdTTOfP9M5tnqE/OU7qucpVzJyo2kVWat01nYiopojuvveEGgGC83YoWV5eZOlTK4NrU9ZyTVzVd9Q46NpMnavFJ46VPVQf6FDNKFqhaK7wEEQrZq6t6hNMj9saLjI3FkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618911; c=relaxed/simple;
	bh=h125aJfDQKNbTXrF3ryHCDYahoS82KTGH/zJCGuwltU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rzRHvxhjCEQWzfzFe24p0idfk4Mikz2FMmUvwWudYsAYdmZR+s8kidZ3h0QziKKviZcu4Bs3hSDnGtHdt/euZVtg905KBkY3KS3zZg1lXTJjroff3O62BGdOS6aBeQO6boZqq0EceD/r3yJeWon+s5v82Q+4dXNaZ3+gqLBLxcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MIEX5fuM; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MIEX5fuM"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 890B3208F4;
	Mon,  8 Apr 2024 19:28:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=h125aJfDQKNbTXrF3ryHCDYahoS82KTGH/zJCG
	uwltU=; b=MIEX5fuMIQthNQbvRzaXJc9MfU7toHI7wDoNjud3PNYTdfWuZ2Vo0t
	64bRGvg3mMym2ZR15R6Jsh5jyXDIqHeNtsmQ7piZhGvSXc+NZxMGDRA9WibAGHTJ
	9o2n+UbMmSJgJWFb8zOmpDihN1dw5KcOw3WuugbVuUoPSlp5rsQ60=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 82BAE208F3;
	Mon,  8 Apr 2024 19:28:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 089E6208F2;
	Mon,  8 Apr 2024 19:28:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Dario Gjorgjevski <dario.gjorgjevski@gmail.com>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile(s): avoid recipe prefix in conditional statements
In-Reply-To: <xmqqle5n8rcr.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	08 Apr 2024 14:41:24 -0700")
References: <CAJm4QYOxn_s8ktJiC6ju2j4OyEYaM2ay7Ca--ZWFWa7APVnTbA@mail.gmail.com>
	<9d14c08ca6cc06cdf8fb4ba33d2470053dca3966.1712591504.git.me@ttaylorr.com>
	<xmqqle5n8rcr.fsf@gitster.g>
Date: Mon, 08 Apr 2024 16:28:24 -0700
Message-ID: <xmqqpluz5t9j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B2D02AE4-F5FF-11EE-BDA8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Taylor Blau <me@ttaylorr.com> writes:
>
>> When a conditional word (ifeq, ifneq, ifdef, etc.) is preceded by one or
>> more tab characters, replace each tab character with 8 space characters
>> with the following:
>>
>>     find . -type f -not -path './.git/*' -name Makefile -or -name '*.mak' |
>>       xargs perl -i -pe '
>>         s/(\t+)(ifn?eq|ifn?def|else|endif)/" " x (length($1) * 8) . $2/ge unless /\\$/
>>       '
>
> Yuck, it means auto indenting Makefile and its pieces almost
> impossible X-<.  I'll take the patch as there is no way to revert
> the change to GNU make, though.

We'd need something like this on top.  Our top-level .gitattributes
defines the default whitespace rules with !indent-with-non-tab and
enables indent-with-non-tab for specific file suffixes like .[ch],
but git-gui/.gitattributes enforces indent-with-non-tab for all
files.

Another thing with this series (and this follow-up) is if we want to
start treating git-gui/ as just a subdirectory without no plan to
feed our changes to the "upstream".  I am actually OK with that, as
the "upstream" we merge (with -Xsubtree merge strategy) from does
not seem to be very active and responsive these days.

 git-gui/.gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git c/git-gui/.gitattributes w/git-gui/.gitattributes
index 59cd41dbff..118d56cfbd 100644
--- c/git-gui/.gitattributes
+++ w/git-gui/.gitattributes
@@ -3,3 +3,4 @@
 git-gui.sh  encoding=UTF-8
 /po/*.po    encoding=UTF-8
 /GIT-VERSION-GEN eol=lf
+Makefile    whitespace=!indent,trail,space
