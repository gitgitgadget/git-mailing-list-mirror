Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94B54F5E0
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748893787; cv=none; b=I1gPUhOo9d6F2NTHeGeDUtXtUA7pNTj2wGG9SkkGUTF9eaSnbeIBFrEnjQV3J61ylkj61ZD1Lg+kLv3Op83y1SU6A+nd5+SFzzYhNlXnT1rDpA6vRwNEUF3wMqG4Sjl0kuF7FWadPfncj8Ajp0Redv+WwFPfWT7v47dav89RSCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748893787; c=relaxed/simple;
	bh=kg2fISsM1vba8BQk6yFY1ebQHdVJ4fP+2EFUBf3KKbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8ryXyVle9gTyfcybjCfrjOMITc+g0Uk9m0XW6OrJcyPIARuDLVk3H+wyr5Kj+L4My2t9jMZCD2HvS9efsamhgt/yvyoKV7HadgJ4Efp/emfvQAakZq+LZ4gwaayP50icyJfvY+MBzcPCE5n2tNfv0j1xSdMN2Vd1rPwL6oe56s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=rdzjfWzy; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="rdzjfWzy"
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 7B3788700BD
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 21:49:39 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:3cf1:3f8a:a7f4:8efc])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id E2261B00565;
	Mon,  2 Jun 2025 21:49:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1748893772;
	bh=kg2fISsM1vba8BQk6yFY1ebQHdVJ4fP+2EFUBf3KKbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rdzjfWzy4hoau0acSatmU8bNqec70LDWh4frmxfDhChTj4lw/LTGqJZnXczvmvtWJ
	 20X7EcttehhrXuvwaMUjEWDWPsugxrnxfCIH35Pt2niuG8mDrFmQ6DjKOAgPYgTPQ+
	 GXOh82ZVGrFANNtGSpYQLU0jdfGgKz4GYJCyfHNs8+UrgcHtz0D1hs9vjYz7W4quME
	 wNiQTpaWjlyT6urFrOGAXC84rhm/HJO6wO853H3I9jZSf+WSU/FDbI4J9nzO622Gj2
	 w7kQ6jAVTJSYEMrbYJP3611eMu0BiB6NFPjHEHohPAw+pCzaeCvJ1ORbfhtJfk08wv
	 3rYvqiVwQoweg==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, Collin Funk <collin.funk1@gmail.com>
Cc: Collin Funk <collin.funk1@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject:
 Re: [PATCH v2] completion: Make sed command that generates config-list.h
 portable.
Date: Mon, 02 Jun 2025 21:49:28 +0200
Message-ID: <3631972.iIbC2pHGDl@cayenne>
In-Reply-To:
 <1ff542bb1090cc5185644d6032addac5cd0df402.1748892261.git.collin.funk1@gmail.com>
References:
 <0ab924839df48d869682bea1b0cb400f378ca6dc.1748889654.git.collin.funk1@gmail.com>
 <1ff542bb1090cc5185644d6032addac5cd0df402.1748892261.git.collin.funk1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 2 June 2025 21:26:47 CEST Collin Funk wrote:
> The OpenBSD 'sed' command does not support '\n' to represent newlines in
> sed expressions. This leads to the follow compiler error:
> 
>     In file included from builtin/help.c:15:
>     ./config-list.h:282:18: error: use of undeclared identifier 'n'
>             "gitcvs.dbUser",n       "gitcvs.dbPass",
>                             ^
>     1 error generated.
>     gmake: *** [Makefile:2821: builtin/help.o] Error 1
> 
> We can use a backslash followed by a newline to fix this.
> 
> This portably issue was introduced in e1b81f54da (completion: take into
> account the formatting backticks for options, 2025-03-19)
> 
> Signed-off-by: Collin Funk <collin.funk1@gmail.com>
> ---
>  generate-configlist.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/generate-configlist.sh b/generate-configlist.sh
> index b06da53c89..e1f9e99488 100755
> --- a/generate-configlist.sh
> +++ b/generate-configlist.sh
> @@ -19,7 +19,8 @@ EOF
>  	s/::$//;
>  	s/`//g;
>  	s/^.*$/	"&",/;
> -	s/,  */",\n	"/g;
> +	s/,  */",\
> +	"/g;
>  	p;};
>  d' \
>  	    "$SOURCE_DIR"/Documentation/*config.adoc \

FYI I pushed your patch to 
https://github.com/gitgitgadget/git/pull/1930/

It seems to be passing, although it's not very readable.

Your commit message has some issues:

 * upper case in "Make": prefixed commits message must be lower case
 * to be correct, the bug was already there at the first introduction of the 
generate-configlist.sh script (3ac68a9). The '\n' was there, and the generated 
.h file had two wrong strings such as
"gitcvs.dbUserngitcvs.dbPass" . My patch only put it in light by breaking the 
build.

Maybe an alternative way of fixing the issue is to just rework the 
documentation on the two spots where a comma is used and put each config 
variable on its own line.

What do you think?

JN



