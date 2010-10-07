From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] worktree: provide better prefix to go back to original cwd
Date: Thu, 7 Oct 2010 10:08:55 +0700
Message-ID: <AANLkTin8zFb9mP7A4=hWV-9SkFqqYLbMQxUw=diW6Vbf@mail.gmail.com>
References: <1286373578-2484-1-git-send-email-pclouds@gmail.com> <20101006180727.GA2118@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, judge.packham@gmail.com, Jens.Lehmann@web.de
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 05:09:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3grN-0004VU-2Z
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 05:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932879Ab0JGDJ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 23:09:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53678 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932426Ab0JGDJZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 23:09:25 -0400
Received: by wwj40 with SMTP id 40so342974wwj.1
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 20:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=XhiKGE19EY5+NiAcAnO20r+SMMpTLDU0569GVrilC1Q=;
        b=TXO/PK+/kqj/OZ1al57nAgA+6xrg7DzZnjmB2FuIiAOAQpkWzRhDcelEa7vxQ8goMC
         S4Joss464bgiYmV0yCybELvbIhIQk/MeuhMpp57wtXmdw5Vt+fz4YCc0dZDvaZHiwtS8
         7KoM0ZxlPKh6s/oEOpMeReTosOU/uO+oEqy7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=QVd/sLzQR+fjvhi9ZR2tfPSwIDbxcri2VV8KnVFsq/hYsnkPLmZV5RlAHAhOyRFKQl
         JI7teA3+hjnBYby38C3n6jL1ZSv+CHW+D1GrNNZLbbgKRz6az1IaYzhHQkybTYRTzenV
         ZX3q4haNmOMhXWDlBbHTNhhicSwAk8NfB5dUg=
Received: by 10.216.164.199 with SMTP id c49mr91152wel.107.1286420955271; Wed,
 06 Oct 2010 20:09:15 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Wed, 6 Oct 2010 20:08:55 -0700 (PDT)
In-Reply-To: <20101006180727.GA2118@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158362>

2010/10/7 Jonathan Nieder <jrnieder@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> This patch allows builtin commands access to original cwd even if it=
's
>> outside worktree, via cwd_to_worktree and worktree_to_cwd fields.
>> --- a/builtin/rev-parse.c
>> +++ b/builtin/rev-parse.c
>> @@ -623,6 +623,16 @@ int cmd_rev_parse(int argc, const char **argv, =
const char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 puts(pr=
efix);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!strcmp(arg, "--cwd-to-worktree")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (startup_info->cwd_to_worktree)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 puts(startu=
p_info->cwd_to_worktree);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!strcmp(arg, "--worktree-to-cwd")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (startup_info->worktree_to_cwd)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 puts(startu=
p_info->worktree_to_cwd);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>
> Nice.
>
> I wonder if this should use something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0puts(".");
>
> or
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0putchar('\n');
>
> . =C2=A0What would be most convenient for scripted callers?

I followed the convention in rev-parse.c, specifically --show-prefix
code. Don't know if it's good or bad for scripts though.

> What do these commands do when run from a bare repository? =C2=A0Is t=
he
> worktree the .git dir in that case, do they fail, or does something
> else happen?

These two new fields are only set when both GIT_DIR and GIT_WORK_TREE
are set, which means non-bare repository. I'll need to handle other
setup cases as well, but for subproject-aware grep, this should be
enough.

> Are there any examples to illustrate whether teaching --show-prefix t=
o
> do what your --worktree-to-cwd does would be a good or bad idea?
> (Just curious.)

I think it's a bad idea. --show-prefix traditionally never returns
"../(something)" and scripts (even builtin commands) depend on that.
It's better to slowly migrate over the new prefix(es) when it makes
sense.

>> --- a/setup.c
>> +++ b/setup.c
>> @@ -313,10 +313,109 @@ const char *read_gitfile_gently(const char *p=
ath)
>> =C2=A0 =C2=A0 =C2=A0 return path;
>> =C2=A0}
>>
>> +/*
>> + * Given "foo/bar" and "hey/hello/world", return "../../hey/hello/w=
orld/"
>> + * Either path1 or path2 can be NULL
>> + */
>> +static char *make_path_to_path(const char *path1, const char *path2=
)
>
> Nice. =C2=A0Do we need to worry about:
>
> =C2=A0- alternate directory separators? (hey\hello\world)
> =C2=A0- DOS drive prefix? (c:\foo\bar, d:\hey\hello\world)
> =C2=A0- relative paths with DOS drive? (c:\foo\bar, d:hello)
> =C2=A0- doubled-up directory separators? (hey//hello/world, //foo/bar=
)
> =C2=A0- non-canonical paths? (hey/./hello/../hello/world)
>
> I'm guessing some of the answers are "no", depending on where these
> paths come from. =C2=A0Compare make_relative_path().

The two last ones are OK. Paths passed to this function come from
either getcwd or make_absolute_path(). I'm sure they are
canonicalized. But I'll add a comment to note that.

I'll look into backslashes and DOS drives (hmm and UNC path too).

> [...]
>
>> =C2=A0static const char *setup_explicit_git_dir(const char *gitdiren=
v,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *work_tree_env, int *non=
git_ok)
>> =C2=A0{
>> - =C2=A0 =C2=A0 static char buffer[1024 + 1];
>> + =C2=A0 =C2=A0 static char buffer[PATH_MAX];
>
> Why?
>
> It might make sense to error out a little before PATH_MAX (though
> later than 1024), to account for subdirs (e.g., objects/). =C2=A0Not =
sure.

I'm not really POSIX-fluent to tell. But I'm sure in this function
there won't be any subdirs.
--=20
Duy
