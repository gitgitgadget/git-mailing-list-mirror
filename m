Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F076AD530
	for <git@vger.kernel.org>; Wed,  8 May 2024 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187189; cv=none; b=tIFbw43CNm6eyvyc2GEyaRi+mjLFly0u57ycWXqMbZsPIV9mSz4Mba0K8/a4j+bP7A/BKq9YzlSmz+JjFuzJ4zNnfMSV6N+IoZ4v8odLmQYyyuwx3crv/7OXH+mzditmI9FsnfREVnyZwu0Ndc0RbpSVj74BJkq95coaLwFD8qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187189; c=relaxed/simple;
	bh=VzD9KUkD/RAcgfLwt3S2XQ2Nj7KtGjQpaIMtOzkjYHQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DPPtKNWCtQ23nZenn3pu4HNMTFv6K1PBAzOcSu3LWgboPCME13Vajc7w4y0GD2eQogKAZQVNkCq3EYEC5nYKRKnBB7NA/CQhq9+dNDitxXqp0vVY7VIslO483JVaugSDVtBmc3ad3SQLnci/6SlHs/QAUSR5hH4u7fTXrGTsAIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zsy6NtNR; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zsy6NtNR"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EC4D1E7AE;
	Wed,  8 May 2024 12:53:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VzD9KUkD/RAcgfLwt3S2XQ2Nj7KtGjQpaIMtOz
	kjYHQ=; b=Zsy6NtNRib5MtSjwNlppgGZgZ3WjNBTB8nyJVH2a1T6K5PmsqvFbZA
	H0ZgIO9KKZWMTybKhxUmPoIDTDy8JoS68Tnd+E80j9YfhS9oWCneODZH93HbmSQU
	nnodKx3rG/jmLDXudXkUX5hDY6v7hZ1m9sq6F+8bFs+L9s0yRt7+o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4113B1E7AD;
	Wed,  8 May 2024 12:53:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C42161E7AC;
	Wed,  8 May 2024 12:53:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Fahad Alrashed via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Fahad
 Alrashed <fahad@keylock.net>
Subject: Re: [PATCH v2] Bug fix: ensure P4 "err" is displayed when exception
 is raised.
In-Reply-To: <pull.1668.v2.git.git.1715168796873.gitgitgadget@gmail.com>
	(Fahad Alrashed via GitGitGadget's message of "Wed, 08 May 2024
	11:46:36 +0000")
References: <pull.1668.git.git.1714802221671.gitgitgadget@gmail.com>
	<pull.1668.v2.git.git.1715168796873.gitgitgadget@gmail.com>
Date: Wed, 08 May 2024 09:53:02 -0700
Message-ID: <xmqqo79gxn2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6FA75594-0D5B-11EF-B504-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Fahad Alrashed via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Fahad Alrashed <fahad@keylock.net>
> Subject: Re: [PATCH v2] Bug fix: ensure P4 "err" is displayed when exception is raised.

Our convention is to use the name of the area as the prefix, e.g.,

	git-p4: show Perforce error to the user

in the title.  Documentation/SubmittingPatches has more guidance on
the title, like omitting the full-stop at the end, and on the
proposed log message in general.

> During "git p4 clone" if p4 process returns an error from the server,
> it will store the message in the 'err' variable. Then it will send a
> text command "die-now" to git-fast-import. However, git-fast-import
> raises an exception: "fatal: Unsupported command: die-now" and err is
> never displayed.

Nicely explained.

> This patch ensures that err is dispayed using
> "finally:".

Instead, we write it more like

	Ensure that err is shown to the end user.

The implementation (i.e., catching an error with try/finally) can be
seen from the patch text.  What is more important to capture in the
proposed log message is what _effect_ the commit wanted to make,
which is a good way to show _why_ we are making the change.

The intent of the original code being to always die at this point.
Even though it is necessary to enclose the earlier part up to
.wait() inside a try block to catch an exception, the two calls to
die() do not have to be inside finally block (in other words,
finally block could be just a no-op, and the die() calls can be done
after the whole try/finally block that kills the fast-import by
sending die-now and makes sure .wait() sees the process go), which
may have made the intent of the fix even more clear, which is "we
use the try/finally construct only to work around an exception
thrown by killing the fast-import process".

The patch posted as-is is not wrong per-se, though.

Thanks.

> diff --git a/git-p4.py b/git-p4.py
> index 28ab12c72b6..f1ab31d5403 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -3253,17 +3253,19 @@ def streamP4FilesCb(self, marshalled):
>              if self.stream_have_file_info:
>                  if "depotFile" in self.stream_file:
>                      f = self.stream_file["depotFile"]
> -            # force a failure in fast-import, else an empty
> -            # commit will be made
> -            self.gitStream.write("\n")
> -            self.gitStream.write("die-now\n")
> -            self.gitStream.close()
> -            # ignore errors, but make sure it exits first
> -            self.importProcess.wait()
> -            if f:
> -                die("Error from p4 print for %s: %s" % (f, err))
> -            else:
> -                die("Error from p4 print: %s" % err)
> +            try:
> +                # force a failure in fast-import, else an empty
> +                # commit will be made
> +                self.gitStream.write("\n")
> +                self.gitStream.write("die-now\n")
> +                self.gitStream.close()
> +                # ignore errors, but make sure it exits first
> +                self.importProcess.wait()
> +            finally:
> +                if f:
> +                    die("Error from p4 print for %s: %s" % (f, err))
> +                else:
> +                    die("Error from p4 print: %s" % err)
>  
>          if 'depotFile' in marshalled and self.stream_have_file_info:
>              # start of a new file - output the old one first
>
> base-commit: 235986be822c9f8689be2e9a0b7804d0b1b6d821
