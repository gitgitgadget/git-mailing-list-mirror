Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C991216A945
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718994038; cv=none; b=UdnnUmyAk2gUlGrx9vCyon0sxT1FdTEtKdFIh/vz8ePvYSdy3WhaPqkVi24jICsG4AHVvbysNXBYnI32E9BLDOGKWNp+H5YlzPTd2uuhZZ1HCTc7N78qJOwhfTod0vtWwiIAn+ZujsnpC7QLopHG6bI3s3GJogFAvR8Q5xQKhik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718994038; c=relaxed/simple;
	bh=hTWOmwz06F0R/HzsAid98ERR1EWP61xK8jZY8/xeVpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eL4hFyuT/Wgn9NYw0K3RXmdaBwe0BnaJ70LGbSm8bz3bAbXDAPnF8O/VNfmXVivvbBzwYvbp1ZlDMZUNUTjCtl95zoT3B0EvGMaQNMKRe8TE/65yA44oER9uTqK2zV2Y/e8FXiEADlQ3cQ/ij9AekMoTyfmUC2KeIo+fmECHZms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TltWlsKz; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TltWlsKz"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DC1226164;
	Fri, 21 Jun 2024 14:20:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hTWOmwz06F0R/HzsAid98ERR1EWP61xK8jZY8/
	xeVpo=; b=TltWlsKzcd7sSelhrzksBgDmWjZgrPG/s8QXgRr6Aw9W483xBpLTmh
	TEhmRHwcPIu+fr5D0Z7I/0RbQRUCDYekNNAalmzJ15hvTxtLZ31bpMT/ONOtZv/v
	5xDGzRaORoUJasvFGujjtMn3sg1+xKGuKDriWYPeGdp4JNveCvoOA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76BE726160;
	Fri, 21 Jun 2024 14:20:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E1D892615F;
	Fri, 21 Jun 2024 14:20:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Randall S. Becker" <the.n.e.key@gmail.com>
Cc: git@vger.kernel.org,  "Randall S. Becker" <randall.becker@nexbridge.ca>,
  "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v0 1/1] Teach git version --build-options about
 zlib+libcurl
In-Reply-To: <20240621154552.62038-2-randall.becker@nexbridge.ca> (Randall
	S. Becker's message of "Fri, 21 Jun 2024 11:45:52 -0400")
References: <20240621154552.62038-1-randall.becker@nexbridge.ca>
	<20240621154552.62038-2-randall.becker@nexbridge.ca>
Date: Fri, 21 Jun 2024 11:20:28 -0700
Message-ID: <xmqqmsnekvir.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F0C2C0E8-2FFA-11EF-B14D-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

"Randall S. Becker" <the.n.e.key@gmail.com> writes:

> This change uses the zlib supplied ZLIB_VERSION #define supplied text
> macro and the libcurl LIBCURL_VERSION #define text macro. No
> stringification is required for either variable's use. If either of
> the #define is not present, that version is not reported.

"the zlib supplied ZLIB_VERSION #define supplied text macro" is
quite a mouthful.  Something like

    version: --build-options reports zlib and libcurl version information

    Use ZLIB_VERSION and LIBCURL_VERSION to show them, if defined, in
    "git version --build-options" output.

should be sufficient.

We will assume that 

 (1) LIBFROTZ_VERSION, if defined, will always be of the same type
     (luckily, all three we are dealing with use a C-string so
     "strbuf_addf(buf, "%s", LIBFROTZ_VERSION)" is good), and that

 (2) no random origin other than the frotz project will define the
     CPP macro LIBFROTZ_VERSION to confuse us.

Both are sensible assumptions that would allow us to trust a
hardcoded strbuf_addf() invocation per each library is sufficient If
a library uses LIBFROTZ_MAJOR and LIBFROTZ_MINOR we may have to do
"strbuf_addf(buf, "%s.%s" LIBFROTZ_MAJOR, LIBFROTZ_MINOR)" that is
different from others, but the point is the version identification
scheme would be constant across different versions of the same
library.

The actual code to report versions should be trivial, once we get
the mechanism to make necessary CPP macros available (when present)
right, but the latter needs a bit more work than this patch shows.

Here is the first change your patch does:

>  #include "git-compat-util.h"
> +#include "git-curl-compat.h"

The file <git-curl-compat.h> begins like so:

        #ifndef GIT_CURL_COMPAT_H
        #define GIT_CURL_COMPAT_H
        #include <curl/curl.h>
	...

If you do not have any <curl/curl.h> anywhere on your system,
I suspect this will break the build, instead of silently leaving
LIBCURL_VERSION undefined.

>  #include "config.h"
>  #include "builtin.h"
>  #include "exec-cmd.h"
> @@ -757,6 +758,12 @@ void get_version_info(struct strbuf *buf, int show_build_options)
>  
>  		if (fsmonitor_ipc__is_supported())
>  			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
> +#if defined LIBCURL_VERSION
> +		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
> +#endif
> +#if defined ZLIB_VERSION
> +		strbuf_addf(buf, "zlib: %s\n", ZLIB_VERSION);
> +#endif

FYI, in the merged result, I would prefer to order these entries
semi-alphabetically, e.g. perhaps stripping possible "lib" prefix or
suffix and comparing the rest to result in curl < openssl < z or
something like that.  Then we know where to add a new one, whose
name we do not know yet, in the future.

Thanks.
