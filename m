From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Handle atexit list internaly for unthreaded builds
Date: Mon, 13 Oct 2014 13:00:16 -0700
Message-ID: <xmqq7g033flb.fsf@gitster.dls.corp.google.com>
References: <87bnpg9b99.fsf@igel.home>
	<2724eb56a7219e0ed341e734beb32aa236119998.1413225018.git.etienne.buira@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, schwab@linux-m68k.org, git@vger.kernel.org
To: Etienne Buira <etienne.buira@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 22:00:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdln8-0006mJ-MG
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 22:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbaJMUAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 16:00:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56692 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751058AbaJMUAV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 16:00:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71F30168FC;
	Mon, 13 Oct 2014 16:00:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2cOWaM5bGd4hCoPM/58MQKjKAPA=; b=CU2ei/
	t1d6H9OODC9/PzZovSPO0XE0GQfBNeYsyv4rdm9KVhN5Jb3MPOGWs2Mf+7M1r3gN
	/AwMT25aOWS0xJTjMHrefow+Is9dU0/N/ie/mt9e/KdtJJcU+Xo/6sFvxIPt09QL
	OW8FxFtJoM++VvELU7XC3V8lQCPjxM/YNx91o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iJdPcQ5OhT4QujQg9GzRWr0iXbIIdoC6
	NG1HJEif77bU14us7mRkZ/gp3/0nPabsQUnLcAUtQYRKDomo4ZtALm25BIdsZtcR
	uZUtDRG4lbzYfqy5mFv1YLqB0ab7vtbLN25tH2UMq+IwVqSBvDMeVmpddXSiHKpi
	/bpKjRQGyW0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6909D168FB;
	Mon, 13 Oct 2014 16:00:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F12AF168F2;
	Mon, 13 Oct 2014 16:00:17 -0400 (EDT)
In-Reply-To: <2724eb56a7219e0ed341e734beb32aa236119998.1413225018.git.etienne.buira@gmail.com>
	(Etienne Buira's message of "Mon, 13 Oct 2014 20:35:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8E02C77E-5313-11E4-85BF-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Etienne Buira <etienne.buira@gmail.com> writes:

> Wrap atexit()s calls on unthreaded builds to handle callback list
> internally.
>
> This is needed because on unthreaded builds, asyncs inherits parent's
> atexit() list, that gets run as soon as the async exit()s (and again at
> the end of the parent process). That led to remove temporary and lock
> files too early.

... that does not explain what you did to builtin/clone.c at all.
Care to enlighten us, please?

>
> Fixes test 5537 (temporary shallow file vanished before unpack-objects
> could open it)
>
> V4: fix bogus preprocessor directives

Please do not write this "V4:" line in the log message.  People who
read "git log" output and find this description would not know
anything about the previous faulty ones.  Putting it _after_ the
three-dash line below will help the reviewers a lot.

>
> Thanks-to: Duy Nguyen <pclouds@gmail.com>
> Thanks-to: Andreas Schwab <schwab@linux-m68k.org>

Usually we spell these "Helped-by: " instead.

> Signed-off-by: Etienne Buira <etienne.buira@gmail.com>
> ---

Thanks.

>  builtin/clone.c   |  5 -----
>  git-compat-util.h |  5 +++++
>  run-command.c     | 40 ++++++++++++++++++++++++++++++++++++++++
>  shallow.c         |  7 ++-----
>  4 files changed, 47 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index bbd169c..e122f33 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -390,7 +390,6 @@ static void clone_local(const char *src_repo, const char *dest_repo)
>  
>  static const char *junk_work_tree;
>  static const char *junk_git_dir;
> -static pid_t junk_pid;
>  static enum {
>  	JUNK_LEAVE_NONE,
>  	JUNK_LEAVE_REPO,
> @@ -417,8 +416,6 @@ static void remove_junk(void)
>  		break;
>  	}
>  
> -	if (getpid() != junk_pid)
> -		return;
>  	if (junk_git_dir) {
>  		strbuf_addstr(&sb, junk_git_dir);
>  		remove_dir_recursively(&sb, 0);
> @@ -758,8 +755,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	struct refspec *refspec;
>  	const char *fetch_pattern;
>  
> -	junk_pid = getpid();
> -
>  	packet_trace_identity("clone");
>  	argc = parse_options(argc, argv, prefix, builtin_clone_options,
>  			     builtin_clone_usage, 0);
> diff --git a/git-compat-util.h b/git-compat-util.h
> index f587749..6dd63dd 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -577,6 +577,11 @@ int inet_pton(int af, const char *src, void *dst);
>  const char *inet_ntop(int af, const void *src, char *dst, size_t size);
>  #endif
>  
> +#ifdef NO_PTHREADS
> +#define atexit git_atexit
> +extern int git_atexit(void (*handler)(void));
> +#endif
> +
>  extern void release_pack_memory(size_t);
>  
>  typedef void (*try_to_free_t)(size_t);
> diff --git a/run-command.c b/run-command.c
> index 35a3ebf..0f9a9b0 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -624,6 +624,45 @@ static int async_die_is_recursing(void)
>  	return ret != NULL;
>  }
>  
> +#else
> +
> +static struct {
> +	void (**handlers)(void);
> +	size_t nr;
> +	size_t alloc;
> +} git_atexit_hdlrs;
> +
> +static int git_atexit_installed;
> +
> +static void git_atexit_dispatch()
> +{
> +	size_t i;
> +
> +	for (i=git_atexit_hdlrs.nr ; i ; i--)
> +		git_atexit_hdlrs.handlers[i-1]();
> +}
> +
> +static void git_atexit_clear()
> +{
> +	free(git_atexit_hdlrs.handlers);
> +	memset(&git_atexit_hdlrs, 0, sizeof(git_atexit_hdlrs));
> +	git_atexit_installed = 0;
> +}
> +
> +#undef atexit
> +int git_atexit(void (*handler)(void))
> +{
> +	ALLOC_GROW(git_atexit_hdlrs.handlers, git_atexit_hdlrs.nr + 1, git_atexit_hdlrs.alloc);
> +	git_atexit_hdlrs.handlers[git_atexit_hdlrs.nr++] = handler;
> +	if (!git_atexit_installed) {
> +		if (atexit(&git_atexit_dispatch))
> +			return -1;
> +		git_atexit_installed = 1;
> +	}
> +	return 0;
> +}
> +#define atexit git_atexit
> +
>  #endif
>  
>  int start_async(struct async *async)
> @@ -682,6 +721,7 @@ int start_async(struct async *async)
>  			close(fdin[1]);
>  		if (need_out)
>  			close(fdout[0]);
> +		git_atexit_clear();
>  		exit(!!async->proc(proc_in, proc_out, async->data));
>  	}
>  
> diff --git a/shallow.c b/shallow.c
> index de07709..f067811 100644
> --- a/shallow.c
> +++ b/shallow.c
> @@ -226,7 +226,6 @@ static void remove_temporary_shallow_on_signal(int signo)
>  
>  const char *setup_temporary_shallow(const struct sha1_array *extra)
>  {
> -	static int installed_handler;
>  	struct strbuf sb = STRBUF_INIT;
>  	int fd;
>  
> @@ -237,10 +236,8 @@ const char *setup_temporary_shallow(const struct sha1_array *extra)
>  		strbuf_addstr(&temporary_shallow, git_path("shallow_XXXXXX"));
>  		fd = xmkstemp(temporary_shallow.buf);
>  
> -		if (!installed_handler) {
> -			atexit(remove_temporary_shallow);
> -			sigchain_push_common(remove_temporary_shallow_on_signal);
> -		}
> +		atexit(remove_temporary_shallow);
> +		sigchain_push_common(remove_temporary_shallow_on_signal);
>  
>  		if (write_in_full(fd, sb.buf, sb.len) != sb.len)
>  			die_errno("failed to write to %s",
