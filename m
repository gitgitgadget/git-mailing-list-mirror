Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D21F8BBD
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112355; cv=none; b=bjA95DmKSiD7sEM5StvcKC05w2jDE5D9TJCiPtXXg8hmhhWV3Y/eeoFzQtyUTf/ylJoc9S4vQWFhvg0EE0/bI8Wlb/x6RgRMWD4plSXqqwJG5EiQ3McHHfgxPW74n4fvcGlguEbfIhufgWcT0IT5b7FJ4TT/p7Gkzp6XJX2fveo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112355; c=relaxed/simple;
	bh=M8WLkqAIyH9hN5Si/bF9+gKO6sfUwf5nX/HmhdB5h3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pXzrR3SPBSaflBJVbLGiP4tqXmxLykxHCtd8n89trkajZ5FYTbu2fmqrglDmrcWjVJT2PWztwFZ4LaMQI6F4QZ2tHTog0p1LuIIg64IFK8APcbIuAwSx8LCBH/307sRg1HOr2rCER2mn3M4VOfUkccj0j7IGrA+Lyk6eRiS8+F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=nkz3hyIE; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="nkz3hyIE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1749112345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9tDOH5cz1brWZcXLdqxPzM+rjmYiXrX4jgV/F5k+zLo=;
	b=nkz3hyIEBW/exD64O0jTjKPaPHO3x8ce5OTGHYWCq46+6Lf2bc4HtAZ3fTyYzpsUdlFTVz
	ukiF/xlqtKiMrUA+GIKHmlZn26EIqemyk1VAgMB/YlCgQfhaQnkKTq4iS9J0CyYFF4VJNG
	uxq33lQbq93TBT8SL42a/enahI87ZV8=
From: Toon Claes <toon@iotcl.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Taylor Blau
 <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, =?utf-8?B?w4Z2YXIg?=
 =?utf-8?B?QXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC v2 1/5] last-modified: new subcommand to show when
 files were last modified
In-Reply-To: <zz2xv667flcb46gp4scqu4wmrxviiecqz2ru35glalbsaluc3p@kmymzn5lxapk>
References: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
 <20250523-toon-new-blame-tree-v2-1-101e4ca4c1c9@iotcl.com>
 <zz2xv667flcb46gp4scqu4wmrxviiecqz2ru35glalbsaluc3p@kmymzn5lxapk>
Date: Thu, 05 Jun 2025 10:32:11 +0200
Message-ID: <8734ce37xw.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Justin Tobler <jltobler@gmail.com> writes:

> On 25/05/23 11:33AM, Toon Claes wrote:
>> +-r::
>> +	Recurse into subtrees.
>> +
>> +-t::
>> +	Show tree entry itself as well as subtrees.  Implies `-r`.
>
> This left me wondering about the default behavior regarding displaying
> trees when neither `-t` and `-r` are specified. If we omit showing when
> a tree was last mostified?

When omitting both the command returns the commit that last modified the
tree. Basically without any of both options it return which commit
touched a tree entry last, it doesn't care if that tree entry is a tree
or a blob.

I shall add something to the docs for `-r` that explains what happens if
it is omitted.

>> +[--] <path>...::
>> +	For each _<path>_ given, the commit which last modified it is returned.
>> +	Without an optional path parameter, all files and subdirectories
>> +	of the current working directory are included in the
>
> are include in the? I assume you meant to say the search/operation.

Whoops.

>> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
>> new file mode 100644
>> index 0000000000..0d4733f666
>> --- /dev/null
>> +++ b/builtin/last-modified.c
>> @@ -0,0 +1,43 @@
>> +#include "git-compat-util.h"
>> +#include "last-modified.h"
>> +#include "hex.h"
>> +#include "quote.h"
>> +#include "config.h"
>> +#include "object-name.h"
>> +#include "parse-options.h"
>> +#include "builtin.h"
>
> For builtins, "builtin.h" should be included at the top and
> "git-compat-util.h" should be omitted.

Thanks, will address.

-- 
Cheers,
Toon
