From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] commit: introduce a config key to allow as-is commit
 with i-t-a entries
Date: Tue, 7 Feb 2012 07:58:12 +0700
Message-ID: <CACsJy8C5=JKHsjyaSFsxxyScb1CCQZmh4gXSAgsyJ8DFkjfQ0g@mail.gmail.com>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
 <1328525855-2547-3-git-send-email-pclouds@gmail.com> <7vwr7z653f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 01:58:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuZOT-0007PN-2B
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 01:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118Ab2BGA6o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 19:58:44 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:58474 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755883Ab2BGA6n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 19:58:43 -0500
Received: by werb13 with SMTP id b13so4681307wer.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 16:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NR3g78e6niuG1HtnZbFcOpL4QoZgmu75SI7hqfdfv/8=;
        b=YeA9rYtA+dfP23x+Dtnw7WAinAieNJjCbW/FPBzTXPmoLZovsqHN/DUsg1JLWmjV1B
         lUBn+TNyA3BddDTk8XWydm200aGN8F8biY/whvjZP1Z+YyDeTeppDXT6kH/l1jiHLbFm
         DbUBG6QngJLJIq+t2Mq5zSgg+McvMYGxw2v7o=
Received: by 10.216.132.214 with SMTP id o64mr4111969wei.26.1328576322205;
 Mon, 06 Feb 2012 16:58:42 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Mon, 6 Feb 2012 16:58:12 -0800 (PST)
In-Reply-To: <7vwr7z653f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190126>

2012/2/7 Junio C Hamano <gitster@pobox.com>:
> It still is not clear to me how best to sell this change to the end-u=
ser
> community.
>
> IIRC, the original motivation of intent-to-add "add -N" was in respon=
se to
> users who curse Git because they often forget to add new files before
> committing, and they wanted to say "Here I have a new file, it is not
> complete yet, but I do not want it left out of the commit. While my m=
emory
> is fresh, let me tell Git to keep an eye on it, so that it can remind=
 me
> if I forget to add the final contents." =C2=A0For them, the current "=
did you
> forget to add them? =C2=A0If so tell me the final contents for at lea=
st the
> paths you will be changing with this commit" error was a perfect safe=
ty
> solution.
>
> It turned out that the benefits described we see above in the context=
,
> "This is useful, among other things, ...", were of more value, and fo=
r
> these use cases, i-t-a entries ceased to mean "I may forget, so I am
> telling you now, please remind me when I say commit." =C2=A0And "did =
you
> forget?" error is hinderance for them.
>
> But does that mean nobody will ever need "please remind me lest I for=
get"?
> Just the original requestor of the "add -N" feature may still be usin=
g
> git, but more importantly, isn't it the case that those who have been
> using it merely for the other side effect (e.g. 'git diff') sometimes=
 want
> the "please remind me" safety?
>
> I suspect that some among 1 million Git users would want the "please
> remind me", so a solution with configuration variable without command=
 line
> override is not ideal (command line without any configurability is fi=
ne as
> long as we have a good default).

Which is why I prefer adding a new configuration variable (and
optionally a command line option) instead of deprecating current
behavior, because (being lazy) I never be able to find "some among 1
million" so I'm fine with assuming there are some among 1 million that
favors safety over convenience.

> I am beginning to think "safety by default, which can be turned off b=
y
> learned users, but still can be turned on on demand" may be a lot eas=
ier
> to sell this. =C2=A0That is:
>
> =C2=A0- commit.ignoreIntentToAdd defaults to `false`; the default wil=
l never
> =C2=A0 change. =C2=A0The users can set it to `true`.
>
> =C2=A0- "commit --ignore-intent-to-add" can be used without setting t=
he
> =C2=A0 configuration or to defeat an explicit `false`, for a one-shot=
 request.
>
> =C2=A0- "commit --honor-intent-to-add" can be used to defeat an expli=
cit
> =C2=A0 `true`, for a one-shot request.
>
> The third one is a bit funny, as it is a way to bring back safety whe=
n the
> user earlier decided that he does not need that kind of safety (i.e. =
"I
> only say 'add -N' for `diff` and stuff, I will never forget to add re=
al
> contents before committing"), so it will almost never be used, becaus=
e
> these users who set 'ignoreIntentToAdd =3D true' do _not_ expect Git =
to help
> them in remembering to add the real contents. =C2=A0And having to add=
 a funny
> option just for the sake of completeness is often an indication that =
there
> is something fundamentally wrong in the system that the option tries =
to
> express an interface into it.

Well, that --honor-intent-to-add could be renamed as
--no-ignore-intent-to-add. The --[no-]ignore-intent-to-add pair
functions as a way to override default behavior/config var. No extra
could required. "git commit -h" just does not show it.

We need better option/config names though, --ignore-intent-to-add
looks way too long to type and it's not clear what it does without
looking up "git add -N".
--=20
Duy
