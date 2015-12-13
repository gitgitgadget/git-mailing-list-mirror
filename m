From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7] Add git-grep threads param
Date: Sun, 13 Dec 2015 14:13:45 -0500
Message-ID: <CAPig+cTybb9d4enQjCuAefexcP=rPG2SF3VvvB78SUW1UmkuQw@mail.gmail.com>
References: <1450019856-14609-1-git-send-email-vleschuk@accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Victor Leschuk <vleschuk@accesssoftek.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Victor Leschuk <vleschuk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 20:14:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8C6E-0007VA-9n
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 20:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbbLMTNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 14:13:46 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:33751 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbbLMTNq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Dec 2015 14:13:46 -0500
Received: by vkca188 with SMTP id a188so143454753vkc.0
        for <git@vger.kernel.org>; Sun, 13 Dec 2015 11:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+nPcZSnLQks1kF6EU2pmlSNhKwCPHizbDydYm0gyemM=;
        b=DQaWxEDI6DeVBLr8rhLSuAvYbb35Mwixm0jWnX5FWhNkjv3b6p6lHL177tkk/M9ghA
         L2pbX1LPcVQhkVvSaW3U8RL1nalNzBp7h5BA7Opjj4vUOG+lxJPK7xXEf8gZSb1GI5xm
         Z3NSY7i1ayZcJz0rDOfGJeM4Nj0FJ0smDk8JYwQYxbWr06/DfCChbvr5bdjrkLgjCTUc
         SrFKTQLif3wXXBLYRsGNJxeZ6mxpSY+7Pe0GAgs/ERaXszO3cT+6HWPxOEr/U/96P0md
         w3HbG4st4l5AMK3aDcqZ22LSZp08uulJyYTpSgfJpVZd5PL8bq6Um9V5nxFCTdJLeJVA
         p99Q==
X-Received: by 10.31.13.205 with SMTP id 196mr22594413vkn.37.1450034025097;
 Sun, 13 Dec 2015 11:13:45 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 13 Dec 2015 11:13:45 -0800 (PST)
In-Reply-To: <1450019856-14609-1-git-send-email-vleschuk@accesssoftek.com>
X-Google-Sender-Auth: huqMflLdOg1JUH5_V3H_K89LG5Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282342>

On Sun, Dec 13, 2015 at 10:17 AM, Victor Leschuk <vleschuk@gmail.com> wrote:
>  "git grep" can now be configured (or told from the command line)
>  how many threads to use when searching in the working tree files.
>
>  Changes to default behavior: number of threads now doesn't depend
>  on online_cpus(), e.g. if specific number is not configured
>  GREP_NUM_THREADS_DEFAULT (8) threads will be used even on 1-core CPU.
>
>  Reason: multithreading can improve performance even on single core machines
>  as IO is also a major factor here. Using multiple threads can significantly
>  boost grep performance when working on slow filesystems (or repo isn't cached)
>  or through network (for example repo is located on NFS).
>
> Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
> ---

Hmm, v7 doesn't seem to address any of the v6 review comments here[1].
Was that review merely overlooked or did you disagree with the
reviewer?

[1]: http://article.gmane.org/gmane.comp.version-control.git/281817

> History of changes from the first version ($gmane/280053/:

It's generally more helpful to reviewers if you provide a link to the
previous version and describe the changes since that version. (If you
prefer, it's also okay to describe all changes, but they should be
organized by version so that it's obvious which changes were made in
which version.)

>         * Param renamed from threads-num to threads
>         * Short version of '--threads' cmd key was removed
>         * Made num_threads 'decision-tree' more obvious
>           and easy to edit for future use ($gmane/280089)
>         * Moved option description to more suitable place in documentation ($gmane/280188)
>         * Hid threads param from 'external' grep.c, made it private for builtin/grep.c ($gmane/280188)
>         * Improved num_threads 'decision-tree', got rid of dependency on online_cpus ($gmane/280299)
>         * Improved param documentation ($gmane/280299)
>         * Fixed broken t7811: moved all threads_num setup to 1 place (for -O option it was in wrong place) ($gmane/281160)
>         * Fixed 'invalid number of threads' message so that it could be translated ($gmane/281160)
>         * Got rid of grep_threads_config() - its too trivial to be separate function ($gmane/281160)
>         * Fixed xcalloc() args (sizeof(pthread_t) -> sizeof(*threads)) to correspond to general git style ($gmane/281160)
>         * Improved commit message to explain why online_cpus() is now not used in threads_num setup ($gmane/281160)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2d06b11..687b9ad 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1450,6 +1450,13 @@ grep.extendedRegexp::
>         option is ignored when the 'grep.patternType' option is set to a value
>         other than 'default'.
>
> +grep.threads::
> +       Number of grep worker threads, use it to tune up performance on
> +       your machines. Leave it unset (or set to 0) for default behavior,
> +       which for now is using 8 threads for all systems.
> +       Default behavior can be changed in future versions
> +       to better suit hardware and circumstances.
> +
>  gpg.program::
>         Use this custom program instead of "gpg" found on $PATH when
>         making or verifying a PGP signature. The program must support the
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 4a44d6d..8222a83 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -23,6 +23,7 @@ SYNOPSIS
>            [--break] [--heading] [-p | --show-function]
>            [-A <post-context>] [-B <pre-context>] [-C <context>]
>            [-W | --function-context]
> +          [--threads <num>]
>            [-f <file>] [-e] <pattern>
>            [--and|--or|--not|(|)|-e <pattern>...]
>            [ [--[no-]exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
> @@ -53,6 +54,13 @@ grep.extendedRegexp::
>         option is ignored when the 'grep.patternType' option is set to a value
>         other than 'default'.
>
> +grep.threads::
> +       Number of grep worker threads, use it to tune up performance on
> +       your machines. Leave it unset (or set to 0) for default behavior,
> +       which for now is using 8 threads for all systems.
> +       Default behavior can be changed in future versions
> +       to better suit hardware and circumstances.
> +
>  grep.fullName::
>         If set to true, enable '--full-name' option by default.
>
> @@ -227,6 +235,13 @@ OPTIONS
>         effectively showing the whole function in which the match was
>         found.
>
> +--threads <num>::
> +       Number of grep worker threads, use it to tune up performance on
> +       your machines. Leave it unset (or set to 0) for default behavior,
> +       which for now is using 8 threads for all systems.
> +       Default behavior can be changed in future versions
> +       to better suit hardware and circumstances.
> +
>  -f <file>::
>         Read patterns from <file>, one per line.
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 4229cae..756b6af 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -24,11 +24,11 @@ static char const * const grep_usage[] = {
>         NULL
>  };
>
> -static int use_threads = 1;
> +#define GREP_NUM_THREADS_DEFAULT 8
> +static int num_threads = 0;
>
>  #ifndef NO_PTHREADS
> -#define THREADS 8
> -static pthread_t threads[THREADS];
> +static pthread_t *threads;
>
>  /* We use one producer thread and THREADS consumer
>   * threads. The producer adds struct work_items to 'todo' and the
> @@ -63,13 +63,13 @@ static pthread_mutex_t grep_mutex;
>
>  static inline void grep_lock(void)
>  {
> -       if (use_threads)
> +       if (num_threads)
>                 pthread_mutex_lock(&grep_mutex);
>  }
>
>  static inline void grep_unlock(void)
>  {
> -       if (use_threads)
> +       if (num_threads)
>                 pthread_mutex_unlock(&grep_mutex);
>  }
>
> @@ -206,7 +206,8 @@ static void start_threads(struct grep_opt *opt)
>                 strbuf_init(&todo[i].out, 0);
>         }
>
> -       for (i = 0; i < ARRAY_SIZE(threads); i++) {
> +       threads = xcalloc(num_threads, sizeof(*threads));
> +       for (i = 0; i < num_threads; i++) {
>                 int err;
>                 struct grep_opt *o = grep_opt_dup(opt);
>                 o->output = strbuf_out;
> @@ -238,12 +239,14 @@ static int wait_all(void)
>         pthread_cond_broadcast(&cond_add);
>         grep_unlock();
>
> -       for (i = 0; i < ARRAY_SIZE(threads); i++) {
> +       for (i = 0; i < num_threads; i++) {
>                 void *h;
>                 pthread_join(threads[i], &h);
>                 hit |= (int) (intptr_t) h;
>         }
>
> +       free(threads);
> +
>         pthread_mutex_destroy(&grep_mutex);
>         pthread_mutex_destroy(&grep_read_mutex);
>         pthread_mutex_destroy(&grep_attr_mutex);
> @@ -267,6 +270,10 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
>         int st = grep_config(var, value, cb);
>         if (git_color_default_config(var, value, cb) < 0)
>                 st = -1;
> +
> +       if (!strcmp(var, "grep.threads"))
> +               num_threads = git_config_int(var, value); /* Sanity check of value will be perfomed later */
> +
>         return st;
>  }
>
> @@ -294,7 +301,7 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
>         }
>
>  #ifndef NO_PTHREADS
> -       if (use_threads) {
> +       if (num_threads) {
>                 add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, path, sha1);
>                 strbuf_release(&pathbuf);
>                 return 0;
> @@ -323,7 +330,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
>                 strbuf_addstr(&buf, filename);
>
>  #ifndef NO_PTHREADS
> -       if (use_threads) {
> +       if (num_threads) {
>                 add_work(opt, GREP_SOURCE_FILE, buf.buf, filename, filename);
>                 strbuf_release(&buf);
>                 return 0;
> @@ -697,6 +704,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>                         N_("show <n> context lines before matches")),
>                 OPT_INTEGER('A', "after-context", &opt.post_context,
>                         N_("show <n> context lines after matches")),
> +               OPT_INTEGER(0, "threads", &num_threads,
> +                       N_("use <n> worker threads")),
>                 OPT_NUMBER_CALLBACK(&opt, N_("shortcut for -C NUM"),
>                         context_callback),
>                 OPT_BOOL('p', "show-function", &opt.funcname,
> @@ -786,7 +795,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>                 opt.output_priv = &path_list;
>                 opt.output = append_path;
>                 string_list_append(&path_list, show_in_pager);
> -               use_threads = 0;
>         }
>
>         if (!opt.pattern_list)
> @@ -817,14 +825,18 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>         }
>
>  #ifndef NO_PTHREADS
> -       if (list.nr || cached || online_cpus() == 1)
> -               use_threads = 0;
> +       if (list.nr || cached || show_in_pager)
> +               num_threads = 0; /* Can not multi-thread object lookup */
> +       else if (num_threads == 0)
> +               num_threads = GREP_NUM_THREADS_DEFAULT; /* User didn't specify value, or just wants default behavior */
> +       else if (num_threads < 0)
> +               die(_("invalid number of threads specified (%d)"), num_threads);
>  #else
> -       use_threads = 0;
> +       num_threads = 0;
>  #endif
>
>  #ifndef NO_PTHREADS
> -       if (use_threads) {
> +       if (num_threads) {
>                 if (!(opt.name_only || opt.unmatch_name_only || opt.count)
>                     && (opt.pre_context || opt.post_context ||
>                         opt.file_break || opt.funcbody))
> @@ -894,7 +906,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>                 hit = grep_objects(&opt, &pathspec, &list);
>         }
>
> -       if (use_threads)
> +       if (num_threads)
>                 hit |= wait_all();
>         if (hit && show_in_pager)
>                 run_pager(&opt, prefix);
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 111b053..d5c3e3f 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1311,6 +1311,7 @@ _git_grep ()
>                         --full-name --line-number
>                         --extended-regexp --basic-regexp --fixed-strings
>                         --perl-regexp
> +                       --threads
>                         --files-with-matches --name-only
>                         --files-without-match
>                         --max-depth
> --
> 2.6.3.369.g3e7f205.dirty
