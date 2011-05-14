From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Add log.abbrev-commit config option
Date: Sat, 14 May 2011 15:35:02 -0400
Message-ID: <BANLkTi=MSfRhUhY1jkRC0agQNp7WHDG9FQ@mail.gmail.com>
References: <1305393758-95432-1-git-send-email-jaysoffian@gmail.com> <20110514190122.GA16851@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 14 21:35:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLKcm-000681-5D
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 21:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab1ENTfd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2011 15:35:33 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:65460 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab1ENTfc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2011 15:35:32 -0400
Received: by pvg12 with SMTP id 12so1580529pvg.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 12:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=m4GSiCuE8j464Jm9Jmaz3iEDkD9vKbt8Zr2gjZcUyDQ=;
        b=EpOdwZF3i+X6NWc0MQELIMoiAvlzd1j5QoZGZh1MFbBVE6cgS7y0i+IaXszZk/ncs1
         v+L6YgXYW+aurEpqEMU4n1zA3KWYdKvq83T/Jzs0KyylRBt31un4SaJHNrmSruMb2KDQ
         n6lq2nHxIUiTJbjKvn7b6oxUTjgU7OhoLdb6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=L79SvD73Gb8+d8gvpJyXu0d23QNht8uMa3L5dR3lDuOUWBA7hQeCnEh/V+65Tct0VX
         2CFQDLbk56CSBDbPEjJzJSFGXAUGx87fS4/h8cSTpXKyvJifjGUCXHoHYCVooGjbgMNR
         SQE8/laZCeK/Oa1e/uwci4RJffBM47HDwkVvs=
Received: by 10.142.247.7 with SMTP id u7mr1753205wfh.255.1305401732111; Sat,
 14 May 2011 12:35:32 -0700 (PDT)
Received: by 10.142.174.16 with HTTP; Sat, 14 May 2011 12:35:02 -0700 (PDT)
In-Reply-To: <20110514190122.GA16851@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173602>

On Sat, May 14, 2011 at 3:01 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Why two options? =C2=A0It would be more conventional to provide just
> log.abbrevCommit. =C2=A0The existing "[add] ignore-errors" is explain=
ed in
> the manual to be a mistake

Ah, okay.

>> config option as
>> a convenience for users who often use --abbrev-commit with git log a=
nd
>> git show (but not git whatchanged, as its output is more likely to b=
e
>> parsed even though it is not technically plumbing).
>
> Hm, that wouldn't have been my hunch. =C2=A0Are you aware of any scri=
pts
> that parse "git whatchanged" output?

Yes, I've seen it in post-receive hooks, however, that's typically in
bare repos where I suppose it's unlikely for the user to set
log.abbrevCommit, so maybe I was just being overly cautious.

> More worrying is "git log --format=3Draw". =C2=A0I think as long as w=
e're
> cautious about rolling this out slowly and noticing breakage early it
> should be okay. =C2=A0It might even be nice to find out if there are
> scripts or tests that care deeply about "git log"'s output format
> (which would be more reliable if they had been written to use
> "git rev-list | git diff-tree -s --stdin").
>
>> Allow the option to be overridden via --no-abbrev-commit.
>
> Good idea anyway. =C2=A0Once parse_revision_opt learns to use parse_o=
ptions
> these negated options would be automatic (though that's a long way
> away).
>
> Unfortunately this wouldn't help scripts much until the option has
> been around for a while. =C2=A0Maybe it would be safer to have two pa=
tches
> --- one to add --no-abbrev-commit which could be included in "maint"
> and widely deployed, and one to add the new configuration only after
> --no-abbrev-commit can be relied on? =C2=A0But on the other hand, scr=
ipts
> can be updated today to use rev-list | diff-tree, so maybe that's not
> worth the trouble.

I think that's overkill. Thinking through it more, this would only
break any scripts:

a) that are parsing whatchanged output; and
b) the user sets log.abbrevCommit w/o updating his script

> People using git by hand would certainly appreciate
> --no-abbrev-commit, I suspect.

That's why I added it.

>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1314,6 +1314,12 @@ interactive.singlekey::
>> =C2=A0 =C2=A0 =C2=A0 linkgit:git-checkout[1]. Note that this setting=
 is silently
>> =C2=A0 =C2=A0 =C2=A0 ignored if portable keystroke input is not avai=
lable.
>>
>> +log.abbrev-commit::
>> +log.abbrevCommit::
>> + =C2=A0 =C2=A0 If true, act as if --abbrev-commit were specified on=
 the command
>> + =C2=A0 =C2=A0 line. May be overridden with --no-abbrev-commit. Not=
e that this setting
>> + =C2=A0 =C2=A0 is ignored by rev-list.
>
> Style: most of that page is written from the point of view of the
> user
>
> [...]
>
> So maybe something like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Whether to abbreviate hexadecimal commit o=
bject names in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0output from the 'log' family of commands. =
=C2=A0The number of
> =C2=A0 =C2=A0 =C2=A0 =C2=A0digits shown is determined by the `--abbre=
v` command-line
> =C2=A0 =C2=A0 =C2=A0 =C2=A0option and `core.abbrev` configuration var=
iable. =C2=A0Can be
> =C2=A0 =C2=A0 =C2=A0 =C2=A0overridden on the command line by --abbrev=
-commit /
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--no-abbrev-commit. =C2=A0The default is f=
alse.
> =C2=A0+
> =C2=A0This does not affect the 'git diff-tree' and 'git rev-list'
> =C2=A0commands.

I thought I phrased it like the nearby options in config.txt. and that
sounds overly verbose to me, but I'll take another look.

>> --- a/Documentation/git-log.txt
>> +++ b/Documentation/git-log.txt
>> @@ -38,6 +38,9 @@ OPTIONS
>> =C2=A0 =C2=A0 =C2=A0 Continue listing the history of a file beyond r=
enames
>> =C2=A0 =C2=A0 =C2=A0 (works only for a single file).
>>
>> +--no-abbrev-commit::
>> + =C2=A0 =C2=A0 Don't abbreviate commit name. Useful for overridding=
 log.abbrevCommit.
>
> Also useful for overriding --abbrev-commit from aliases. :)
>
> Shouldn't it be documented next to --abbrev-commit?

As I implemented it, --no-abbrev-commit is only honored from within
log.c, so I didn't want it to show up in the rev-list man page.

But, see below where I address your question about why I didn't
implement --no-abbrev-commit in revision.c

>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -23,6 +23,7 @@
>> =C2=A0/* Set a default date-time format for git log ("log.date" conf=
ig variable) */
>> =C2=A0static const char *default_date_mode =3D NULL;
>>
>> +static int default_abbrev_commit =3D 0;
>> =C2=A0static int default_show_root =3D 1;
>> =C2=A0static int decoration_style;
>
> Style: we try to avoid unnecessary zero initializers for variables in
> the BSS section.

Okay.

> [...]
>> @@ -89,11 +91,13 @@ static void cmd_log_init_finish(int argc, const =
char **argv, const char *prefix,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct rev_info *rev, struct setup_revision_opt *opt)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct userformat_want w;
>> - =C2=A0 =C2=A0 int quiet =3D 0, source =3D 0;
>> + =C2=A0 =C2=A0 int quiet =3D 0, source =3D 0, no_abbrev_commit =3D =
0;
>>
>> =C2=A0 =C2=A0 =C2=A0 const struct option builtin_log_options[] =3D {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BOOLEAN(0, "quiet", =
&quiet, "supress diff output"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BOOLEAN(0, "quiet", =
&quiet, "suppress diff output"),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BOOLEAN(0, "sou=
rce", &source, "show source"),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OPT_BOOLEAN(0, "no-abbre=
v-commit", &no_abbrev_commit,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 "don't abbreviate commit name"),
>
> What happens if I do
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git log --no-abbrev-commit --abbrev-commit
>
> ? =C2=A0How about
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git log --no-abbrev-commit --no-no-abbrev-=
commit --abbrev-commit
>
> ? :) =C2=A0The behavior should be nicer if this is implemented in rev=
ision.c.


It was a thinko to put it in log.c. I added --no-abbrev-commit
thinking of its primary use case to override log.abbrevCommit. But
obviously it's more generally useful in revision.c (even though that
doesn't honor log.abbrevCommit), since it can still be used to
override earlier CLI options that might enable abbreviation.

I'll move it. Then I can document the option next to --abbrev-commit
where it makes sense.

> [...]
>> @@ -323,6 +330,11 @@ static int git_log_config(const char *var, cons=
t char *value, void *cb)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return git_config_s=
tring(&fmt_pretty, var, value);
>> =C2=A0 =C2=A0 =C2=A0 if (!strcmp(var, "format.subjectprefix"))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return git_config_s=
tring(&fmt_patch_subject_prefix, var, value);
>> + =C2=A0 =C2=A0 if (!strcasecmp(var, "log.abbrevcommit") ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 !strcasecmp(var, "log.abbrev-commit"))=
 {
>
> No need to use strcasecmp --- the vars passed to config functions
> already have the section and variable names in lowercase.

Okay, it was a cut-and-paste from ignore-errors I think.

>> @@ -347,6 +359,7 @@ int cmd_whatchanged(int argc, const char **argv,=
 const char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 struct setup_revision_opt opt;
>>
>> =C2=A0 =C2=A0 =C2=A0 git_config(git_log_config, NULL);
>> + =C2=A0 =C2=A0 default_abbrev_commit =3D 0;
>
> Puzzling as mentioned above.

Will drop.

>> --- a/t/t4202-log.sh
>> +++ b/t/t4202-log.sh
>> @@ -450,6 +450,14 @@ test_expect_success 'log.decorate configuration=
' '
>>
>> =C2=A0'
>>
>> +test_expect_success 'log.abbrev-commit configuration' '
>> + =C2=A0 =C2=A0 test_might_fail git config --remove-section log &&
>> + =C2=A0 =C2=A0 git log --abbrev-commit >expect &&
>> + =C2=A0 =C2=A0 git config log.abbrev-commit true &&
>> + =C2=A0 =C2=A0 git log >actual &&
>> + =C2=A0 =C2=A0 test_cmp expect actual
>> +'
>
> To avoid polluting the configuration, it would be nicest to do:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git config log.abbrev-commit true &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_when_finished "git config --unset log=
=2Eabbrev-commit" &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git log >actual &&
>
> though it looks like some tests already protect themselves.


Other tests in t4202 protect themselves at the start, I emulated that b=
ehavior.


> Just because I'm curious: what happens if you do
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git config log.abbrev-commit true
>
> in test_create_repo in test-lib.sh? =C2=A0(I.e., are there many tests=
 that
> would be confused by this?) =C2=A0Tests tend to be more picky than us=
er
> scripts about the output of git but it might still be an ok way to
> get a vague sense of the impact.

I'll let you know. :-)

> Hope that helps, and thanks for a pleasant read.

Thanks for the quick review.

j.
