From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Mon, 6 Feb 2012 15:44:11 +0100
Message-ID: <201202061544.14417.jnareb@gmail.com>
References: <201202042045.54114.jnareb@gmail.com> <201202052146.56458.jnareb@gmail.com> <CALKQrgcAsPXziQCTReZkCKnnXTX=rwPFrzp0wJ3ZYwn0b_M5Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 15:44:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuPnn-0001cH-8R
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 15:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884Ab2BFOoO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 09:44:14 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60457 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab2BFOoN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 09:44:13 -0500
Received: by eaah12 with SMTP id h12so2481635eaa.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Qy5gj/5Ii75BJ5NkA5zMzxbJMqi2eYKV/j2gtK6Yl6Y=;
        b=qeYYv2c5pd0rZWqXmfzDbWKYncHViX7F72R1E1jYSCUpYWmGdcX3n3HL7ZN57z1QNC
         Yi+HEEGh6tvE5yfi0/zOAjcOiqjs1cobaR7tNk7jP6oOlP6NYPTqiel7YNjx3kFCNePJ
         GAliv4ahhMUzkCnybkGgj1o0Trp46xTYLalco=
Received: by 10.213.13.209 with SMTP id d17mr2302384eba.20.1328539452275;
        Mon, 06 Feb 2012 06:44:12 -0800 (PST)
Received: from [192.168.1.13] (abvv240.neoplus.adsl.tpnet.pl. [83.8.219.240])
        by mx.google.com with ESMTPS id a58sm61664337eeb.8.2012.02.06.06.44.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Feb 2012 06:44:11 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CALKQrgcAsPXziQCTReZkCKnnXTX=rwPFrzp0wJ3ZYwn0b_M5Tw@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190071>

On Sun, 5 Feb 2012, Johan Herland wrote:
> On Sun, Feb 5, 2012 at 21:46, Jakub Narebski <jnareb@gmail.com> wrote=
:
>> On Sun, 5 Feb 2012, Johan Herland wrote:
>>> 2012/2/5 Jakub Narebski <jnareb@gmail.com>:

[...]
>>> I agree that the 'public' state should (by default) be automaticall=
y
>>> inferred from remote-tracking branches. As it stands, we can do thi=
s
>>> with current git, by writing a pre-rebase hook that checks if any o=
f
>>> the commits to-be-rebased are reachable from any remote-tracking
>>> branch.
>>
>> It is nice that we can achieve a large part of this feature with exi=
sting
>> infrastructure. =C2=A0It would be nice if we ship such pre-rebase ho=
ok with
>> git, so people can just enable it if they want to use this functiona=
lity,
>> like the default pre-commit hook that checks for whitespace errors.
>=20
> Yeah. As it is, the pre-rebase hook shipped with v1.7.9 (when
> activated) does something similar (i.e. prevent rewriting 'public'
> commits). However, it's highly workflow-specific, since it determines
> whether the branch being rebased has been merged into "next" or
> "master". IMHO, a hook that tested for reachability from
> remote-tracking refs would be more generally useful. Obviously, the
> two can be combined, and even further combinations may be desirable
> (e.g. also checking for reachability from commits annotated in
> refs/notes/public).

Relying on (default) hooks to implement this feature has the disadvanta=
ge
that it wouldn't be turned on by default... while this feature would be
most helpful for users new to git (scared by refuse to push).
=20
I am not sure either if everything (wrt. safety net) can be implemented
via hooks.  One thing that I forgot about is preventing rewinding of
branch past the published commit using e.g. "git reset --hard <commit>"=
=2E
Unless `pre-rewrite` hook could be used for that safety too...

[...]
>> Note however that the safety net, i.e. refusing or warning against a=
ttempted
>> rewrite of published history is only part of issue. =C2=A0Another im=
portant part
>> is querying and showing "phase" of a commit. =C2=A0What I'd like to =
see is
>> ability to show among others in "git log" and "git show" output if c=
ommit
>> was already published or not (and if it is marked 'secret').
>=20
> Today, you can use --decorate to display remote-tracking refs in the
> log/show output. However, only the tip commits are decorated, so if
> the commits shown are not at the tip, you're out of luck. I believe
> teaching log/show to decorate _all_ commits that are reachable from
> some given ref(s) should be fairly straightforward.

That would be nice.
=20
> If you use 'git notes' to annotate 'public' and 'secret' states, then
> you can also use the --show-notes=3D<ref> option to let show/log disp=
lay
> the annotations on 'public'/'secret' commits.

=46irst, in my opinion annotating _all_ commits with their phase is I t=
hink
out of question, especially annotating 'public' commits.  I don't think
git-notes mechanism would scale well to annotating every commit; but
perhaps this was tested to work, and I am mistaken.=20
=20
Second, I have doubts if "phase" is really state of an individual commi=
t,
and not the feature of revision walking.

Take for example the situation where given commit is reference by=20
remote-tracking branch 'public/foo', and also by two local branches:
'foo' with upstream 'public/foo', and local branch 'bar' with no upstre=
am.

Now it is quite obvious that this feature should prevent rewriting 'foo=
'
branch, for which commits are published upstream.  But what about branc=
h
'bar'?  Should we prevent rewriting (e.g. rebase) here too?  What about
rewinding 'bar' to point somewhere else.  What if 'bar' is really detac=
hed
HEAD?=20

These questions need to be answered...

[...]
>>> Also, if you want to record where 'public' commits have been sent
>>> (other than what can be inferred from the remote-tracking branches)=
,
>>> you could write this into the refs/notes/public annotation.
>>
>> I wonder if this too can be done by hook...
>=20
> You're looking for someting like a post-push hook that runs on the
> _client_ after a successful push. AFAIK, that doesn't exist yet. (Not
> to be confused with the receive/update hooks that run on the
> _server_.)

And such hook could react to what was successfully pushed.  Without
such hook we would have to write wrapper around git-push and parse
its output...
=20
Nb. such hook could create "fake" remote-tracking branches if given
push-only remote doesn't have them set up.

>>> As for 'secret' commits, you could annotate these on a
>>> refs/notes/secret notes ref, and then teach 'git push' (or whatever
>>> other method for publishing commits you use) to refuse to publish
>>> commits annotated on this notes ref. Possibly we would want to add =
a
>>> "pre-push" or "pre-publish" hook.
>>
>> Well, addition of pre-push / pre-publish was resisted on the grounds
>> that all it does is something that can be as easy done by hand befor=
e
>> push. =C2=A0Perhaps this new use case would help bring it forward, d=
on't
>> you think?
>=20
> Maybe. I didn't follow the original discussion. From my POV, you coul=
d
> argue that instead of another hook, you could always write a script
> that does the 'secret' check before invoking 'git push', and then
> you'd use that script instead of 'git push'. But you could argue the
> same point for pretty much all of the other existing hooks (e.g.
> instead of a pre-commit hook you could have your own commit wrapper
> script). So I don't think that's a sufficient argument to refuse the
> existence of a pre-push/publish hook.

Right, This would be for this feature very much like pre-commit hook.

--=20
Jakub Narebski
Poland
