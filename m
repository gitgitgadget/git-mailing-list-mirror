From: Dongcan Jiang <dongcan.jiang@gmail.com>
Subject: Re: [PATCH] [GSoC][MICRO] Forbid "log --graph --no-walk"
Date: Fri, 6 Mar 2015 21:13:26 +0800
Message-ID: <CABwkPcoBG61YY0N4b33gdMq2cC1oQ_wFV7KaGGu3wYfuY9inGw@mail.gmail.com>
References: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
	<CAPig+cQDAurk2WeTNZPVTnQ8GJSQOpWyDxHNCK_ww25ZdLtFwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 14:13:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTs4P-00087e-Ec
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 14:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbbCFNN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2015 08:13:28 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:46981 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbbCFNN1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2015 08:13:27 -0500
Received: by pdev10 with SMTP id v10so14568945pde.13
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 05:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=2IxqtdZqVBpqArxUwqXlB8MhRlC20ItAPFAwEGfrcAk=;
        b=Ki4bpuimRlxMqfOswsuNCgkEY+q985MF8PlE4cQpf/wl1LZwUh3FGDNOf2yZ03NGbR
         w3LI0rQUVqV0evDMr0lta1ciUxcKHXQZVjSARngCl5zQ4+rd8JnBtKpN1BYYgl5QIfms
         XvV1hCnFF9rktiuR1Ln+haQ7S/XESc4qu1/nSHrVQ3j6DYp/BxqFkYQ+IUhw3WrFiCFe
         qYkZLWPFqYETFU7ezJfLIOJ4p6vmGAYXrGc2IK6DIBAIjr2NQWakK1iLspLDJMRmgk/V
         7lrTiMNxUeYHDhsfpHkYZKTQ1r5TSkArMqxsSuvP1vSkeeh4e5Ph3b3GV9XXfZOYi3BX
         8/ZA==
X-Received: by 10.67.21.201 with SMTP id hm9mr25137129pad.58.1425647606433;
 Fri, 06 Mar 2015 05:13:26 -0800 (PST)
Received: by 10.70.78.225 with HTTP; Fri, 6 Mar 2015 05:13:26 -0800 (PST)
In-Reply-To: <CAPig+cQDAurk2WeTNZPVTnQ8GJSQOpWyDxHNCK_ww25ZdLtFwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264921>

Hi, Eric and Ren=C3=A9

Thanks for your suggestions. Good ideas!

> Genuine question: Despite the GSoC micro-project mentioning only
> 'log', is it ever meaningful for these two options to be specified
> together? I suspect not, but it would be nice to hear from someone
> more familiar with the issue. If not specific to 'log', then the > pa=
tch
> can be simplified a good deal.

> Why only for git log?  Doesn't the justification given in the
> commit message above apply in general?

At first, I also tried to only judge the value of "revs->no_walk &&
revs->graph", but unfortunately, it failed to pass all cases in
t4052-stat-output.sh.
e.g. command "git show --stat --graph" failed to get the correct result=
=2E

=46inally, this is because that "revs->no_walk" gets set when it comes
to "git show --stat". That's why I add the parameter
"revs->cmd_is_log" as judgement. Of course, it causes the limitation
you've mentioned. I will consider better solution in the next patch
edition as soon as possible.

Best Regards

Dongcan

2015-03-06 17:56 GMT+08:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Fri, Mar 6, 2015 at 3:55 AM, Dongcan Jiang <dongcan.jiang@gmail.co=
m> wrote:
>> Forbid "log --graph --no-walk
>
> Style: drop capitalization in the Subject: line. Also prefix with the
> command or module being modified, followed by a colon. So:
>
>     log: forbid combining --graph and --no-walk
>
> or:
>
>     revision: forbid combining --graph and --no-walk
>
>> Because --graph is about connected history while --no-walk is about =
discrete points.
>
> Okay. You might also want to cite the wider discussion[1].
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/216083
>
>> revision.c: Judge whether --graph and --no-walk come together when r=
unning git-log.
>> buildin/log.c: Set git-log cmd flag.
>> Documentation/rev-list-options.txt: Add specification on the forbidd=
en usage.
>
> No need to repeat in prose what the patch itself states more clearly
> and concisely.
>
> Also, such a change should be accompanied by new test(s).
>
>> Signed-off-by: Dongcan Jiang <dongcan.jiang@gmail.com>
>> ---
>> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-=
list-options.txt
>> index 4ed8587..eea2c0a 100644
>> --- a/Documentation/rev-list-options.txt
>> +++ b/Documentation/rev-list-options.txt
>> @@ -679,6 +679,7 @@ endif::git-rev-list[]
>>         given on the command line. Otherwise (if `sorted` or no argu=
ment
>>         was given), the commits are shown in reverse chronological o=
rder
>>         by commit time.
>> +       Cannot be combined with `--graph` when running git-log.
>>
>>  --do-walk::
>>         Overrides a previous `--no-walk`.
>> @@ -781,6 +782,7 @@ you would get an output like this:
>>         on the left hand side of the output.  This may cause extra l=
ines
>>         to be printed in between commits, in order for the graph his=
tory
>>         to be drawn properly.
>> +       Cannot be combined with `--no-walk` when running git-log.
>
> Nice to see documentation updates. More below.
>
>>  This enables parent rewriting, see 'History Simplification' below.
>>  +
>> diff --git a/builtin/log.c b/builtin/log.c
>> index dd8f3fc..7bf5adb 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -627,6 +627,7 @@ int cmd_log(int argc, const char **argv, const c=
har *prefix)
>>         git_config(git_log_config, NULL);
>>
>>         init_revisions(&rev, prefix);
>> +       rev.cmd_is_log =3D 1;
>>         rev.always_show_header =3D 1;
>>         memset(&opt, 0, sizeof(opt));
>>         opt.def =3D "HEAD";
>> diff --git a/revision.c b/revision.c
>> index 66520c6..5f62c89 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -1399,6 +1399,8 @@ void init_revisions(struct rev_info *revs, con=
st char *prefix)
>>
>>         revs->commit_format =3D CMIT_FMT_DEFAULT;
>>
>> +       revs->cmd_is_log =3D 0;
>> +
>>         init_grep_defaults();
>>         grep_init(&revs->grep_filter, prefix);
>>         revs->grep_filter.status_only =3D 1;
>> @@ -2339,6 +2341,8 @@ int setup_revisions(int argc, const char **arg=
v, struct rev_info *revs, struct s
>>
>>         if (revs->reflog_info && revs->graph)
>>                 die("cannot combine --walk-reflogs with --graph");
>> +       if (revs->no_walk && revs->graph && revs->cmd_is_log)
>
> Placing 'revs->cmd_is_log' first would make it clear at a glance that
> this restriction impacts 'log' only (but see question below):
>
>     if (revs->cmd_is_log && revs->no_walk && revs->graph)
>
>> +               die("cannot combine --no-walk with --graph when runn=
ing git-log");
>>         if (!revs->reflog_info && revs->grep_filter.use_reflog_filte=
r)
>>                 die("cannot use --grep-reflog without --walk-reflogs=
");
>>
>> diff --git a/revision.h b/revision.h
>> index 0ea8b4e..255982a 100644
>> --- a/revision.h
>> +++ b/revision.h
>> @@ -146,6 +146,9 @@ struct rev_info {
>>                         track_first_time:1,
>>                         linear:1;
>>
>> +       /* cmd type */
>> +       unsigned int  cmd_is_log:1;
>
> Genuine question: Despite the GSoC micro-project mentioning only
> 'log', is it ever meaningful for these two options to be specified
> together? I suspect not, but it would be nice to hear from someone
> more familiar with the issue. If not specific to 'log', then the patc=
h
> can be simplified a good deal.
>
>>         enum date_mode date_mode;
>>
>>         unsigned int    abbrev;
>> --



--=20
=E6=B1=9F=E4=B8=9C=E7=81=BF=EF=BC=88Dongcan Jiang=EF=BC=89
Team of Search Engine & Web Mining
School of Electronic Engineering & Computer Science
Peking University, Beijing, 100871, P.R.China
