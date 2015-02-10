From: Matt Korostoff <mkorostoff@gmail.com>
Subject: Re: [PATCH] contrib/completion: suppress stderror in bash completion
 of git remotes
Date: Mon, 9 Feb 2015 19:08:09 -0500
Message-ID: <CAMZO7d+qL-rzvi0GrAuzAg=02MxByMt0Zc=fMnvK175YQyB8YA@mail.gmail.com>
References: <1423515508-40109-1-git-send-email-MKorostoff@gmail.com> <xmqqy4o6aj1w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 01:08:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKyNb-0004ok-0E
	for gcvg-git-2@plane.gmane.org; Tue, 10 Feb 2015 01:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761685AbbBJAId convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Feb 2015 19:08:33 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:56217 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761679AbbBJAIa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Feb 2015 19:08:30 -0500
Received: by mail-qc0-f177.google.com with SMTP id s11so192263qcv.8
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 16:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UeHwZKA44BL+VRll/4dYp+2MJmVn6+uJ3bKiW3vDAI0=;
        b=gLT1rtRjVfMRB4JBnORlFzqoAFH/KG0rDNzTMFZ8os+Lnphx0KBTQiRfiuBBZnI7v2
         7WVrpHiZb9jnvKM7AlfF8ZgAKwXhEABcl0dr4S7yIDhRtogrVsDCEXOsnUHYOg4eKfFJ
         DcPNmjgAAc1P09nS0uKD3UtEBrzHQ5dPToZb+GZvApYqBWg4sBaYWxrxy8gaww9xWYc2
         WfYqstpoqncUt8So+HeqDlEx6Gu1bFZidbV+Lqg4Y49ToooxXMgD2NVPnml2BgHT9FT7
         jLwvLG3u6S6R/fKTFOwomZutCcRQ7nZ3lXwktwYJmKMZWy/QWgbaXVtIZkbpUfa2eM0w
         oScg==
X-Received: by 10.140.101.232 with SMTP id u95mr43863821qge.48.1423526909966;
 Mon, 09 Feb 2015 16:08:29 -0800 (PST)
Received: by 10.140.89.167 with HTTP; Mon, 9 Feb 2015 16:08:09 -0800 (PST)
In-Reply-To: <xmqqy4o6aj1w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263620>

Thank you for your detailed reply Junio.  I'll try to address your
concerns individually, but let me also offer a general thought that
this is probably a good use case to handle even if the root cause is
solvable outside of git.  That is to say, I would think we'd still
want git autocompletion working for users running on imperfect
platforms.

> What's "some system"?

My apologies, that was a typo. I meant to write "some systems."  I'm
not sure what the root cause is, but I can tell you I'm running a
rather vanilla development environment (git 1.7.10, bash 3.2, osx
10.8).  I wish I could supply a list of the version combinations that
result in such an event, but I'm not sure how I would do acquire a
list like that.

> Is this a platform's bug (e.g. "test -d" does not work correctly)?

I don't believe so=E2=80=94here's a simple test-of-the-test I threw tog=
ether
https://gist.github.com/MKorostoff/f203e414847d43b21de4 which does not
throw this error.

> Is this an configuration error of user's Git repository?

I think I have a pretty generic git configuration (here it is, though
note I've had to redact some identifying information
https://gist.github.com/MKorostoff/f8358f72b968249a3925).  Still, I'd
think we would want to handle such a misconfiguration explicitly,
rather than throw a seemingly unrelated error during autocompletion

> Is this something else?

It would be very helpful if you could supply a few more details on the
type of something you're looking for

> I _think_ you would see the problem if $d/remotes is a directory
> whose contents cannot be listed

I can confirm, that is indeed the behavior.  Animated gif example here
http://i.imgur.com/qcPxAub.gif

> But I wonder if we rather want the user to notice that
> misconfiguration so that the user can correct it

While I wholeheartedly agree that such user feedback would be
valuable, I'm just not sure that it makes sense for this feedback to
interrupt the user's typing mid-word.

Sorry if anyone receives this twice, my first attempt to send was
rejected for including HTML.

On Mon, Feb 9, 2015 at 4:09 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Matt Korostoff <mkorostoff@gmail.com> writes:
>
>> In some system configurations there is a bug with the
>> __git_remotes function.  Specifically, there is a problem
>> with line 415, `test -d "$d/remotes" && ls -1 "$d/remotes"`.
>> While `test -d` is meant to prevent listing the remotes
>> directory if it does not exist, in some system, `ls` will
>> run regardless.
>
> What's "some system"?
>
> Is this a platform's bug (e.g. "test -d" does not work correctly)?
>
> Is this an configuration error of user's Git repository?
>
> Is this something else?
>
> I _think_ you would see the problem if $d/remotes is a directory
> whose contents cannot be listed (e.g. "chmod a=3D $d/remotes"), and
> that would not be a platform's bug (i.e. "test -d" would happily say
> "Yes there is a directory", and "ls" would fail with "Permission
> denied").  But I wonder if we rather want the user to notice that
> misconfiguration so that the user can correct it, instead of hiding
> the error message from "ls".
>
>> This results in an error in which typing `git push or` + `tab`
>> prints out `ls: .git/remotes: No such file or directory`.
>> This can be fixed by simply directing stderror of this line
>> to /dev/null.
>> ---
>>  contrib/completion/git-completion.bash |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
>> index 2fece98..72251cc 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -412,7 +412,7 @@ __git_refs_remotes ()
>>  __git_remotes ()
>>  {
>>       local i IFS=3D$'\n' d=3D"$(__gitdir)"
>> -     test -d "$d/remotes" && ls -1 "$d/remotes"
>> +     test -d "$d/remotes" && ls -1 "$d/remotes" 2>/dev/null
>>       for i in $(git --git-dir=3D"$d" config --get-regexp 'remote\..=
*\.url' 2>/dev/null); do
>>               i=3D"${i#remote.}"
>>               echo "${i/.url*/}"
