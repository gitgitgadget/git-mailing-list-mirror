Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546001CB147
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342294; cv=none; b=UKG2+D0aCUN5kD3s44nNtuRT2nSb+eRkjCopiDl026Pg6mM0be4rlVPRv1cT1wNdy+66hJBE46f7jx9lks2f40rgOF8tqCWDLqx4JT8xm60YmTon9tfIvKG4QQieGLu/JpwJ8VidXr/nCbltQaztqRbrD5XyP4wztl72DwRQ53g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342294; c=relaxed/simple;
	bh=Qq6k3wwn8zsOldPeiV9GztiMY9sqvuZrFs6QDYd2xRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JQyYPLuOKlJ2aV6/ZJsKrOEpgrwKChhMINXkaDWGZ7rWhCWMYB6rEJepskcjC4Rm1pYqrrKoZjCcA7mCD56BwDtKWRqAgAXpB3KZS3uwLjqyEtzVClE/wVEMH6I/qSGD15VIDuM649KLnWQZXjteA+ODbE0ImxqaAEmPnYlcrt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GfnUZkAH; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GfnUZkAH"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CFC0D19823;
	Thu, 22 Aug 2024 11:58:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Qq6k3wwn8zsOldPeiV9GztiMY9sqvuZrFs6QDY
	d2xRc=; b=GfnUZkAH+lTxd9pGGCjKtGWukj5rvftahiakCOeP3kESs3gEePlccb
	UXF0u+F0T6WvQyamp7fYp7LfJpSRPP8PAirhxkaxmxMt3hpj2a+wnaeo8qB4Eq/s
	l6h44+e8EfuM7SJ/d9WUQNw7OVLioaGkOjUsCts5hUsPAlFA0Y+9Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C87F219822;
	Thu, 22 Aug 2024 11:58:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 514CC19821;
	Thu, 22 Aug 2024 11:58:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Haritha via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Haritha <harithamma.d@ibm.com>
Subject: Re: [PATCH] exec_cmd: RUNTIME_PREFIX on z/OS systems
In-Reply-To: <pull.1769.git.git.1724334732249.gitgitgadget@gmail.com> (Haritha
	via GitGitGadget's message of "Thu, 22 Aug 2024 13:52:12 +0000")
References: <pull.1769.git.git.1724334732249.gitgitgadget@gmail.com>
Date: Thu, 22 Aug 2024 08:58:07 -0700
Message-ID: <xmqqplq0tur4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 53C7F418-609F-11EF-B534-E92ED1CD468F-77302942!pb-smtp21.pobox.com

"Haritha  via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  Makefile         |  8 ++++++++
>  config.mak.uname |  1 +
>  exec-cmd.c       | 23 +++++++++++++++++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index a87e18b317d..bdc68234823 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -385,6 +385,10 @@ include shared.mak
>  # supports calling _NSGetExecutablePath to retrieve the path of the running
>  # executable.
>  #
> +# When using RUNTIME_PREFIX, define HAVE_ZOS_GET_EXECUTABLE_PATH if your platform
> +# supports calling __getprogramdir and getprogname to retrieve the path of the
> +# running executable.
> +#
>  # When using RUNTIME_PREFIX, define HAVE_WPGMPTR if your platform offers
>  # the global variable _wpgmptr containing the absolute path of the current
>  # executable (this is the case on Windows).

It is a bit puzzling why this new thing is not added after the last
existing one in the same family of "When using RUNTIME_PREFIX".  Our
usual convention to order things that have no inherent logical order
among them is either to add the new one at the end or order them
alphabetically.  This comment applies to the other additions to an
existing list (e.g. cascade of git_get_exec_$SYSTEM() calls in
git_get_exec_path() function).

In any case, we should reorganize this section a bit to make it more
obvious that the options from HAVE_BSD_KERN_PROC_SYSCTL to
HAVE_WPGMPTR are the ones that affect how RUNTIME_PREFIX finds the
program location, but that is outside the scope of this topic.

The remainder of the patch looked perfectly in line with the
existing practice (except for where the new thing is added, which I
already mentioned); I do not do zos so I'll have to take your word
for the implementation of git_get_exec_path_zos(), though ;-)

The following shows how I would fix what I found annoying while
studying the existing code to prepare this review.  None of it
should be part of this topic (even though it could become a
preliminary clean-up step if we wanted to), but since I wrote it
already, I'll record it here on the list as #leftoverbits.

Thanks.

 Makefile   | 26 ++++++++++++++------------
 exec-cmd.c | 20 +++++++++-----------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git c/Makefile w/Makefile
index 41dfa0bad2..910aec0973 100644
--- c/Makefile
+++ w/Makefile
@@ -373,21 +373,23 @@ include shared.mak
 # Perl scripts to use a modified entry point header allowing them to resolve
 # support files at runtime.
 #
-# When using RUNTIME_PREFIX, define HAVE_BSD_KERN_PROC_SYSCTL if your platform
-# supports the KERN_PROC BSD sysctl function.
+# When using RUNTIME_PREFIX:
 #
-# When using RUNTIME_PREFIX, define PROCFS_EXECUTABLE_PATH if your platform
-# mounts a "procfs" filesystem capable of resolving the path of the current
-# executable. If defined, this must be the canonical path for the "procfs"
-# current executable path.
+# - define HAVE_BSD_KERN_PROC_SYSCTL if your platform supports the
+#   KERN_PROC BSD sysctl function.
 #
-# When using RUNTIME_PREFIX, define HAVE_NS_GET_EXECUTABLE_PATH if your platform
-# supports calling _NSGetExecutablePath to retrieve the path of the running
-# executable.
+# - define PROCFS_EXECUTABLE_PATH if your platform mounts a "procfs"
+#   filesystem capable of resolving the path of the current
+#   executable. If defined, this must be the canonical path for the
+#   "procfs" current executable path.
 #
-# When using RUNTIME_PREFIX, define HAVE_WPGMPTR if your platform offers
-# the global variable _wpgmptr containing the absolute path of the current
-# executable (this is the case on Windows).
+# - define HAVE_NS_GET_EXECUTABLE_PATH if your platform supports
+#   calling _NSGetExecutablePath to retrieve the path of the running
+#   executable.
+#
+# - define HAVE_WPGMPTR if your platform offers the global variable
+#   _wpgmptr containing the absolute path of the current executable
+#   (this is the case on Windows).
 #
 # INSTALL_STRIP can be set to "-s" to strip binaries during installation,
 # if your $(INSTALL) command supports the option.
diff --git c/exec-cmd.c w/exec-cmd.c
index 909777f61f..54bc7ed304 100644
--- c/exec-cmd.c
+++ w/exec-cmd.c
@@ -100,6 +100,8 @@ static int git_get_exec_path_procfs(struct strbuf *buf)
 	}
 	return -1;
 }
+#else
+# define git_get_exec_path_procfs(ignore) 1
 #endif /* PROCFS_EXECUTABLE_PATH */
 
 #ifdef HAVE_BSD_KERN_PROC_SYSCTL
@@ -127,6 +129,8 @@ static int git_get_exec_path_bsd_sysctl(struct strbuf *buf)
 	}
 	return -1;
 }
+#else
+# define git_get_exec_path_bsd_sysctl(ignore) 1
 #endif /* HAVE_BSD_KERN_PROC_SYSCTL */
 
 #ifdef HAVE_NS_GET_EXECUTABLE_PATH
@@ -148,6 +152,8 @@ static int git_get_exec_path_darwin(struct strbuf *buf)
 	}
 	return -1;
 }
+#else
+# define git_get_exec_path_darwin(ignore) 1
 #endif /* HAVE_NS_GET_EXECUTABLE_PATH */
 
 #ifdef HAVE_WPGMPTR
@@ -166,6 +172,8 @@ static int git_get_exec_path_wpgmptr(struct strbuf *buf)
 	buf->len += len;
 	return 0;
 }
+#else
+# define git_get_exec_path_wpgmptr(ignore) 1
 #endif /* HAVE_WPGMPTR */
 
 /*
@@ -190,22 +198,12 @@ static int git_get_exec_path(struct strbuf *buf, const char *argv0)
 	 * after the first successful method.
 	 */
 	if (
-#ifdef HAVE_BSD_KERN_PROC_SYSCTL
 		git_get_exec_path_bsd_sysctl(buf) &&
-#endif /* HAVE_BSD_KERN_PROC_SYSCTL */
-
-#ifdef HAVE_NS_GET_EXECUTABLE_PATH
 		git_get_exec_path_darwin(buf) &&
-#endif /* HAVE_NS_GET_EXECUTABLE_PATH */
-
-#ifdef PROCFS_EXECUTABLE_PATH
 		git_get_exec_path_procfs(buf) &&
-#endif /* PROCFS_EXECUTABLE_PATH */
-
-#ifdef HAVE_WPGMPTR
 		git_get_exec_path_wpgmptr(buf) &&
-#endif /* HAVE_WPGMPTR */
 
+		/* fallback -- must be at the end */
 		git_get_exec_path_from_argv0(buf, argv0)) {
 		return -1;
 	}
