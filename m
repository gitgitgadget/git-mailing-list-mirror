From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] alias: use run_command api to execute aliases
Date: Thu, 6 Jan 2011 20:52:04 +0100
Message-ID: <AANLkTiniRYH2jz69vhuSCzPMmAg4KQ5nowd7NqrmMYVw@mail.gmail.com>
References: <1294341187-3956-1-git-send-email-kusmabite@gmail.com> <20110106194101.GA14750@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 20:52:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pavss-0006dp-MS
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 20:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704Ab1AFTw0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jan 2011 14:52:26 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36640 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752407Ab1AFTwZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jan 2011 14:52:25 -0500
Received: by fxm20 with SMTP id 20so16343989fxm.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 11:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=xYgyCghpg6kCv5wiUpCT9moXK53C7XUCNWHSWd+dLoM=;
        b=GTkAlcEnwRiagEMeS4D30rA3+Wf9LJpEg/2KrW0XX5uQkbomQBQYek63yaS/ld32BZ
         I5s2UI223gieuy4w6S50FliVWz9XcbislZxBHjFEm9vldu/cbA4Ev8WW+Kk2f1B2mfsl
         YQtj5E7ErTNzNJJl09Enlcg8LJfTLC3H3lR88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=re59pUd7+qSH96vD1pxOYIsOuruYDDI6XzxCKH/wTuc2jutSpNvm8XSRzs6CjihAP5
         vpN2xFJD4qlkVgzCRL2fCjOVEtSu6mOUmPJZOoJPyrIPK6VAdjkDuHG1iyK+lQRT/+6H
         UUBXpXkGYxFl7hBs8z/9q43ar/IPfAVI4r0eA=
Received: by 10.223.118.136 with SMTP id v8mr7622102faq.90.1294343544273; Thu,
 06 Jan 2011 11:52:24 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Thu, 6 Jan 2011 11:52:04 -0800 (PST)
In-Reply-To: <20110106194101.GA14750@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164662>

On Thu, Jan 6, 2011 at 8:41 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Erik Faye-Lund wrote:
>
>> --- a/git.c
>> +++ b/git.c
>> @@ -177,19 +177,20 @@ static int handle_alias(int *argcp, const char=
 ***argv)
> [...]
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 trace_printf("trace: alias=
 to shell cmd: %s =3D> %s\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
alias_command, alias_string + 1);
>
> Replaced by
>
> =A0 =A0 =A0 =A0trace: run_command: ...
>
> (followed by "trace: exec: ..." on non-Windows (execv_shell_cmd)).
> Ok.
>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D system(alias_strin=
g + 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* build alias_argv */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 alias_argv =3D malloc(size=
of(char *) * *argcp + 1);
>
> This seems to be missing parentheses, so valgrind will complain
> except on 8-bit systems. ;-)
>
> What if malloc fails?
>

2x whoops :)

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 alias_argv[0] =3D alias_st=
ring + 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 1; i < *argcp; =
++i)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 alias_argv=
[i] =3D (*argv)[i];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 alias_argv[*argcp] =3D NUL=
L;
>
> Nit: all these *argcp are noisy.
>

Yes. Fetching argc once is cleaner, thanks.

>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D run_command_v_opt(=
alias_argv, RUN_USING_SHELL);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret >=3D 0 && WIFEXI=
TED(ret) &&
>
> The return value from run_command and from system do not mean
> the same thing.
>

Yet another "whoops" :)

>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Failed to run '%s' =
when expanding alias '%s'",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 alias_string + 1=
, alias_command);
>
> run_command already prints an error message, but this one still
> seems useful since it mentions the alias.
>
> Except as noted above,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>

Thanks, I agree with all your comments. But why did you remove the "/*
build alias_argv */"-comment? :)

v2 coming up!
