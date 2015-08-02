From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 2/2] notes: add notes.merge option to select default strategy
Date: Sat, 1 Aug 2015 21:12:40 -0700
Message-ID: <CA+P7+xpV4JwCpUa3RGgxuWdpguLmQ60k_ToqM6cRXO8TNz+o-g@mail.gmail.com>
References: <1438384341-2688-1-git-send-email-jacob.e.keller@intel.com>
 <1438384341-2688-3-git-send-email-jacob.e.keller@intel.com> <CAPig+cSws1EWRTuV2D49RCyy6reeC7yJ5YiOSO4ee3S1rjdhBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 02 06:13:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLke2-00055i-Gn
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 06:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbbHBENB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 00:13:01 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33573 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbbHBENA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 00:13:00 -0400
Received: by igbpg9 with SMTP id pg9so54196240igb.0
        for <git@vger.kernel.org>; Sat, 01 Aug 2015 21:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tkdTw0AsQLQcXVV5Q88XgAyYMps2w7hZWscOtQvgBGM=;
        b=VxK4MU17dnxNpnXicFTF492Qi6GAe3ag9gwOhZNPOEx2E5PaDJlGeBPJHD0eTC5+Yt
         cqHJGv/8EPZSqQ7aHeWPwl6CqUz9gBtU1Ic2CNmkXyOQHk/CUxRW88yv3q+2873B+x+c
         5FoNYo6LKT31mukQvK0USRGi/jeIzGBa/F+tv5F1qpyFWKR9k+qlVcKj2gEVitztZ6X3
         nHNhmjLjb0ZDb4VJHPhhfrrvuwOtJmKdMlmz9Sfd0AZ3E3KWMXaijTc05kGaK0v03d1D
         /SENXfT+GxYMIW55sE+mjYH3BkkXDH/VNR+V5dNlBtQjiXsJJ3oTQgQw/U+XzozTtY9Z
         p7SA==
X-Received: by 10.50.109.233 with SMTP id hv9mr16054684igb.92.1438488779648;
 Sat, 01 Aug 2015 21:12:59 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Sat, 1 Aug 2015 21:12:40 -0700 (PDT)
In-Reply-To: <CAPig+cSws1EWRTuV2D49RCyy6reeC7yJ5YiOSO4ee3S1rjdhBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275127>

On Sat, Aug 1, 2015 at 7:46 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Jul 31, 2015 at 7:12 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> Teach git-notes about a new configuration option "notes.merge" for
>> selecting the default notes merge strategy. Document the option in
>> config.txt and git-notes.txt
>>
>> Add tests for the configuration option. Ensure that command line
>> --strategy option overrides the configured value. Ensure that -s can't
>> be passed with --commit or --abort. Ensure that --abort and --commit
>> can't be used together.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> Cc: Johan Herland <johan@herland.net>
>> Cc: Michael Haggerty <mhagger@alum.mit.edu>
>> Cc: Eric Sunshine <sunshine@sunshineco.com>
>
> Thanks, this looks better than the previous round. A few comments below...
>
>> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
>> index 674682b34b83..d8944f5aec60 100644
>> --- a/Documentation/git-notes.txt
>> +++ b/Documentation/git-notes.txt
>> @@ -101,13 +101,13 @@ merge::
>>         any) into the current notes ref (called "local").
>>  +
>>  If conflicts arise and a strategy for automatically resolving
>> -conflicting notes (see the -s/--strategy option) is not given,
>> -the "manual" resolver is used. This resolver checks out the
>> -conflicting notes in a special worktree (`.git/NOTES_MERGE_WORKTREE`),
>> -and instructs the user to manually resolve the conflicts there.
>> -When done, the user can either finalize the merge with
>> -'git notes merge --commit', or abort the merge with
>> -'git notes merge --abort'.
>> +conflicting notes (see the -s/--strategy option or notes.merge
>> +config option) is not given, the "manual" resolver is used.
>> +This resolver checks out the conflicting notes in a special
>> +worktree (`.git/NOTES_MERGE_WORKTREE`), and instructs the user
>> +to manually resolve the conflicts there. When done, the user
>> +can either finalize the merge with 'git notes merge --commit',
>> +or abort the merge with 'git notes merge --abort'.
>
> When you re-wrap the text like this, it's difficult to spot your one
> little change in all the diff noise. For the sake of review, it's
> often better to minimize the change, even if it leaves the text more
> jagged than you'd like.
>

Even if it leaves it incredibly jagged? That is one of the downsides
with diff of flowed text like this :(

>>  remove::
>>         Remove the notes for given objects (defaults to HEAD). When
>> @@ -181,10 +181,10 @@ OPTIONS
>>  -s <strategy>::
>>  --strategy=<strategy>::
>>         When merging notes, resolve notes conflicts using the given
>> -       strategy. The following strategies are recognized: "manual"
>> -       (default), "ours", "theirs", "union" and "cat_sort_uniq".
>> -       See the "NOTES MERGE STRATEGIES" section below for more
>> -       information on each notes merge strategy.
>> +       strategy. Overrides "notes.merge". The following strategies are
>> +       recognized: `manual`, `ours`, `theirs`, `union` and
>> +       `cat_sort_uniq`. See the `NOTES MERGE STRATEGIES` section below
>> +       for more information on each notes merge strategy.
>
> Ditto.
>
>>  --commit::
>>         Finalize an in-progress 'git notes merge'. Use this option
>> diff --git a/builtin/notes.c b/builtin/notes.c
>> index 88fdafb32bc0..728980bc79bf 100644
>> --- a/builtin/notes.c
>> +++ b/builtin/notes.c
>> @@ -741,6 +743,25 @@ static int merge_commit(struct notes_merge_options *o)
>>         return ret;
>>  }
>>
>> +static int parse_notes_strategy(const char *arg, enum notes_merge_strategy *strategy)
>> +{
>> +       if (!strcmp(arg, "manual"))
>> +               *strategy = NOTES_MERGE_RESOLVE_MANUAL;
>> +       else if (!strcmp(arg, "ours"))
>> +               *strategy = NOTES_MERGE_RESOLVE_OURS;
>> +       else if (!strcmp(arg, "theirs"))
>> +               *strategy = NOTES_MERGE_RESOLVE_THEIRS;
>> +       else if (!strcmp(arg, "union"))
>> +               *strategy = NOTES_MERGE_RESOLVE_UNION;
>> +       else if (!strcmp(arg, "cat_sort_uniq"))
>> +               *strategy = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
>> +       else {
>> +               return 1;
>
> In this codebase, it's customary to return 0 on success and -1 on error
>

Fair enough.

>> +       }
>
> Style: drop unnecessary braces
>
>> +
>> +       return 0;
>> +}
>> +
>>  static int merge(int argc, const char **argv, const char *prefix)
>>  {
>>         struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
>> @@ -950,6 +961,18 @@ static int get_ref(int argc, const char **argv, const char *prefix)
>>         return 0;
>>  }
>>
>> +static int git_notes_config(const char *var, const char *value, void *cb)
>> +{
>> +       if (!strcmp(var, "notes.merge")) {
>> +               if (!value)
>> +                       return config_error_nonbool(var);
>> +               if (parse_notes_strategy(value, &merge_strategy))
>> +                       return error("Unknown notes merge strategy: %s", value);
>
> For the non-error case, don't you want to 'return 0' here to indicate
> that you handled the config variable rather than letting it fall
> through to git_default_config() below?
>

Makes sense, I can fix that.

Regards,
Jake

>> +       }
>> +
>> +       return git_default_config(var, value, cb);
>> +}
>> +
>>  int cmd_notes(int argc, const char **argv, const char *prefix)
>>  {
>>         int result;
