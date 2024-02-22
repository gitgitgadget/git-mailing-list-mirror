Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178AC14B832
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640688; cv=none; b=jBkMXO2tQF5DOd4s6T28pwqr0UsdJwqmhmL4+s7Wyfg69axQHDYm+srBbEWtihl2Xr7fAv7MH9IrLy1o1MMQRMmYqCg4rVuH3QnpfZ8VkVKBNPqmjQ8lIP6veDNTp5lMg6HF5pIV8mQrDkIePnxfye8vEaPnK8yMDA9yPTsI79M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640688; c=relaxed/simple;
	bh=M/PQFK9TcB3IaX4zVmS7l2rzuBgWH5RmEuRZqD6Kedk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YHR7yUbs2wpYLrUrqfde41k60YO7F1pYT2qaLH+3xLtRGRkVcDq1Er3PbqiB9o5rQ48zlumTnBY/Jlv/siNCNCEd/GgZ+i6nJLZw4jyQ6NoGVLklICqugdvo0Q7D2o4YGRsFyXiQZDqk0HK5sH/vMX8YGhdubE9xmqdRfjrXQqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XqrQMLIc; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XqrQMLIc"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DD2B1D8755;
	Thu, 22 Feb 2024 17:24:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=M/PQFK9TcB3IaX4zVmS7l2rzuBgWH5RmEuRZqD
	6Kedk=; b=XqrQMLIcfEjyLrwWrP/LOQwhC7vCsH4EsRZQel0yLRquIXSxIcmnj1
	T6IVNzVBTpkyoarMJMT6qg0ligC8OKjhLSqALSgUERFD6kE5E1z+gJAmm+kZZ1QG
	rGdTFl/l8RVXUfpt0lfGAVWdPCrVgvX84KR9+JO2uh+/h4Bd9bhlg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 85C261D8754;
	Thu, 22 Feb 2024 17:24:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E98C31D8753;
	Thu, 22 Feb 2024 17:24:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org,  Jonathan Tan <jonathantanmy@google.com>,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v5 3/3] test-stdlib: show that git-std-lib is independent
In-Reply-To: <20240222175033.1489723-4-calvinwan@google.com> (Calvin Wan's
	message of "Thu, 22 Feb 2024 17:50:33 +0000")
References: <cover.1696021277.git.jonathantanmy@google.com>
	<20240222175033.1489723-4-calvinwan@google.com>
Date: Thu, 22 Feb 2024 14:24:43 -0800
Message-ID: <xmqqr0h4b0ic.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2E4568A4-D1D1-11EE-87FB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Calvin Wan <calvinwan@google.com> writes:

> diff --git a/Makefile b/Makefile
> index d37ea9d34b..1d762ce13a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -870,9 +870,7 @@ TEST_BUILTINS_OBJS += test-xml-encode.o
>  # Do not add more tests here unless they have extra dependencies. Add
>  # them in TEST_BUILTINS_OBJS above.
>  TEST_PROGRAMS_NEED_X += test-fake-ssh
> -TEST_PROGRAMS_NEED_X += test-tool
> -
> -TEST_PROGRAMS = $(patsubst %,t/helper/%$X,$(TEST_PROGRAMS_NEED_X))
> +TEST_PROGRAMS_NEED_X += $(info tpnxnpg=$(NO_POSIX_GOODIES))test-tool

Is this version meant to be ready for reviewing?  $(info) used like
this does not look like a good fit for production code.

> diff --git a/strbuf.h b/strbuf.h
> index e959caca87..f775416307 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -1,6 +1,8 @@
>  #ifndef STRBUF_H
>  #define STRBUF_H
>  
> +#include "git-compat-util.h"
> +
>  /*
>   * NOTE FOR STRBUF DEVELOPERS
>   *

The same comment about header inclusion I made on [1/3] applies
here, too.  I am open to hearing better ideas to handle system
headers, but my preference is to allow any and all headers assume
<git-compat-util.h> (or its moral equivalent that may be stripped
down by moving non-essential things out) is already included, which
in turn means those *.c files (like t/helper/test-stdlib.c we see
below) would include <git-compat-util.h> (or its trimmed down
version) as the first header, before including <strbuf.h>.

In any case, this change, if we were to make it (and I do not think
we should), should be treated like the change to pager.h in [1/3],
i.e. part of making the existing headers ready to be shared with the
"stdlib" effort.  It does not belong to this [3/3] step, where we
are supposed to be demonstrating the use of "stdlib", which has
become (minimally) usable with the steps before this one.

> diff --git a/stubs/misc.c b/stubs/misc.c
> index 92da76fd46..8d80581e39 100644
> --- a/stubs/misc.c
> +++ b/stubs/misc.c
> @@ -9,6 +9,7 @@
>   * yet. To do that we need to start using dgettext() rather than
>   * gettext() in our code.
>   */
> +#include "gettext.h"
>  int git_gettext_enabled = 0;
>  #endif

This change should have happened before this [3/3] step, whose point
is to demonstrate "stdlib" that has already been made (minimally)
usable with steps before this one.

> diff --git a/t/helper/.gitignore b/t/helper/.gitignore
> index 8c2ddcce95..5cec3b357f 100644
> --- a/t/helper/.gitignore
> +++ b/t/helper/.gitignore
> @@ -1,2 +1,3 @@
>  /test-tool
>  /test-fake-ssh
> +/test-stdlib
> diff --git a/t/helper/test-stdlib.c b/t/helper/test-stdlib.c
> new file mode 100644
> index 0000000000..460b472fb4
> --- /dev/null
> +++ b/t/helper/test-stdlib.c
> @@ -0,0 +1,266 @@
> +#include "git-compat-util.h"
> +#include "abspath.h"
> +#include "hex-ll.h"
> +#include "parse.h"
> +#include "strbuf.h"
> +#include "string-list.h"
> +
> +/*
> + * Calls all functions from git-std-lib
> + * Some inline/trivial functions are skipped
> + *
> + * NEEDSWORK: The purpose of this file is to show that an executable can be
> + * built with git-std-lib.a and git-stub-lib.a, and then executed. If there
> + * is another executable that demonstrates this (for example, a unit test that
> + * takes the form of an executable compiled with git-std-lib.a and git-stub-
> + * lib.a), this file can be removed.
> + */

Or alternatively, these "random list of function calls" can be
turned into a more realistic test helpers in place.  "stdlib"
will hopefully gain more coverage of the features of low level
helpers "git" binary proper uses, and I do not think it is
far-fetched to migrate the "test-tool date" subcommands all to not
link directly with "libgit.a" but with gitstdlib instead and the
things should work, right?  Right now, the "random list of function
calls" do not do anything useful, but that does not have to be the
case.  It should offer us more value to us than "It links!" ;-).

Having said that, the most valuable part in this [3/3] step is how
this t/helper/test-stdlib is linked, i.e. this part from the
Makefile:

> +t/helper/test-stdlib$X: t/helper/test-stdlib.o GIT-LDFLAGS $(STD_LIB_FILE) $(STUB_LIB_FILE) $(GITLIBS)
> +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
> +		$< $(STD_LIB_FILE) $(STUB_LIB_FILE) $(EXTLIBS)

where we have no $(LIB_FILE) (aka libgit.a).  Especially if we can
grow the capability in $(STD_LIB_FILE) without adding too much stuff
to $(STUB_LIB_FILE), this is a major achievement.  Very nice.

