From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv14 5/7] git submodule update: have a dedicated helper for cloning
Date: Fri, 19 Feb 2016 15:49:05 -0800
Message-ID: <CAGZ79kZjD_hRBFEVpj-80NpaYR2qRvnLbBb+9kR4x7MKoRX+UQ@mail.gmail.com>
References: <1455905833-7449-1-git-send-email-sbeller@google.com>
	<1455905833-7449-6-git-send-email-sbeller@google.com>
	<20160219230740.GM28749@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 00:50:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWuoV-0000IV-TP
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 00:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1428858AbcBSXt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 18:49:59 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:33325 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1427316AbcBSXtR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 18:49:17 -0500
Received: by mail-ig0-f177.google.com with SMTP id y8so50395705igp.0
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 15:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+Wd5doIft4BfdTNCVsmNg/g+6uHW2jjtb8PXb8crKVQ=;
        b=KAhaQYwYAvrbg003M2ZAUKbbDmeGHZPc8R9bFz6LYXjhhdDSbEbVe078efyrAldxVP
         XGdqXggje+s7gntcYybp/Gy+JmkKcW1Aj/37iZIEEkTFvmMhvy78/8ydxVBm5f+ktqDD
         BlXzagsWeN6F8+kMP/fymvzao8FWBHeO94rBCJ319X1x2YARWcpY27rPimAWHX5WLqlv
         UsFIu63ATqOipqcdQFHzi1za++GGVrocRiutTgCe8DC/gzju0j1K8UNKr+8/xsO1TRvn
         5I9eOSatMO8w2afu6xuoJc3Y3PXvVEfuTo5F+LKAgNnK2QdjHJuyO0jeEoSRG6ixF6kk
         anwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=+Wd5doIft4BfdTNCVsmNg/g+6uHW2jjtb8PXb8crKVQ=;
        b=TdBYhVz8gEjSfJfGBEO/RZfTg/fuAgAKCUQ/ihn3Hd36HRZEbNfLuUai7r8qBVYAl8
         L98N9RaTa6zXCxMsLrfhKPTS86PzzTR7Zm/C5BEqO/LHmkcWUQv3Yzczc9SXlk2DPm9a
         eKKDXXO5tEF5K3ttgTTpK8eh7lGSBoDFQHifmkjlcktYRaWZinldRdJns8TBcAGo4iif
         9857qi+/kNgJWtQr7XAwmzJsd3ajpnA4GShifVfZk2pv865yIQnqLnZ0cH6L9Kd5hRHz
         jHpfW2cgymYKAwuBZ5xHVCpbcCeS6TkvTsZkjiYzCiq3zJr/rvVF3HY4hwAAH/G08KfP
         napA==
X-Gm-Message-State: AG10YOQ4aCV9TdVgzls1Z+rLzUDjX+ATx+JPQJAgQHY0yrgR4L/8PmEtOQn1pBuphZoRGmaYVIA2tIcAGipDw5fW
X-Received: by 10.50.176.195 with SMTP id ck3mr557682igc.94.1455925746101;
 Fri, 19 Feb 2016 15:49:06 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Fri, 19 Feb 2016 15:49:05 -0800 (PST)
In-Reply-To: <20160219230740.GM28749@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286761>

On Fri, Feb 19, 2016 at 3:07 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> I still have trouble reading this patch (patch 5).  Some musing below
> to figure out what could change to make it more readable (perhaps in a
> patch on top).

After this review (I added replies from bottom to top, the same way I
write my code ;)
I think we need another reroll at least.

>> +#define SUBMODULE_UPDATE_CLONE_INIT {0, 0, 0, NULL, NULL, NULL, NULL, MODULE_LIST_INIT, STRING_LIST_INIT_DUP, SUBMODULE_UPDATE_STRATEGY_INIT}
>
> I think these struct fields need some comments.  It's not clear what
> most of them represent.

ok.

>
> [...]
>> +static int update_clone_inspect_next_task(struct child_process *cp,
>
> What is being inspected here?  What does the return value represent?
>
> Would a name like 'prepare_to_clone_next_submodule' make sense?  A
> comment could say that 'ce' points to the candidate submodule to clone,
> that the return value represents whether we want to clone it, and
> that the first parameter is an output parameter representing a command
> to run to carry out the clone.
>

ok.

>
> It's common to call submodule_from_path with null_sha1 as a parameter
> but I have trouble continuing to remember what that means.  Maybe
> there should be a separate function that handles that?  As a
> side-effect, the name and docstring of that function could explain
> what it means, which I still am not sure about. :)

Good idea!

>         if (pp->update.type == SM_UPDATE_NONE
>             || (pp->update.type == SM_UPDATE_UNSPECIFIED
>                 && sub->update_strategy.type == SM_UPDATE_NONE)) {
>
> What does pp stand for?

parallel processes similar to cp standing for child process.

>
> Is the --update parameter ever set to 'none'?  What does it mean
> when someone sets it to none?

In the initialization. This is to preserve precedence.
Yeah there is a test for --update=none.

>
>> +             strbuf_addf(err, "Skipping submodule '%s'\n",
>> +                         displaypath);
>
> Does the caller expect a newline at the end of err?
>
> In the refs code that uses an err strbuf, the convention is to
> not end the message with a newline.  That way, a function like
> die() can insert a newline and messages are guaranteed to be
> newline-terminated even if someone is sloppy and does the wrong thing
> when generating an error.

Oh! So we need to add new lines ourselves here.

>> +             if (pp->reference)
>> +                     argv_array_push(&cp->args, pp->reference);
>> +             if (pp->depth)
>> +                     argv_array_push(&cp->args, pp->depth);
>
> What does 'cp' stand for mean?  Would a name like 'child' work?

child process ? (any code which had a struct child_process referred to
it as *cp)


>
> The 'count' variable is more of a cursor than a count.  Would a name +
> comment like
>
>         /* index into 'list' representing the next submodule to consider cloning */
>         int current;
>
> work?
>

I think that's better.

>
> [...]
>> +static int update_clone(int argc, const char **argv, const char *prefix)
>> +{
>> +     const char *update = NULL;
>> +     struct string_list_item *item;
>> +     struct submodule_update_clone pp = SUBMODULE_UPDATE_CLONE_INIT;
>> +
>> +     struct option module_list_options[] = {
>
> The name looks stale.
>
>> +             OPT_STRING(0, "prefix", &prefix,
>> +                        N_("path"),
>> +                        N_("path into the working tree")),
>> +             OPT_STRING(0, "recursive_prefix", &pp.recursive_prefix,
>> +                        N_("path"),
>> +                        N_("path into the working tree, across nested "
>> +                           "submodule boundaries")),
>
> What do these options represent?  I'm used to the 'prefix' parameter to
> a command coming from git machinery that remembers what the path to the
> original cwd was relative to the worktree or repository root.  Here
> there's an option to set it --- is that intentional?  Would setting the
> environment variable GIT_PREFIX (that git already knows how to respect)
> work in its place?
>
> What is recursive_prefix relative to?
>
> Nit: it would be more idiomatic to use a dash in place of an underscore
> in the second one's name.  But this is an internal interface so it
> doesn't matter much.
>
>> +             OPT_STRING(0, "update", &update,
>> +                        N_("string"),
>> +                        N_("update command for submodules")),
>
> This one is confusing to me because while the script supports --rebase /
> --merge / --checkout this option seems to be more general.
>
> If the help string said '(rebase, merge, or checkout)' then I wouldn't
> mind.
>
>> +             OPT_STRING(0, "reference", &pp.reference, "<repository>",
>> +                        N_("Use the local reference repository "
>> +                           "instead of a full clone")),
>
> Is this allowed to be relative?  If so, what is it relative to?
>
> [...]
>> +             OPT__QUIET(&pp.quiet, N_("do't print cloning progress")),
>
> Typo.
>
> [...]
>> +     const char *const git_submodule_helper_usage[] = {
>> +             N_("git submodule--helper list [--prefix=<path>] [<path>...]"),
>
> Is this the 'list' subcommand?

no. :(

>
> [...]
>> +     gitmodules_config();
>> +     /* Overlay the parsed .gitmodules file with .git/config */
>> +     git_config(submodule_config, NULL);
>> +     run_processes_parallel(1, update_clone_get_next_task,
>> +                               update_clone_start_failure,
>> +                               update_clone_task_finished,
>> +                               &pp);
>
> Neat. \o/
>
>> +     if (pp.print_unmatched) {
>> +             printf("#unmatched\n");
>
> I'm still confused about this.  I think a comment where
> 'print_unmatched' is declared would probably clear it up.

Probably this is a too literal translation from shell to C.
By printing #unmatched the shell on the other end of the pipe
of this helper program knows to just stop and error out.

So this is telling the downstream program to stop.

Maybe we can name the variable 'quickstop' ?
'abort_and_exit' ?

>
> [...]
>> +     for_each_string_list_item(item, &pp.projectlines)
>> +             utf8_fprintf(stdout, "%s", item->string);
>
> (just curious) why are these saved up and printed all at once instead
> of being printed as it goes?

To have a clean abort path, i.e. we need to be done with all the parallel stuff
before we start on doing local on-disk stuff. So we need to be sure we
do not print "#unmatched\n" but rather all the repositories.

In a next step, we can do the checkout in parallel if there is nothing to assume
to lead to trouble. i.e. update strategy is checkout and the submodule is
in a clean state at the tip of a branch.

All problems which need to be solved by the user should be presented in
a sequential way, i.e. present one problem and then full stop.
That seems to be more encouraging as if we'd throw a "Here are a dozen
broken submodule repositories which we expect the user fixes up".

>
> [...]
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>
> Very nice.
>
> Thanks,
> Jonathan
