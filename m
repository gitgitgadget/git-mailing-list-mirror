Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88C0C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 15:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7755364FAB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 15:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhCKPDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbhCKPDK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 10:03:10 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49EBC061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 07:03:10 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id s21so3725920pfm.1
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 07:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mTZXbi2zVwYnSSaB39lAl5SmU4LubH7Wj094jDO1DvM=;
        b=rrWk4N1ELMzkk+t/gbZ11FavWdStl4XE7tCaEeAX2wRga45bOFsKADZzkXu6EmZSfs
         4Vb/qMr8RBFgwFT76o14KPe/1QgE4yZfJW7Yy0CcD7XAz5p+FqOiJ6tzr6oKqL3XXGjw
         6iZ8cn0SjP38ZlN1vlZZWnwSYBc20Xlhy+NElJvAPqhL85DIMAW9z2YsdiLUaSJpvCye
         DSL2hf+C0IVtdMcccyVtJY51ukP9Dl/RHdUtsZdtYXIwJ0qEpQsKAe01kNtFESjNfrmm
         xJos4VAHPWmUCRXSQ4/HJZZOsIAyAuKR7I69dAB0Z3qYfiKgMD4XfJVApXfxeFsPKAyk
         hSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mTZXbi2zVwYnSSaB39lAl5SmU4LubH7Wj094jDO1DvM=;
        b=ePEKj36Ve5dzXQ3BLSbVCCarptplqvQAkcaTBDswzZzFjjs4Z3Em9iFvBcErdsRv6j
         Np0YyVp4RIpIm/t5S5I7M8dDcdihVHLpA9/Q4L+ppvqWkI4lK/9vgOKq2inV8aMKUPgo
         +VOECzZHXRmIO3418xMLnmXSmnyB6+e5yhc2N8Tvp3tnYfvM4w6oJAmXaOBdvnO9Bq/w
         /q33u/mG6nhdrmb1rAre154f/lNy7FLHEm6PkBphlAHtz1ZV4XdI5ZlKTqIgj4J7A9G7
         XixxsJzpNSt0mIIAoR9Gxxaykwe5/Mg7sWqUcXfWUGA+kmfnftAMygzTR9PmZi7mlwZ9
         6cyw==
X-Gm-Message-State: AOAM530F73U+nFy3cwrUVQa/yD47J0XRUhDlQuBVup2el8LHdTJT3iAR
        0EXEuSBJd7mqwb6sHy6LLTQ=
X-Google-Smtp-Source: ABdhPJzaBj6T8vV+TBWPWCz+3lBxaYd+MSwPerGiOvrWDbgXavTuIl0T0C0IT6DT8v+Tm7BJyFW4RA==
X-Received: by 2002:a63:dd49:: with SMTP id g9mr7884320pgj.175.1615474989660;
        Thu, 11 Mar 2021 07:03:09 -0800 (PST)
Received: from konoha ([14.139.233.131])
        by smtp.gmail.com with ESMTPSA id e22sm2732273pgk.56.2021.03.11.07.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:03:09 -0800 (PST)
Date:   Thu, 11 Mar 2021 20:33:04 +0530
From:   Shourya Shukla <periperidip@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] [GSOC] commit: provides multiple common signatures
Message-ID: <20210311150304.GA8169@konoha>
References: <pull.901.git.1615446968597.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.901.git.1615446968597.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey!

The idea seems very useful to me though I am not sure what others feel
about this and whether Git is ready for such a thing or not. Keeping
this concern aside, I will still review the patch due to my own interest
in it as well.

On 11/03 07:16, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>
> 
> Similar to "Helped-by", "Reported-by", "Reviewed-by", "Mentored-by"
> these signatures are often seen in git commit messages. After

I think it will be better to rephrase the line so that it is easier to
understand. It took me a couple of reads to figure out what you meant.

Something like:

Similar to "Signed-off-by", trailers such as "Reported-by", "Helped-by"
and "Mentored-by" are also seen in Git commits.

> referring to the simple implementation of `commit --signoff`
> and `send-email -cc=" commiter <email>"`, I am considering
> whether to provide multiple signature parameters from the
> command line. I think this might help maintainers and
> developers directly uses the shell to provide these signatures
> instead of multiple times repetitive writing those trailers
> each time.

The above para is more appropriate for a cover letter than a commit
message. Your thought process for the patch you sent is equally valuable
but this does not belong in the commit message. Commit messages are more
about what you did and any nuances that follow. You get me?

Use 'git format-patch --cover-letter <...>' to create a cover letter for
your patch.

> To achieve this goal, i refactored the `append_signoff` design and
> provided `append_message` and `append_message_string_list` interfaces,
> providing new ways to generate those various signatures.

s/i/I

Also, commit messages are generally written in the imperative tense when
desciribing what you have done in the commit.

> Users now can use `commit -H "helper <eamil>"` to generate "Helped-by" trailer,
> `commit -R "reviewer <eamil>"` to generate "Reviewed-by" trailer,
> `commit -r "reporter <eamil> "`to generate "Reported-by" trailer,
> `commit -M "mentor <eamil>"` to generate "Mentored-by" trailer.

Multiple typos.

> Signed-off-by: ZheNing Hu <adlternative@gmail.com>

So, an improved commit message could be:

-----8<-----
commit: support multiple trailers from the command line

Historically, Git has supported the 'Signed-off-by' commit trailer
using the '--signoff' and the '-s' option from the command line. Extend
this list to include other commonly used trailers viz., "Helped-by",
"Reviewed-by", "Reported-by" and "Mentored-by". Introduce options '-H',
'-R', '-r' and '-M' corresponding to the aforementioned trailers.

While at it, add tests in the script 't7502-commit-porcelain.sh' and add
information regarding these options in the Documentation of 'git
commit'.
----->8-----

>     [GSOC] commit: provides multiple signatures from command line
>     
>     I don’t know if my idea will satisfy everyone, I'm also thinking about
>     whether we can provide a more generalized version (I think this idea can
>     be extended: because users and developers have other signature methods
>     that they want, such as "Based-on-patch-by") I hope someone can give me
>     pointers (on the correctness of ideas or codes)

It will be great if we let the user add customised options for the
respective trailers but I think that trying to cater to such a large
audience will only complicate the whole process and decrease the support
avialable for the options/command. Apart from this, I think that the
trailer "Reviewed-by" may not be that widely used and it would be better
if we remove it from this patch.

>  Documentation/git-commit.txt |  24 +++++++-
>  builtin/commit.c             |  63 +++++++++++++++++++++
>  sequencer.c                  |  40 +++++++++----
>  sequencer.h                  |   4 ++
>  t/t7502-commit-porcelain.sh  | 106 +++++++++++++++++++++++++++++++++++
>  5 files changed, 226 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 17150fa7eabe..e1b528d70c1a 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -14,7 +14,9 @@ SYNOPSIS
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
>  	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
>  	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
> -	   [-S[<keyid>]] [--] [<pathspec>...]
> +	   [-S[<keyid>]] [--] [<pathspec>...] [(-H|--helped-by)=<address>...]
> +	   [(-R|--reviewed-by)=<address>...] [(-r|--reported-by)=<address>...]
> +	   [(-M|--mentored)=<address>...]
>  
>  DESCRIPTION
>  -----------
> @@ -166,6 +168,26 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
>  
>  include::signoff-option.txt[]
>  
> +-H=<address>...::
> +--helped-by=<address>...::
> +	Add one or more `Helped-by` trailer by the committer at the end of the commit
> +	log message.
> +
> +-R=<address>...::
> +--reviewed-by=<address>...::
> +	Add one or more `Reviewed-by` trailer by the committer at the end of the commit
> +	log message.
> +
> +-r=<address>...::
> +--reported-by=<address>...::
> +	Add one or more `Reported-by` trailer by the committer at the end of the commit
> +	log message.
> +
> +-M=<address>...::
> +--mentored-by=<address>...::
> +	Add one or more `Mentored-by` trailer by the committer at the end of the commit
> +	log message.

Oh! I did not think you had added long forms of these options and was
about to comment on that. Good that you added. Do talk about them as
well in the commit message.

>  -n::
>  --no-verify::
>  	This option bypasses the pre-commit and commit-msg hooks.
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 739110c5a7f6..4b312af03181 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -113,6 +113,10 @@ static int config_commit_verbose = -1; /* unspecified */
>  static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
>  static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
>  static char *sign_commit, *pathspec_from_file;
> +static struct string_list helped_by = STRING_LIST_INIT_NODUP;
> +static struct string_list mentored_by = STRING_LIST_INIT_NODUP;
> +static struct string_list reviewed_by = STRING_LIST_INIT_NODUP;
> +static struct string_list reported_by = STRING_LIST_INIT_NODUP;

Good that you kept the variables as 'string_list's instead of a usual
'char*'.

>  /*
>   * The default commit message cleanup mode will remove the lines
> @@ -829,6 +833,20 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	if (signoff)
>  		append_signoff(&sb, ignore_non_trailer(sb.buf, sb.len), 0);
>  
> +	if(helped_by.items)
> +		append_message_string_list(&sb, "Helped-by: ", &helped_by, ignore_non_trailer(sb.buf, sb.len), 0);
> +	if(reviewed_by.items)
> +		append_message_string_list(&sb, "Reviewed-by: ", &reviewed_by, ignore_non_trailer(sb.buf, sb.len), 0);
> +	if(reported_by.items)
> +		append_message_string_list(&sb, "Reported-by: ", &reported_by, ignore_non_trailer(sb.buf, sb.len), 0);
> +	if(mentored_by.items)
> +		append_message_string_list(&sb, "Mentored-by: ", &mentored_by, ignore_non_trailer(sb.buf, sb.len), 0);

I think this part will look prettier if you wrap around the text. For
code segments, the wrap around limit is 80 chars. For commit messages
its 72 chars. Wrap around means that as soon as you hit N number of
characters, you proceed to the next(new) line.

> +	string_list_clear(&helped_by, 0);
> +	string_list_clear(&reviewed_by, 0);
> +	string_list_clear(&reported_by, 0);
> +	string_list_clear(&mentored_by, 0);
> +
>  	if (fwrite(sb.buf, 1, sb.len, s->fp) < sb.len)
>  		die_errno(_("could not write commit template"));
>  
> @@ -1490,6 +1508,42 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>  	return git_status_config(k, v, s);
>  }
>  
> +static int help_callback(const struct option *opt, const char *arg, int unset)
> +{
> +	if (unset)
> +		string_list_clear(&helped_by, 0);
> +	else
> +		string_list_append(&helped_by, arg);
> +	return 0;
> +}
> +
> +static int review_callback(const struct option *opt, const char *arg, int unset)
> +{
> +	if (unset)
> +		string_list_clear(&reviewed_by, 0);
> +	else
> +		string_list_append(&reviewed_by, arg);
> +	return 0;
> +}
> +
> +static int report_callback(const struct option *opt, const char *arg, int unset)
> +{
> +	if (unset)
> +		string_list_clear(&reported_by, 0);
> +	else
> +		string_list_append(&reported_by, arg);
> +	return 0;
> +}
> +
> +static int mentor_callback(const struct option *opt, const char *arg, int unset)
> +{
> +	if (unset)
> +		string_list_clear(&mentored_by, 0);
> +	else
> +		string_list_append(&mentored_by, arg);
> +	return 0;
> +}
>  int cmd_commit(int argc, const char **argv, const char *prefix)
>  {
>  	static struct wt_status s;
> @@ -1507,6 +1561,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
>  		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
>  		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
> +		OPT_CALLBACK('H', "helped-by", NULL, N_("email"), N_("add a Helped-by trailer"), help_callback),
> +		OPT_CALLBACK('r', "reported-by", NULL, N_("email"), N_("add a Reported-by trailer"), report_callback),
> +		OPT_CALLBACK('R', "reviewed-by", NULL, N_("email"), N_("add a Reviewed-by trailer"), review_callback),
> +		OPT_CALLBACK('M', "mentored-by", NULL, N_("email"), N_("add a Mentored-by trailer"), mentor_callback),

It would be lovely if you could line wrap these above additions too!

>  		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
>  		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
>  		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
> @@ -1561,6 +1619,11 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  	struct commit_extra_header *extra = NULL;
>  	struct strbuf err = STRBUF_INIT;
>  
> +	helped_by.strdup_strings = 1;
> +	reviewed_by.strdup_strings = 1;
> +	reported_by.strdup_strings = 1;
> +	mentored_by.strdup_strings = 1;
> +
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>  		usage_with_options(builtin_commit_usage, builtin_commit_options);
>  
> diff --git a/sequencer.c b/sequencer.c
> index d2332d3e1787..528daf9df252 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4668,16 +4668,12 @@ int sequencer_pick_revisions(struct repository *r,
>  	return res;
>  }
>  
> -void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
> +void append_message(struct strbuf *msgbuf, struct strbuf *sob,
> +			size_t ignore_footer, unsigned flag)

Its nice to see that you generalised the pre-exisiting function instead
of creating a new one(s) for the new trailers. Good.

It will be better to name 'struct strbuf *sob' to something more
generic, maybe 'struct strbuf *trailer' since 'sob' stands for
'Signed-off-by' and since the function is becoming more generic, its
contents should too.

>  {
>  	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
> -	struct strbuf sob = STRBUF_INIT;
>  	int has_footer;
>  
> -	strbuf_addstr(&sob, sign_off_header);
> -	strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
> -	strbuf_addch(&sob, '\n');
> -
>  	if (!ignore_footer)
>  		strbuf_complete_line(msgbuf);
>  
> @@ -4685,11 +4681,11 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
>  	 * If the whole message buffer is equal to the sob, pretend that we
>  	 * found a conforming footer with a matching sob
>  	 */
> -	if (msgbuf->len - ignore_footer == sob.len &&
> -	    !strncmp(msgbuf->buf, sob.buf, sob.len))
> +	if (msgbuf->len - ignore_footer == sob->len &&
> +	    !strncmp(msgbuf->buf, sob->buf, sob->len))
>  		has_footer = 3;
>  	else
> -		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
> +		has_footer = has_conforming_footer(msgbuf, sob, ignore_footer);

Again, rename the variables.

>  	if (!has_footer) {
>  		const char *append_newlines = NULL;
> @@ -4723,8 +4719,32 @@ void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
>  
>  	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))
>  		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
> -				sob.buf, sob.len);
> +				sob->buf, sob->len);
> +}
> +void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
> +{
> +	struct strbuf sob = STRBUF_INIT;
> +	strbuf_addstr(&sob, sign_off_header);
> +	strbuf_addstr(&sob, fmt_name(WANT_COMMITTER_IDENT));
> +	strbuf_addch(&sob, '\n');
> +	append_message(msgbuf, &sob, ignore_footer, flag);
> +	strbuf_release(&sob);
> +}

I think it will be nice if you could use a flag to denote whether the
entity to be appended is a 'sign-off' or not. This way when say the
variable 'int signoff' is 1, then use the above part in the
'append_message()' function otherwise go with the flow that exists.

> +void append_message_string_list(struct strbuf *msgbuf, const char *header,
> +		struct string_list *sobs, size_t ignore_footer, unsigned flag) {
> +	int i;
> +	struct strbuf sob = STRBUF_INIT;
> +
> +	for ( i = 0; i < sobs->nr; i++)
> +	{
> +		strbuf_addstr(&sob, header);
> +		strbuf_addstr(&sob, sobs->items[i].string);
> +		strbuf_addch(&sob, '\n');
> +		append_message(msgbuf, &sob, ignore_footer, flag);
> +		strbuf_reset(&sob);
> +	}
>  	strbuf_release(&sob);
>  }

Similarly, here, if 'signoff = 0' then the above part goes on. Or
another alternative can be to create a 'append_message_helper()' and
shift the current contents of 'append_message()' into that and use the
above function to work as per the value of signoff.

So a possible flow can be:

void append_message_string_list(...params...) {

	if (signoff) {
		..excecute the necessary segments and call the
		'append_message_helper()' function...
	} else {
		..similarly here..
	}
}

This way we save ourselves some extra functions.

> diff --git a/sequencer.h b/sequencer.h
> index f8b2e4ab8527..b24e274f4c62 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -174,6 +174,10 @@ int todo_list_rearrange_squash(struct todo_list *todo_list);
>   * and the new signoff will be spliced into the buffer before those bytes.
>   */
>  void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
> +void append_message(struct strbuf *msgbuf, struct strbuf *sob,
> +		size_t ignore_footer, unsigned flag);
> +void append_message_string_list(struct strbuf *msgbuf, const char*header,
> +		struct string_list *sobs, size_t ignore_footer, unsigned flag);
>  
>  void append_conflicts_hint(struct index_state *istate,
>  		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);

Then, these would have to be corrected too.

> diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
> index 6396897cc818..40823152a51c 100755
> --- a/t/t7502-commit-porcelain.sh
> +++ b/t/t7502-commit-porcelain.sh
> @@ -154,6 +154,112 @@ test_expect_success 'sign off' '
>  
>  '

I feel that the tests deserve a commit of their own. A follow-up commit
in this patch.

> +test_expect_success 'helped-by' '
> +
> +	>file1 &&
> +	git add file1 &&
> +	git commit --helped-by="foo <bar@frotz>" \
> +	--helped-by="foo2 <bar2@frotz>" -m "thank you" &&
> +	git cat-file commit HEAD >commit.msg &&
> +	sed -ne "s/Helped-by: //p" commit.msg >actual &&
> +	cat >expected <<-\EOF &&
> +	foo <bar@frotz>
> +	foo2 <bar2@frotz>
> +	EOF
> +	test_cmp expected actual
> +

Was this extra line feed intentional? It looks odd here and other test
(scripts) don't have this. Though, this test script seems to have many
tests which have an extra line feed. My suggestion would be to eliminate
it. Maybe this script is old and hasn't been reviewed for a cleanup in
a long time.

> +'
> +
> +test_expect_success 'reported-by' '
> +
> +	>file2 &&
> +	git add file2 &&
> +	git commit --reported-by="foo <bar@frotz>" \
> +	--reported-by="foo2 <bar2@frotz>" -m "thank you" &&
> +	git cat-file commit HEAD >commit.msg &&
> +	sed -ne "s/Reported-by: //p" commit.msg >actual &&
> +	cat >expected <<-\EOF &&
> +	foo <bar@frotz>
> +	foo2 <bar2@frotz>
> +	EOF
> +	test_cmp expected actual
> +

Similarly here and in the parts that follow.

<...>

This seems like a good patch to me but more experienced members will be
able to comment better I think. Good job anyways.

Regards,
Shourya Shukla

