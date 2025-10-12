Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2B81A3154
	for <git@vger.kernel.org>; Sun, 12 Oct 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760269561; cv=none; b=TEBGViGMLIzyMFZGtncjORT+/KBVOhuuX8KK7lkx87Lt3xakipjSyOyZKt39BqFBjFj9or5eoIdsqKFD2tvmLDjWfB1a4kRXtekMh2fPbrQB+CJ7GUKjciyTbRZKkrVKAUn13jKOW60MBZg09fuUH20c6CWaJ9qkwxdDEAf3iME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760269561; c=relaxed/simple;
	bh=kEQarWJAph2AWbYDrVbNNNi6xK44dg9Tpdjm+gpvcxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uv/4Dd9jYdyhytihe58tHzM2UNGO3eYtYmjQrpxH6qFFEbPsSHYfA9/iI4BrQQjgoCj95rGcsjx6wDNIOh5+08KS+odfJ0U0e21L4tCsse9ZHvT54d1nkLJ3iGeAbZwEKTiM+7Uf3+wSLqLNVoqT/y7pvFL0PjvI2nh+CoAzAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4ckzFW0YrtzRnmN;
	Sun, 12 Oct 2025 13:45:50 +0200 (CEST)
Message-ID: <e593886e-eeb4-440f-a317-a2959577e1e3@kdbg.org>
Date: Sun, 12 Oct 2025 13:45:50 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mingw: avoid relative `#include`s
Content-Language: en-US
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>, git@vger.kernel.org
References: <pull.1985.git.1759995961.gitgitgadget@gmail.com>
 <484ef8b825e5d1d68a61f0f8cc2520457e8f4f3a.1759995961.git.gitgitgadget@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <484ef8b825e5d1d68a61f0f8cc2520457e8f4f3a.1759995961.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 09.10.25 um 09:46 schrieb Johannes Schindelin via GitGitGadget:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> We want to make them relative to the top-level directory.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/mingw.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 8538e3d172..da99473f56 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1,22 +1,22 @@
>  #define USE_THE_REPOSITORY_VARIABLE
>  #define DISABLE_SIGN_COMPARE_WARNINGS
>  
> -#include "../git-compat-util.h"
> +#include "git-compat-util.h"
>  #include "win32.h"
>  #include <aclapi.h>
>  #include <sddl.h>
>  #include <conio.h>
>  #include <wchar.h>
> -#include "../strbuf.h"
> -#include "../run-command.h"
> -#include "../abspath.h"
> -#include "../alloc.h"
> +#include "strbuf.h"
> +#include "run-command.h"
> +#include "abspath.h"
> +#include "alloc.h"
>  #include "win32/lazyload.h"
> -#include "../config.h"
> -#include "../environment.h"
> -#include "../trace2.h"
> -#include "../symlinks.h"
> -#include "../wrapper.h"
> +#include "config.h"
> +#include "environment.h"
> +#include "trace2.h"
> +#include "symlinks.h"
> +#include "wrapper.h"
>  #include "dir.h"
>  #include "gettext.h"
>  #define SECURITY_WIN32

Why is this needed?

With #include "foo" it is quite clear that the file is first looked up
from the directory of the file being processed. The changed code
requires that the top-level directory is among the -I directives of the
command lines. Then it would be much more logical to use #include <foo>
instead. But that I wouldn't regard as desirable, either, because the
included file isn't from a subordinate module or library.

So, IMO, the status quo is perfect and does not need this change.

-- Hannes

