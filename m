From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] completion: add new _GIT_complete helper
Date: Mon, 7 May 2012 02:20:54 +0200
Message-ID: <CAMP44s3q-X7W5qeu6LZzu13C6SfhEZy9i4AfJ9Sszcou52MsGw@mail.gmail.com>
References: <1336231400-6878-1-git-send-email-felipe.contreras@gmail.com>
	<20120506111425.GJ2164@goldbirke>
	<CAMP44s3xwgsfjZA6r+bydu-5r1nEO5cGc=wcDSr+WdwunTtpwg@mail.gmail.com>
	<20120506233235.GN2164@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon May 07 02:21:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRBhH-0003nK-Mw
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 02:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906Ab2EGAU5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 20:20:57 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:60744 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754891Ab2EGAU4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 20:20:56 -0400
Received: by eekc41 with SMTP id c41so1263200eek.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 17:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=hQ5uqepn8cKFG+kXIssp2HkdUVE5dj++TLhjlyYYgrU=;
        b=Pmrimn6uhSdgwWGPjLb3fUDOxUOHnsSv2aaG5uMcBsPcd6AU5i7zylw7L+4uBIS8iM
         ZpugV1daswvjFyhcvi2kJY1z6+RH/r/I2rhkPJv41JE/FuoJG8l+edAmYPSicFdiU8Bb
         TPl7HDkSpNeHNGy4fOJsNJqOZSDN5Jk56kcpXzvDMDTGpKNMpCbqwHqmbLzJmKqhIXzr
         TnlSIEPpsOrcCAgnJFUJvpOgdyJkaQvNPhDdRbaTaElfJ2aujL9mSNy8Q4zR756PbU0i
         LNodeaZLFmnAxZepKF+rNs653XR2E6XfNnN6vqK9+Yeyu0eBjrxgx5lDNc9m/4DOfRRO
         x5pQ==
Received: by 10.213.28.208 with SMTP id n16mr2422536ebc.106.1336350054919;
 Sun, 06 May 2012 17:20:54 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sun, 6 May 2012 17:20:54 -0700 (PDT)
In-Reply-To: <20120506233235.GN2164@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197225>

Hi,

On Mon, May 7, 2012 at 1:32 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> w=
rote:
> On Sun, May 06, 2012 at 10:37:06PM +0200, Felipe Contreras wrote:
>> On Sun, May 6, 2012 at 1:14 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
> wrote:
>> > On Sat, May 05, 2012 at 05:23:20PM +0200, Felipe Contreras wrote:
>> >> This simplifies the completions, and makes it easier to define al=
iases:
>> >>
>> >> =C2=A0_GIT_complete gf git_fetch
>> >
>> > So, 'gf' is an alias for 'git fetch', for which the user would lik=
e to
>> > use the completion for 'git fetch', right? =C2=A0But that completi=
on
>> > function is caled _git_fetch(), so the underscore prefix is missin=
g
>> > here.
>>
>> No, it's not missing:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0local name=3D"${2-$1}"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0eval "$(typeset -f __git_func_wrap | sed =
-e "s/__git_func/_$name/")"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0complete -o bashdefault -o default -o nos=
pace -F _${name}_wrap
>> $1 2>/dev/null \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| complete -=
o default -o nospace -F _${name}_wrap $1
>>
>> See how we add '_' before $name?
>
> Indeed, the '_' is added before $name no less than three times. =C2=A0=
How
> could I have missed that?! ;) =C2=A0It would be better to do it once =
and be
> done with it.

Sure.

>> There's not point in burdening the
>> user with adding a prefix that will _always_ be there anyway.
>
> I don't think it's that much of a burden. =C2=A0The function is calle=
d
> _git_fetch, use that as second argument

Perhaps not, but why are you arguing for making users' life more
difficult? Even if it's just a little.

In fact, it could be even simpler:

_GIT_complete gf fetch

>> > Besides, this example won't work, because the completion for 'git
>> > fetch' uses __git_complete_remote_or_refspec(), which in turn reli=
es
>> > on finding out the name of the git command from the word on the
>> > command line, and it won't be able to do that from 'gf'.
>>
>> That's irrelevant, it's an example;
>
> It's relevant; if you give an example, then at least that example
> should work properly, don't you think?

It does work... on my branch.

If you have another example that works, feel free to suggest it, but
I'm going to remove that message, along with _GIT_complete (and
replace it with __git_complete and a note that it's not public API),
because I'm tired of trying to make users' life easier; I just want
the patch in.

>> replace with another command that
>> doesn't use 'words', and it would work.
>
> That it doesn't work has nothing to do with $words. =C2=A0The problem=
 is that
> __git_complete_remote_or_refspec() expects to find the git command in
> ${words[1]}, but in case of an alias it can't.

${words[1]} is part of $words. And BTW, git bundle also fails similarly=
=2E

And then, even if you fetch the command properly,
__git_complete_remote_or_refspec will still fail because it would
assume the remote is 'git'.

Also BTW, git fetch is already broken anyway:

 git --no-pager fetch <TAB>

So don't blame my patch :)

>> > I remember we discussed this in an earlier round, and you even
>> > suggested a possible fix (passing the command name as argument to
>> > __git_complete_remote_or_refspec()). =C2=A0I think that's the righ=
t thing
>> > to do here.
>>
>> Yeah, but I suggested that in order to avoid the eval and the typese=
t
>> that I require for future future patches, but it turns out it's stil=
l
>> needed anyway, so my suggestion is to have a 'cmd' variable that
>> stores the command; __git_func_wrap would take the responsibility of
>> doing that.
>
> Well, now I suggest to do that to fix
> __git_complete_remote_or_refspec(), because that seems to be the
> easiest, cleanest, and fastest solution.

That's not enough to make 'git fetch' work, try it.

>> >> + =C2=A0 =C2=A0 __git_func "$@"
>> >
>> > What is this "$@" for and why? =C2=A0None of the _git_<cmd>() func=
tions
>> > take any arguments, nor does _git() and _gitk(), and AFAICT Bash w=
on't
>> > pass any either.
>>
>> bash's complete passes 3 arguments.
>
> Oh, indeed; the first argument is the command name, the second is the
> current word, and the third is the previous word. =C2=A0All these are
> available in our completion functions as ${words[0]}, $cur, and $prev=
,
> respectively.

Yeah, but that's still what bash does, and I saw no reason to change it=
=2E

>> They might not be used, but it
>> doesn't hurt to pass them either.
>
> They _are_ not used, so passing them has no benefit either. =C2=A0I w=
ould
> rather stick to using $cur and $prev than $2 and $3.

Sure, but it was just 4 more characters that didn't hurt anybody. Your
version makes passing those arguments more difficult, so I see no need
to try to implement that.

Cheers.

--=20
=46elipe Contreras
