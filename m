From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Warning from AV software about kill.exe
Date: Thu, 5 Jan 2012 17:33:25 +0100
Message-ID: <CABPQNSbd++dAOGu+5+WNMXzF6xtsdTpZq=xeXPbHwmxputXVRA@mail.gmail.com>
References: <4EF2E08C.3050502@icefield.yk.ca> <87mxalkn9q.fsf@thomas.inf.ethz.ch>
 <878vm4lb9q.fsf@fox.patthoyts.tk> <4F0418B1.5050403@icefield.yk.ca>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Erik Blake <erik@icefield.yk.ca>
X-From: git-owner@vger.kernel.org Thu Jan 05 17:34:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiqGb-0006hi-0z
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 17:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932803Ab2AEQeI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 11:34:08 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55388 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932488Ab2AEQeH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2012 11:34:07 -0500
Received: by pbdu13 with SMTP id u13so395483pbd.19
        for <git@vger.kernel.org>; Thu, 05 Jan 2012 08:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=UcafSCxjLdL51uXJmvihyPhB689DwFR3aiLsOOfdGL8=;
        b=x/0ujSkhWsSEce+vrW8YTeXtmmowMm8iSAE9yY1MyqxhGrGXbq2cgTBHWb0eRgoSNB
         zsqC3Y5otu0JC6R70fY1WSiYzqptGbRQcVVSnu6F6ObgpOCyZFdBDKM83WBgT3eCk8VR
         TIeKxUrAzmCy3ZveoX0CPIyIR3ehsHsj9RXGY=
Received: by 10.68.191.100 with SMTP id gx4mr6932737pbc.26.1325781246209; Thu,
 05 Jan 2012 08:34:06 -0800 (PST)
Received: by 10.68.8.7 with HTTP; Thu, 5 Jan 2012 08:33:25 -0800 (PST)
In-Reply-To: <4F0418B1.5050403@icefield.yk.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187989>

On Wed, Jan 4, 2012 at 10:15 AM, Erik Blake <erik@icefield.yk.ca> wrote=
:
> On 2011-12-22 19:19, Pat Thoyts wrote:
>> Thomas Rast<trast@student.ethz.ch> =A0writes:
>>> Erik Blake<erik@icefield.yk.ca> =A0writes:
>>>
>>>> I'm running git under Win7 64. As I selected "Repository|Visualize=
 all
>>>> branch history" in the git gui, my AV software (Trustport) trapped=
 the
>>>> bin\kill.exe program for "trying to modify system global settings
>>>> (time, timezone, registry quota, etc.)"
>>>>
>>>> Does anyone know the details of this process and what it's functio=
n
>>>> is? First time I've seen it, though I'm a relatively new user.
>>>
>>> 'kill' is a standard unix utility that sends signals to processes, =
in
>>> particular signals that cause the processes to exit or be killed
>>> forcibly by the kernel, hence the name. =A0(I don't know how the wi=
ndows
>>> equivalent works under the hood, but presumably it's something simi=
lar.)
>>>
>>> git-gui and gitk use kill to terminate background worker processes =
that
>>> are no longer needed because you closed the window their output wou=
ld
>>> have been displayed in, etc.
>>
>> You might try replacing the command in the tcl scripts with 'exec
>> taskkill /f /pid $pid' and see if that avoids the error. taskkill is
>> present on XP and above as part of the OS distribution so shouldn't
>> suffer any AV complaints.
>>
>
> Another way to implement this (on Windows) would be for the git progr=
ams to
> tag themselves with a mutex. Then the "kill" program can determine wh=
ich git
> programs are running and send them user-defined windows messages to s=
hut
> themselves down. Alternatively, you could send the programs the stand=
ard
> windows WM_CLOSE message, but the OS or an AV program might still be
> troubled by that behaviour.
>
> This is how we implement this type of behaviour in our windows progra=
ms. It
> does not raise the ire of the OS or AV since you do not have one proc=
ess
> trying to shut down another. It also bypasses all issues with process
> privileges etc.
>
> Erik
>

No thanks. A process is allowed to terminate another process on
Windows (as long as they are running as the same user, and the access
token has not been messed with). If your AV detects this and prevents
it, then your AV is broken. Re-building a kind of cooperative process
termination for that reason is not the way forward.

But the problem might be that MSYS' kill does more than it's supposed
to (or misbehaves in some other way). This is, however, something you
should take up with the MSYS developers, not the git development
community.

I would take this up with Trustport support. Overly eager AV
heuristics is a fairly common problem, and usually gets fixed quickly.
