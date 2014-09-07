From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH v3 2/2] headers: include dependent headers
Date: Sun, 07 Sep 2014 12:35:59 +0200
Message-ID: <540C350F.3080906@web.de>
References: <1410082617-59230-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 07 12:36:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQZpc-0007oP-QD
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 12:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbaIGKgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2014 06:36:25 -0400
Received: from mout.web.de ([212.227.17.11]:60540 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbaIGKgY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2014 06:36:24 -0400
Received: from [192.168.178.27] ([79.250.174.198]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M8i11-1YMmyq30rL-00w9ul; Sun, 07 Sep 2014 12:36:15
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <1410082617-59230-1-git-send-email-davvid@gmail.com>
X-Provags-ID: V03:K0:eM8Pw7zk7pVhbaq6D9KB0ZpcF0UH0izatDWd0sBWRf82jbV68Qm
 AEACESDKCe4x3JmUV931tkgNqu2AeDzXb/u6zFMUgnm3yHfU36ZCD284nDEET+Oi3sLLeaJ
 xKWrl5IjrUcICHBnl/x3Z0zqCNyQ/CAfOZOK+SI5lzrIxD7M4463QXlZ2LXMw83ezUQtN2Z
 m9RzhgjRX1EelaSnrTVug==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256619>

Am 07.09.2014 um 11:36 schrieb David Aguilar:
> Add dependent headers so that including a header does not
> require including additional headers.
>
> This makes it so that "gcc -c $header" succeeds for each header.

> diff --git a/cache.h b/cache.h
> index 4d5b76c..8b827d7 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1,7 +1,6 @@
>   #ifndef CACHE_H
>   #define CACHE_H
>
> -#include "git-compat-util.h"
>   #include "strbuf.h"
>   #include "hashmap.h"
>   #include "advice.h"

Oh, that's a new change and worth mentioning in the commit message.

> diff --git a/color.h b/color.h
> index 9a8495b..6b50a0f 100644
> --- a/color.h
> +++ b/color.h
> @@ -1,7 +1,8 @@
>   #ifndef COLOR_H
>   #define COLOR_H
>
> -struct strbuf;
> +#include "git-compat-util.h"
> +#include "strbuf.h"
>
>   /*  2 + (2 * num_attrs) + 8 + 1 + 8 + 'm' + NUL */
>   /* "\033[1;2;4;5;7;38;5;2xx;48;5;2xxm\0" */

I didn't notice this one the first time around.  Isn't the forward
declaration of struct strbuf enough?

> diff --git a/diff.h b/diff.h
> index b4a624d..27f7696 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -6,11 +6,11 @@
>
>   #include "tree-walk.h"
>   #include "pathspec.h"
> +#include "strbuf.h"
>
>   struct rev_info;
>   struct diff_options;
>   struct diff_queue_struct;
> -struct strbuf;
>   struct diff_filespec;
>   struct userdiff_driver;
>   struct sha1_array;

Same here.

> diff --git a/quote.h b/quote.h
> index 71dcc3a..37f857b 100644
> --- a/quote.h
> +++ b/quote.h
> @@ -1,7 +1,8 @@
>   #ifndef QUOTE_H
>   #define QUOTE_H
>
> -struct strbuf;
> +#include "git-compat-util.h"
> +#include "strbuf.h"
>
>   /* Help to copy the thing properly quoted for the shell safety.
>    * any single quote is replaced with '\'', any exclamation point

And here.

 > diff --git a/submodule.h b/submodule.h
 > index 7beec48..52bb673 100644
 > --- a/submodule.h
 > +++ b/submodule.h
 > @@ -1,8 +1,10 @@
 >   #ifndef SUBMODULE_H
 >   #define SUBMODULE_H
 >
 > -struct diff_options;
 > -struct argv_array;
 > +#include "git-compat-util.h"
 > +#include "diff.h"
 > +#include "argv-array.h"
 > +#include "string-list.h"
 >
 >   enum {
 >   	RECURSE_SUBMODULES_ON_DEMAND = -1,

Similarly here with structs diff_options and argv_array.

> diff --git a/utf8.c b/utf8.c
> index b30790d..fb9f299 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -2,13 +2,6 @@
>   #include "strbuf.h"
>   #include "utf8.h"
>
> -/* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ */
> -
> -struct interval {
> -	ucs_char_t first;
> -	ucs_char_t last;
> -};
> -
>   size_t display_mode_esc_sequence_len(const char *s)
>   {
>   	const char *p = s;
> diff --git a/utf8.h b/utf8.h
> index 65d0e42..af855c5 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -1,8 +1,17 @@
>   #ifndef GIT_UTF8_H
>   #define GIT_UTF8_H
>
> +#include "strbuf.h"
> +
>   typedef unsigned int ucs_char_t;  /* assuming 32bit int */
>
> +/* This code is originally from http://www.cl.cam.ac.uk/~mgk25/ucs/ */
> +
> +struct interval {
> +	ucs_char_t first;
> +	ucs_char_t last;
> +};
> +
>   size_t display_mode_esc_sequence_len(const char *s);
>   int utf8_width(const char **start, size_t *remainder_p);
>   int utf8_strnwidth(const char *string, int len, int skip_ansi);

The move of struct interval was mentioned in the comment section of
the first patch.  Perhaps include a note in the commit message?

> diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
> index c8b5adb..7fd5364 100644
> --- a/vcs-svn/fast_export.h
> +++ b/vcs-svn/fast_export.h
> @@ -1,8 +1,9 @@
>   #ifndef FAST_EXPORT_H_
>   #define FAST_EXPORT_H_
>
> -struct strbuf;
> -struct line_buffer;
> +#include "git-compat-util.h"
> +#include "strbuf.h"
> +#include "vcs-svn/line_buffer.h"
>
>   void fast_export_init(int fd);
>   void fast_export_deinit(void);

struct strbuf forward declaration vs. including strbuf.h again.

> diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
> index 889c6a3..3a946f7 100644
> --- a/vcs-svn/repo_tree.h
> +++ b/vcs-svn/repo_tree.h
> @@ -1,7 +1,8 @@
>   #ifndef REPO_TREE_H_
>   #define REPO_TREE_H_
>
> -struct strbuf;
> +#include "git-compat-util.h"
> +#include "strbuf.h"
>
>   #define REPO_MODE_DIR 0040000
>   #define REPO_MODE_BLB 0100644

And again.

> diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
> index 74eb464..d0cbd51 100644
> --- a/vcs-svn/svndiff.h
> +++ b/vcs-svn/svndiff.h
> @@ -1,8 +1,9 @@
>   #ifndef SVNDIFF_H_
>   #define SVNDIFF_H_
>
> -struct line_buffer;
> -struct sliding_view;
> +#include "git-compat-util.h"
> +#include "vcs-svn/line_buffer.h"
> +#include "vcs-svn/sliding_window.h"
>
>   extern int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
>   		struct sliding_view *preimage, FILE *postimage);

Similar issue here with different structs.
