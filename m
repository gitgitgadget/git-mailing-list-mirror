From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>
Subject: Re: [PATCH] completion: fix issue with process substitution not
 working on Git for Windows
Date: Wed, 26 Oct 2011 08:52:03 +0200
Message-ID: <CAJzBP5QYKOf4OUMm4vfVay=b7F_fHJf40JgzDAZZa7p0fxLpyA@mail.gmail.com>
References: <1319565695-5976-1-git-send-email-stefan.naewe@gmail.com>
	<4EA71E8C.8010704@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Oct 26 08:52:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIxLP-0003KZ-Kq
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 08:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab1JZGwF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Oct 2011 02:52:05 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55814 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968Ab1JZGwE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2011 02:52:04 -0400
Received: by gyb13 with SMTP id 13so1263369gyb.19
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 23:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=NuX0OA0rS+pOirVMfDNaQFYcmup0ctTdreePIdxTG/Q=;
        b=Ijas2Bc1e/H9EmweVkh8KBFG8oxRJVRvEmVIxqoUEmWyzyTiMky5QAMnru18/X+CZY
         OtrLQ2jvTDZCNwD8XEylf0sqQcW1hV31ETppgLu0QrDZDoWadky53GLZ8gZ120F8SkHn
         Q7CwgI4Hy2LF2a9MZgihB2FuYoT7C3oaVuuQE=
Received: by 10.101.27.28 with SMTP id e28mr6788370anj.50.1319611923695; Tue,
 25 Oct 2011 23:52:03 -0700 (PDT)
Received: by 10.101.164.10 with HTTP; Tue, 25 Oct 2011 23:52:03 -0700 (PDT)
In-Reply-To: <4EA71E8C.8010704@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184247>

Am 25. Oktober 2011 22:39 schrieb Johannes Sixt <j6t@kdbg.org>:
> Am 25.10.2011 20:01, schrieb Stefan Naewe:
>> Git for Windows comes with a bash that doesn't support process subst=
itution.
>> It issues the following error when using git-completion.bash with
>> GIT_PS1_SHOWUPSTREAM set:
>>
>> $ export GIT_PS1_SHOWUPSTREAM=3D1
>> sh.exe": cannot make pipe for process substitution: Function not imp=
lemented
>> sh.exe": cannot make pipe for process substitution: Function not imp=
lemented
>> sh.exe": <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.s=
howupstream)$' 2>/dev/null | tr '\0\n' '\n '): ambiguous redirect
>>
>> Replace the process substitution with a simple "echo $var | while...=
".
>>
>> Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
>> ---
>> =C2=A0contrib/completion/git-completion.bash | =C2=A0 =C2=A04 +++-
>> =C2=A01 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
>> index 8648a36..926db80 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -110,6 +110,8 @@ __git_ps1_show_upstream ()
>> =C2=A0 =C2=A0 =C2=A0 local upstream=3Dgit legacy=3D"" verbose=3D""
>>
>> =C2=A0 =C2=A0 =C2=A0 # get some config options from git-config
>> + =C2=A0 =C2=A0 output=3D"$(git config -z --get-regexp '^(svn-remote=
\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')"
>> + =C2=A0 =C2=A0 echo "$output" | \
>> =C2=A0 =C2=A0 =C2=A0 while read key value; do
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case "$key" in
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bash.showupstream)
>> @@ -125,7 +127,7 @@ __git_ps1_show_upstream ()
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 upstream=3Dsvn+git # default upstream is SVN if available, else=
 git
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ;;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 esac
>> - =C2=A0 =C2=A0 done < <(git config -z --get-regexp '^(svn-remote\..=
*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')
>> + =C2=A0 =C2=A0 done
>>
>> =C2=A0 =C2=A0 =C2=A0 # parse configuration values
>> =C2=A0 =C2=A0 =C2=A0 for option in ${GIT_PS1_SHOWUPSTREAM}; do
>
> Are you sure that the result still works as intended? The while loop
> sets a few variables. When you place it in a pipe, the loop runs in a
> subshell, and subsequent code will not see the modified values. Unles=
s
> bash knows how to optimize away the subshell, that is.

I doesn't work in the 'git svn' case, I guess.

> OTOH, when you use while ...; do ...; done < <(...), the while loop i=
s
> not in a subshell.
>
> An alternative is to use: =C2=A0while ...; do ...; done <<< "$output"

I'll try that.

> BTW, you don't need to protect the end-of-line with a backslash if th=
e
> line ends with the pipe symbol.

OK. Will do.

> -- Hannes

Thanks,
  Stefan
--=20
----------------------------------------------------------------
python -c "print '73746566616e2e6e6165776540676d61696c2e636f6d'.decode(=
'hex')"
