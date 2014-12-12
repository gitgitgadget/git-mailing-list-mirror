From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] strbuf: migrate api-strbuf.txt documentation to
 strbuf.h
Date: Fri, 12 Dec 2014 14:30:12 -0800
Message-ID: <20141212223012.GC29365@google.com>
References: <20141212212726.GA26284@peff.net>
 <20141212212800.GA27451@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:30:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzYj9-0005ZF-Av
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 23:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbaLLWaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 17:30:17 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36829 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbaLLWaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 17:30:16 -0500
Received: by mail-ie0-f179.google.com with SMTP id rp18so7791321iec.38
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 14:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NevaXF54CHus8blYhJB+jgFrV7Tym8geFELrxKFbyVk=;
        b=few0A7MRgAxO3APCOc49qf4OJGcbYOJDB4kvpYic3fvqTBCO9stlkLKfn7dZjXwbmb
         yH2bTIXaQPZlQIhlehZyEHQ4Oj9gFgAS3oPq6LlqUc/gVNoEQ7E5NzTT5xrqT0OSFY8/
         6X7zwfAUqf0J+hTbAaE4sgvpAfJ5UXpgbYg4yJvd/hTFr/bK3JseDsHZBWAHFvvsE/iI
         wuWg25ygaAgsYIkkU4M4xDCQoPRhEtwZ60NhezGO+zzgPZbYgiq15cbTZlCwoV4W/S0V
         xJOcDyuKLJVIq5okhfpejw5ECb/3RQsDXKD04uPu/z0n9DM2UuwTGdoq47+yFm0AL2qJ
         n2Ww==
X-Received: by 10.107.137.199 with SMTP id t68mr18554063ioi.38.1418423415526;
        Fri, 12 Dec 2014 14:30:15 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2400:9730:c8d1:a786])
        by mx.google.com with ESMTPSA id o185sm1236314ioe.40.2014.12.12.14.30.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:30:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141212212800.GA27451@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261385>

Jeff King wrote:

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/technical/api-strbuf.txt | 351 -------------------------
>  strbuf.h                               | 458 ++++++++++++++++++++++++++++-----
>  2 files changed, 390 insertions(+), 419 deletions(-)
>  delete mode 100644 Documentation/technical/api-strbuf.txt

Thanks.  This looks very sensible.  Some suggested tweaks below (see patch at
bottom).

> +++ b/strbuf.h
[...]
> +/**
> + * * Life Cycle
[...]
> +/**
> + * Adding data to the buffer

These were headings like

	* Life Cycle
	* Adding data to the buffer

Most ended up as ' * *' after the conversion, keeping the extra '*', but
'Adding data to the buffer' didn't.

After patch 4/4 they look the same again, so it doesn't matter.

[...]
>   * NOTE: This function will *always* be implemented as an inline or a macro
> - * that expands to:
> - * +
> - * ----
> - * strbuf_add(..., s, strlen(s));
> - * ----
> - * +
> - * Meaning that this is efficient to write things like:
> + * using strlen, meaning that this is efficient to write things like:
>   *
>   * ----
>   * strbuf_addstr(sb, "immediate string");
>   * ----

Makes sense.

[...]
>  /**
>   * Read the contents of a given file descriptor. The third argument can be
> - *     used to give a hint about the file size, to avoid reallocs.
> - */
> + * used to give a hint about the file size, to avoid reallocs.  If read fails,
> + * any partial read is undone */

Missing period at end of sentence.  "*/" should go on the next line.

[...]
> +extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
> +
> +/**
> + * Set the buffer to the path of the current working directory.
> + */
> +extern int strbuf_getcwd(struct strbuf *sb);

This snuck up a few lines --- it was between getwholeline_fd and
add_absolute_path before.  I think it makes sense for getcwd to be
next to add_absolute_path.

[...]
> +extern void stripspace(struct strbuf *buf, int skip_comments);
> +
> +/**
> + * Launch the user preferred editor to edit a file and fill the buffer
> + * with the file's contents upon the user completing their editing. The
> + * third argument can be used to set the environment which the editor is
> + * run in. If the buffer is NULL the editor is launched as usual but the
> + * file's contents are not read into the buffer upon completion.
> + */
> +extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);

split_* were before this before.  Probably launch_editor belongs with
read_file and co instead, but during this conversion it makes sense to
just keep the order from before.

[...]
> - * `strbuf_split_buf`::
> - * `strbuf_split_str`::
> - * `strbuf_split_max`::
> - * `strbuf_split`::
> - * 
> - *     Split a string or strbuf into a list of strbufs at a specified
> - *     terminator character.  The returned substrings include the
> - *     terminator characters.  Some of these functions take a `max`
> - *     parameter, which, if positive, limits the output to that
> - *     number of substrings.
> - * 
> - * `strbuf_list_free`::
> - * 
> - *     Free a list of strbufs (for example, the return values of the
> - *     `strbuf_split()` functions).
> +/*
> + * Split str (of length slen) at the specified terminator character.
> + * Return a null-terminated array of pointers to strbuf objects
> + * holding the substrings.  The substrings include the terminator,
> + * except for the last substring, which might be unterminated if the
[...]
> + */
> +extern struct strbuf **strbuf_split_buf(const char *, size_t,
> +                                       int terminator, int max);
> +
> +/*
> + * Split a NUL-terminated string at the specified terminator
> + * character.  See strbuf_split_buf() for more information.
> + */
> +static inline struct strbuf **strbuf_split_str(const char *str,
> +                                              int terminator, int max)
> +{
> +       return strbuf_split_buf(str, strlen(str), terminator, max);
> +}
> +
> +/*
> + * Split a strbuf at the specified terminator character.  See
> + * strbuf_split_buf() for more information.
> + */
> +static inline struct strbuf **strbuf_split_max(const struct strbuf *sb,

This is something that the flat file format did better.  Would it work to
do something similar, for example by dropping the boilerplate comment
before the inline functions (not shown in the patch below)?

	/**
	 * Split a string or strbuf into a list of strbufs at a specified
	 * terminator character.  [...]
	 */
	extern struct strbuf **strbuf_split_buf(const char *, size_t, int terminator, int max);

	static inline struct strbuf **strbuf_split_str(const char *str, int terminator, int max)
	{
		return strbuf_split_buf(str, strlen(str), terminator, max);
	}

	static inline struct strbuf **strbuf_split_max(const struct strbuf *sb, int terminator, int max)
	{
		return strbuf_split_buf(sb->buf, sb->len, terminator, max);
	}

	static inline struct strbuf **strbuf_split(const struct strbuf *sb, int terminator)
	{
		return strbuf_split_max(sb, terminator, 0);
	}

	/**
	 * Free a list of strbufs (for example, the return values of the
	 * `strbuf_split()` functions).
	 */
	extern void strbuf_list_free(struct strbuf **);

 strbuf.h | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 0a83f9a..108644e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -202,7 +202,7 @@ extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
 
 
 /**
- * Adding data to the buffer
+ * * Adding data to the buffer
  *
  * NOTE: All of the functions in this section will grow the buffer as
  * necessary.  If they fail for some reason other than memory shortage and the
@@ -368,7 +368,8 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 /**
  * Read the contents of a given file descriptor. The third argument can be
  * used to give a hint about the file size, to avoid reallocs.  If read fails,
- * any partial read is undone */
+ * any partial read is undone.
+ */
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
 
 /**
@@ -384,11 +385,6 @@ extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
 extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
 
 /**
- * Set the buffer to the path of the current working directory.
- */
-extern int strbuf_getcwd(struct strbuf *sb);
-
-/**
  * Read a line from a FILE *, overwriting the existing contents
  * of the strbuf. The second argument specifies the line
  * terminator character, typically `'\n'`.
@@ -413,6 +409,11 @@ extern int strbuf_getwholeline(struct strbuf *, FILE *, int);
 extern int strbuf_getwholeline_fd(struct strbuf *, int, int);
 
 /**
+ * Set the buffer to the path of the current working directory.
+ */
+extern int strbuf_getcwd(struct strbuf *sb);
+
+/**
  * Add a path to a buffer, converting a relative path to an
  * absolute one in the process.  Symbolic links are not
  * resolved.
@@ -425,15 +426,6 @@ extern void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
  */
 extern void stripspace(struct strbuf *buf, int skip_comments);
 
-/**
- * Launch the user preferred editor to edit a file and fill the buffer
- * with the file's contents upon the user completing their editing. The
- * third argument can be used to set the environment which the editor is
- * run in. If the buffer is NULL the editor is launched as usual but the
- * file's contents are not read into the buffer upon completion.
- */
-extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
-
 static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 {
 	if (strip_suffix_mem(sb->buf, &sb->len, suffix)) {
@@ -495,6 +487,15 @@ static inline struct strbuf **strbuf_split(const struct strbuf *sb,
  */
 extern void strbuf_list_free(struct strbuf **);
 
+/**
+ * Launch the user preferred editor to edit a file and fill the buffer
+ * with the file's contents upon the user completing their editing. The
+ * third argument can be used to set the environment which the editor is
+ * run in. If the buffer is NULL the editor is launched as usual but the
+ * file's contents are not read into the buffer upon completion.
+ */
+extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
+
 extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *buf, size_t size);
 
 /*
