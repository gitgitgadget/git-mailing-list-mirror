From: Jason Karns <karns.17@gmail.com>
Subject: Re: bug in bash completion for git-branch --set-upstream-to on OSX
Date: Mon, 23 Mar 2015 09:45:16 -0400
Message-ID: <CAKNmmv2ap+svVJQHBjNzdcNuc42Urbt6uuBVRjfUMveb98sRHQ@mail.gmail.com>
References: <20150322120612.Horde.LAxCkP-VMKE3Ur7ZXII3Hg1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Mar 23 14:45:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya2fS-0005m6-SB
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 14:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbbCWNpT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2015 09:45:19 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:35101 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbbCWNpR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2015 09:45:17 -0400
Received: by webck51 with SMTP id ck51so11431476web.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 06:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:cc:content-type:content-transfer-encoding;
        bh=j5SSEobHiKzRYpPSh/obUgr6zmKeQeP5VjW5X1pBCnQ=;
        b=YEWEiL7Onaz6w89tPFxaoj8L7Dtn9UdZ2Xt2opdT7EobavUNT2HAK02VVyNIGjd3Fg
         M0r6dP/btBil0Ai6LoaM87skGUgyk+3xRbrbJwywZkM6P5MWiWPlxQVGnY8bsa6FQrgj
         Dv/Q7fzXLxiMGzCcxKqVUGqIT6qi6I5Z8rFJWMh43o7aDVfHCc8DJ03liXYg5oyi75Mb
         zkaOVP60hsnlsb6Jq2hvHUiWERh+vu2xkGL7vb4w/Ta8n94fEcBe5zu6DjD5wrKGuuBW
         86d4JYHAsH/odC4EnMYM/4ySMd2CkiuW1Orsidfmwf5s6nE6ODSloLu//ULDFk5h9xri
         JOPQ==
X-Received: by 10.194.190.10 with SMTP id gm10mr186387127wjc.91.1427118316064;
 Mon, 23 Mar 2015 06:45:16 -0700 (PDT)
Received: by 10.27.215.79 with HTTP; Mon, 23 Mar 2015 06:45:16 -0700 (PDT)
In-Reply-To: <20150322120612.Horde.LAxCkP-VMKE3Ur7ZXII3Hg1@webmail.informatik.kit.edu>
X-Google-Sender-Auth: QtIaFg1nct371JGoSd5Z-vqqxX8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266139>

On Sun, Mar 22, 2015 at 7:06 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
>
> Hi,
>
> Quoting Jason Karns <karns.17@gmail.com>:
>
>> There appears to be a bug in the bash completion for git-branch when
>> attempting to complete the remote ref argument for --set-upstream-to=
=3D
>>
>> When:
>>
>> $ git branch --set-upstream-to=3Dorigin/mast<TAB>
>>
>> I would expect it to complete to:
>>
>> $ git branch --set-upstream-to=3Dorigin/master
>>
>> However, the completion for --set-upstream-to=3D completes the ref
>> correctly, but completely wipes the --set-upstream option; resulting
>> in:
>>
>> $ git branch origin/master
>
>
> Strange.
>
> The code in question
>
>    case "$cur" in
>    --set-upstream-to=3D*)
>            __gitcomp "$(__git_refs)" "" "${cur##--set-upstream-to=3D}=
"
>            ;;
>
> looks unsuspicious, this is the "standard" way to complete
> '--option=3D<TAB>' (except that we should use __gitcomp_nl() for comp=
leting
> refs, but that should have no effect on this issue).  Does the same i=
ssue
> affect other 'git cmd --option=3D<TAB>' completions as well, e.g. 'gi=
t log
> --date=3D<TAB>' or 'git commit --reuse-message=3D<TAB>'?

Yep, same buggy behavior.

>
> We had a similar issue with ':' on the command line a looong while
> ago, see v1.5.6.4~9^2 (bash completion: Resolve git show ref:path<tab=
>
> losing ref: portion, 2008-07-15).  Maybe we are dealing with the same=
 issue
> here, just a different character?
>
> What does
>
>    printf "$COMP_WORDBREAKS" |tr ' \t\n' STN
>
> print out?  Is the '=3D' missing, perhaps?  If that's indeed the case=
,
> does adding it back (COMP_WORDBREAKS=3D"$COMP_WORDBREAKS"=3D) fix the=
 issue?

Adding it back in did indeed fix the issue. Now I get to track down
who/why `=3D` isn't present in COMP_WORDBREAKS.

Thanks!

>
> G=C3=A1bor
>

Jason
