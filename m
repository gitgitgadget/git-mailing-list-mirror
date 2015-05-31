From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [WIP/PATCH v4 8/8] ref-filter: add 'ref-filter.h'
Date: Sat, 30 May 2015 23:43:23 -0400
Message-ID: <CAPig+cR88O=STcJDrB+96uJ0Y60mO49QxoJfbOY8Xk4hPvNxGA@mail.gmail.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-8-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 05:54:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyuKU-0003cJ-Lz
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 05:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878AbbEaDnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 23:43:25 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36557 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860AbbEaDnX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 23:43:23 -0400
Received: by iepj10 with SMTP id j10so87875282iep.3
        for <git@vger.kernel.org>; Sat, 30 May 2015 20:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CLR+4efnX5g6A005UrgGQQeC9WN0PGSxweaJOIkKiE0=;
        b=YLpXB2CtwyHTflRGOU48MwDe4j/OjvRLNDIbAEl62kOSnektakNn4uiznId9M2GX/D
         zE4XOw0U2FhxJdFzu8yPjjlmHer58eKKfL+uq7MCDjpEleeDQu09k5O9hK1SkWWMsbVU
         CAt99qavrbmaZwcXLAUXzJbOiGBtx+BSbrjVvRc8lvFtM/zZdZDQGX/JgEuKJx8kfhV/
         2nA27Lks8gGBBFPTuoJdWxmL+9JeZ8XIWzcYI2D1hH1O+MJfiFXuwR90G60yzoD7xXfE
         0k62mhiX/51A1/SBamZ1ME5XfKqCmNvRz7xO4kFtWWn5Jga7G6KttqCAvrg1lP4oj77j
         B49g==
X-Received: by 10.107.151.75 with SMTP id z72mr18993140iod.46.1433043803277;
 Sat, 30 May 2015 20:43:23 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sat, 30 May 2015 20:43:23 -0700 (PDT)
In-Reply-To: <1433008411-8550-8-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: OOX6MlRR4UAQPA_40U7hWstF0Wo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270314>

On Sat, May 30, 2015 at 1:53 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Create 'ref-filter.h', also add ref-filter to the Makefile.
> This completes movement of creation of 'ref-filter' from
> 'for-each-ref'.

It's important that the project can be built successfully and function
correctly at each stage of a patch series. Unfortunately, the way this
series is organized, the build breaks after application of patch 7/8
since for-each-ref.c is trying to access functionality which was moved
to ref-filter.c, but there is no header at that stage which advertises
the functionality. Fixing this may be as simple as swapping patches
7/8 and 8/8, along with whatever minor adjustments they might need to
keep them sane. (The alternative would be to combine patches 7/8 and
8/8, however, Matthieu didn't seem to favor that approach[1].)

Overall, this round has been a more pleasant read than previous rounds.

[1]: http://article.gmane.org/gmane.comp.version-control.git/270192

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Makefile               |  1 +
>  builtin/for-each-ref.c | 41 +------------------------------
>  ref-filter.c           |  1 +
>  ref-filter.h           | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 69 insertions(+), 40 deletions(-)
>  create mode 100644 ref-filter.h
>
> diff --git a/Makefile b/Makefile
> index 323c401..ad455a3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -762,6 +762,7 @@ LIB_OBJS += reachable.o
>  LIB_OBJS += read-cache.o
>  LIB_OBJS += reflog-walk.o
>  LIB_OBJS += refs.o
> +LIB_OBJS += ref-filter.o
>  LIB_OBJS += remote.o
>  LIB_OBJS += replace_object.o
>  LIB_OBJS += rerere.o
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 65ed954..2f11c01 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -2,46 +2,7 @@
>  #include "cache.h"
>  #include "refs.h"
>  #include "parse-options.h"
> -
> -/* Quoting styles */
> -#define QUOTE_NONE 0
> -#define QUOTE_SHELL 1
> -#define QUOTE_PERL 2
> -#define QUOTE_PYTHON 4
> -#define QUOTE_TCL 8
> -
> -struct atom_value {
> -       const char *s;
> -       unsigned long ul; /* used for sorting when not FIELD_STR */
> -};
> -
> -struct ref_sort {
> -       struct ref_sort *next;
> -       int atom; /* index into used_atom array */
> -       unsigned reverse : 1;
> -};
> -
> -struct ref_array_item {
> -       unsigned char objectname[20];
> -       int flag;
> -       const char *symref;
> -       struct atom_value *value;
> -       char *refname;
> -};
> -
> -struct ref_array {
> -       int nr, alloc;
> -       struct ref_array_item **items;
> -};
> -
> -struct ref_filter {
> -       const char **name_patterns;
> -};
> -
> -struct ref_filter_cbdata {
> -       struct ref_array array;
> -       struct ref_filter filter;
> -};
> +#include "ref-filter.h"
>
>  static char const * const for_each_ref_usage[] = {
>         N_("git for-each-ref [<options>] [<pattern>]"),
> diff --git a/ref-filter.c b/ref-filter.c
> index 2a8f504..1c73750 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2,6 +2,7 @@
>  #include "cache.h"
>  #include "parse-options.h"
>  #include "refs.h"
> +#include "ref-filter.h"
>  #include "wildmatch.h"
>  #include "commit.h"
>  #include "remote.h"
> diff --git a/ref-filter.h b/ref-filter.h
> new file mode 100644
> index 0000000..dacae59
> --- /dev/null
> +++ b/ref-filter.h
> @@ -0,0 +1,66 @@
> +#ifndef REF_FILTER_H
> +#define REF_FILTER_H
> +
> +#include "sha1-array.h"
> +#include "refs.h"
> +#include "commit.h"
> +#include "parse-options.h"
> +
> +/* Quoting styles */
> +#define QUOTE_NONE 0
> +#define QUOTE_SHELL 1
> +#define QUOTE_PERL 2
> +#define QUOTE_PYTHON 4
> +#define QUOTE_TCL 8
> +
> +struct atom_value {
> +       const char *s;
> +       unsigned long ul; /* used for sorting when not FIELD_STR */
> +};
> +
> +struct ref_sort {
> +       struct ref_sort *next;
> +       int atom; /* index into used_atom array */
> +       unsigned reverse : 1;
> +};
> +
> +struct ref_array_item {
> +       unsigned char objectname[20];
> +       int flag;
> +       const char *symref;
> +       struct atom_value *value;
> +       char *refname;
> +};
> +
> +struct ref_array {
> +       int nr, alloc;
> +       struct ref_array_item **items;
> +};
> +
> +struct ref_filter {
> +       const char **name_patterns;
> +};
> +
> +struct ref_filter_cbdata {
> +       struct ref_array array;
> +       struct ref_filter filter;
> +};
> +
> +/*  Callback function for for_each_*ref(). This filters the refs based on the filters set */
> +int ref_filter_handler(const char *refname, const unsigned char *sha1, int flag, void *cb_data);
> +/*  Clear all memory allocated to ref_filter_data */
> +void ref_filter_clear_data(struct ref_filter_cbdata *ref_cbdata);
> +/*  Parse format string and sort specifiers */
> +int parse_ref_filter_atom(const char *atom, const char *ep);
> +/*  Used to verify if the given format is correct and to parse out the used atoms */
> +int verify_ref_format(const char *format);
> +/*  Sort the given ref_array as per the ref_sort provided */
> +void sort_ref_array(struct ref_sort *sort, struct ref_array *array);
> +/*  Print the ref using the given format and quote_style */
> +void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style);
> +/*  Callback function for parsing the sort option */
> +int opt_parse_ref_sort(const struct option *opt, const char *arg, int unset);
> +/*  Default sort option based on refname */
> +struct ref_sort *ref_default_sort(void);
> +
> +#endif /*  REF_FILTER_H  */
> --
> 2.4.2
