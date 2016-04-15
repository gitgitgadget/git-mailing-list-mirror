From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 0/2] implement better chunk heuristics
Date: Fri, 15 Apr 2016 10:02:39 -0700
Message-ID: <CAGZ79kbCHA3L6mUfYn6OfVXLDEyhv70PwxXo-YHP_QZXXAB8ig@mail.gmail.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 19:02:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar78t-0006Hm-9I
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 19:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbcDORCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 13:02:42 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:33999 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbcDORCk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 13:02:40 -0400
Received: by mail-io0-f177.google.com with SMTP id 2so140786798ioy.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 10:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=GcSAy7f5u2Ew+urmehQCvbvADxqAqM1TAqlPhpJKLuA=;
        b=m1Xg1QpKdx/scuHxEfpdRvmkP3f2SsU6EtLyESCiYuTyBFBSFByk3gCkc0r+MXbbiB
         OszZVXdgDzE7y8yqzByInqdZhR8Q37maKX2lzEfLNtQGCetsk+1UQVWaLmyuxUfoC6B8
         3G/5Vb61z6bcJ0wqtCgLxOUPuAl4J08z4/p0qvQ9UMT95xanYCwhk91lOncFuwbd3T+8
         oB/OozGZb9NKPKiQt+xfBWtA8zbPv5vMvEjQ/5/toQF61nC25TVAPyFLleKIeet1NAu0
         m0JiAJMOf0TaC+nAQSDxqfoMGEqT7LE7rrDyqrBbTuVtEOsA7Yw1EENCAKnIzoEKWJCY
         zrpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=GcSAy7f5u2Ew+urmehQCvbvADxqAqM1TAqlPhpJKLuA=;
        b=im4iVQoVPX7KaKxQ5IsYRrp/UAojYtYdOLVllv6YyBM3ApusEApo+Ql2PaJzHOeBhW
         zrXBVe40CEK5DvehePnON95tAjA/DoW9mwCEt4Gw9UAp9r5ZixKQssiKvGdVEBEpPBA0
         sUMHAbc+dPbRXbFVdyerNPyXF/DYHMtwcerSbxA9tRTxG5D74DIsnyCr5Pukw0XlVY3X
         yvdMcifni0L3qVoh8HLIrmoeDkqNI66i9IdH3TAxaJ3+IP7tnQg+BH4L0yTeUQZbVgPc
         /t0KQJSlOSvXHKbI0VGUcmict9a2t8i1CergmZe9a97gDSFrauQqa2+C2uPvmdLCoO+4
         AgMQ==
X-Gm-Message-State: AOPr4FVswNY51KuHcPR0Rcwhc5aLLjZbxPdNNPqj5a/OKKUPtAEfb4BXQVQ30VOtfD0OzuyYINhKH6UjgaoOC9GG
X-Received: by 10.107.184.8 with SMTP id i8mr23750585iof.96.1460739759782;
 Fri, 15 Apr 2016 10:02:39 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Fri, 15 Apr 2016 10:02:39 -0700 (PDT)
In-Reply-To: <20160415165141.4712-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291619>

On Fri, Apr 15, 2016 at 9:51 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> I took up Stefan's patch, and modified it to resolve a couple issues. I
> also tried to implement the suggestions from Junio's review, as well as
> the suggestions I had. It appears to produce equivalent output as Jeff's
> script. This version is still missing a few things, and it is possible
> Stefan is working on a v2 of his own, but I thought I'd submit this.
>
> There's still several TODOs:
> * Add some tests
> * better name for the heuristic(?)
> * better patch description plus documentation
> * is_emptyline should be more generic and handle CRLF
>
> Changes since Stefan's v1:
> * Added a patch to implement xdl_hash_and_recmatch as Junio suggested.
> * Fixed a segfault in Stefan's patch
> * Added XDL flag to configure the behavior
> * Used an int and counted empty lines via += instead of |=
> * Renamed starts_with_emptyline to is_emptyline
> * Added diff command line and config options
>
> For reviewer convenience, the interdiff between this and Stefan's version:
>
> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
> index edba56522bce..cebf82702d2a 100644
> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -170,6 +170,12 @@ diff.tool::
>
>  include::mergetools-diff.txt[]
>
> +diff.emptyLineHeuristic::
> +       Set this option to true to enable the empty line chunk heuristic when
> +       producing diff output. This heuristic will attempt to shift hunks such
> +       that a common empty line occurs below the hunk with the rest of the
> +       context above it.
> +

    This heuristic will attempt to shift hunks such that *the last* common
    empty line occurs below the hunk with the rest of the context above it.

maybe?


>  diff.algorithm::
>         Choose a diff algorithm.  The variants are as follows:
>  +
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 4b0318e2ac15..6c1cd8b35584 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -63,6 +63,12 @@ ifndef::git-format-patch[]
>         Synonym for `-p --raw`.
>  endif::git-format-patch[]
>
> +--empty-line-heuristic::
> +--no-empty-line-heuristic::
> +       When possible, shift common empty lines in diff hunks below the hunk
> +       such that the last common empty line for each hunk is below, with the
> +       rest of the context above the hunk.
> +
>  --minimal::
>         Spend extra time to make sure the smallest possible
>         diff is produced.
> diff --git a/diff.c b/diff.c
> index 4dfe6609d059..8ab9a492928d 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -26,6 +26,7 @@
>  #endif
>
>  static int diff_detect_rename_default;
> +static int diff_empty_line_heuristic = 0;
>  static int diff_rename_limit_default = 400;
>  static int diff_suppress_blank_empty;
>  static int diff_use_color_default = -1;
> @@ -189,6 +190,10 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>                 diff_detect_rename_default = git_config_rename(var, value);
>                 return 0;
>         }
> +       if (!strcmp(var, "diff.emptylineheuristic")) {
> +               diff_empty_line_heuristic = git_config_bool(var, value);
> +               return 0;
> +       }
>         if (!strcmp(var, "diff.autorefreshindex")) {
>                 diff_auto_refresh_index = git_config_bool(var, value);
>                 return 0;
> @@ -3278,6 +3283,8 @@ void diff_setup(struct diff_options *options)
>         options->use_color = diff_use_color_default;
>         options->detect_rename = diff_detect_rename_default;
>         options->xdl_opts |= diff_algorithm;
> +       if (diff_empty_line_heuristic)
> +               DIFF_XDL_SET(options, EMPTY_LINE_HEURISTIC);
>
>         options->orderfile = diff_order_file_cfg;
>
> @@ -3798,6 +3805,10 @@ int diff_opt_parse(struct diff_options *options,
>                 DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
>         else if (!strcmp(arg, "--ignore-blank-lines"))
>                 DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
> +       else if (!strcmp(arg, "--empty-line-heuristic"))
> +               DIFF_XDL_SET(options, EMPTY_LINE_HEURISTIC);
> +       else if (!strcmp(arg, "--no-empty-line-heuristic"))
> +               DIFF_XDL_CLR(options, EMPTY_LINE_HEURISTIC);
>         else if (!strcmp(arg, "--patience"))
>                 options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
>         else if (!strcmp(arg, "--histogram"))
> diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
> index 4fb7e79410c2..9195a5c0e958 100644
> --- a/xdiff/xdiff.h
> +++ b/xdiff/xdiff.h
> @@ -41,6 +41,8 @@ extern "C" {
>
>  #define XDF_IGNORE_BLANK_LINES (1 << 7)
>
> +#define XDF_EMPTY_LINE_HEURISTIC (1 << 8)
> +
>  #define XDL_EMIT_FUNCNAMES (1 << 0)
>  #define XDL_EMIT_FUNCCONTEXT (1 << 2)
>
> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
> index 5f14beb98049..83984b90f82f 100644
> --- a/xdiff/xdiffi.c
> +++ b/xdiff/xdiffi.c
> @@ -400,7 +400,7 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
>  }
>
>
> -static int starts_with_emptyline(const char *recs)
> +static int is_emptyline(const char *recs)
>  {
>         return recs[0] == '\n'; /* CRLF not covered here */
>  }
> @@ -416,7 +416,7 @@ static int xdl_hash_and_recmatch(xrecord_t **recs, long ixs, long ix, long flags
>  int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>         long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
>         char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
> -       unsigned char has_emptyline;
> +       unsigned int emptylines;
>         xrecord_t **recs = xdf->recs;
>
>         /*
> @@ -450,7 +450,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>
>                 do {
>                         grpsiz = ix - ixs;
> -                       has_emptyline = 0;
> +                       emptylines = 0;
>
>                         /*
>                          * If the line before the current change group, is equal to
> @@ -458,11 +458,11 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>                          * the group.
>                          */
>                         while (ixs > 0 && xdl_hash_and_recmatch(recs, ixs - 1, ix - 1, flags)) {
> +                               emptylines += is_emptyline(recs[ix - 1]->ptr);
> +
>                                 rchg[--ixs] = 1;
>                                 rchg[--ix] = 0;
>
> -                               has_emptyline |=
> -                                       starts_with_emptyline(recs[ix]->ptr);

How is this fixing the segfault bug?
From my understanding ix should have the same value here as ix-1 above.

>                                 /*
>                                  * This change might have joined two change groups,
>                                  * so we try to take this scenario in account by moving
> @@ -492,9 +492,6 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>                                 rchg[ixs++] = 0;
>                                 rchg[ix++] = 1;
>
> -                               has_emptyline |=
> -                                       starts_with_emptyline(recs[ix]->ptr);
> -

Or would this fix the segfault bug?
I think we would need to have the check for empty lines
in both loops to be sure to cover the whole movable range.


>                                 /*
>                                  * This change might have joined two change groups,
>                                  * so we try to take this scenario in account by moving
> @@ -527,21 +524,12 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>                  * As we shifted the group forward as far as possible, we only
>                  * need to shift it back if at all.
>                  */
> -               if (has_emptyline) {
> -                       while (ixs > 0 && recs[ixs - 1]->ha == recs[ix - 1]->ha &&
> -                              xdl_recmatch(recs[ixs - 1]->ptr, recs[ixs - 1]->size, recs[ix - 1]->ptr, recs[ix - 1]->size, flags) &&
> -                              !starts_with_emptyline(recs[ix - 1]->ptr)) {
> +               if ((flags & XDF_EMPTY_LINE_HEURISTIC) && emptylines) {
> +                       while (ixs > 0 &&
> +                              !is_emptyline(recs[ix - 1]->ptr) &&
> +                              xdl_hash_and_recmatch(recs, ixs - 1, ix - 1, flags)) {
>                                 rchg[--ixs] = 1;
>                                 rchg[--ix] = 0;
> -
> -                               /*
> -                                * This change did not join two change groups,
> -                                * as we did that before already, so there is no
> -                                * need to adapt the other-file, i.e.
> -                                * running
> -                                *     for (; rchg[ixs - 1]; ixs--);
> -                                *     while (rchgo[--ixo]);
> -                                */
>                         }
>                 }
>         }
>
> Jacob Keller (1):
>   xdiff: add xdl_hash_and_recmatch helper function
>
> Stefan Beller (1):
>   xdiff: implement empty line chunk heuristic
>
>  Documentation/diff-config.txt  |  6 ++++++
>  Documentation/diff-options.txt |  6 ++++++
>  diff.c                         | 11 +++++++++++
>  xdiff/xdiff.h                  |  2 ++
>  xdiff/xdiffi.c                 | 42 ++++++++++++++++++++++++++++++++++++++----
>  5 files changed, 63 insertions(+), 4 deletions(-)
>
> --
> 2.8.1.369.geae769a
>
