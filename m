From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] strbuf: make stripspace() part of strbuf
Date: Thu, 15 Oct 2015 10:36:17 -0700
Message-ID: <xmqqsi5cghke.fsf@gitster.mtv.corp.google.com>
References: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
	<1444911524-14504-2-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Thu Oct 15 19:36:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmmS5-0006lx-0N
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 19:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbbJORgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 13:36:23 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36582 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbbJORgW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 13:36:22 -0400
Received: by padcn9 with SMTP id cn9so12013679pad.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 10:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VVhjNSZCkKwqaf9p9cKqNOj2l5c09ATIwlYFEvXyms4=;
        b=HTbS8pAglJ0geB4V0vlrCxfRX21/5l1ZgAyTiyfsUrAAwu7ecLq+SA6BySfPRuwk07
         sZ+nfAOd6t3sr1wXniazXzPOug8RiXjle2KkAhVJEJIpWmvna0M/q+zKY0FZFEUeD649
         vKD9nAGJzfcIk3lUfr+PR3KohryV3G8FMU4XIo/BVFBlMIa71kbyRHTsCGieWWcFfaHU
         1CPPWcw0KFfMiQF9BlSIqJ71azhPlWI329Qh3RTESDElEqijPFuY/LqHRS3oIK+qksA2
         NO8KEYHNuRbPNejFNvNy3gGuE2pfbyKQCXJZ3oJtmpJSh7lBGNPwkB/KTaA83lwGMD/0
         9vug==
X-Received: by 10.67.15.100 with SMTP id fn4mr11586740pad.120.1444930581693;
        Thu, 15 Oct 2015 10:36:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id ix1sm3281054pbd.40.2015.10.15.10.36.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 10:36:20 -0700 (PDT)
In-Reply-To: <1444911524-14504-2-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Thu, 15 Oct 2015 14:18:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279675>

Tobias Klauser <tklauser@distanz.ch> writes:

> Rename stripspace() to strbuf_stripspace() and move it to the strbuf
> module as suggested in [1].
>
> Also switch all current users of stripspace() to the new function name
> and  keep a temporary wrapper inline function for topic branches still
> using stripspace().
>
> [1] https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#make_.27stripspace.28.29.27_part_of_strbuf

I think Matthieu already mentioned this, but please explain why it
is a good idea to do this in your own words here, without forcing
readers to go to other places to find out.  Giving credit to an
external page for giving you an inspiration to do something is good,
but the proposed log message needs to justify itself.  In other
words, when you are challenged to defend this change, you are not
allowed to say "SmallProjectIdeas page said it is a good thing to
do.  I just did it without questioning it." ;-)  Instead you are
expected to justify it yourself.

> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---

A good rule of thumb to see if it is a good time to do this kind of
change is to do this:

	$ git log -p maint..pu | grep stripspace

which shows only one mention in a context, so this change may cause
textual conflict with something else somewhere nearby but won't hurt
other topics in flight.

The patch itself looks OK.

Thanks.

>  builtin/am.c         |  2 +-
>  builtin/branch.c     |  2 +-
>  builtin/commit.c     |  6 ++---
>  builtin/merge.c      |  2 +-
>  builtin/notes.c      |  6 ++---
>  builtin/stripspace.c | 69 ++--------------------------------------------------
>  builtin/tag.c        |  2 +-
>  strbuf.c             | 66 +++++++++++++++++++++++++++++++++++++++++++++++++
>  strbuf.h             | 11 ++++++++-
>  9 files changed, 88 insertions(+), 78 deletions(-)
>
> diff --git a/builtin/am.c b/builtin/am.c
> index 4f77e07..fbe9152 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1343,7 +1343,7 @@ static int parse_mail(struct am_state *state, const char *mail)
>  	strbuf_addstr(&msg, "\n\n");
>  	if (strbuf_read_file(&msg, am_path(state, "msg"), 0) < 0)
>  		die_errno(_("could not read '%s'"), am_path(state, "msg"));
> -	stripspace(&msg, 0);
> +	strbuf_stripspace(&msg, 0);
>  
>  	if (state->signoff)
>  		am_signoff(&msg);
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 3ba4d1b..3f48746 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -794,7 +794,7 @@ static int edit_branch_description(const char *branch_name)
>  		strbuf_release(&buf);
>  		return -1;
>  	}
> -	stripspace(&buf, 1);
> +	strbuf_stripspace(&buf, 1);
>  
>  	strbuf_addf(&name, "branch.%s.description", branch_name);
>  	status = git_config_set(name.buf, buf.len ? buf.buf : NULL);
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 63772d0..dca09e2 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -775,7 +775,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	s->hints = 0;
>  
>  	if (clean_message_contents)
> -		stripspace(&sb, 0);
> +		strbuf_stripspace(&sb, 0);
>  
>  	if (signoff)
>  		append_signoff(&sb, ignore_non_trailer(&sb), 0);
> @@ -1014,7 +1014,7 @@ static int template_untouched(struct strbuf *sb)
>  	if (!template_file || strbuf_read_file(&tmpl, template_file, 0) <= 0)
>  		return 0;
>  
> -	stripspace(&tmpl, cleanup_mode == CLEANUP_ALL);
> +	strbuf_stripspace(&tmpl, cleanup_mode == CLEANUP_ALL);
>  	if (!skip_prefix(sb->buf, tmpl.buf, &start))
>  		start = sb->buf;
>  	strbuf_release(&tmpl);
> @@ -1726,7 +1726,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		wt_status_truncate_message_at_cut_line(&sb);
>  
>  	if (cleanup_mode != CLEANUP_NONE)
> -		stripspace(&sb, cleanup_mode == CLEANUP_ALL);
> +		strbuf_stripspace(&sb, cleanup_mode == CLEANUP_ALL);
>  	if (template_untouched(&sb) && !allow_empty_message) {
>  		rollback_index_files();
>  		fprintf(stderr, _("Aborting commit; you did not edit the message.\n"));
> diff --git a/builtin/merge.c b/builtin/merge.c
> index a0edaca..e6741f3 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -806,7 +806,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>  			abort_commit(remoteheads, NULL);
>  	}
>  	read_merge_msg(&msg);
> -	stripspace(&msg, 0 < option_edit);
> +	strbuf_stripspace(&msg, 0 < option_edit);
>  	if (!msg.len)
>  		abort_commit(remoteheads, _("Empty commit message."));
>  	strbuf_release(&merge_msg);
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 3608c64..bb23d55 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -192,7 +192,7 @@ static void prepare_note_data(const unsigned char *object, struct note_data *d,
>  		if (launch_editor(d->edit_path, &d->buf, NULL)) {
>  			die(_("Please supply the note contents using either -m or -F option"));
>  		}
> -		stripspace(&d->buf, 1);
> +		strbuf_stripspace(&d->buf, 1);
>  	}
>  }
>  
> @@ -215,7 +215,7 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
>  	if (d->buf.len)
>  		strbuf_addch(&d->buf, '\n');
>  	strbuf_addstr(&d->buf, arg);
> -	stripspace(&d->buf, 0);
> +	strbuf_stripspace(&d->buf, 0);
>  
>  	d->given = 1;
>  	return 0;
> @@ -232,7 +232,7 @@ static int parse_file_arg(const struct option *opt, const char *arg, int unset)
>  			die_errno(_("cannot read '%s'"), arg);
>  	} else if (strbuf_read_file(&d->buf, arg, 1024) < 0)
>  		die_errno(_("could not open or read '%s'"), arg);
> -	stripspace(&d->buf, 0);
> +	strbuf_stripspace(&d->buf, 0);
>  
>  	d->given = 1;
>  	return 0;
> diff --git a/builtin/stripspace.c b/builtin/stripspace.c
> index 1259ed7..f677093 100644
> --- a/builtin/stripspace.c
> +++ b/builtin/stripspace.c
> @@ -1,71 +1,6 @@
>  #include "builtin.h"
>  #include "cache.h"
> -
> -/*
> - * Returns the length of a line, without trailing spaces.
> - *
> - * If the line ends with newline, it will be removed too.
> - */
> -static size_t cleanup(char *line, size_t len)
> -{
> -	while (len) {
> -		unsigned char c = line[len - 1];
> -		if (!isspace(c))
> -			break;
> -		len--;
> -	}
> -
> -	return len;
> -}
> -
> -/*
> - * Remove empty lines from the beginning and end
> - * and also trailing spaces from every line.
> - *
> - * Turn multiple consecutive empty lines between paragraphs
> - * into just one empty line.
> - *
> - * If the input has only empty lines and spaces,
> - * no output will be produced.
> - *
> - * If last line does not have a newline at the end, one is added.
> - *
> - * Enable skip_comments to skip every line starting with comment
> - * character.
> - */
> -void stripspace(struct strbuf *sb, int skip_comments)
> -{
> -	int empties = 0;
> -	size_t i, j, len, newlen;
> -	char *eol;
> -
> -	/* We may have to add a newline. */
> -	strbuf_grow(sb, 1);
> -
> -	for (i = j = 0; i < sb->len; i += len, j += newlen) {
> -		eol = memchr(sb->buf + i, '\n', sb->len - i);
> -		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
> -
> -		if (skip_comments && len && sb->buf[i] == comment_line_char) {
> -			newlen = 0;
> -			continue;
> -		}
> -		newlen = cleanup(sb->buf + i, len);
> -
> -		/* Not just an empty line? */
> -		if (newlen) {
> -			if (empties > 0 && j > 0)
> -				sb->buf[j++] = '\n';
> -			empties = 0;
> -			memmove(sb->buf + j, sb->buf + i, newlen);
> -			sb->buf[newlen + j++] = '\n';
> -		} else {
> -			empties++;
> -		}
> -	}
> -
> -	strbuf_setlen(sb, j);
> -}
> +#include "strbuf.h"
>  
>  static void comment_lines(struct strbuf *buf)
>  {
> @@ -111,7 +46,7 @@ int cmd_stripspace(int argc, const char **argv, const char *prefix)
>  		die_errno("could not read the input");
>  
>  	if (mode == STRIP_SPACE)
> -		stripspace(&buf, strip_comments);
> +		strbuf_stripspace(&buf, strip_comments);
>  	else
>  		comment_lines(&buf);
>  
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 9e17dca..5660787 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -268,7 +268,7 @@ static void create_tag(const unsigned char *object, const char *tag,
>  	}
>  
>  	if (opt->cleanup_mode != CLEANUP_NONE)
> -		stripspace(buf, opt->cleanup_mode == CLEANUP_ALL);
> +		strbuf_stripspace(buf, opt->cleanup_mode == CLEANUP_ALL);
>  
>  	if (!opt->message_given && !buf->len)
>  		die(_("no tag message?"));
> diff --git a/strbuf.c b/strbuf.c
> index 29df55b..9583875 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -743,3 +743,69 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
>  	}
>  	strbuf_setlen(sb, sb->len + len);
>  }
> +
> +/*
> + * Returns the length of a line, without trailing spaces.
> + *
> + * If the line ends with newline, it will be removed too.
> + */
> +static size_t cleanup(char *line, size_t len)
> +{
> +	while (len) {
> +		unsigned char c = line[len - 1];
> +		if (!isspace(c))
> +			break;
> +		len--;
> +	}
> +
> +	return len;
> +}
> +
> +/*
> + * Remove empty lines from the beginning and end
> + * and also trailing spaces from every line.
> + *
> + * Turn multiple consecutive empty lines between paragraphs
> + * into just one empty line.
> + *
> + * If the input has only empty lines and spaces,
> + * no output will be produced.
> + *
> + * If last line does not have a newline at the end, one is added.
> + *
> + * Enable skip_comments to skip every line starting with comment
> + * character.
> + */
> +void strbuf_stripspace(struct strbuf *sb, int skip_comments)
> +{
> +	int empties = 0;
> +	size_t i, j, len, newlen;
> +	char *eol;
> +
> +	/* We may have to add a newline. */
> +	strbuf_grow(sb, 1);
> +
> +	for (i = j = 0; i < sb->len; i += len, j += newlen) {
> +		eol = memchr(sb->buf + i, '\n', sb->len - i);
> +		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
> +
> +		if (skip_comments && len && sb->buf[i] == comment_line_char) {
> +			newlen = 0;
> +			continue;
> +		}
> +		newlen = cleanup(sb->buf + i, len);
> +
> +		/* Not just an empty line? */
> +		if (newlen) {
> +			if (empties > 0 && j > 0)
> +				sb->buf[j++] = '\n';
> +			empties = 0;
> +			memmove(sb->buf + j, sb->buf + i, newlen);
> +			sb->buf[newlen + j++] = '\n';
> +		} else {
> +			empties++;
> +		}
> +	}
> +
> +	strbuf_setlen(sb, j);
> +}
> diff --git a/strbuf.h b/strbuf.h
> index aef2794..5397d91 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -418,7 +418,16 @@ extern void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
>   * Strip whitespace from a buffer. The second parameter controls if
>   * comments are considered contents to be removed or not.
>   */
> -extern void stripspace(struct strbuf *buf, int skip_comments);
> +extern void strbuf_stripspace(struct strbuf *buf, int skip_comments);
> +
> +/**
> + * Temporary alias until all topic branches have switched to use
> + * strbuf_stripspace directly.
> + */
> +static inline void stripspace(struct strbuf *buf, int skip_comments)
> +{
> +	strbuf_stripspace(buf, skip_comments);
> +}
>  
>  static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
>  {
