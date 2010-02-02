From: Eugene Sajine <euguess@gmail.com>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor 
	with no changes written
Date: Tue, 2 Feb 2010 15:47:45 -0500
Message-ID: <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
References: <76c5b8581002021207y3eccdc19i9a4abcc3d04315f0@mail.gmail.com>
	 <8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com>
	 <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org,
	Eugene Sajine <euguess@gmail.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 21:48:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcPfG-0005Vb-Lr
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 21:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132Ab0BBUrr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 15:47:47 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:41723 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164Ab0BBUrq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 15:47:46 -0500
Received: by iwn39 with SMTP id 39so623010iwn.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 12:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=poNScxqDfqJW4tOYXPbf9coGdv0KIIxWYA/tqAFane0=;
        b=ioHkA25CQDh8S/K5pZITTsfDbcM+bjre2DvHZtzQ+YMlQ8mqRe8gW4F0aIni/CjrbT
         t++8uloDs3bggc1GH8PEyCLfX6mkqOI9RPSzFR6zY/glK9DduZCzZ10vwI1r4QMkxX4C
         1m893c9FOd19ySSYdSPgUjQoFp87EstGZ2JSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=yG1v+3VhmvOJ/xOB8iZloyYfL+hbhOrb3T18i4vs+7ERidDNGerFdETiy8jP1s8lRO
         aUp0rh3CY/ABM+t+6lxW/T1NlmdZIBfXAHDYOvFDyazfqYup8hk3P8n3jz+PlMigsdk5
         wMPwOWk2KwiY6S1fE4utbTwlXOQUzadL0xYko=
Received: by 10.231.147.70 with SMTP id k6mr2026728ibv.55.1265143665236; Tue, 
	02 Feb 2010 12:47:45 -0800 (PST)
In-Reply-To: <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138753>

On Tue, Feb 2, 2010 at 3:27 PM, Avery Pennarun <apenwarr@gmail.com> wro=
te:
> On Tue, Feb 2, 2010 at 3:14 PM, Jacob Helwig <jacob.helwig@gmail.com>=
 wrote:
>> On Tue, Feb 2, 2010 at 12:07, Eugene Sajine <euguess@gmail.com> wrot=
e:
>>> When git commit --amend is executed it fires up vi so i can change =
the
>>> commit message. If I have something staged, then when I'm exiting v=
i
>>> using :q (without doing/writing any changes), it still commits
>>> everything staged with old message.
>>>
>>> I believe it should actually abort amending and return to the state
>>> before the "git commit --amend" was issued.
>>
>> I don't think this is actually the right way to go. =C2=A0A _very_ c=
ommon
>> use case for "commit --amend" is to add things to the previous commi=
t,
>> without changing the commit message at all. =C2=A0Yes, you can avoid=
 having
>> to fire up the editor at all in this case, but it's still a perfectl=
y
>> valid thing to want to do.
>
> I agree and I do this all the time. However, I've also done it
> accidentally before I learned the "remove the commit message and save=
"
> trick.
>
> Perhaps what's really missing is more documentation of how to
> "unamend" if you change your mind :) =C2=A0I happen to know about "gi=
t
> reset HEAD@{1}" but it's not terribly obvious.
>
> Avery
>

Well, i understand this logic but it seems to me that the issue is a
little bit deeper than that.
I just realized that the "rebase -i" is doing the same thing.

If you're just exiting the vi using :q without writing changes it will
perform rebase! I'm 100% sure it is not OK.

So, it seems that it will do that every time it has some
*prepopulated* message in the editor, so it doesn't understand when
changes are written and when they are not.

I believe all those actions should be treated exactly the same way as
the commit itself. If I'm writing/saving changes - it is good to go.
If not - abort.
I.e. the message can be prepopulated in the editor, but it should be
the same state as when you create a new message for commit, i.e. git
should not know anything about that message.

Thanks,
Eugene
