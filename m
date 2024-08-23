Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71EF41C69
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432274; cv=none; b=Z2XxmZD6y4pkSgB8ulS/4YroMZvDGiGaDNOwLKT+p5eaazeD/xbv7S4abSYFNFwR8oxY5tNzT+CfAVhIAkDx87bAiPDBodtSrdpfNpQShCk9CMvp6uD45HYi5idMAHwTtLph5Num3JEDKX7O+NIZloX7Ag0zCihZKG8qqfjV/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432274; c=relaxed/simple;
	bh=mqqy/S2Y+sdc1LeG4kEul+6gFD7DoRtHKbhIqerjeEc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fez0Rs0UmGQEZ08j72tSPe3tOj7SW0cVpu6wOlqBzjV8CUnb/tE5kzUyq0PKGotEkRvsuOCvkk7zP1IIQ0jpJkpE5Uea2CWW6vFBmDffPsIYQy4eQtBes/eJ/JiMrYfzj8aTMEVzD6ZfoNPKHa7SZe6m7vqMymhQWIKsz28h1Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ehZRDDpC; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ehZRDDpC"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C97824668;
	Fri, 23 Aug 2024 12:57:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mqqy/S2Y+sdc1LeG4kEul+6gFD7DoRtHKbhIqe
	rjeEc=; b=ehZRDDpCktQd6ziP+oT09as0YHnVSwys2TvHV6zEWmdCtdXzBsQi3J
	zy2iWTIvgPX70wLztB+h9N55Z7c9jm2pAJeS4XJPAfQRpDpU9t5WcO17Ymj7STTn
	sL10/HSuiA0ONJAMWyLcELQqZHuv6Dx0ZT9xuL/lQqkH1wTvsa58s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 64BC024667;
	Fri, 23 Aug 2024 12:57:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D748E24666;
	Fri, 23 Aug 2024 12:57:47 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Haritha via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Haritha <harithamma.d@ibm.com>
Subject: Re: [PATCH] exec_cmd: RUNTIME_PREFIX on z/OS systems
In-Reply-To: <xmqqplq0tur4.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	22 Aug 2024 08:58:07 -0700")
References: <pull.1769.git.git.1724334732249.gitgitgadget@gmail.com>
	<xmqqplq0tur4.fsf@gitster.g>
Date: Fri, 23 Aug 2024 09:57:46 -0700
Message-ID: <xmqqa5h3p46t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D32DCFF8-6170-11EF-A14B-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> The following shows how I would fix what I found annoying while
> studying the existing code to prepare this review.  None of it
> should be part of this topic (even though it could become a
> preliminary clean-up step if we wanted to), but since I wrote it
> already, I'll record it here on the list as #leftoverbits.
>
> Thanks.

I'll take your patch as-is and merge it down to 'next'.

Once the dust settles from this topic, I'll see if we want to do
further clean-ups (the "how-about" patch below, possibly also
reorder them alphabetically) so for now, I'd leave #leftoverbits
mark here.


>  Makefile   | 26 ++++++++++++++------------
>  exec-cmd.c | 20 +++++++++-----------
>  2 files changed, 23 insertions(+), 23 deletions(-)
>
> diff --git c/Makefile w/Makefile
> index 41dfa0bad2..910aec0973 100644
> --- c/Makefile
> +++ w/Makefile
> @@ -373,21 +373,23 @@ include shared.mak
>  # Perl scripts to use a modified entry point header allowing them to resolve
>  # support files at runtime.
>  #
> -# When using RUNTIME_PREFIX, define HAVE_BSD_KERN_PROC_SYSCTL if your platform
> -# supports the KERN_PROC BSD sysctl function.
> +# When using RUNTIME_PREFIX:
>  #
> -# When using RUNTIME_PREFIX, define PROCFS_EXECUTABLE_PATH if your platform
> -# mounts a "procfs" filesystem capable of resolving the path of the current
> -# executable. If defined, this must be the canonical path for the "procfs"
> -# current executable path.
> +# - define HAVE_BSD_KERN_PROC_SYSCTL if your platform supports the
> +#   KERN_PROC BSD sysctl function.
>  #
> -# When using RUNTIME_PREFIX, define HAVE_NS_GET_EXECUTABLE_PATH if your platform
> -# supports calling _NSGetExecutablePath to retrieve the path of the running
> -# executable.
> +# - define PROCFS_EXECUTABLE_PATH if your platform mounts a "procfs"
> +#   filesystem capable of resolving the path of the current
> +#   executable. If defined, this must be the canonical path for the
> +#   "procfs" current executable path.
>  #
> -# When using RUNTIME_PREFIX, define HAVE_WPGMPTR if your platform offers
> -# the global variable _wpgmptr containing the absolute path of the current
> -# executable (this is the case on Windows).
> +# - define HAVE_NS_GET_EXECUTABLE_PATH if your platform supports
> +#   calling _NSGetExecutablePath to retrieve the path of the running
> +#   executable.
> +#
> +# - define HAVE_WPGMPTR if your platform offers the global variable
> +#   _wpgmptr containing the absolute path of the current executable
> +#   (this is the case on Windows).
>  #
>  # INSTALL_STRIP can be set to "-s" to strip binaries during installation,
>  # if your $(INSTALL) command supports the option.
> diff --git c/exec-cmd.c w/exec-cmd.c
> index 909777f61f..54bc7ed304 100644
> --- c/exec-cmd.c
> +++ w/exec-cmd.c
> @@ -100,6 +100,8 @@ static int git_get_exec_path_procfs(struct strbuf *buf)
>  	}
>  	return -1;
>  }
> +#else
> +# define git_get_exec_path_procfs(ignore) 1
>  #endif /* PROCFS_EXECUTABLE_PATH */
>  
>  #ifdef HAVE_BSD_KERN_PROC_SYSCTL
> @@ -127,6 +129,8 @@ static int git_get_exec_path_bsd_sysctl(struct strbuf *buf)
>  	}
>  	return -1;
>  }
> +#else
> +# define git_get_exec_path_bsd_sysctl(ignore) 1
>  #endif /* HAVE_BSD_KERN_PROC_SYSCTL */
>  
>  #ifdef HAVE_NS_GET_EXECUTABLE_PATH
> @@ -148,6 +152,8 @@ static int git_get_exec_path_darwin(struct strbuf *buf)
>  	}
>  	return -1;
>  }
> +#else
> +# define git_get_exec_path_darwin(ignore) 1
>  #endif /* HAVE_NS_GET_EXECUTABLE_PATH */
>  
>  #ifdef HAVE_WPGMPTR
> @@ -166,6 +172,8 @@ static int git_get_exec_path_wpgmptr(struct strbuf *buf)
>  	buf->len += len;
>  	return 0;
>  }
> +#else
> +# define git_get_exec_path_wpgmptr(ignore) 1
>  #endif /* HAVE_WPGMPTR */
>  
>  /*
> @@ -190,22 +198,12 @@ static int git_get_exec_path(struct strbuf *buf, const char *argv0)
>  	 * after the first successful method.
>  	 */
>  	if (
> -#ifdef HAVE_BSD_KERN_PROC_SYSCTL
>  		git_get_exec_path_bsd_sysctl(buf) &&
> -#endif /* HAVE_BSD_KERN_PROC_SYSCTL */
> -
> -#ifdef HAVE_NS_GET_EXECUTABLE_PATH
>  		git_get_exec_path_darwin(buf) &&
> -#endif /* HAVE_NS_GET_EXECUTABLE_PATH */
> -
> -#ifdef PROCFS_EXECUTABLE_PATH
>  		git_get_exec_path_procfs(buf) &&
> -#endif /* PROCFS_EXECUTABLE_PATH */
> -
> -#ifdef HAVE_WPGMPTR
>  		git_get_exec_path_wpgmptr(buf) &&
> -#endif /* HAVE_WPGMPTR */
>  
> +		/* fallback -- must be at the end */
>  		git_get_exec_path_from_argv0(buf, argv0)) {
>  		return -1;
>  	}
