From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 2/2] notes: add notes.merge option to select default strategy
Date: Sat, 1 Aug 2015 22:46:48 -0400
Message-ID: <CAPig+cSws1EWRTuV2D49RCyy6reeC7yJ5YiOSO4ee3S1rjdhBg@mail.gmail.com>
References: <1438384341-2688-1-git-send-email-jacob.e.keller@intel.com>
	<1438384341-2688-3-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Sun Aug 02 04:47:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLjIo-0004UR-Vj
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 04:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbbHBCqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 22:46:50 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:36098 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbbHBCqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 22:46:49 -0400
Received: by ykeb10 with SMTP id b10so6889157yke.3
        for <git@vger.kernel.org>; Sat, 01 Aug 2015 19:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DJwh8pr2dJP3jSdNEbxz/ZPdofHZT5fFRKYiWo5XcYQ=;
        b=BLCZcPd756X4OtENUmbkelfa4P6jNd70/3TW24ihiH5dhi+xm6n3ENJZQk657K2+Dl
         /+lHVmcrOUOw/ldb8T9tcgZsie3G/pxkzs0UwIaXWgPCDknxZPo5os4cYEKsfb2gwNzc
         0dzjR35ZVjF/6yy2VMzqvIn4kdG3T5QyXBKW06L+3qBlF4GdFH7iuo7ddmEk0NKob/MY
         0pjLagjyDg2f+/QFe///8z3g0pxmKrZ9v+J8t+P3DUrWxInQLLH9SCXZldNPbTMT7Qnn
         ZzqF1l3jv9YBPJoNHafeWfKk7ox8cfvNet9bWufNcaCm7uczWWI0S97aaD319VBc/nhn
         JDsQ==
X-Received: by 10.170.138.134 with SMTP id f128mr12689676ykc.90.1438483608419;
 Sat, 01 Aug 2015 19:46:48 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sat, 1 Aug 2015 19:46:48 -0700 (PDT)
In-Reply-To: <1438384341-2688-3-git-send-email-jacob.e.keller@intel.com>
X-Google-Sender-Auth: dlJenvmE0jmstKA6Qjw-cveinZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275126>

On Fri, Jul 31, 2015 at 7:12 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> Teach git-notes about a new configuration option "notes.merge" for
> selecting the default notes merge strategy. Document the option in
> config.txt and git-notes.txt
>
> Add tests for the configuration option. Ensure that command line
> --strategy option overrides the configured value. Ensure that -s can't
> be passed with --commit or --abort. Ensure that --abort and --commit
> can't be used together.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> Cc: Johan Herland <johan@herland.net>
> Cc: Michael Haggerty <mhagger@alum.mit.edu>
> Cc: Eric Sunshine <sunshine@sunshineco.com>

Thanks, this looks better than the previous round. A few comments below...

> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index 674682b34b83..d8944f5aec60 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -101,13 +101,13 @@ merge::
>         any) into the current notes ref (called "local").
>  +
>  If conflicts arise and a strategy for automatically resolving
> -conflicting notes (see the -s/--strategy option) is not given,
> -the "manual" resolver is used. This resolver checks out the
> -conflicting notes in a special worktree (`.git/NOTES_MERGE_WORKTREE`),
> -and instructs the user to manually resolve the conflicts there.
> -When done, the user can either finalize the merge with
> -'git notes merge --commit', or abort the merge with
> -'git notes merge --abort'.
> +conflicting notes (see the -s/--strategy option or notes.merge
> +config option) is not given, the "manual" resolver is used.
> +This resolver checks out the conflicting notes in a special
> +worktree (`.git/NOTES_MERGE_WORKTREE`), and instructs the user
> +to manually resolve the conflicts there. When done, the user
> +can either finalize the merge with 'git notes merge --commit',
> +or abort the merge with 'git notes merge --abort'.

When you re-wrap the text like this, it's difficult to spot your one
little change in all the diff noise. For the sake of review, it's
often better to minimize the change, even if it leaves the text more
jagged than you'd like.

>  remove::
>         Remove the notes for given objects (defaults to HEAD). When
> @@ -181,10 +181,10 @@ OPTIONS
>  -s <strategy>::
>  --strategy=<strategy>::
>         When merging notes, resolve notes conflicts using the given
> -       strategy. The following strategies are recognized: "manual"
> -       (default), "ours", "theirs", "union" and "cat_sort_uniq".
> -       See the "NOTES MERGE STRATEGIES" section below for more
> -       information on each notes merge strategy.
> +       strategy. Overrides "notes.merge". The following strategies are
> +       recognized: `manual`, `ours`, `theirs`, `union` and
> +       `cat_sort_uniq`. See the `NOTES MERGE STRATEGIES` section below
> +       for more information on each notes merge strategy.

Ditto.

>  --commit::
>         Finalize an in-progress 'git notes merge'. Use this option
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 88fdafb32bc0..728980bc79bf 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -741,6 +743,25 @@ static int merge_commit(struct notes_merge_options *o)
>         return ret;
>  }
>
> +static int parse_notes_strategy(const char *arg, enum notes_merge_strategy *strategy)
> +{
> +       if (!strcmp(arg, "manual"))
> +               *strategy = NOTES_MERGE_RESOLVE_MANUAL;
> +       else if (!strcmp(arg, "ours"))
> +               *strategy = NOTES_MERGE_RESOLVE_OURS;
> +       else if (!strcmp(arg, "theirs"))
> +               *strategy = NOTES_MERGE_RESOLVE_THEIRS;
> +       else if (!strcmp(arg, "union"))
> +               *strategy = NOTES_MERGE_RESOLVE_UNION;
> +       else if (!strcmp(arg, "cat_sort_uniq"))
> +               *strategy = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
> +       else {
> +               return 1;

In this codebase, it's customary to return 0 on success and -1 on error

> +       }

Style: drop unnecessary braces

> +
> +       return 0;
> +}
> +
>  static int merge(int argc, const char **argv, const char *prefix)
>  {
>         struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
> @@ -950,6 +961,18 @@ static int get_ref(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> +static int git_notes_config(const char *var, const char *value, void *cb)
> +{
> +       if (!strcmp(var, "notes.merge")) {
> +               if (!value)
> +                       return config_error_nonbool(var);
> +               if (parse_notes_strategy(value, &merge_strategy))
> +                       return error("Unknown notes merge strategy: %s", value);

For the non-error case, don't you want to 'return 0' here to indicate
that you handled the config variable rather than letting it fall
through to git_default_config() below?

> +       }
> +
> +       return git_default_config(var, value, cb);
> +}
> +
>  int cmd_notes(int argc, const char **argv, const char *prefix)
>  {
>         int result;
